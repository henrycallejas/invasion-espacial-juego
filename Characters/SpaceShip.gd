extends KinematicBody2D

signal tiro_al_jefe

export var velocidad = 200
var direccion : int
onready var tamano_pantalla = get_viewport_rect().size

var bala


# Called when the node enters the scene tree for the first time.
func _ready():
	print(tamano_pantalla.x)
	bala = load("res://Characters/Bala.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direccion = 0
	direccion = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	if direccion != 0:
		$AnimatedSprite.play("move")
		position.x += direccion * velocidad * delta		
	else:
		$AnimatedSprite.stop()
	position.x = clamp(position.x, 0+40, tamano_pantalla.x-40)
	verificarDisparo()

func verificarDisparo():
	if Input.is_action_just_pressed("disparo"):
		print("Disparando...")
		var nuevaBala = bala.instance()
		get_parent().add_child(nuevaBala)
		nuevaBala.global_position = $Position2D.global_position
		nuevaBala.connect("area_entered", self, "prueba")
		nuevaBala.connect("punto_ganado", self, "en_punto_ganado")

func en_punto_ganado():
	emit_signal("tiro_al_jefe")

func moverDerecha():
	pass


#LO QUITE PARA VER SI NO HACIA NADA
#func _on_Area2D_area_entered(area):
#	if area.is_in_group("balas"):
#		print("ME ENTRO UNA BALA!!!!!")
#		emit_signal("vida_perdida")
#	pass 
