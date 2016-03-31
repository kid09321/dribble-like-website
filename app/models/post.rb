class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_one :photo
  accepts_nested_attributes_for :photo
  has_many :comments

  def is_editable?(user)
    user == author
  end

end
