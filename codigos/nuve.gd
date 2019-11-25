extends Spatial
export var velocidad_desplazamiento = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	translation.x -= velocidad_desplazamiento * delta
	if translation.x < -50:
		translation.x = get_tree().get_nodes_in_group("Posicicion_inicial")[0].translation.x + 20

