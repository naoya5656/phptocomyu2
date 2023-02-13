class Follow < ApplicationRecord
  belongs_to :follower, class_name: "Customer" #フォローするユーザのid
  belongs_to :followed, class_name: "Customer" #フォローされるユーザのid


end
