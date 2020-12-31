extends Node

const PATH = "user://dat_game.dat"
const PASS = "123abc"

var is_loaded = false
var data = {
	"Puntaje": 0,
	"Vidas": 3,
		niveles = {
			'Level1': false,
			'Level2': true,
			'Level3': true,
			'Level4': true
		}
}
# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	if file.file_exists(PATH):
		load_data()
	else:
		save_data()
		load_data()
		pass
	pass # Replace with function body.

func save_data():
	var file = File.new()
	file.open_encrypted_with_pass(PATH, File.WRITE, PASS)
	file.store_var(data)
#	file.store_line(to_json(data)) seria si solo es un json sin encriptar
	file.close()
	is_loaded = false
#	esto es para evitar que se carguen los datos mas de una vez
func load_data():
	if is_loaded:
		return
	var file = File.new()
	file.open_encrypted_with_pass(PATH, File.READ, PASS)
	data = file.get_var()
	file.close()
	is_loaded = true
	pass
