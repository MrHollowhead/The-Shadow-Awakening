extends Node

var quest_states = {}
var conv_states = {}
var quest_definitions = {}

func start_quest(quest_id: String) -> void:
	quest_states[quest_id] = {
		"status": "active",
		"stage": 1
	}

func advance_quest(quest_id: String) -> void:
	if quest_states.has(quest_id):
		quest_states[quest_id]["stage"] += 1

func complete_quest(quest_id: String) -> void:
	if quest_states.has(quest_id):
		quest_states[quest_id]["status"] = "completed"
		
func decline_quest(quest_id : String) -> void:
	if quest_states.has(quest_id):
		if quest_states[quest_id]["status"] == "active":
			quest_states[quest_id]["status"] = "declined"
			
func get_quest_state(quest_id: String) -> Dictionary:
	if quest_states.has(quest_id):
		return quest_states[quest_id]

	return {}
	
func register_quest(quest_data: QuestData) -> void:
	quest_definitions[quest_data.quest_id] = quest_data
	
func get_quest_definition(quest_id: String) -> QuestData:
	if quest_definitions.has(quest_id):
		return quest_definitions[quest_id]

	return null

func _ready() -> void:
	var kyrt_quest = load("res://resources/quests/kyrt_key.tres")
	register_quest(kyrt_quest)
