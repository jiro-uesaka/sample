class Shift < ApplicationRecord
    belongs_to :user
    belongs_to :shop
    has_many :headcounts
    has_many :workers
end
