class Recording < ActiveRecord::Base

  belongs_to :user

  has_many :likes
  has_many :flags
  has_many :comments
  has_many :recording_tags
  has_many :tags, through: :recording_tags

  has_many :flag_users, through: :flags, source: :user
  has_many :like_users, through: :likes, source: :user

  validates :title, presence: true

  has_attached_file :sound
  validates_attachment_content_type :sound, content_type: ['audio/mpeg','audio/mp3']


  def player_params
    {recordingname: self.title,
     url: self.sound.url,
    latitude: self.latitude,
    longitude: self.longitude}
  end


end
