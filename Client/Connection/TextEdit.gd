extends TextEdit

export(int) var LIMIT = 10
var current_text = ''
var cursor_line = 0
var cursor_column = 0

signal clicked

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		readonly = true
		emit_signal("clicked")

func _on_TextEdit_text_changed():
	var new_text : String = text
	if new_text.length() > LIMIT:
		text = current_text
		# when replacing the text, the cursor will get moved to the beginning of the
		# text, so move it back to where it was 
		cursor_set_line(cursor_line)
		cursor_set_column(cursor_column)

	current_text = text
	# save current position of cursor for when we have reached the limit
	cursor_line = cursor_get_line()
	cursor_column = cursor_get_column()
