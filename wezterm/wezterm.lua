-- This configuration breaks up the configuration into multiple files
-- The key is that our goal is to return a big table so we need a function to merge a bunch of little tables
-- From: https://github.com/Hdoc1509/wezterm-config/blob/master/wezterm.lua
-- 
local merge = require('kruger.utils').merge
local basic = require('kruger.basic')
local appearance = require('kruger.appearance')
local keymaps = require('kruger.keymaps')

return merge(basic, appearance, keymaps)
