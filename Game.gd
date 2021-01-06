extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_btn_salir_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_btn_jugar_pressed():
	Transicion.cambiar_escena("res://Levels.tscn")
#	get_tree().change_scene("res://Levels.tscn")
	pass # Replace with function body.
