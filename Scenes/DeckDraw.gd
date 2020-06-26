extends TextureButton

func _ready():
	rect_scale *= $'../../'.CardSize / rect_size
