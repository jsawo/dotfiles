local dial = require("dial.map")
local augend = require("dial.augend")
local config = require("dial.config")

vim.api.nvim_set_keymap("n", "<C-s>", dial.inc_normal(), {noremap = true})
vim.api.nvim_set_keymap("n", "<C-x>", dial.dec_normal(), {noremap = true})
vim.api.nvim_set_keymap("v", "<C-s>", dial.inc_visual(), {noremap = true})
vim.api.nvim_set_keymap("v", "<C-x>", dial.dec_visual(), {noremap = true})
vim.api.nvim_set_keymap("v", "g<C-s>", dial.inc_gvisual(), {noremap = true})
vim.api.nvim_set_keymap("v", "g<C-x>", dial.dec_gvisual(), {noremap = true})

local function to_capital(str)
    return str:gsub("^%l", string.upper)
end

local function to_pascal(str)
    return str:gsub("%W*(%w+)", to_capital)
end

local function to_snake(str)
    return str:gsub("%f[^%l]%u", "_%1"):gsub("%f[^%a]%d", "_%1"):gsub("%f[^%d]%a", "_%1"):gsub("(%u)(%u%l)", "%1_%2"):lower()
end

local function to_camel(str)
    return to_pascal(str):gsub("^%u", string.lower)
end

config.augends:register_group{
  -- default augends used when no group name is specified
  default = {
    augend.integer.alias.decimal_int,   -- decimal number (-1, 0, 1, 2, 3, ...)
    augend.hexcolor.new({}),
    augend.date.new({ -- hour (21:38:11)
        pattern = "%H:%M:%S",
        default_kind = "hour",
        only_valid = true,
        word = false,
    }),
    augend.date.new({ -- hour (21:38)
        pattern = "%H:%M",
        default_kind = "hour",
        only_valid = true,
        word = false,
    }),
    augend.date.alias["%d.%m.%Y"],
    augend.date.alias["%m/%d/%Y"],
    augend.date.alias["%Y/%m/%d"],
    augend.constant.alias.bool, -- boolean value (true <-> false)
    augend.semver.alias.semver, -- semver (0.1.2, 1.2.3, 1.2.3-alpha.1, etc.)
    augend.constant.alias.alpha,
    augend.constant.alias.Alpha,
    -- augend.paren.alias.quote,

    augend.constant.new({ elements = { 
      "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" 
    }}),

    augend.constant.new({ elements = { 
      "poniedziałek", "wtorek", "środa", "czwartek", "piątek", "sobota", "niedziela" 
    }}),

    augend.constant.new({ elements = { 
      "pon", "wt", "śr", "czw", "pt", "so", "nie" 
    }}),

    augend.constant.new({ elements = {
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December",
    }}), 

    augend.constant.new({
      elements = {
        "styczeń", "luty", "marzec", "kwiecień", "maj", "czerwiec",
        "lipiec", "sierpień", "wrzesień", "październik", "listopad", "grudzień",
      },
    }),

    augend.constant.new({ elements = { "True", "False" } }),
    augend.constant.new({ elements = { "TRUE", "FALSE" } }),
    augend.constant.new({ elements = { "enable", "disable" } }),
    augend.constant.new({ elements = { "enabled", "disabled" } }),
    augend.constant.new({ elements = { "on", "off" } }),
    augend.constant.new({ elements = { "trace", "debug", "info", "warn", "error", "fatal" } }),
    augend.constant.new({ elements = { "int", "int64", "int32" } }),
    augend.constant.new({ elements = { "float64", "float32" } }),
    augend.constant.new({ elements = { "h1", "h2", "h3", "h4", "h5", "h6" } }),

    -- cycle between camelCase, PascalCase, snake_case
    -- augend.user.new({
    --     find = require("dial.augend.common").find_pattern("[%a_]+"),
    --     add = function(text, _, _)
    --         if to_camel(text) == text then
    --             text = to_snake(text)
    --         elseif to_snake(text) == text then
    --             text = to_pascal(text)
    --         elseif to_pascal(text) == text then
    --             text = to_camel(text)
    --         end

    --         return { text = text, cursor = #text }
    --     end,
    -- }),

    -- cycle between # Title, ## Title, ### Title, ...
    augend.user.new({
      desc = "Markdown Header (# Title)",

      find = function(line)
        local from, to = line:find("^#+")
        if from == nil or to > 7 then return nil end
        return { from = from, to = to }
      end,

      add = function(text, addend)
        local n = #text
        n = n + addend
        if n < 1 then
          n = 1
        end
        if n > 6 then
          n = 6
        end
        text = ("#"):rep(n)
        return { text = text, cursor = 1 }
      end,
    }),
  },

  -- -- augends used when group with name `mygroup` is specified
  -- mygroup = {
  --   augend.integer.alias.decimal,
  --   augend.constant.alias.bool,    -- boolean value (true <-> false)
  --   augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
  -- }
}

-- enable only for specific FileType
-- autocmd FileType typescript lua vim.api.nvim_buf_set_keymap(0, "n", "<C-s>", dial.inc_normal("typescript"), {noremap = true})
