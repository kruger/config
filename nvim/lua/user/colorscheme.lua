-- this is where you set your colorscheme:
local colorscheme = "koehler"

-- this makes sure it's there.
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
