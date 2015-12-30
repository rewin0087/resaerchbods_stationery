class Stationery < ActiveRecord::Base
  TYPES = %w(CONSUMABLE FIXED)

  TYPES.each do |type|
    define_method "#{type.underscore}?" do
      self.stationery_type == type
    end

    define_singleton_method "#{type.underscore}" do
      type
    end
  end

  default_scope -> { order('name ASC') }
  scope :in_stocks, -> { where('in_stocks > 0') }
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :stationery_type, presence: true

  has_many :user_stationeries, dependent: :destroy
end
