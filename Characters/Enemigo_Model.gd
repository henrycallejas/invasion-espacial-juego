extends Area2D

#Poner atribucion a <a href="https://www.vecteezy.com/free-vector/spaceship">Spaceship Vectors by Vecteezy</a>

export var velocidad = 300
export var direccion = 1
export var nivel_actual_boss : int = 1

signal enemigo_muerto
signal vida_perdida
 

var bala = load("res://Characters/Bala.tscn")
var puede_disparar : bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += velocidad * direccion * delta
	for ray in $Rays.get_children():
		if ray.is_colliding():
			var position_objetivo = ray.get_collider().global_position
			disparar_contra()
#			disparar_contra(delta)
#	pass

#PONER SEÑAL CUANDO CHOQUE CON EL JUGADOR
func _on_Enemigo_Model_body_entered(body):
	if body.is_in_group("jugador"):
		queue_free()
		emit_signal("vida_perdida")
	pass # Replace with function body.

func _on_Timer_timeout(delta):
	print("Entra al timer")
	disparar_contra()
	pass # Replace with function body.

func disparar_contra():
	if puede_disparar:
		var nueva_bala = bala.instance()
		nueva_bala.velocidad_bala *=- nivel_actual_boss
		nueva_bala.position.y -= nueva_bala.velocidad_bala * 60
		get_parent().add_child(nueva_bala)
		nueva_bala.global_position = $Position2D.global_position
		nueva_bala.connect("vida_perdida", self, "_on_Enemigo_vida_perdida")
		puede_disparar = false

func _on_Enemigo_vida_perdida():
	emit_signal("vida_perdida")
	pass # Replace with function body.

func _on_Enemigo_Model_area_entered(area):
	if area.is_in_group("balas"):
			emit_signal("enemigo_muerto")
			queue_free()
	pass # Replace with function body.
