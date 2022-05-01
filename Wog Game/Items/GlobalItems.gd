extends Node


var item_and_scenes : Dictionary = {
}
func _ready():
	append_items_and_scenes("res://Items")

func append_items_and_scenes(path):
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") and file != "GlobalItems.gd":
			item_and_scenes[file.to_lower()] = load(path + "/" + file.to_lower() + "/" + file.to_lower() + ".tscn")
	print(item_and_scenes)
	dir.list_dir_end()
