extends CharacterBody2D
const NORMAL_SPEED = 300.0
const SPRINT_SPEED = 400.0


func _physics_process(delta: float) -> void:
	var SPEED = NORMAL_SPEED
	if Input.is_action_pressed("Sprint"):
		SPEED = SPRINT_SPEED
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	
	if direction.y < 0:
		$hero_back_look.show()
		$hero_front_look.hide()
	elif direction.y > 0:
		$hero_back_look.hide()
		$hero_front_look.show()

	move_and_slide()
