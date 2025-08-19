-- NOTE: These are my custom highlights for my taste ✨

-- Get colors from base16 colors
local colors = require('base16-colorscheme').colors
local colorUtil = require 'utils.colorManipulation'

-- Dap icons highlight
local sign = vim.fn.sign_define -- for convenience

sign('DapBreakpoint', {
  text = '●',
  texthl = 'DiagnosticError', -- Red color by default
  linehl = '',
  numhl = '',
})

sign('DapBreakpointCondition', {
  text = '●',
  texthl = 'DiagnosticWarn', -- Yellow/orange
  linehl = '',
  numhl = '',
})

sign('DapLogPoint', {
  text = '◆',
  texthl = 'DiagnosticInfo', -- Blue or light blue
  linehl = '',
  numhl = '',
})

sign('DapStopped', {
  text = '',
  texthl = 'DiagnosticHint', -- Typically green
  linehl = 'Visual', -- Highlights the whole line
  numhl = 'CursorLineNr', -- Number column highlight
})

-- Stop stylua from here
-- stylua: ignore start


-- Core highlights
vim.api.nvim_set_hl(0, 'Normal',      { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = colorUtil.darken(colors.base00, 0.2), fg = colors.base05 })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = colorUtil.darken(colors.base00, 0.2), fg = colorUtil.darken(colors.base00, 0.2) })
vim.api.nvim_set_hl(0, 'FloatTitle',  { bg = colors.base0E, fg = colors.base00, bold = true })
vim.api.nvim_set_hl(0, 'Pmenu',       { link = "NormalFloat" })
vim.api.nvim_set_hl(0, 'PmenuSel',    { bg = colors.base01, fg = 'none' })
vim.api.nvim_set_hl(0, 'PmenuThumb',  { bg = colors.base02, fg = colors.base05 })
vim.api.nvim_set_hl(0, 'PmenuSbar',   { bg = colors.base05, fg = colors.base05 })
vim.api.nvim_set_hl(0, 'Terminal',    { bg = 'none' })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FoldColumn',  { bg = 'none' })
vim.api.nvim_set_hl(0, 'Folded',      { bg = 'none' })
vim.api.nvim_set_hl(0, 'SignColumn',  { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalNC',    { bg = 'none' })
vim.api.nvim_set_hl(0, 'LineNr',      { bg = 'none' })
vim.api.nvim_set_hl(0, 'ErrorMsg',    { bg = 'none' })
vim.api.nvim_set_hl(0, 'WarningMsg',  { bg = 'none' })
vim.api.nvim_set_hl(0, 'ModeMsg',     { bg = 'none' })

-- Telescope highlights
local darkerbg         = colorUtil.darken(colors.base00, 0.2)
local darkercursorline = colorUtil.darken(colors.base01, 0.1)
local darkerstatusline = colorUtil.darken(colors.base02, 0.1)

vim.api.nvim_set_hl(0, "TelescopeBorder",         { fg = darkerbg,         bg = darkerbg         })
vim.api.nvim_set_hl(0, "TelescopePromptBorder",   { fg = darkerstatusline, bg = darkerstatusline })
vim.api.nvim_set_hl(0, "TelescopePromptNormal",   { fg = colors.base05,    bg = darkerstatusline })
vim.api.nvim_set_hl(0, "TelescopePromptPrefix",   { fg = colors.base08,    bg = darkerstatusline })
vim.api.nvim_set_hl(0, "TelescopeNormal",         { fg = 'none',           bg = darkerbg         })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle",   { fg = darkercursorline, bg = colors.base0E, bold = true })
vim.api.nvim_set_hl(0, "TelescopePromptTitle",    { fg = darkercursorline, bg = colors.base0D, bold = true })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle",   { fg = darkerbg,         bg = colors.base0B, bold = true })
vim.api.nvim_set_hl(0, "TelescopeSelection",      { fg = colors.base0D,    bg = 'none' })
vim.api.nvim_set_hl(0, "TelescopeMatching",       { fg = colors.base09,    bg = 'none' })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = colors.base08,    bg = 'none' })
vim.api.nvim_set_hl(0, "TelescopePreviewLine",    { fg = 'none',           bg = colors.base01 })



-- Transparent background for nvim-tree
vim.api.nvim_set_hl(0, 'NvimTreeNormal',      { bg = 'none' })
vim.api.nvim_set_hl(0, 'NvimTreeVertSplit',   { bg = 'none' })
vim.api.nvim_set_hl(0, 'NvimTreeEndOfBuffer', { bg = 'none' })

