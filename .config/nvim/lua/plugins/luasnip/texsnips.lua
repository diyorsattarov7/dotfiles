-- plugins/luasnip/texsnips.luasnip

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node

ls.add_snippets("tex", {
    s("doc", {
        t("\\documentclass["),
        i(1, "options"),
        t("]{"),
        i(2, "article"),
        t("}")
    }),
    s("pkg", {
        c(1, {
            sn(nil, {
                t("\\usepackage{"),
                i(1, "package"),
                t("}")
            }),
            sn(nil, {
                t("\\usepackage["),
                i(1, "options"),
                t("]{"),
                i(2, "package"),
                t("}")
            }),
        })
    }),

    s("dm", {
        t("\\["),
        t({ "", "   "}),
        i(1, "math here"),
        t({ "", "\\]" }),
    }),

    s("it", {
        t("\\textit{"),
        i(1, "text"),
        t("}")
    }),

    s("frac", {
        t("\\frac{"),
        i(1, "num"),
        t("}{"),
        i(2, "den"),
        t("}")
    })

})
