FactoryGirl.define do
  factory :lineup do
    team { build :team }

    factory :filled_lineup do
      after(:create) do |lineup|
        def positions() (1..9).to_a.shuffle end

        positions.zip(positions).each do |batting, fielding|
          create(:lineup_player, lineup: lineup,
            batting_position: batting, fielding_position: fielding)
        end
      end
    end
  end
end
