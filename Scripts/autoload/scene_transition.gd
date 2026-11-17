extends CanvasLayer
@onready var fade = get_node_or_null("Fade")
var transitioning = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade.modulate.a = 0.0

func change_scene(target_scene: String, duration: float = 0.4) -> void:
	if transitioning:
		return
	
	transitioning = true
	var player = get_tree().current_scene.get_node("main_hero")
	player.can_move = false
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1.0, duration)
	await tween.finished
	get_tree().change_scene_to_file(target_scene)
	await get_tree().scene_changed
	var fade_in_tween = create_tween()
	fade_in_tween.tween_property(fade, "modulate:a", 0.0, duration)
	var new_player = get_tree().current_scene.get_node("main_hero")
	new_player.can_move = true
	transitioning = false
