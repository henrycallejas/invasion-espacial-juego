extends CanvasLayer

onready var color: ColorRect = $ColorRect
onready var anim_player : AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	layer = -1
	pass # Replace with function body.

func cambiar_escena(ruta: String):
	layer = 1
	anim_player.play("Fade")
	yield(anim_player, "animation_finished")
	anim_player.play_backwards("Fade")
	yield(anim_player, "animation_finished")
	layer = -1
	
	
	
