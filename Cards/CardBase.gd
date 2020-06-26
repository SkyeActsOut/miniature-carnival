extends MarginContainer


# Declare member variables here. Examples:
onready var CardDatabase = preload ("res://Cards/CardDatabase.gd")
var cardName = "Blank"
onready var cardInfo = CardDatabase.DATA[CardDatabase.get(cardName)]
onready var CardImg = str("res://Cards/Assets/", cardInfo[0], "/", cardName, ".png")

# Called when the node enters the scene tree for the first time.
func _ready():
	print(cardInfo)
	print (CardImg)
	var cardSize = rect_size
	$Border.scale *= cardSize/$Border.texture.get_size()
	$Card.texture = load (CardImg)
	$Card.scale *= cardSize/$Card.texture.get_size()
	
	var attack = cardInfo[1]
	var retaliation = cardInfo[2]
	var health = cardInfo[3]
	var cost = cardInfo[4]
	var specialText = cardInfo [7]
	$Bars/TopBar/Name/CenterContainer/Name.text = str(cardName)
	$Bars/TopBar/Cost/CenterContainer/Cost.text = str(cost)
	$Bars/CardMiddle/Text/CenterContainer/Text.text = str(specialText)
	$Bars/BottomBar/Stats/CenterContainer/Stats.text = str(attack, "/", retaliation)
	$Bars/BottomBar/Health/CenterContainer/Health.text = str(health)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
