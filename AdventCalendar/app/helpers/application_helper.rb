module ApplicationHelper

  # Returns true if used has access to given calendar, returns false in all other cases

  # Example use: "user_has_access_to? @calendar"

  def user_has_access_to?(calendar)
    access = false
    if user_signed_in?
      if current_user.admin? || current_user.id == calendar.user_id
        access = true
      end
    end

    access
  end

  # Returns true if signed in user is admin, returns false in all other cases

  # Example use: "if user_is_admin?"

  def user_is_admin?
    if user_signed_in?
      current_user.admin?
    else
      false
    end
  end

end
