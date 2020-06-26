extends Node

var card_size = Vector2 (500, 700)
var position = Vector2(1400, 100)
var inspect_card

const CardBase = preload ("res://Cards/Card.tscn")

func inspect (card):
	print (card)
	if (card == null):
		remove_child(inspect_card)
	else:
		inspect_card = card.duplicate()
		inspect_card.rect_position = position
		inspect_card.rect_scale *= card_size / inspect_card.rect_size
		self.add_child(inspect_card)
		print (inspect_card.rect_position)

static func clone(node, new_owner):
	if node.get_child_count():
		for kid in node.get_children():
			print (kid)
			new_owner.add_child ( kid.duplicate() )
			clone (kid, new_owner)
	else:
		return
