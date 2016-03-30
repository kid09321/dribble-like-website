class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id

  def is_editable?(user)
    user == author
  end

end
