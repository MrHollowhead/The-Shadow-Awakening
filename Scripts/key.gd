extends StaticBody2D
var player_here = false



func _process(delta: float) -> void:
	if player_here == true and Input.is_action_just_pressed("Interaction"):
		$"../../NPC".quest_state = 2
		$Area2D.monitoring = false
		$Area2D/Sprite2D.hide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_here = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_here = false
