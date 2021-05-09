require File.expand_path('../base.rb', __FILE__)
class Session < Base
  attr_accessor :date, :available_capacity, :min_age_limit

  def initialize(sessions)
    self.from_attributes(sessions)
  end

  def available_date
    return unless available?

    date
  end

  def available?
    available_capacity.to_i.positive? && (min_age_limit == 18)
  end
end
