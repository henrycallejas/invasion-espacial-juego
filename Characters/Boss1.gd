extends Area2D

signal vida_perdida
signal nivel_superado

export var puntos_vida_boss = 100
export var velocidad = 300
var direccion = 1
var puede_disparar = false
onready var tamano_pantalla = get_viewport_rect().size

var bala = load("res://Characters/Bala.tscn")

func _process(delta):
	moverse(delta)

func moverse(delta):
	position.x += velocidad * direccion * delta
	position.x = clamp(position.x, 0+40, tamano_pantalla.x-40)
	if position.x == tamano_pantalla.x-40 or position.x == 40:
		direccion *= -1

# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD_Boss/TextureProgress.max_value = puntos_vida_boss
	pass # Replace with function body.

func disparar_contra():
	var nueva_bala = bala.instance()
	nueva_bala.velocidad_bala *=-1
	nueva_bala.position.y -= nueva_bala.velocidad_bala * 60
	get_parent().add_child(nueva_bala)
	nueva_bala.global_position = $Position2D.global_position
	nueva_bala.connect("vida_perdida", self, "on_vida_perdida")

func on_vida_perdida():
	emit_signal("vida_perdida")

func _on_Timer_timeout():
	disparar_contra()
	pass # Replace with function body.




func _on_Boss1_area_entered(area):
	if area.is_in_group("balas"):
		print("PUNTO GANADO AL JUGADOR")
		puntos_vida_boss -=10
		if(puntos_vida_boss <= 0):
			$HUD_Boss/Label.text = 'GANASTE'
			emit_signal('nivel_superado')
		$HUD_Boss/TextureProgress.value = puntos_vida_boss
	pass # Replace with function body.
