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
	var speed
	
	if is_running:
		speed = run_speed
	else:
		speed = walk_speed
	
	if input_dir != Vector2.ZERO:
		last_dir = input_dir
		velocity = input_dir * speed
		move_and_slide()
		_play_move(input_dir, is_running)
	else:
		velocity = Vector2.ZERO
		_play_idle(last_dir)
	
func _play_move(dir: Vector2, is_running) -> void:
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0.0:
			anim.flip_h = false
			if is_running:
				anim.play("run")
			else:
				anim.play("walk")
		else:
			anim.flip_h = true
			if is_running:
				anim.play("run")
			else:
				anim.play("walk")
	else:
		if dir.y > 0.0:
			if is_running:
				anim.play("run")
			else:
				anim.play("walk")
		else:
			if is_running:
				anim.play("run")
			else:
				anim.play("walk")
		
	
func _play_idle(dir: Vector2) -> void:
	if abs(dir.x) > abs(dir.y):
		if dir.x > 0.0:
			anim.play("idle")
		else:
			anim.play("idle")
	else:
		if dir.y > 0.0:
			anim.play("idle")
		else:
			anim.play("idle")
