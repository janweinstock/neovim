-- CPU / memory usage of the machine nvim is running on (Linux only).
-- Sampled from /proc at most every 2s; lualine redraws once per second.
local uv = vim.uv or vim.loop
local sys = { at = 0, total = 0, idle = 0, cpu = nil, mem = nil }

local ICON_CPU = "\u{f035b}" -- nf-md-memory (chip)
local ICON_MEM = "\u{f0328}" -- nf-md-layers

local function read(path)
  local f = io.open(path)
  if not f then
    return nil
  end
  local s = f:read("*a")
  f:close()
  return s
end

local function sample()
  local now = uv.now()
  if sys.at ~= 0 and now - sys.at < 2000 then
    return
  end

  local stat, meminfo = read("/proc/stat"), read("/proc/meminfo")
  if not stat or not meminfo then
    return
  end

  -- cpu  user nice system idle iowait irq softirq steal ...
  local v = {}
  for n in stat:match("^cpu%s+([^\n]+)"):gmatch("%d+") do
    v[#v + 1] = tonumber(n)
  end
  local total = 0
  for i = 1, math.min(8, #v) do
    total = total + v[i]
  end
  local idle = v[4] + (v[5] or 0)
  if sys.at ~= 0 and total > sys.total then
    sys.cpu = 100 * (1 - (idle - sys.idle) / (total - sys.total))
  end
  sys.at, sys.total, sys.idle = now, total, idle

  local mem_total = tonumber(meminfo:match("MemTotal:%s+(%d+)"))
  local mem_avail = tonumber(meminfo:match("MemAvailable:%s+(%d+)"))
  if mem_total and mem_avail then
    sys.mem = 100 * (1 - mem_avail / mem_total)
  end
end

-- "%%" is a literal percent sign in a statusline
local function cpu()
  sample()
  return sys.cpu and string.format("%s %2d%%%%", ICON_CPU, sys.cpu) or ""
end

local function mem()
  sample()
  return sys.mem and string.format("%s %2d%%%%", ICON_MEM, sys.mem) or ""
end

-- green -> yellow -> orange -> red (dracula palette)
local function level_color(key)
  return function()
    local pct = sys[key] or 0
    if pct >= 90 then
      return { fg = "#ff5555", gui = "bold" }
    elseif pct >= 70 then
      return { fg = "#ffb86c" }
    elseif pct >= 40 then
      return { fg = "#f1fa8c" }
    end
    return { fg = "#50fa7b" }
  end
end

-- Each window has its own statusline, so narrow splits need to drop things.
local function wider_than(cols)
  return function()
    return vim.api.nvim_win_get_width(0) >= cols
  end
end

-- Encoding / fileformat / filetype say nothing useful about a terminal buffer
-- (e.g. "snacks_terminal") and only eat space there.
local function file_info(cols)
  return function()
    return vim.bo.buftype ~= "terminal" and vim.api.nvim_win_get_width(0) >= cols
  end
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    require("lualine").setup({
      options = {
        theme = "dracula",
      },
      sections = {
        lualine_x = {
          { cpu, color = level_color("cpu"), cond = wider_than(40) },
          { mem, color = level_color("mem"), cond = wider_than(40) },
          { "encoding", cond = file_info(100) },
          { "fileformat", cond = file_info(100) },
          { "filetype", cond = file_info(0) },
        },
      },
    })
  end,
}
