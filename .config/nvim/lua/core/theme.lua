-- core/theme.lua
local selected_theme = "github"
local dark_background = "#0E1116"

local colors = {
	foreground = "#C9D1D9",
	comment = "#8B949E",
	orange = "#F0883E",
	purple = "#D2A8FF",
	blue = "#79C0FF",
	cyan = "#A5D6FF",
}

local context_namespace = vim.api.nvim_create_namespace("GithubCppContext")

local function is_in_tmux()
	return vim.env.TMUX ~= nil
end

local function is_dark_mode()
	return vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null") ~= ""
end

local function highlight(group, color)
	vim.api.nvim_set_hl(0, group, {
		fg = color,
	})
end

local function apply_highlights()
	-- Comments
	highlight("Comment", colors.comment)
	highlight("@comment", colors.comment)

	-- Keywords
	highlight("Keyword", colors.orange)
	highlight("Conditional", colors.orange)
	highlight("Repeat", colors.orange)
	highlight("Statement", colors.orange)
	highlight("Exception", colors.orange)
	highlight("StorageClass", colors.orange)
	highlight("Structure", colors.orange)

	for _, group in ipairs({
		"@keyword",
		"@keyword.function",
		"@keyword.return",
		"@keyword.conditional",
		"@keyword.repeat",
		"@keyword.operator",
		"@keyword.modifier",
		"@keyword.type",
		"@keyword.import",
	}) do
		highlight(group, colors.orange)
	end

	-- Types
	highlight("Type", colors.foreground)
	highlight("@type", colors.foreground)
	highlight("@type.cpp", colors.foreground)
	highlight("@type.definition", colors.purple)
	highlight("@type.definition.cpp", colors.purple)
	highlight("@type.builtin", colors.orange)
	highlight("@type.builtin.cpp", colors.orange)
	highlight("@type.qualifier", colors.orange)

	for _, group in ipairs({
		"@lsp.type.class.cpp",
		"@lsp.type.struct.cpp",
		"@lsp.type.enum.cpp",
		"@lsp.type.concept.cpp",
		"@lsp.type.type.cpp",
		"@lsp.type.typeAlias.cpp",
		"@lsp.type.typeParameter.cpp",
		"@lsp.type.templateParameter.cpp",
		"@lsp.type.dependentType.cpp",
		"@lsp.type.enumMember.cpp",
	}) do
		highlight(group, colors.foreground)
	end

	-- Standard-library types
	highlight("@lsp.typemod.type.defaultLibrary.cpp", colors.blue)

	-- Type declarations and definitions
	for _, type_name in ipairs({
		"class",
		"struct",
		"enum",
		"concept",
		"type",
		"typeAlias",
	}) do
		highlight("@lsp.typemod." .. type_name .. ".declaration.cpp", colors.purple)
		highlight("@lsp.typemod." .. type_name .. ".definition.cpp", colors.purple)
	end

	-- Functions
	highlight("Function", colors.blue)
	highlight("@function", colors.blue)
	highlight("@function.call", colors.blue)
	highlight("@function.method", colors.blue)
	highlight("@function.method.call", colors.blue)
	highlight("@function.builtin", colors.foreground)
	highlight("@constructor", colors.foreground)

	highlight("@lsp.type.function.cpp", colors.blue)
	highlight("@lsp.type.method.cpp", colors.blue)

	-- Function declarations and definitions
	for _, type_name in ipairs({ "function", "method" }) do
		highlight("@lsp.typemod." .. type_name .. ".declaration.cpp", colors.purple)
		highlight("@lsp.typemod." .. type_name .. ".definition.cpp", colors.purple)
	end

	-- Standard-library functions
	highlight("@lsp.typemod.function.defaultLibrary.cpp", colors.foreground)
	highlight("@lsp.typemod.method.defaultLibrary.cpp", colors.foreground)

	-- Namespaces
	highlight("@module", colors.foreground)
	highlight("@namespace", colors.foreground)
	highlight("@module.cpp", colors.foreground)
	highlight("@lsp.type.namespace.cpp", colors.foreground)

	-- Namespace declarations
	highlight("@lsp.typemod.namespace.declaration.cpp", colors.purple)
	highlight("@lsp.typemod.namespace.definition.cpp", colors.purple)

	-- Standard-library namespaces
	highlight("@lsp.typemod.namespace.defaultLibrary.cpp", colors.foreground)

	-- Variables and parameters
	highlight("Identifier", colors.foreground)
	highlight("@variable", colors.foreground)
	highlight("@variable.member", colors.foreground)
	highlight("@variable.parameter", colors.foreground)
	highlight("@property", colors.foreground)
	highlight("@attribute", colors.foreground)

	highlight("@lsp.type.variable.cpp", colors.foreground)
	highlight("@lsp.type.parameter.cpp", colors.foreground)
	highlight("@lsp.type.property.cpp", colors.foreground)
	highlight("@lsp.type.field.cpp", colors.foreground)

	-- Standard-library variables
	highlight("@lsp.typemod.variable.defaultLibrary.cpp", colors.foreground)

	-- Literals
	highlight("String", colors.cyan)
	highlight("@string", colors.cyan)
	highlight("@character", colors.cyan)

	highlight("Number", colors.blue)
	highlight("@number", colors.blue)
	highlight("@number.float", colors.blue)

	highlight("Boolean", colors.blue)
	highlight("@boolean", colors.blue)

	highlight("Constant", colors.foreground)
	highlight("@constant", colors.foreground)
	highlight("@constant.builtin", colors.blue)

	-- Preprocessor
	highlight("PreProc", colors.orange)
	highlight("Include", colors.orange)
	highlight("Define", colors.orange)
	highlight("Macro", colors.blue)

	highlight("@keyword.directive", colors.orange)
	highlight("@keyword.directive.define", colors.orange)

	-- Macro usages
	highlight("@constant.macro", colors.blue)
	highlight("@constant.macro.cpp", colors.blue)
	highlight("@function.macro", colors.blue)
	highlight("@function.macro.cpp", colors.blue)
	highlight("@lsp.type.macro.cpp", colors.blue)

	-- Macro declarations and definitions
	highlight("@lsp.typemod.macro.declaration.cpp", colors.purple)
	highlight("@lsp.typemod.macro.definition.cpp", colors.purple)

	-- Operators and punctuation
	highlight("Operator", colors.foreground)
	highlight("@operator", colors.foreground)
	highlight("@punctuation.delimiter", colors.foreground)
	highlight("@punctuation.bracket", colors.foreground)

	-- Context-specific highlights
	highlight("GithubCppCall", colors.blue)
	highlight("GithubCppNamespace", colors.blue)
	highlight("GithubCppNamespaceDefinition", colors.purple)
