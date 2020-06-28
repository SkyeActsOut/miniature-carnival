extends Node

var size = 7
const TileBase = preload ("res://Cards/Tile.tscn")
var x = 100
var y = 50

onready var map = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(size):
		map.append([])
		for j in range(size):
			map [i].append(TileBase.instance())
			map [i][j].rect_position = Vector2(x, y)
			add_child(map[i][j])
			print (str ("PLACING AT: ", x, " ", y))
			x+= 125
		y+= 125
		x = 100
		
func isOnTile (pos):
	for i in range(size):
		for j in range(size):
			var posDiff = sqrt(pow(map[i][j].rect_position.x - pos.x, 2) + pow(map[i][j].rect_position.y - pos.y, 2))
			if (posDiff <= 128):
				print (str("PLACING ON ", i, " ", j))
				return map[i][j]
	return null
