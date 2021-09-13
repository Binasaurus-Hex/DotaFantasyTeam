extends Control

var drafter: String

func _ready():
	ConnectionBridge.connect("draft_time", self, "on_draft_time")
	ConnectionBridge.connect("wait_time", self,"on_wait_time")
	
func on_wait_time(time: int):
	$Label.text = "waiting : " + time as String
	
func on_draft_time(time: int):
	$Label.text = drafter + " is drafting: " + time as String
