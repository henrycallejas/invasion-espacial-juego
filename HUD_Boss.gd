extends CanvasLayer


export var health_value: int

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgress.max_value = health_value
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
