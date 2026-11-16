extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = get_node("main_hero")
	var spawn = get_node("PlayerSpawn")
	player.global_position = spawn.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
