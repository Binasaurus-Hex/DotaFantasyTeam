extends Node

func _on_WaitTimer_seconds_changed(seconds):
	ConnectionBridge.send("wait_time", seconds)


func _on_DraftingTimer_seconds_changed(seconds):
	ConnectionBridge.send("draft_time", seconds)
