--[[
    Contains tile data and necessary code for rendering a tile map to the
    screen.
]]

require 'Util'
Map = Class{}

-- width of the pyramid
WIDTH = 10
PYRAMID = 4


-- FLag
POST_1 = 8
POST_2 = 12
POST_3 = 16

FLAG = 13
FLAG_1 = 14
FLAG_2 = 15



TILE_BRICK = 1
TILE_EMPTY = -1

-- cloud tiles
CLOUD_LEFT = 6
CLOUD_RIGHT = 7

-- bush tiles
BUSH_LEFT = 2
BUSH_RIGHT = 3

-- mushroom tiles
MUSHROOM_TOP = 10
MUSHROOM_BOTTOM = 11

-- jump block
JUMP_BLOCK = 5
JUMP_BLOCK_HIT = 9

-- a speed to multiply delta time to scroll map; smooth value
local SCROLL_SPEED = 62
