extends Node

onready var botons = $CenterContainer.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Preparando los niveles")
	for boton in botons:
		boton.connect("pressed", self, "conectarBotonPress", [boton.name])
		boton.disabled = Persistence.data['niveles'][boton.name]
		print("Conectando boton")
		pass # Replace with function body.

func conectarBotonPress(nivel):
	print("Cambiando nivel")
	Transicion.cambiar_escena("res://" + nivel + ".tscn")
#	get_tree().change_scene("res://" + nivel + ".tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
