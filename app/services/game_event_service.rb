class GameEventService < GameService
  def create(outcome, offender, defender = nil, assistant = nil)
    build(outcome, offender)
    build_out(defender, assistant) if out?(outcome)
    @last_pa.save!
  end

  private

  OUT_EVENTS = [:sacrifice_fly, :sacrifice_bunt,
                :force_out, :tag_out, :fly_out]

  def out?(outcome)
    OUT_EVENTS.include? outcome
  end

  def build(outcome, player)
    @last_pa.game_events.build(outcome: outcome, player: player)
  end

  def build_out(defender, assistant = nil)
    build('put_out', defender)
    build_assist(assistant) if assistant
  end

  def build_assist(assistant)
    build('assist', assistant)
  end
end
