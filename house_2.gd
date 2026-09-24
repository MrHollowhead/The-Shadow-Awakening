extends StaticBody2D
var player_here = false
var in_dialogue = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interaction") and player_here == true and not in_dialogue:
		$"../UI/DialogueBox/speaker_name".text = $"../main_hero".hero_name
		$"../UI/DialogueBox/Label".text = "It's locked"
		$"../UI/DialogueBox/speaker_icon".texture = preload("res://art/characters/hero/Hero_icon.png")
		$"../UI/DialogueBox".show()
		in_dialogue = true
	elif in_dialogue == true and Input.is_action_just_pressed("Interaction"):
		$"../UI/DialogueBox".hide()
		in_dialogue = false
		$"../main_hero".can_move = true

func _on_door_hitbox_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_here = true


func _on_door_hitbox_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_here = false
