local function locate(item)
  local world = GetWorld().name
  for x = 0, 99 do
    for y = 0, 53 do
      local tile = GetTile(x, y)
      if tile.fg == 2978 or tile.fg == 9268 then
        local extra = tile.extra
        if extra.lastupdate ~= 0 and extra.owner ~= 0 then
          local name = GetName(extra.lastupdate)
          if name then
            local priceInfo = extra.owner < 0 and tostring(-extra.owner) .. " / World Lock" or tostring(extra.owner) .. " World Lock Each"
            local logs = string.format("Item: %s|Price: %s|PosX: %d|PosY: %d|", name, priceInfo, x, y)
            local log = string.format("|%s|%s|%s|%d|%d|", world, name, priceInfo, x, y)
            if item:upper() == name:upper() then
              return logs
            else
              LogToConsole("Not Found")
            end
          end
        end
      end
    end
  end
end
