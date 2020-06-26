extends Node2D

const CardSize = Vector2 (125, 175)
const CardBase = preload ("res://Cards/Card.tscn")
const PlayerHand = preload ("res://Cards/PlayerHand.gd")
var cardSelected = []
onready var deckSize = PlayerHand.cardList.size()

onready var screen_size = Vector2 (1920, 1080)

onready var CenteredCardOval = screen_size*Vector2(0.5, 1.45)
onready var Horizontal_Radius = get_viewport().size.x * 0.45
onready var Vertical_Radius = get_viewport().size.y * 0.4
var angle = deg2rad(90) - 0.3
var AngleVector = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _input(event):
#	if Input.is_action_just_released("leftclick"):
#		drawCard()
		
# Places a random card from the deck
func drawCard ():
	var new_card = CardBase.instance()
	cardSelected = randi() % deckSize
	new_card.cardName = PlayerHand.cardList[cardSelected]
	AngleVector = Vector2(Horizontal_Radius * cos(angle), - Vertical_Radius * sin(angle))
	new_card.rect_position = CenteredCardOval + AngleVector - new_card.rect_size/2
	new_card.rect_scale *= CardSize / new_card.rect_size
	$Cards.add_child(new_card)
	PlayerHand.cardList.erase(PlayerHand.cardList[cardSelected])
	deckSize -= 1
	angle+= 0.1
	return deckSize
