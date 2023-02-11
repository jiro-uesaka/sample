class Worker < ApplicationRecord
    belongs_to :shift
    belongs_to :staff
end
