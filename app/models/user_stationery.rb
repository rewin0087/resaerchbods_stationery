class UserStationery < ActiveRecord::Base
  STATUSES = %w(BORROWED USED CLEARED)

  STATUSES.each do |status|
    define_method "#{status.underscore}?" do
      self.status == status
    end

    define_singleton_method "#{status.underscore}" do
      status
    end
  end

  MAX_BORROW_DAYS = 2.days
  default_scope -> { order('created_at DESC') }
  before_create :set_overdue_at
  before_create :set_used_if_consumable
  belongs_to :user
  belongs_to :stationery

  validates :user, presence: true
  validates :stationery_id, presence: true

  def set_overdue_at
    stationery.in_stocks -=1
    stationery.save
    self.overdue_at = DateTime.now + 2.days if stationery.fixed?
  end

  def set_used_if_consumable
    self.status = UserStationery.used if stationery.consumable?
  end

  def cleared!
    self.status = UserStationery.cleared
    save
  end

  def self.overdues(user)
    joins(:stationery).
      where('overdue_at < ?', Time.now).
      where('stationeries.stationery_type = ?', Stationery.fixed).
      where(user: user, status: UserStationery.borrowed)
  end
end
