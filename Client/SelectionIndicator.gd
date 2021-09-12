extends Control

export var selected_material: Material

func select():
	get_parent().material = selected_material
	
func deselect():
	get_parent().material = null
