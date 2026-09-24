extends StaticBody2D
var player_here = false
var dialogue_state = 0
var end_of_dialogue = false
var submitted_name = false
var quest_state = 0
var quest_declined = false


func _process(delta: float) -> void:
	if $"../UI/DialogueBox/name_input".has_focus():
		return
	if player_here:
		print(quest_state)
	if player_here == true and Input.is_action_just_pressed("Interaction") and end_of_dialogue == false:
		if dialogue_state == 0:
			$"../main_hero".can_move = false
			$"../UI/DialogueBox/speaker_name".text = "Villager"
			$"../UI/DialogueBox/speaker_icon".texture = preload("res://art/characters/NPC1_icon.png")
			$"../UI/DialogueBox/Label".text = "Well you are a new face.\nWelcome to our humble village!"
			$"../UI/DialogueBox".show()
			dialogue_state += 1
		elif dialogue_state == 1:
			$"../UI/DialogueBox/speaker_name".text = "Kyrt"
			$"../UI/DialogueBox/Label".text = "My name is Kyrt.\nWhat shall I call you?"
			$"../UI/DialogueBox/name_input".show()
			$"../UI/DialogueBox/name_input".grab_focus()
		elif dialogue_state == 3:
			$"../UI/DialogueBox/speaker_name".text = "Kyrt"
			$"../UI/DialogueBox/speaker_icon".texture = preload("res://art/characters/NPC1_icon.png")
			$"../UI/DialogueBox/Label".text = "Nice to meet you, " + $"../main_hero".hero_name + "!"
			dialogue_state += 1
		elif dialogue_state == 4:
			$"../UI/DialogueBox/Label".text = "Actually.....\nNow that I think about it. Could you help me out?"
			$"../UI/DialogueBox/yes_button".show()
			$"../UI/DialogueBox/no_button".show()
		
	if dialogue_state == 2 and submitted_name == true and player_here == true:
		$"../UI/DialogueBox/name_input".hide()
		$"../UI/DialogueBox/speaker_icon".texture = preload("res://art/characters/hero/Hero_icon.png")
		$"../UI/DialogueBox/speaker_name".text = $"../main_hero".hero_name
		$"../UI/DialogueBox/Label".text = "My name is " + $"../main_hero".hero_name + "."
		dialogue_state += 1
		
	if dialogue_state == 4 and quest_declined == true:
		$"../UI/DialogueBox/Label".text = "Well alright then, I'll be here"
		$"../UI/DialogueBox/yes_button".hide()
		$"../UI/DialogueBox/no_button".hide()
		dialogue_state += 1
		end_of_dialogue = true
		
	if dialogue_state == 5 and quest_declined == true and Input.is_action_just_pressed("Interaction") and player_here == true and end_of_dialogue == false:
		$"../UI/DialogueBox/yes_button".show()
		$"../UI/DialogueBox/no_button".show()
		$"../UI/DialogueBox".show()
		$"../main_hero".can_move = false
		$"../UI/DialogueBox/Label".text = "Changed your mind yet?"
		$"../UI/DialogueBox/speaker_name".text = "Kyrt"
		$"../UI/DialogueBox/speaker_icon".texture = preload("res://art/characters/NPC1_icon.png")
		
	if dialogue_state == 5 and quest_state == 1:
		$"../UI/DialogueBox/Label".text = "Thanks!\nI seem to have lost my key somewhere.."
		$"../UI/DialogueBox/yes_button".hide()
		$"../UI/DialogueBox/no_button".hide()
		if Input.is_action_just_pressed("Interaction"):
			dialogue_state += 1
	elif dialogue_state == 6 and quest_state == 1:
		$"../UI/DialogueBox/Label".text = "I think it's somewhere around those mushrooms\n next to the most eastern house."
		dialogue_state +=1 
		$"../House6/key".show()
		$"../House6/key/Area2D".monitoring = true
		end_of_dialogue = true
	
	if player_here == true and quest_state == 2 and Input.is_action_just_pressed("Interaction"):
		if dialogue_state == 7:
			$"../UI/DialogueBox/speaker_name".text = "Kyrt"
			$"../UI/DialogueBox/speaker_icon".texture = preload("res://art/characters/NPC1_icon.png")
			$"../UI/DialogueBox".show()
			$"../main_hero".can_move = false
			$"../UI/DialogueBox/Label".text = "Thank you so much!\nMay the Gods aid you on your journey!"
			dialogue_state +=1
		elif dialogue_state == 8:
			dialogue_state +=1
		elif dialogue_state == 9:
			end_of_dialogue = true
		
	
	if end_of_dialogue == true and Input.is_action_just_pressed("Interaction"):
		$"../UI/DialogueBox".hide()
		$"../main_hero".can_move = true
		end_of_dialogue = false
		$"../UI/DialogueBox/yes_button".hide()
		$"../UI/DialogueBox/no_button".hide()
		
func _on_npc_int_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_here = true


func _on_npc_int_area_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_here = false


func _on_no_button_pressed() -> void:
	quest_declined = true
	dialogue_state = 4


func _on_yes_button_pressed() -> void:
	quest_declined = false
	quest_state = 1
	dialogue_state = 5
