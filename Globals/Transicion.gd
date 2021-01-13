extends CanvasLayer

onready var anim_player : AnimationPlayer = $AnimationPlayer
var level_layer: int = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	layer = -1
	pass # Replace with function body.

func cambiar_escena(ruta: String):
	if layer == -1:
		layer = 1
	anim_player.play("Fade")
	yield(anim_player, "animation_finished")
	get_node(".").get_parent().get_tree().change_scene(ruta)
	anim_player.play_backwards("Fade")
	get_tree().create_timer(1)
#	Creo el contador para darle tiempo a que se vuelva a cambiar
#	el layer a -1 sino la capa de transición queda arriba de la capa 
#	de Levels
	layer = -1
	
	



func _on_Transicion_tree_exiting():
	layer = -1
	pass # Replace with function body.