-- Notification highlights
vim.api.nvim_set_hl(0, 'NotifyBackground',  { bg = 'none', fg = 'none' })
vim.api.nvim_set_hl(0, 'NotifyINFOBody',    { bg = 'none', fg = colors.base05 })
vim.api.nvim_set_hl(0, 'NotifyERRORBody',   { bg = 'none', fg = colors.base09 })
vim.api.nvim_set_hl(0, 'NotifyWARNBody',    { bg = 'none', fg = colors.base0A })
vim.api.nvim_set_hl(0, 'NotifyTRACEBody',   { bg = 'none', fg = colors.base0B })
vim.api.nvim_set_hl(0, 'NotifyDEBUGBody',   { bg = 'none', fg = colors.base0B })
vim.api.nvim_set_hl(0, 'NotifyINFOTitle',   { bg = 'none', fg = colors.base05 })
vim.api.nvim_set_hl(0, 'NotifyERRORTitle',  { bg = 'none', fg = colors.base09 })
vim.api.nvim_set_hl(0, 'NotifyWARNTitle',   { bg = 'none', fg = colors.base0A })
vim.api.nvim_set_hl(0, 'NotifyTRACETitle',  { bg = 'none', fg = colors.base0B })
vim.api.nvim_set_hl(0, 'NotifyDEBUGTitle',  { bg = 'none', fg = colors.base0B })
vim.api.nvim_set_hl(0, 'NotifyINFOBorder',  { bg = 'none', fg = colors.base05 })
vim.api.nvim_set_hl(0, 'NotifyERRORBorder', { bg = 'none', fg = colors.base09 })
vim.api.nvim_set_hl(0, 'NotifyWARNBorder',  { bg = 'none', fg = colors.base0A })
vim.api.nvim_set_hl(0, 'NotifyTRACEBorder', { bg = 'none', fg = colors.base0B })
vim.api.nvim_set_hl(0, 'NotifyDEBUGBorder', { bg = 'none', fg = colors.base0B })
vim.api.nvim_set_hl(0, 'NotifyINFOIcon',    { bg = 'none', fg = colors.base05 })
vim.api.nvim_set_hl(0, 'NotifyERRORIcon',   { bg = 'none', fg = colors.base09 })
vim.api.nvim_set_hl(0, 'NotifyWARNIcon',    { bg = 'none', fg = colors.base0A })
vim.api.nvim_set_hl(0, 'NotifyTRACEIcon',   { bg = 'none', fg = colors.base0B })
vim.api.nvim_set_hl(0, 'NotifyDEBUGIcon',   { bg = 'none', fg = colors.base0B })

-- Dashboard highlights (mini.starter)
vim.api.nvim_set_hl(0, 'MiniStarterHeader',      { bg = 'none', fg = colors.base0D })
vim.api.nvim_set_hl(0, 'MiniStarterFooter',      { bg = 'none', fg = colors.base0E })
vim.api.nvim_set_hl(0, 'MiniStarterItemPrefix',  { bg = 'none', fg = colors.base0B })
vim.api.nvim_set_hl(0, 'MiniStarterSection',     { bg = 'none', fg = colors.base0C })

