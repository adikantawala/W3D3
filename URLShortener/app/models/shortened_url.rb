# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true
  def self.shortener(user,long_url)
    temp = ShortenedUrl.random_code
    ShortenedUrl.create!(user_id: user.id, long_url: long_url, short_url: temp)
  end 
  
  def self.random_code
    @short_url = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(@short_url)
      @short_url = SecureRandom.urlsafe_base64
    end
    return @short_url
  end
  
  has_many :visitors,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit 
  
  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
    
  def num_clicks
    visitors.count
  end
  
  def num_uniques
    Visit.select(:user_id).distinct.count
  end 
  
end
