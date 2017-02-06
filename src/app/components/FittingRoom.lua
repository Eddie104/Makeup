--
-- Author: zhouhongjie@apowo.com
-- Date: 2017-02-06 15:12:41
--

local Tab = class("Tab", function (iconName, isSelected)
	return display.newSprite(isSelected and 'select.png' or 'unselect.png')
end)

function Tab:ctor(iconName, isSelected)
	if not isSelected then
		isSelected = false
	end
	self._isSelected = isSelected

	display.newSprite(iconName, 96 / 2, 104 / 2):addTo(self)
end

function Tab:selected(bool)
	if not self._isSelected == bool then
		self:setTexture(bool and 'select.png' or 'unselect.png')
		self._isSelected = bool
	end
end


--====================================

local Cell = class('Cell', function ()
	return display.newSprite('image 396.png')
end)

function Cell:ctor(imgName, category, categoryIndex, changeHandler)
	self._changeHandler = changeHandler
	self._category, self._categoryIndex = category, categoryIndex
	self._goods = display.newSprite(imgName):addTo(self):pos(46, 46)

	self:setTouchEnabled(true)
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, handler(self, self.onTouched))
end

function Cell:change(imgName, category)
	self._category = category
	self._goods:setTexture(imgName)
end

function Cell:onTouched(evt)
	if evt.name == 'began' then
		return true
	elseif evt.name == 'ended' then
		-- print(self._category, self._categoryIndex)
		self._changeHandler(self._category, self._categoryIndex)
	end
end

--====================================

local FittingRoom = class("FittingRoom", function ()
	return display.newNode()
end)

function FittingRoom:ctor(changeHandler)
	local h = 126
	display.newColorLayer(cc.c4b(255, 255, 255, 150)):addTo(self):setContentSize(cc.size(display.width, h))
	display.newColorLayer(cc.c4b(226, 213, 203, 255)):addTo(self):pos(0, h):setContentSize(cc.size(display.width, 3))
	display.newColorLayer(cc.c4b(172, 168, 169, 255)):addTo(self):pos(0, h + 3):setContentSize(cc.size(display.width, 3))

	self._cellArr = {}
	for i = 1, 6 do
		table.insert(self._cellArr, Cell.new('Icon10' .. i .. '.png', 1, i, changeHandler):addTo(self):pos(0 + i * 93, 56))
	end

	self._categoryListView = cc.ui.UIListView.new({ 
		direction = cc.ui.UIScrollView.DIRECTION_HORIZONTAL,
		-- bgColor = cc.c4b(255, 0, 0, 255),
		viewRect = cc.rect(0, 0, display.width, 104),
		async = false
	}):addTo(self):onTouch(handler(self, self.onTouch))
	self._categoryListView:pos(0, 126 + 6)

	self._tabArr = {}
	self._categoryListView:addItem(self:createTab('icon_01.png', true))
	self._categoryListView:addItem(self:createTab('icon_02.png'))
	self._categoryListView:addItem(self:createTab('icon_03.png'))
	self._categoryListView:addItem(self:createTab('icon_08.png'))
	self._categoryListView:addItem(self:createTab('icon_09.png'))
	self._categoryListView:reload()
end

function FittingRoom:onTouch(evt)
	if evt.name == 'clicked' then
		for i, v in ipairs(self._tabArr) do
			v:getContent():selected(evt.itemPos == i)
		end
		for i, v in ipairs(self._cellArr) do
			v:change('Icon' .. evt.itemPos .. '0' .. i .. '.png', evt.itemPos)
		end
	end
end

function FittingRoom:createTab(iconName, isSelected)
	local item = self._categoryListView:newItem(Tab.new(iconName, isSelected))
	item:setItemSize(96, 104)
	table.insert(self._tabArr, item)
	return item
end

return FittingRoom