extends Node

var size = 7
const TileBase = preload ("res://Cards/Tile.tscn")
var x = 100
var y = 50

var map = []

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
			
