
local Avatar = import('..components.Avatar')
local FittingRoom = import('..components.FittingRoom')

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	display.newSprite('901_Bg.png'):addTo(self):align(display.CENTER_TOP, display.cx, display.top)
	self._avatar = Avatar.new():addTo(self)
	self._avatar:pos(display.cx, display.cy + 150)

	-- self:setTouchEnabled(true)
	-- self:addNodeEventListener(cc.NODE_TOUCH_EVENT, handler(self, self.onTouched))


	FittingRoom.new(handler(self._avatar, self._avatar.change)):addTo(self):pos(display.left, display.bottom)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

-- function MainScene:onTouched(evt)
-- 	if evt.name == 'began' then
-- 		return true
-- 	elseif evt.name == 'ended' then
-- 		self._avatar:change('shirt', '402_shirts.png')
-- 	end
-- end

return MainScene
