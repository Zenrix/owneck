extends Node

func _ready():
	var tileScene = preload("res://tile.tscn")
	var tile = tileScene.instance()
	tile.init(Vector3(0, 0, 0), Vector3(1, 1, 1))
	get_node(".").add_child(tile)
	set_process(true)
	set_process_input(true)

