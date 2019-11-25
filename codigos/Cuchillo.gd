extends Area


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	translation.x -= get_tree().get_nodes_in_group("Escena_principal")[0].velocidad_cuchillo * delta# la velocidad del cuchillo es tomada desde la escena principal ṕpara ir aumentando la velocidad dinamicamente
	if translation.x < -25:
		queue_free()

