class Report < ApplicationRecord
    has_many :reports, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
    has_many :reverse_of_reports, class_name: "Report", foreign_key: "reported_id", dependent: :destroy
end
