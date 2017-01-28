module UserHelper
  def check_current_user(header_class_name)
    case header_class_name
    when "title"       then set_title
    when "navbar_menu" then set_navbar_menu
    when "user_panel"  then set_user_panel
    end
  end

  private

  def set_title
    current_user ? set_navbar_header_links(trainer_path) : set_navbar_header_links(root_path)
  end

  def set_navbar_header_links(path)
    link_to t(:flashcards_label), path, class: "navbar-brand"
  end

  def set_navbar_menu
    render partial: "layouts/header/navbar_menu_links"
  end

  def set_user_panel
    current_user ? set_login_navbar_links : set_logout_navbar_links
  end

  def set_login_navbar_links
    render partial: "layouts/header/login_navbar_links"
  end

  def set_logout_navbar_links
    render partial: "layouts/header/logout_navbar_links"
  end
end
