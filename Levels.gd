extends Node

onready var botons = $CenterContainer.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	for boton in botons:
		boton.connect("pressed", self, "conectarBotonPress", [boton.name])
		boton.disabled = Persistence.data['niveles'][boton.name]
		pass # Replace with function body.

func conectarBotonPress(nivel):
	get_tree().change_scene("res://" + nivel + ".tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
