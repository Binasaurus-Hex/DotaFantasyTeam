extends Control

var drafter_name: String

func _ready():
	ConnectionBridge.connect("draft_time", self, "_on_draft_time")
	ConnectionBridge.connect("wait_time", self,"_on_wait_time")
	ConnectionBridge.connect("drafting_participant", self, "_on_drafting_participant")
	
func _on_drafting_participant(participant_name: String):
	drafter_name = participant_name
	
func _on_wait_time(time: int):
	$Label.text = "waiting : " + time as String
	
func _on_draft_time(time: int):
	$Label.text = drafter_name + " is drafting: " + time as String
