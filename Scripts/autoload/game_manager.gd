extends Node

var quest_states = {}
var conv_states = {}
var quest_definitions = {}

func make_quest_available(quest_id: String) -> void:
	if quest_definitions.has(quest_id):
		if not quest_states.has(quest_id):
			quest_states[quest_id] = {
				"status": "available",
				"stage": 0,
				"completed_objectives": []
			}

func start_quest(quest_id: String) -> void:
	if not quest_states.has(quest_id):
		return
	if quest_states[quest_id]["status"] != "available":
		return
	quest_states[quest_id]["status"] = "active"

func advance_quest(quest_id: String) -> void:
	if quest_states.has(quest_id):
		quest_states[quest_id]["stage"] += 1

func complete_quest(quest_id: String) -> void:
	if quest_states.has(quest_id):
		quest_states[quest_id]["status"] = "completed"

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

func complete_objective(quest_id: String, objective_index: int) -> void:
	if not quest_states.has(quest_id):
		return

	if not quest_definitions.has(quest_id):
		return

	if quest_states[quest_id]["status"] != "active":
		return

	var objectives = quest_definitions[quest_id].objectives

	if objective_index < 0 or objective_index >= objectives.size():
		return

	var completed = quest_states[quest_id]["completed_objectives"]

	if not completed.has(objective_index):
		completed.append(objective_index)
			
func is_objective_completed(quest_id: String, objective_index: int) -> bool:
	if quest_states.has(quest_id):
		return quest_states[quest_id]["completed_objectives"].has(objective_index)
		
	return false

func are_all_objectives_completed(quest_id: String) -> bool:
	if not quest_states.has(quest_id):
		return false

	if not quest_definitions.has(quest_id):
		return false

	var objectives = quest_definitions[quest_id].objectives
	var completed = quest_states[quest_id]["completed_objectives"]

	return completed.size() == objectives.size()

func get_active_quests() -> Array:
	var active_quests = []

	for quest_id in quest_states:
		if quest_states[quest_id]["status"] == "active":
			active_quests.append(quest_id)

	return active_quests

func get_completed_quests() -> Array:
	var completed_quests = []

	for quest_id in quest_states:
		if quest_states[quest_id]["status"] == "completed":
			completed_quests.append(quest_id)

	return completed_quests

func get_available_quests() -> Array:
	var available_quests = []

	for quest_id in quest_states:
		if quest_states[quest_id]["status"] == "available":
			available_quests.append(quest_id)

	return available_quests

func _ready() -> void:
	var kyrt_quest = load("res://resources/quests/kyrt_key.tres")
	register_quest(kyrt_quest)
