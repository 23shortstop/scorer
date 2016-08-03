class PlateAppearanceService < GameService
  def create_next
    start_next_half_inning if half_inning_ended?
    next_pa.save!
  end

  private

  def half_inning_ended?
    outs >= OUTS_PER_HALF_INNING
  end

  def start_next_half_inning
    switch_half_inning
    switch_teams
    @outs = 0
  end

  def switch_teams
    @last_pa = @game.plate_appearances.where(half_inning: @half.to_sym).last
    @ofenders, @defenders = @defenders, @ofenders
  end

  def switch_half_inning
    case @half
    when 'top'    then @half = 'bottom'
    when 'bottom' then @half = 'top'; @inning += 1
    end
  end

  def next_pa
    @game.plate_appearances.build(batter: next_batter, pitcher: @defenders.fielders.first,
      **runners_on_bases, inning: @inning, outs: outs, half_inning: @half)
  end

  def next_batter
    batting_order = @ofenders.batters
    next_batter_index = @last_pa ? batting_order.index(@last_pa.batter) + 1 : 0
    batting_order.fetch(next_batter_index, batting_order.first)
  end
end
