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
var anim_done

# Scripts
var CardDatabase
var InspectArea
var Tiles

# Dragged / Place
var dragged
var placed

# Size Vectors
var cardSize = Vector2(175, 245)
var cardScaler = Vector2 (0.75, 0.75)
var smallCardSize = cardSize * cardScaler
var placedCardSize = Vector2(105, 147)

var init_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_filter = MOUSE_FILTER_IGNORE
	
	InspectArea = get_node ("/root/GameScene/InspectArea")
	
	Tiles = get_node ("/root/GameScene/Tiles")
	
	CardDatabase = get_node ("/root/GameScene/CardDatabase")
	print (CardDatabase.DATA)
	var cardInfo = CardDatabase.DATA[cardName]
	var CardImg = str("res://Cards/Assets/Backgrounds/", cardName, ".png")
	
	print(cardInfo)
	print (CardImg)
	$Card_Parent/Card.texture = load (CardImg)
	setSize(cardSize)
	
	var attack = cardInfo.attack_power
	var attack_speed = cardInfo.attack_speed
	var health = cardInfo.health
	var cost = "NA"
	$Card_Parent/Bars/TopBar/Name/CenterContainer/Name.text = str(cardName)
	$Card_Parent/Bars/TopBar/Cost/CenterContainer/Cost.text = str(cost)
	$Card_Parent/Bars/BottomBar/Stats/CenterContainer/Stats.text = str(attack, "@", attack_speed)
	$Card_Parent/Bars/BottomBar/Health/CenterContainer/Health.text = str(health)
	
	init_pos = rect_position
	
	set_process(true)

func setSize (size):
	rect_scale = size / rect_size # Sets the scale to the difference between the desired size and the current size
	# Sets textures to double the desired size (double because the desired size is half of the actual), devided by the texture size
	$Card_Parent/Border.scale = size*Vector2(2, 2)/$Card_Parent/Border.texture.get_size()
	$Card_Parent/Card.scale = size*Vector2(2, 2)/$Card_Parent/Card.texture.get_size()

func _on_Focus_mouse_entered():
	#Position
	if (!placed):
		offset = Vector2 (0, -100)
		start_pos = Vector2(0, 0)
#		$Card_Parent.position = offset
	
	#Animation
	elapsed = 0
	destination = offset
	time = 0.1
	anim = true
	anim_done = false
	
	InspectArea.inspect (self)

func _on_Focus_mouse_exited():
	#Position
	if (!placed):
		offset = Vector2 (0, 0)
		start_pos = Vector2(0, -100)
	
	#Animation
	elapsed = 0
	destination = offset
	time = 0.1
	anim = true
	anim_done = false
	
	InspectArea.inspect (null)

# SETS DRAGGING POSITION
func _on_Focus_gui_input(event):
	if event is InputEventMouseButton:
		if (!placed):
			if event.is_pressed():
				dragged = true
				setSize (smallCardSize)
			else:
				dragged = false
				setSize (cardSize)
		else:
			pass

# UPDATE FUNCTION
# USED FOR ANIMATIONS & DRAGGING
func _process(delta):
	# ANIMATIONS
	if (anim && !placed):
		elapsed += delta
		var intermediate =  (destination - start_pos) * (elapsed / time) + start_pos
		$Card_Parent.position = intermediate
		if elapsed >= time:
			$Card_Parent.position = destination
			anim = false
			anim_done = true
	
	# DRAGGING
	elif (dragged && !placed):
		set_position(get_viewport().get_mouse_position() - smallCardSize)
		
	# CARD PLACEMENT
	elif (!placed):
		# Checks to see if the card is on any of the tiles
		if (!isStationary()):
			var tile = Tiles.isOnTile(rect_position)
			if (tile != null):
				placeCard(tile)
			else:
				rect_position = init_pos
		
func placeCard (tile):
	placed = true
	setSize(smallCardSize)
	init_pos = tile.rect_position
	rect_position = tile.rect_position
	
func isStationary ():
	return init_pos == rect_position || anim || !anim_done

