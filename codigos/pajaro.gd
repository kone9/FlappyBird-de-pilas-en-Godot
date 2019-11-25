extends RigidBody

export(int) var fuerza_impulso = 10 #fuerza de impulso
export(float) var cantidad_rotacion = 5.0 #fuerza de rotación
var rotacion_pollo
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):#funcion con propiedades fisicas que se actualiza 60 veces por segundo
	rotar_pollo()#da una rotación al pollo
	if Input.is_action_just_pressed("click_izquierdo") or Input.is_action_just_pressed("Volar_Touch"):#si presiono click izquierdo o el touch de un celular
		apply_central_impulse(Vector3(0,fuerza_impulso,0))#aplico un impulso
		get_tree().get_nodes_in_group("sonido_volar")[0].play()#reprodusco sonido volar
	
func rotar_pollo(): #hace que el pollo rota
	rotacion_pollo = translation.y # esto determina como rota el pollo
	$Pajaro_animado.rotation_degrees.x = -rotacion_pollo * cantidad_rotacion #esto hace que el pollo rote,como hay problemas con el cuerpo rigido,roto solo la figura sin afectar las propiedades físicas


		
func instanciar_pollo_cocido():#intancia el pollo cocido
	var rotacion_aleatoria = rand_range(-30,30)
	var pollo_cocido = get_tree().get_nodes_in_group("Escena_principal")[0].escenas_a_intanciar[0].instance()#busco en la escena principal la variable que contiene la escena,en este caso es un arreglo
	get_parent().add_child(pollo_cocido)#tomo el padre de pajaro y agrego este nodo
	pollo_cocido.translation = translation#la posición dle pollo cocido es igual a la del pollo normal
	pollo_cocido.rotation = rotation #la rotación del pollo cocido es igual a la del pollo normal
	pollo_cocido.apply_central_impulse(Vector3(0,20,0))#aplico un impulso al centro de pollo
	pollo_cocido.apply_torque_impulse(Vector3(0,0,rotacion_aleatoria))#aplica un torque de impulso

func _on_Area_body_entered(body):#si el area entra a un cuerpo
	if body.is_in_group("muerte"):#si el area esta en el grupo muerte
		get_tree().get_nodes_in_group("Escena_principal")[0].muerto = true
		instanciar_pollo_cocido()#llamo a la función que crea el pollo muerto
		queue_free()#elimino al pajaro

func _on_Area_area_entered(area):
	if area.is_in_group("diamante"):
		get_tree().get_nodes_in_group("coint")[0].play()
		get_tree().get_nodes_in_group("Escena_principal")[0].puntaje += 1#aumento 1 al valor del puntaje
		area.queue_free()
	if area.is_in_group("muerte"):#si el area esta en el grupo muerte
		get_tree().get_nodes_in_group("Escena_principal")[0].muerto = true
		instanciar_pollo_cocido()#llamo a la función que crea el pollo muerto
		queue_free()#elimino al pajaro
