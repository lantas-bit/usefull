local function add(a, b)
    return a + b
end

local function subtract(a, b)
    return a - b
end

local function multiply(a, b)
    return a * b
end

local function divide(a, b)
    if b == 0 then
        return "Error: Division by zero"
    else
        return a / b
    end
end

local function toUpperCase(str)
    return string.upper(str)
end

local function toLowerCase(str)
    return string.lower(str)
end

local function isNumber(str)
    return tonumber(str) ~= nil
end

local api = {
    add = add,
    subtract = subtract,
    multiply = multiply,
    divide = divide,
    toUpperCase = toUpperCase,
    toLowerCase = toLowerCase,
    isNumber = isNumber
}

return api
