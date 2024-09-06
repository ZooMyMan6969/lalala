local plugin_label = "Follower"
local menu = {}

menu.elements = {
    main_tree = tree_node:new(0),
    main_toggle = checkbox:new(false, get_hash(plugin_label .. "_main_toggle")),
}

function menu.render()
    if not menu.elements.main_tree:push("Follower") then
      return
    end

    menu.elements.main_toggle:render("Enable", "Start Following")
    if not menu.elements.main_toggle:get() then
      menu.elements.main_tree:pop()
      return
    end

end

return menu
