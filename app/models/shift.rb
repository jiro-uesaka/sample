class Shift < ApplicationRecord
    belongs_to :user
    belongs_to :shop
    has_one :headcount
    has_many :workers
end
