extends MarginContainer


# Declare member variables here. Examples:
var cardName = "Yellow_Octo"

# Called when the node enters the scene tree for the first time.
func _ready():
	var CardDatabase = get_node ("/root/GameScene/CardDatabase")
	print (CardDatabase.DATA)
	var cardInfo = CardDatabase.DATA[cardName]
	var CardImg = str("res://Cards/Assets/Backgrounds/", cardName, ".png")
	
	print(cardInfo)
	print (CardImg)
	var cardSize = rect_size
	$Border.scale *= cardSize/$Border.texture.get_size()
	$Card.texture = load (CardImg)
	$Card.scale *= cardSize/$Card.texture.get_size()
	
	var attack = cardInfo.attack_power
	var attack_speed = cardInfo.attack_speed
	var health = cardInfo.health
	var cost = "NA"
	$Bars/TopBar/Name/CenterContainer/Name.text = str(cardName)
	$Bars/TopBar/Cost/CenterContainer/Cost.text = str(cost)
	$Bars/BottomBar/Stats/CenterContainer/Stats.text = str(attack, "@", attack_speed)
	$Bars/BottomBar/Health/CenterContainer/Health.text = str(health)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
