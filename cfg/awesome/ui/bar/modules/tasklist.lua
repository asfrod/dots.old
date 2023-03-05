local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local beautiful = require("beautiful")
local dpi       = beautiful.xresources.apply_dpi
return function(s)
  local horiz = awful.widget.tasklist {
    screen          = s,
    filter          = awful.widget.tasklist.filter.currenttags,
    buttons         = {
      awful.button({}, 1, function(c)
        c:activate { context = "tasklist", action = "toggle_minimization" }
      end),
    },
    layout          = {
      layout = wibox.layout.fixed.horizontal,
      spacing = 5,
    },
    widget_template = {
      {
        {
          {
            {
              awful.widget.clienticon,
              forced_height = dpi(35),
              forced_width = dpi(35),
              halign = "center",
              valign = "center",
              widget = wibox.container.place,
            },
            margins = {
              left = dpi(3),
            },
            widget = wibox.container.margin,
          },
          {
            {
              {
                id            = "text_role",
                forced_height = dpi(20),
                widget        = wibox.widget.textbox,
              },
              widget = wibox.container.constraint,
              width = dpi(150)
            },
            margins = {
              left = dpi(10),
              right = dpi(10)
            },
            widget = wibox.container.margin,
          },
          spacing = dpi(10),
          layout = wibox.layout.align.horizontal,
        },
        margins = dpi(4),
        bg = beautiful.bg2,
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
    }

  }

  local vert = awful.widget.tasklist {
    screen          = s,
    filter          = awful.widget.tasklist.filter.currenttags,
    source          = function()
      local ret = {}
      for _, t in ipairs(s.tags) do
        gears.table.merge(ret, t:clients())
      end
      return ret
    end,
    buttons         = {
      awful.button({}, 1, function(c)
        c:activate { context = "tasklist", action = "toggle_minimization" }
      end),
    },
    layout          = {
      layout = wibox.layout.fixed.vertical,
      spacing = 10,
    },
    widget_template = {
      {
        {
          awful.widget.clienticon,
          forced_height = dpi(25),
          forced_width = dpi(25),
          halign = "center",
          valign = "center",
          widget = wibox.container.place,
        },
        margins = {
          top = 5,
          bottom = 5,
          left = 3,
          right = 3
        },
        widget  = wibox.container.margin
      },
      id     = 'background_role',
      widget = wibox.container.background
    }
  }
  local tasklist
  if beautiful.barDir == 'left' or beautiful.barDir == 'right' then
    tasklist = vert
  else
    tasklist = horiz
  end
  return tasklist
end
