--
-- Author: zhouhongjie@apowo.com
-- Date: 2017-02-06 14:54:31
--

local Avatar = class("Avatar", function ()
	return display.newNode()
end)

function Avatar:ctor()
	self._shirt = display.newSprite('31.png'):addTo(self)
	display.newSprite('601_head.png'):addTo(self)
	self._nacklace = display.newSprite('51.png'):addTo(self)
	self._hair = display.newSprite('11.png'):addTo(self)
	self._earrings = display.newSprite('21.png'):addTo(self)
	self._hat = display.newSprite('41.png'):addTo(self)
	self._bodyArr = {
		self._hair,
		self._earrings,
		self._shirt,
		self._hat,
		self._nacklace
	}
end

function Avatar:change(category, index)
	self._bodyArr[category]:setTexture(category .. index .. '.png')
end

return Avatar