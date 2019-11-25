extends Spatial

export(Array,PackedScene) var escenas_a_intanciar
var muerto = false#si esta o no esta muerto
var noRepetir = false#evita que las cosas se repitan al morir
var puedo_reiniciar = false
var puntaje = 0#un contador para el puntaje
export(int) var velocidad_cuchillo = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()#crea una semilla para que en cada inicio de juego la aleatoriedad sea diferente

func _process(delta):
	if muerto == false:
		$UI/Puntaje.text = "Puntaje: " + str(puntaje) #mientras no este muerto siempre voy actualizando valor puntaje
	if muerto == true and noRepetir == false:
		noRepetir = true#evita que se repita esto a cada rato
		$Sonidos_and_VfX/sonido_morir.play()
		$AnimationPlayer.play("camara_temblor")#activo animación temblor
		$Timer_reiniciar.start()#inicio el timer para reiniciar la escena
		$Timer_intanciar_diamantes.stop()#dejo de instanciar diamantes
		$Timer_instanciar_cuchillos.stop()#dejo de instanciar los cuchillos
		$Sonidos_and_VfX/musica.stop() #detengo la musica
		$Timer_volver_al_menu.start()#inicia el timer para volver al menu principal
		
func instanciar_cuchillos():
	var posicion_aleatoria_en_y = rand_range(-10 , 10)#posición aleatoria entre estos 2 valores
	var cuchillo = escenas_a_intanciar[2].instance()#instancio la escena
	add_child(cuchillo)#hago que el diamante sea hijo de la escena
	cuchillo.translation.x = $Posicicion_inicial.translation.x#la posición inicial es la del 3D position
	cuchillo.translation.y = posicion_aleatoria_en_y#la posición inicial en Y es aleatoria entre esos dos valores
	cuchillo.translation.z = -20

func instanciar_diamantes():#esta función intancia diamantes a la escena
	var posicion_aleatoria_en_y = rand_range(-10 , 10)#posición aleatoria entre estos 2 valores
	var diamante = escenas_a_intanciar[1].instance()#instancio la escena
	add_child(diamante)#hago que el diamante sea hijo de la escena
	diamante.translation.x = $Posicicion_inicial.translation.x#la posición inicial es la del 3D position
	diamante.translation.y = posicion_aleatoria_en_y#la posición inicial en Y es aleatoria entre esos dos valores
	diamante.translation.z = -20


func _on_Boton_reiniciar_pressed():#si presiono el boton
	get_tree().reload_current_scene()#reinicia la escena

func _on_Timer_reiniciar_timeout():#cuando el timer termina el tiempo
	$UI/Boton_reiniciar.visible = true#mostrar cartel puedo reiniciar

func _on_Timer_intanciar_diamantes_timeout():#cuando termina el tiempo instancio diamantes
	instanciar_diamantes()#instancio diamantes


func _on_Timer_instanciar_cuchillos_timeout():#cuando termina el tiempo del nodo
	instanciar_cuchillos()#instancio cuchillos


func _on_Timer_volver_al_menu_timeout():#si termina este tiempo
	get_tree().change_scene("res://escenas/Menu_inicio.tscn")#vuelvo al menu de inicio


func _on_Timer_aumentar_dificultad_timeout():
	if velocidad_cuchillo < 30:#mientras la velocidad cuchillo sea menor a 30
		velocidad_cuchillo += 1#aumenta la velocidad del cuchillo
	else:#sino
		velocidad_cuchillo = 0#la velocidad cuchillo es igual a 0
	
	if $Timer_instanciar_cuchillos.wait_time > 1:#si el wait time es mayor a 1 segundo
		$Timer_instanciar_cuchillos.wait_time -= 0.1#redusco 0.1 fracción de segundo cada ves que instancio cuchillos
	