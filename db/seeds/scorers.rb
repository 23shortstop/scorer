Scorer.destroy_all

Scorer.create!(name: FFaker::Name.name,
               email: FFaker::Internet.email,
               password: FFaker::Internet.password)