end

local function apply_cpp_context(buffer)
	if not vim.api.nvim_buf_is_valid(buffer) then
		return
	end

	vim.api.nvim_buf_clear_namespace(buffer, context_namespace, 0, -1)

	if vim.bo[buffer].filetype ~= "cpp" then
		return
	end

	if vim.g.colors_name ~= "github_dark_colorblind" then
		return
	end

	local parser_ok, parser = pcall(vim.treesitter.get_parser, buffer, "cpp")

	if not parser_ok then
		return
	end

	local query_ok, query = pcall(
		vim.treesitter.query.parse,
		"cpp",
		[[
		(call_expression
			function: (identifier) @github_call)

		(qualified_identifier
			scope: (namespace_identifier) @github_namespace)

		(namespace_definition
			name: (namespace_identifier) @github_namespace_definition)
	]]
	)

	if not query_ok then
		return
	end

	local trees = parser:parse()

	for _, tree in ipairs(trees) do
		for capture_id, node in query:iter_captures(tree:root(), buffer, 0, -1) do
			local capture = query.captures[capture_id]
			local group = nil

			if capture == "github_call" then
				group = "GithubCppCall"
			elseif capture == "github_namespace" then
				local name = vim.treesitter.get_node_text(node, buffer)

				if name ~= "std" and name ~= "Color" then
					group = "GithubCppNamespace"
				end
			elseif capture == "github_namespace_definition" then
				group = "GithubCppNamespaceDefinition"
			end

			if group then
				local start_row, start_col, end_row, end_col = node:range()

				vim.api.nvim_buf_set_extmark(buffer, context_namespace, start_row, start_col, {
					end_row = end_row,
					end_col = end_col,
					hl_group = group,
					priority = 200,
				})
			end
		end
	end
end

local function refresh_cpp_buffers()
	for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buffer) then
			apply_cpp_context(buffer)
		end
	end
end

local function set_theme()
	if not is_in_tmux() or selected_theme ~= "github" then
		vim.cmd("colorscheme default")
		refresh_cpp_buffers()
		return
	end

	local dark_mode = is_dark_mode()
	local theme = dark_mode and "github_dark_colorblind" or "github_light_colorblind"

	require("github-theme").setup({
		options = {
			terminal_colors = true,
			styles = {
				comments = "NONE",
				keywords = "NONE",
				functions = "NONE",
			},
		},
		palettes = {
			github_dark_colorblind = {
				bg0 = dark_background,
				bg1 = dark_background,
			},
		},
		groups = {
			github_dark_colorblind = {
				Normal = { bg = dark_background },
				NormalNC = { bg = dark_background },
			},
		},
	})

	vim.cmd("colorscheme " .. theme)

	if dark_mode then
		apply_highlights()
	end

	refresh_cpp_buffers()
end

local theme_group = vim.api.nvim_create_augroup("GithubTheme", {
	clear = true,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	group = theme_group,
	callback = function()
		if vim.g.colors_name == "github_dark_colorblind" then
			apply_highlights()
		end

		vim.schedule(refresh_cpp_buffers)
	end,
})

vim.api.nvim_create_autocmd("FocusGained", {
	group = theme_group,
	callback = set_theme,
})

vim.api.nvim_create_autocmd({
	"BufEnter",
	"BufWritePost",
	"InsertLeave",
	"TextChanged",
	"TextChangedI",
}, {
	group = theme_group,
	callback = function(event)
		apply_cpp_context(event.buf)
	end,
})

set_theme()
