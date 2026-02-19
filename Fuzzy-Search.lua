local M = {}
function levenshtein(a, b)
  a = a:lower()
  b = b:lower()
  local lenA, lenB = #a, #b
  if math.abs(lenA - lenB) > 4 then return 999 end

  local prev = {}
  local curr = {}

  for j = 0, lenB do
    prev[j] = j
  end
  
  for i = 1, lenA do
    curr[0] = i
    for j = 1, lenB do
      local cost = (a:sub(i,i) == b:sub(j,j)) and 0 or 1
      curr[j] = math.min(
      prev[j] + 1,
      curr[j-1] + 1,
      prev[j-1] + cost
      )
    end
    prev, curr = curr, prev
  end
  return prev[lenB]
end

function M.load(url)
  local res = MakeRequest(url,"GET", {["User-Agent"] = "LuaClient"}, "", {}, {})
  if res then
    M.raw = res.body or res.content
    if M.raw then
        return true
    end
  end
  return false
end

function M.search(input, maxDistance)
  if not M.raw then
    return nil, "Raw url or data url mot loaded"
  end
    
  input = input:lower()
  local bestID, bestName, bestScore = nil, nil, math.huge

  for id, name in M.raw:gmatch('"item_id"%s*:%s*(%d+).-?"name"%s*:%s*"([^"]+)"') do
    local lowerName = name:lower()
      
    if lowerName:find(input, 1, true) then
      return tonumber(id), name, 0
    end
      
    local score = levenshtein(input, lowerName)
    if score < bestScore then
      bestScore = score
      bestID = tonumber(id)
      bestName = name
    end
  end
  
  if bestScore <= (maxDistance or 3) then
    return bestID, bestName, bestScore
  end
  return nil
end

return M
