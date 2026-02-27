extends CharacterBody2D

@export var walk_speed := 100
@export var run_speed := 150

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var last_dir := Vector2.DOWN

func _physics_process(_delta: float) -> void:
	var input_dir := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()

	var is_running := Input.is_action_pressed("sprint")
	var speed := run_speed if is_running else walk_speed
	
	if input_dir != Vector2.ZERO:
		last_dir = input_dir
		velocity = input_dir * speed
		move_and_slide()
		_play_move(input_dir, is_running)
	else:
		velocity = Vector2.ZERO
		anim.play("idle")
	
func _play_move(dir: Vector2, is_running) -> void:
	var action := "run" if is_running else "walk"
	
	if (abs(dir.x) >= abs(dir.y)):
		anim.flip_h = dir.x < 0
		anim.play(action)
	else:
		anim.play(action)