-- Noice highlights
vim.api.nvim_set_hl(0, 'NoiceCmdline',                       { link = 'Normal' })
vim.api.nvim_set_hl(0, 'NoiceCmdlineIcon',                   { fg = colors.base0B })
vim.api.nvim_set_hl(0, 'NoiceCmdlineIconCalculator',         { link = 'NoiceCmdlineIcon' })
vim.api.nvim_set_hl(0, 'NoiceCmdlineIconCmdline',            { link = 'NoiceCmdlineIcon' })
vim.api.nvim_set_hl(0, 'NoiceCmdlineIconFilter',             { link = 'NoiceCmdlineIcon' })
vim.api.nvim_set_hl(0, 'NoiceCmdlineIconHelp',               { link = 'NoiceCmdlineIcon' })
vim.api.nvim_set_hl(0, 'NoiceCmdlineIconIncRename',          { link = 'NoiceCmdlineIcon' })
vim.api.nvim_set_hl(0, 'NoiceCmdlineIconInput',              { link = 'NoiceCmdlineIcon' })
vim.api.nvim_set_hl(0, 'NoiceCmdlineIconLua',                { link = 'NoiceCmdlineIcon' })
vim.api.nvim_set_hl(0, 'NoiceCmdlineIconSearch',             { link = 'NoiceCmdlineIcon' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopup',                  { link = 'NormalFloat' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorder',            { link = 'FloatBorder' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorderCalculator',  { link = 'NoiceCmdlinePopupBorder' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorderCmdline',     { link = 'NoiceCmdlinePopupBorder' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorderFilter',      { link = 'NoiceCmdlinePopupBorder' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorderHelp',        { link = 'NoiceCmdlinePopupBorder' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorderIncRename',   { link = 'NoiceCmdlinePopupBorder' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorderInput',       { link = 'NoiceCmdlinePopupBorder' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorderLua',         { link = 'NoiceCmdlinePopupBorder' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorderSearch',      { link = 'NoiceCmdlinePopupBorder' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitle',             { link = 'FloatTitle' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitleLua',          { link = 'NoiceCmdlinePopupTitle' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitleHelp',         { link = 'NoiceCmdlinePopupTitle' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitleInput',        { link = 'NoiceCmdlinePopupTitle' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitleFilter',       { link = 'NoiceCmdlinePopupTitle' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitleSearch',       { link = 'NoiceCmdlinePopupTitle' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitleCmdline',      { link = 'NoiceCmdlinePopupTitle' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitleIncRename',    { link = 'NoiceCmdlinePopupTitle' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitleCalculator',   { link = 'NoiceCmdlinePopupTitle' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePrompt',                 { link = 'FloatTitle' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindDefault',     { link = 'Special' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindClass',       { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindColor',       { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindConstant',    { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindConstructor', { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindEnum',        { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindEnumMember',  { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindField',       { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindFile',        { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindFolder',      { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindFunction',    { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindInterface',   { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindKeyword',     { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindMethod',      { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindModule',      { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindProperty',    { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindSnippet',     { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindStruct',      { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindText',        { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindUnit',        { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindValue',       { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceCompletionItemKindVariable',    { link = 'NoiceCompletionItemKindDefault' })
vim.api.nvim_set_hl(0, 'NoiceConfirmBorder',                 { bg = colorUtil.darken(colors.base00, 0.2), fg = colorUtil.darken(colors.base00, 0.2),  })
vim.api.nvim_set_hl(0, 'NoiceConfirm',                       { bg = colorUtil.darken(colors.base00, 0.2), fg = colors.base0B })
vim.api.nvim_set_hl(0, 'NoiceFormatConfirm',                 { bg = colors.base01, fg = colors.base05 })

-- Blink-Cmp highlights
vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder',        { link = 'FloatBorder' }) -- link to float border
vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder',         { link = 'FloatBorder' }) -- link to float border
vim.api.nvim_set_hl(0, 'BlinkCmpDocSeparator',      { fg = colors.base0D, bg = 'none' }) -- separate doc and detail with a blue line
vim.api.nvim_set_hl(0, 'BlinkCmpKindText',          { fg = colors.base0B }) -- green
vim.api.nvim_set_hl(0, 'BlinkCmpKindMethod',        { fg = colors.base0D }) -- blue
vim.api.nvim_set_hl(0, 'BlinkCmpKindFunction',      { fg = colors.base0D }) -- blue
vim.api.nvim_set_hl(0, 'BlinkCmpKindConstructor',   { fg = colors.base0D }) -- blue
vim.api.nvim_set_hl(0, 'BlinkCmpKindField',         { fg = colors.base0B }) -- green
vim.api.nvim_set_hl(0, 'BlinkCmpKindVariable',      { fg = colors.base08 }) -- red
vim.api.nvim_set_hl(0, 'BlinkCmpKindClass',         { fg = colors.base0A }) -- yellow
vim.api.nvim_set_hl(0, 'BlinkCmpKindInterface',     { fg = colors.base0A }) -- yellow
vim.api.nvim_set_hl(0, 'BlinkCmpKindModule',        { fg = colors.base0D }) -- blue
vim.api.nvim_set_hl(0, 'BlinkCmpKindProperty',      { fg = colors.base0D }) -- blue
vim.api.nvim_set_hl(0, 'BlinkCmpKindUnit',          { fg = colors.base0B }) -- green
vim.api.nvim_set_hl(0, 'BlinkCmpKindValue',         { fg = colors.base09 }) -- orange
vim.api.nvim_set_hl(0, 'BlinkCmpKindEnum',          { fg = colors.base0A }) -- yellow
vim.api.nvim_set_hl(0, 'BlinkCmpKindKeyword',       { fg = colors.base0E }) -- magenta
vim.api.nvim_set_hl(0, 'BlinkCmpKindSnippet',       { fg = colors.base08 }) -- red
vim.api.nvim_set_hl(0, 'BlinkCmpKindColor',         { fg = colors.base08 }) -- red
vim.api.nvim_set_hl(0, 'BlinkCmpKindFile',          { fg = colors.base0D }) -- blue
vim.api.nvim_set_hl(0, 'BlinkCmpKindReference',     { fg = colors.base08 }) -- red
vim.api.nvim_set_hl(0, 'BlinkCmpKindFolder',        { fg = colors.base0D }) -- blue
vim.api.nvim_set_hl(0, 'BlinkCmpKindEnumMember',    { fg = colors.base0C }) -- cyan
vim.api.nvim_set_hl(0, 'BlinkCmpKindConstant',      { fg = colors.base09 }) -- orange
vim.api.nvim_set_hl(0, 'BlinkCmpKindStruct',        { fg = colors.base0D }) -- blue
vim.api.nvim_set_hl(0, 'BlinkCmpKindEvent',         { fg = colors.base0D }) -- blue
vim.api.nvim_set_hl(0, 'BlinkCmpKindOperator',      { fg = colors.base0C }) -- cyan
vim.api.nvim_set_hl(0, 'BlinkCmpKindTypeParameter', { fg = colors.base0F }) -- brown
vim.api.nvim_set_hl(0, 'BlinkCmpKindCopilot',       { fg = colors.base0C }) -- cyan


-- Treesitter highlights

local treesitterhighlights = {
  TSAnnotation              = { fg = colors.base0E },
  TSAttribute               = { fg = colors.base0E },
  TSBoolean                 = { fg = colors.base0E },
  TSCharacter               = { fg = colors.base0C },
  TSCharacterSpecial        = { link = "SpecialChar" },
  TSComment                 = { link = "Comment" },
  TSConditional             = { fg = colors.base08 },
  TSConstBuiltin            = { fg = colors.base0E },
  TSConstMacro              = { fg = colors.base0E },
  TSConstant                = { fg = colors.base05 },
  TSConstructor             = { fg = colors.base0B },
  TSDebug                   = { link = "Debug" },
  TSDefine                  = { link = "Define" },
  TSEnvironment             = { link = "Macro" },
  TSEnvironmentName         = { link = "Type" },
  TSError                   = { link = "Error" },
  TSException               = { fg = colors.base08 },
  TSField                   = { fg = colors.base0D },
  TSFloat                   = { fg = colors.base0E },
  TSFuncBuiltin             = { fg = colors.base0B },
  TSFuncMacro               = { fg = colors.base0B },
  TSFunction                = { fg = colors.base0B },
  TSFunctionCall            = { fg = colors.base0B },
  TSInclude                 = { fg = colors.base08 },
  TSKeyword                 = { fg = colors.base08 },
  TSKeywordFunction         = { fg = colors.base08 },
  TSKeywordOperator         = { fg = colors.base09 },
  TSKeywordReturn           = { fg = colors.base08 },
  TSLabel                   = { fg = colors.base09 },
  TSLiteral                 = { link = "String" },
  TSMath                    = { fg = colors.base0D },
  TSMethod                  = { fg = colors.base0B },
  TSMethodCall              = { fg = colors.base0B },
  TSNamespace               = { fg = colors.base0A },
  TSNone                    = { fg = colors.base05 },
  TSNumber                  = { fg = colors.base0E },
  TSOperator                = { fg = colors.base09 },
  TSParameter               = { fg = colors.base05 },
  TSParameterReference      = { fg = colors.base05 },
  TSPreProc                 = { link = "PreProc" },
  TSProperty                = { fg = colors.base0D },
  TSPunctBracket            = { fg = colors.base05 },
  TSPunctDelimiter          = { link = "Delimiter" },
  TSPunctSpecial            = { fg = colors.base0D },
  TSRepeat                  = { fg = colors.base08 },
  TSStorageClass            = { fg = colors.base09 },
  TSStorageClassLifetime    = { fg = colors.base09 },
  TSStrike                  = { fg = colors.base04 },
  TSString                  = { fg = colors.base0C },
  TSStringEscape            = { fg = colors.base0B },
  TSStringRegex             = { fg = colors.base0B },
  TSStringSpecial           = { link = "SpecialChar" },
  TSSymbol                  = { fg = colors.base05 },
  TSTag                     = { fg = colors.base09 },
  TSTagAttribute            = { fg = colors.base0B },
  TSTagDelimiter            = { fg = colors.base0B },
  TSText                    = { fg = colors.base0B },
  TSTextReference           = { link = "Constant" },
  TSTitle                   = { link = "Title" },
  TSTodo                    = { link = "Todo" },
  TSType                    = { fg = colors.base0A, bold = true },
  TSTypeBuiltin             = { fg = colors.base0A, bold = true },
  TSTypeDefinition          = { fg = colors.base0A, bold = true },
  TSTypeQualifier           = { fg = colors.base09, bold = true },
  TSURI                     = { fg = colors.base0D },
  TSVariable                = { fg = colors.base05 },
  TSVariableBuiltin         = { fg = colors.base0E },
}
-- stylua: ignore end
-- stopped ignoring stylua from now on

-- Apply all treesitter highlights
for group, opts in pairs(treesitterhighlights) do
  vim.api.nvim_set_hl(0, group, opts)
end
