# t.integer :user_id, null: false
# t.integer :, null: false
# t.timestamps
class Visit < ApplicationRecord
  validates :user_id, :shortened_url_id, presence: true
  
  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
    
  belongs_to :shortened_url,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :ShortenedUrl
    
  
    
    
end
