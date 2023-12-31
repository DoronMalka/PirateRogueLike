extends CharacterBody2D


const ACCELERATION = 200
const MAX_SPEED = 200
const FRICTION = 1000

@onready var anim_tree = $AnimationTree
@onready var anim_player = $AnimationPlayer
@onready var sword = load("res://Sword.gd").new()


func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", input_vector)
		anim_tree.set("parameters/Run/blend_position", input_vector)
		anim_tree.set("parameters/conditions/is_moving", true)
		anim_tree.set("parameters/conditions/idle", false)
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		anim_tree.set("parameters/conditions/is_moving", false)
		anim_tree.set("parameters/conditions/idle", true)
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	if Input.is_action_just_pressed("ui_accept"):
		sword.swing(0)
	print(velocity)
	move_and_slide()
