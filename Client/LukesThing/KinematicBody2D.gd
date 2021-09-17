extends KinematicBody2D

signal winner


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var direction = Vector2(0,0)
var speed = 10
var touched = null
var current = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func _input(ev):
	direction = Vector2(0,0)
	if Input.is_key_pressed(KEY_W):
		direction += Vector2(0,-3)
	if Input.is_key_pressed(KEY_A):
		direction += Vector2(-1,0)
	if Input.is_key_pressed(KEY_D):
		direction += Vector2(1,0)

func _physics_process(delta):
	var collusion2 = move_and_collide(Vector2(0, 10))
	var can_move = true
	
	if collusion2 or touched:
		current = direction * speed
	
	if touched != null and collusion2 == null:
		can_move = not touched.collider_id
	if touched != null:
		if touched.collider_id == 1226:
			emit_signal("winner")
			position = Vector2(0,0)
	if collusion2 != null:
		if collusion2.collider_id == 1226:
			emit_signal("winner")
			position = Vector2(0,0)
		
	
	if can_move:
		if current.length() > 0.1:
			touched = move_and_collide(current)
			current = current * 0.9
