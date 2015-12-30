class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  PENALTY = 5 # USD
  STATUSES = %w(ACTIVE DEACTIVED)

  STATUSES.each do |status|
    define_method "#{status.underscore}?" do
      self.status == status
    end

    define_singleton_method "#{status.underscore}" do
      status
    end
  end

  validates :full_name, presence: true
  validates :email, presence: true
  validates :status, presence: true
  has_many :user_stationeries
  has_many :stationeries, through: :user_stationeries

  def can_borrow?
    overdue_stationeries.size < 1
  end

  def overdue_stationeries
    UserStationery.overdues(self)
  end

  def overdue_penalty
    overdue_stationeries.size * PENALTY
  end
end
