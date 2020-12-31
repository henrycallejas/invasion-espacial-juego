extends KinematicBody2D

signal punto_ganado
signal vida_perdida

var velocidad_bala = 400
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -=  delta * velocidad_bala
	pass

func _on_Area2D_area_entered(area):
	if area.is_in_group("espacio"):
		print("es una bala")
	if area.is_in_group("enemigos") or area.is_in_group("boss"):
		emit_signal("punto_ganado")
	queue_free()
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.is_in_group("jugador"):
		print("entro una bala al cuerpo")
		emit_signal("vida_perdida")
		queue_free()
	pass # Replace with function body.
