module NavigationHelper

  # get navigation 'active' css class if rule match
  def nav_class(match_rules)
    navigation_url_active?(nil, match_rules) ? 'active' : nil
  end

  # @param match_rules if :resource symbol, then match to url that starts withs specified url
  # @param match_rules if :same symbol, then match exactly to url
  # @param match_rules if hash {:controller, :action, :path, :method} and same yes with _not suffix (like :controller_not)
  def navigation_link(text, url, match_rules = :resource, link_options = {})
    link_options = merge_active_class(navigation_url_active?(url, match_rules), link_options)
    link_to text, url, link_options
  end

  # same as #navigation_link but link wrapped into LI tag
  def navigation_li_link(text, url, match_rules = :resource, li_options = {})
    li_options = merge_active_class(navigation_url_active?(url, match_rules), li_options)
    content_tag('li', link_to(text, url), li_options)
  end

  # no link to page that match rule (active link is #)
  def safe_navigation_link(text, url, match_rules = :resource, link_options = {})
    active = navigation_url_active?(url, match_rules)
    link_options = active ? {:class => 'safe'}.merge(link_options) : link_options
    link_to text, active ? '#' : url, link_options
  end

  private

  # params: url, params hash, regexp
  def navigation_url_active?(url, match_rules)
    if match_rules.is_a?(Hash) && !match_rules.blank?
      active = true
      active &&= navigation_rule_match match_rules, :controller, controller.controller_path
      active &&= navigation_rule_match match_rules, :action, controller.action_name if active
      active &&= navigation_rule_match match_rules, :path, request.path if active
      active &&= navigation_rule_match match_rules, :method, request.method if active
    elsif match_rules == :resource || match_rules == nil
      active = request.path.starts_with?(url.gsub(root_url, "/"))
    elsif match_rules == :exact || match_rules == :same
      active = request.path == url.gsub(root_url, "/")
    elsif match_rules.is_a?(Regexp)
      active = match_rules === request.path
    else
      active = match_rules
    end
    active
  end

  def navigation_rule_match(match_rules, name, compare_with)
    return match_rules[name] === compare_with if match_rules[name]
    not_name = "#{name}_not".to_sym
    return !(match_rules[not_name] === compare_with) if match_rules[not_name]
    true
  end

  def merge_active_class(active, element_options)
    if active
      element_options ||= {}
      element_options[:class] = "active #{element_options[:class]}"
    end
    element_options
  end

end
