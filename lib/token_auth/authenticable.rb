module TokenAuth
  module Authenticatable
    extend ActiveSupport::Concern

    included do
      before_save :hash_password
    end

    module ClassMethods
      def find_by_authentication_token(token)
        entity_id = token_val(token)
        find(entity_id) if entity_id
      end

      def authenticate(*args)
        validate_credentials!(*args)

        query = class_variable_get(:@@credentials).inject('find_by_') do |prev, cur|
          prev += cur.to_s + '_and_'
        end

        entity = send(query.gsub(/_and_$/, ''), *perform_args(*args))
        token = entity.store_token if entity

        [entity, token]
      end

      def generate_hash(password)
        Digest::SHA2.hexdigest(Digest::SHA2.hexdigest(TokenAuth::salt + password) + TokenAuth::salt.reverse)
      end

      def token_val(token)
        Redis.current[token_key(token)]
      end

      def token_key(token)
        "auth_token:#{name.parameterize.singularize.underscore}:#{token}"
      end

      private

      def credentials(*args)
        class_variable_set(:@@credentials, args)
      end

      def perform_args(*args)
        password_index = class_variable_get(:@@credentials).index(:password)
        return args unless password_index

        args[password_index] = generate_hash(args[password_index])
        args
      end

      def validate_credentials!(*args)
        unless class_variable_get(:@@credentials).size == args.size
          raise BadCredentials.new("Wrong number of arguments.
            Get #{args.siz} of #{class_variable_get(:@@credentials).size}")
        end

        args.each do |item|
          raise BadCredentials.new("Params should not be blank!") if item.blank?
        end
      end
    end

    def store_token
      token = generate_token
      key = self.class.token_key(token)

      Redis.current[key] = id
      Redis.current.expire(key, TokenAuth::expire)

      token
    end

    private

    def generate_token
      begin
        token = SecureRandom.hex
      end while self.class.token_val(token)

      token
    end

    def hash_password
      self.password = self.class.generate_hash(password) if password_changed?
    end
  end
end
