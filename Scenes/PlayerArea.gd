extends Node2D

const CardSize = Vector2 (125, 175)
const CardBase = preload ("res://Cards/Card.tscn")
const PlayerHand = preload ("res://Cards/PlayerHand.gd")
var cardSelected = []
onready var deckSize = PlayerHand.cardList.size()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_released("leftclick"):
		placeCard()
		
# Places a random card from the deck
func placeCard ():
	var new_card = CardBase.instance()
	cardSelected = randi() % deckSize
	new_card.cardName = PlayerHand.cardList[cardSelected]
	new_card.rect_position = get_global_mouse_position()
	new_card.rect_scale *= CardSize / new_card.rect_size
	$Cards.add_child(new_card)
	PlayerHand.cardList.erase(PlayerHand.cardList[cardSelected])
	deckSize -= 1
