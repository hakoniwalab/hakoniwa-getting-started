extends "res://addons/hakoniwa_robot_sync/scripts/robot_sync_controller.gd"


func _ready() -> void:
	var sim_node := get_node_or_null("../HakoniwaSimNode")
	if sim_node_path.is_empty() and sim_node != null:
		sim_node_path = sim_node.get_path()
	if target_root_path.is_empty():
		target_root_path = $"../RosToGodot".get_path()
	if profile_path.is_empty():
		profile_path = "res://config/robot_sync.profile.json"
	super._ready()
