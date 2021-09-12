extends Node

var participant: String
export var connection_scene: PackedScene
export var waiting_scene: PackedScene
export var drafting_scene: PackedScene

func _ready():
	add_child()
