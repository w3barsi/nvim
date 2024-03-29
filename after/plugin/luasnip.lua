---@diagnostic disable: unused-local
local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")
--
-- vim.keymap.set({ "i", "s" }, "<C-s>", function()
--   if ls.expand_or_jumpable() then
--     ls.expand_or_jump()
--   end
-- end)
-- vim.keymap.set("n", "<Tab>", function()
--   ls.jump(1)
-- end, { silent = true })
--
ls.setup({
  history = true,
  update_events = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<--", "Error" } },
      },
    },
  },
})

ls.add_snippets("all", {
  s(
    { trig = "rus", name = "useState" },
    fmt("const [{}, set{setter}] = useState{}({})", {
      i(1, "value"),
      i(0),
      i(2, "{InitialValue}"),
      setter = l(l._1:sub(1, 1):upper() .. l._1:sub(2, -1), { 1, 2 }),
    })
  ),
  s(
    { trig = "rusi", name = "useState + Import" },
    fmt("const [{}, set{setter}] = useState({})", {
      i(1, "value"),
      i(2, "{InitialValue}"),
      setter = l(l._1:sub(1, 1):upper() .. l._1:sub(2, -1), { 1, 2 }),
    })
  ),
  s(
    { trig = "rusi", name = "useState with Generic" },
    fmt("const [{}, set{setter}] = useState<{}>({})", {
      i(1, "value"),
      i(2, "Generic"),
      i(3, "InitialValue"),
      setter = l(l._1:sub(1, 1):upper() .. l._1:sub(2, -1), { 1, 2 }),
    })
  ),
  s(
    { trig = "rusgi", name = "useState with Generic + Import" },
    fmt("const [{}, set{setter}] = useState{}<{}>({})", {
      i(1, "value"),
      i(0),
      i(2, "Generic"),
      i(3, "InitialValue"),
      setter = l(l._1:sub(1, 1):upper() .. l._1:sub(2, -1), { 1, 2 }),
    })
  ),
  s(
    { trig = "rrafce", name = "React Arrow Function Component with Export" },
    fmt(
      [[
			const {} = ({}) => {{
			  return ({})
			}}
			export default {func};
	    ]],
      {
        i(1, "FunctionName"),
        i(2),
        i(0),
        func = rep(1),
      }
    )
  ),
  s("clog", fmt("console.log({})", { i(1) })),
  s(
    { trig = "rrfc", name = "React Functional Component with Export" },
    fmt(
      [[
			export default function {}({}) {{
			  return ({})
			}}
	    ]],
      {
        i(1, "FunctionName"),
        i(2),
        i(0),
      }
    )
  ),
  s("cdiv", t("flex h-screen items-center justify-center")),
})
