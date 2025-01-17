extends Node

const SAVE_FILE_PATH = "user://BlackalsDeathArena.save"

var save_data: Dictionary = {
	"meta_upgrade_currency": 0,
	"meta_upgrades": {}
}

func _ready():
	GameEvents.exp_vial_collected.connect(on_exp_collected)
	load_save_file()
	
func load_save_file():
	if !FileAccess.file_exists(SAVE_FILE_PATH):
		return
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	save_data = file.get_var()
	print(save_data)

func save():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(save_data)
	
func add_meta_upgrade(upgrade: MetaUpgrade):
	if !save_data["meta_upgrades"].has(upgrade.id):
		save_data["meta_upgrades"][upgrade.id] = {
			"quantity": 0
		}
	
	save_data["meta_upgrades"][upgrade.id]["quantity"] += 1
	save()
	
func get_upgrade_quantity(upgrade_id: String):
	var quantity = 0
	if save_data["meta_upgrades"].has(upgrade_id):
		quantity = save_data["meta_upgrades"][upgrade_id]["quantity"]
	return quantity

func on_exp_collected(number: float):
	save_data["meta_upgrade_currency"] += number
	
	
