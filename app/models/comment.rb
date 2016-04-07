class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  
  validates :body, length: { minimum: 5, maximum: 500 }
  
end
