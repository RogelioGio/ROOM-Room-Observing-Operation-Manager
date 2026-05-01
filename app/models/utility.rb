class Utility < ApplicationRecord
  belongs_to :room

    enum :status, { working: 0, not_working: 1, under_maintenance: 2 }
end
