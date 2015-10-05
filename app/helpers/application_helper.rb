module ApplicationHelper

# <% unless cart.line_items.empty? %>
# <% end %>
# Можно сделать и так в _cart.html.erb

  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    
    content_tag("div", attributes, &block)
  end

end
