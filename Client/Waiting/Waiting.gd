extends Control

export var drafting_scene: PackedScene
var my_participant

func _ready():
	InternetBridge.connect("all_participants",self,"_on_all_participants")

func _process(delta):
	$VBoxContainer/ProgressBar.value += 100 * delta
	if $VBoxContainer/ProgressBar.value >= 100:
		$VBoxContainer/ProgressBar.value = 0
		
func _on_all_participants(participants: Array):
	for participant in participants:
		print(participant.name)
	var drafting = drafting_scene.instance()
	drafting.participants = participants
	drafting.my_participant = my_participant
	var root = get_tree().root
	root.remove_child(self)
	root.add_child(drafting)
