extends CharacterBody2D
const NORMAL_SPEED = 300.0
const SPRINT_SPEED = 400.0
var last_direcion = ""
var can_move = true


@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	if not can_move:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	var SPEED = NORMAL_SPEED
	if Input.is_action_pressed("Sprint"):
		SPEED = SPRINT_SPEED
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED
		if direction.y > 0:
			last_direcion = "up"
		elif direction.y < 0:
			last_direcion = "down"
		elif direction.x > 0:
			last_direcion = "right"
		else:
			last_direcion = "left"
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	
	if direction.y != 0 or direction.x != 0:
		$hero_back_look.hide()
		$hero_front_look.hide()
		$hero_left_look.hide()
		$hero_right_look.hide()
		if direction.y < 0:
			$hero_back_walk.show()
			$hero_back_walk.play("default")
			$hero_front_walk.hide()
			$hero_front_walk.stop()
			$hero_left_walk.hide()
			$hero_left_walk.stop()
			$hero_right_walk.hide()
			$hero_right_walk.stop()
		elif direction.y > 0:
			$hero_front_walk.show()
			$hero_front_walk.play("default")
			$hero_back_walk.hide()
			$hero_back_walk.stop()
			$hero_left_walk.hide()
			$hero_left_walk.stop()
			$hero_right_walk.hide()
			$hero_right_walk.stop()
		elif direction.x > 0:
			$hero_right_walk.show()
			$hero_right_walk.play("default")
			$hero_back_walk.hide()
			$hero_back_walk.stop()
			$hero_front_walk.hide()
			$hero_front_walk.stop()
			$hero_left_walk.hide()
			$hero_left_walk.stop()
		elif direction.x < 0:
			$hero_left_walk.show()
			$hero_left_walk.play("default")
			$hero_back_walk.hide()
			$hero_back_walk.stop()
			$hero_front_walk.hide()
			$hero_front_walk.stop()
			$hero_right_walk.hide()
			$hero_right_walk.stop()
	if direction.y == 0 and direction.x == 0:
		$hero_back_walk.hide()
		$hero_back_walk.stop()
		$hero_front_walk.hide()
		$hero_front_walk.stop()
		$hero_left_walk.hide()
		$hero_left_walk.stop()
		$hero_right_walk.hide()
		$hero_right_walk.stop()
		if last_direcion == "up":
			$hero_front_look.show()
		elif last_direcion == "down":
			$hero_back_look.show()
		elif last_direcion == "right":
			$hero_right_look.show()
		elif last_direcion == "left":
			$hero_left_look.show()
	





	move_and_slide()
