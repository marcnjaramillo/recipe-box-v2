module ProfileHelper
  include ActionView::RecordIdentifier

  def following?(user)
    current_user&.following&.include?(user)
  end

  def dom_id_for_follower(follower)
    dom_id(follower)
  end

  def profile_image user
    image = user.profile_image.present? ? user.profile_image : "default.png"
    image_tag(image, class: "h-20 w-20 rounded-full")
  end

  def profile_image_thumb user
    image = user.profile_image.present? ? user.profile_image : "default.png"
    image_tag(image, class: "h-8 w-8 rounded-full")
  end

  def follow_image user
    image = user.profile_image.present? ? user.profile_image : "default.png"
    image_tag(image, class: "follow-pic m-r-10")
  end

  def can_edit_profile? profile_id
    user_signed_in? && current_user.id == profile_id
  end
end