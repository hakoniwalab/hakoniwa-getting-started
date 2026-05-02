class_name HakoPdu_hako_srv_msgs_GetSimStateResponse
extends RefCounted


var sim_state: int = 0
var master_time: int = 0
var is_pdu_created: bool = false
var is_simulation_mode: bool = false
var is_pdu_sync_mode: bool = false

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_srv_msgs/GetSimStateResponse.gd").new()
    if d.has("sim_state"):
        obj.sim_state = d["sim_state"]
    if d.has("master_time"):
        obj.master_time = d["master_time"]
    if d.has("is_pdu_created"):
        obj.is_pdu_created = d["is_pdu_created"]
    if d.has("is_simulation_mode"):
        obj.is_simulation_mode = d["is_simulation_mode"]
    if d.has("is_pdu_sync_mode"):
        obj.is_pdu_sync_mode = d["is_pdu_sync_mode"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["sim_state"] = sim_state
    d["master_time"] = master_time
    d["is_pdu_created"] = is_pdu_created
    d["is_simulation_mode"] = is_simulation_mode
    d["is_pdu_sync_mode"] = is_pdu_sync_mode
    return d
