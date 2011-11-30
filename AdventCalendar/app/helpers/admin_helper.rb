module AdminHelper

  # Returns owner of given calendar

  #  Example use: put "#{owner_of(@calendar).name}"

  def owner_of(calendar)
    users = User.all

    for user in users.each do
      return user if user.id == calendar.user_id
    end
  end
end
