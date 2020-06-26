extends MarginContainer

# CARD VARS
var cardName = "Yellow_Octo"
var offset = Vector2()

# ANIMATION VARS
var destination
var time
var elapsed = 0
var start_pos
var anim 

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = rect_position
	
	var CardDatabase = get_node ("/root/GameScene/CardDatabase")
	print (CardDatabase.DATA)
	var cardInfo = CardDatabase.DATA[cardName]
	var CardImg = str("res://Cards/Assets/Backgrounds/", cardName, ".png")
	
	print(cardInfo)
	print (CardImg)
	var cardSize = rect_size
	$Card_Parent/Border.scale *= cardSize/$Card_Parent/Border.texture.get_size()
	$Card_Parent/Card.texture = load (CardImg)
	$Card_Parent/Card.scale *= cardSize/$Card_Parent/Card.texture.get_size()
	
	var attack = cardInfo.attack_power
	var attack_speed = cardInfo.attack_speed
	var health = cardInfo.health
	var cost = "NA"
	$Card_Parent/Bars/TopBar/Name/CenterContainer/Name.text = str(cardName)
	$Card_Parent/Bars/TopBar/Cost/CenterContainer/Cost.text = str(cost)
	$Card_Parent/Bars/BottomBar/Stats/CenterContainer/Stats.text = str(attack, "@", attack_speed)
	$Card_Parent/Bars/BottomBar/Health/CenterContainer/Health.text = str(health)
	
	set_process(true)

func _on_Focus_mouse_entered():
	offset = Vector2 (0, -35)
	$Card_Parent.position = offset
	elapsed = 0
	destination = start_pos + offset
	time = 0.15
	anim = true

func _on_Focus_mouse_exited():
	offset = Vector2 (0, 0)
	$Card_Parent.position = offset
	elapsed = 0
	destination = start_pos + offset
	time = 0.15
	anim = true
	
func _process(delta):
	if (anim):
		if elapsed >= time:
			rect_position = destination
			anim = false
		elapsed += delta
		var intermediate =  (destination - start_pos) * (elapsed / time) + start_pos
		rect_position = intermediate
