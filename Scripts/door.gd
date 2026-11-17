extends StaticBody2D
var player_here = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_here and Input.is_action_just_pressed("Interaction"):
		GameManager.set_player_spawn_position("TavernOutsideSpawn")
		SceneTransition.change_scene("res://Scenes/world.tscn")


func _on_exit_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_here = true


func _on_exit_area_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_here = false
