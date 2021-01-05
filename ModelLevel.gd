extends Node2D

export  var enemigo: PackedScene
export  var boss : PackedScene
export  var hud_boss : PackedScene
export  var next_level : String
export  var level_name : String
onready var tamano_pantalla = get_viewport_rect().size
export var num_enemigos: int = 5
onready var puntos= Persistence.data["Puntaje"]

# Called when the node enters the scene tree for the first time.
func _ready():
	actualizarPuntos()
	actualizarVidas()
	actualizarElixir()
#	print(get_node(".").name) Sirve para saber el nombre del nivel del nodo principal de la escena
	var nivel = get_node(".").name
	obtenerNivel(nivel)
	$HUD/Button.connect("pressed", self, "conectarPausa")
	pass # Replace with function body.
	
func obtenerNivel(nivel):
	match nivel:
		'Level1': $Control/Label.text = 'Nivel 1'
		'Level2': $Control/Label.text = 'Nivel 2'
	pass

func verificarVidas():
	if Persistence.data["Vidas"] <=0:
		Persistence.data["Vidas"] = 3
		Persistence.save_data()
		get_tree().change_scene("res://Game_Over.tscn")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	verificarVidas()
	pass
#	pass


func _on_Timer_timeout():
	$Control/Label.visible = false
	randomize()
	instanciarAlAzar()
	
	pass # Replace with function body.

func instanciarAlAzar():
	var num_azar = randi() % num_enemigos
	for i in num_azar:
		randomize()
		var enemigoNuevo = enemigo.instance()
		enemigoNuevo.connect("enemigo_muerto", self, "punto_sumado")
		enemigoNuevo.connect("vida_perdida", self, "quitar_vida")
		add_child(enemigoNuevo)
		enemigoNuevo.global_position = $Position2D.global_position
		$Position2D.position.x = randi() % int(tamano_pantalla.x)
		$Position2D.position.y = -200 + randi() %100
		

func punto_sumado():
	puntos +=1
	Persistence.data["Puntaje"] +=1
	Persistence.save_data()
	actualizarPuntos()
	
func actualizarPuntos():
	$HUD/Puntaje.text = str(puntos)
	
func actualizarVidas():
	$HUD/Vidas.text = "Vidas: " + str(Persistence.data["Vidas"])

func actualizarElixir():
	$HUD/Elixir.text = "Elixir: " + str(Persistence.data["Elixir"])

func _on_espaciovacio2_area_entered(area):
	if area.is_in_group("enemigos"):
		area.queue_free()


func _on_TimerBoss_timeout():
	var new_boss = boss.instance()
	new_boss.global_position = $PositionBoss.global_position
	add_child(new_boss)
	new_boss.connect("vida_perdida", self, "quitar_vida")
	new_boss.connect("nivel_superado", self, "cambiar_nivel")
	pass # Replace with function body.

func quitar_vida():
	print("Entre a señal vida perdida")
	Persistence.data["Vidas"] -=1
	Persistence.save_data()
	actualizarVidas()

func cambiar_nivel():
	get_tree().change_scene(next_level)
	Persistence.data['niveles'][level_name] = false
	Persistence.save_data()
	pass

func _on_SpaceShip_tiro_al_jefe():
	punto_sumado()
	pass # Replace with function body.

func conectarPausa():
	$HUD/Button.text = 'Seguir Jugando'
	get_tree().paused = !get_tree().paused
	if(get_tree().paused == false):
		$HUD/Button.text = 'Pausa'


func _on_SpaceShip_elixir_ganado():
	Persistence.data["Elixir"] +=20
	Persistence.save_data()
	actualizarElixir()
	verificarElixir()
	pass # Replace with function body.

func verificarElixir():
	if Persistence.data["Elixir"] >= 100:
		Persistence.data["Vidas"] +=1
		Persistence.data["Elixir"] = 0
		Persistence.save_data()
		actualizarVidas()
		actualizarElixir()
