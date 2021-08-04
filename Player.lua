-- push.lua v0.3

-- Copyright (c) 2018 Ulysse Ramage
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

local love11 = love.getVersion() == 11
local getDPI = love11 and love.window.getDPIScale or love.window.getPixelScale
local windowUpdateMode = love11 and love.window.updateMode or function(width, height, settings)
  local _, _, flags = love.window.getMode()
  for k, v in pairs(settings) do flags[k] = v end
  love.window.setMode(width, height, flags)
end

local push = {
  
    defaults = {
      fullscreen = false,
      resizable = false,
      pixelperfect = false,
      highdpi = true,
      canvas = true,
      stencil = true
    }
    
  }
  setmetatable(push, push)

function push:applySettings(settings)
    for k, v in pairs(settings) do
        self["_" .. k] = v
    end
end

function push:resetSettings() return self:applySettings(self.defaults) end

function push:setupScreen(WWIDTH, WHEIGHT, RWIDTH, RHEIGHT, settings)

    settings = settings or {}
  
    self._WWIDTH, self._WHEIGHT = WWIDTH, WHEIGHT
    self._RWIDTH, self._RHEIGHT = RWIDTH, RHEIGHT
  
    self:applySettings(self.defaults) --set defaults first
    self:applySettings(settings) --then fill with custom settings
    
    windowUpdateMode(self._RWIDTH, self._RHEIGHT, {
      fullscreen = self._fullscreen,
      resizable = self._resizable,
      highdpi = self._highdpi
    })
  
    self:initValues()
  
    if self._canvas then
      self:setupCanvas({ "default" }) --setup canvas
    end
  
    self._borderColor = {0, 0, 0}
  
    self._drawFunctions = {
      ["start"] = self.start,
      ["end"] = self.finish
    }
  
    return self
  end