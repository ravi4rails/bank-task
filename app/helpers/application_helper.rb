module ApplicationHelper

  def flash_class(level)
    case level
    when :success then "alert alert-success"
    when :notice then "alert alert-success"
    when :alert then "alert alert-danger"
    when :error then "alert alert-danger"
    when :warning then "alert alert-warning"
    end
  end

  def customer_list
    User.where(role: 'customer').map {|user| [user.name, user.id]}
  end

end
