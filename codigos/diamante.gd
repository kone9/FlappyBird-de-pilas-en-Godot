extends Area

export var velocidad_desplazamiento = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	translation.x -= velocidad_desplazamiento * delta
	if translation.x < -25:
		queue_free()

