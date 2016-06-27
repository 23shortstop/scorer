module TokenAuth
  class Unauthorized < StandardError; end
  class BadCredentials < StandardError; end

  @salt = '23JIUhui8*hg8y77%8h9h*78yG565^TF54%$ef6@93nid9fuu8*y7!34rf2!43r';
  @expire = 2.hours

  class << self
    attr_accessor :salt, :expire

    def setup
      yield self
    end
  end
end
