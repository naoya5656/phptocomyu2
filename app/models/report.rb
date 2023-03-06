class Report < ApplicationRecord
    has_one_attached :image
    belongs_to :reporter, class_name: "Customer"
    belongs_to :reported, class_name: "Customer"
    enum status: { waiting: 0, keep: 1, finish: 2 }
    validates :image, presence: true
    validates :reason, presence: true
end