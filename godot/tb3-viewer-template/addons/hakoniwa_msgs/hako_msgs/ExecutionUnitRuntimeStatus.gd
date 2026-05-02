class_name HakoPdu_hako_msgs_ExecutionUnitRuntimeStatus
extends RefCounted


var config_hash: int = 0
var unit_count: int = 0
var status: PackedByteArray = PackedByteArray()
var epoch: PackedByteArray = PackedByteArray()
var curr_owner_node_id: PackedByteArray = PackedByteArray()
var next_owner_node_id: PackedByteArray = PackedByteArray()

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/ExecutionUnitRuntimeStatus.gd").new()
    if d.has("config_hash"):
        obj.config_hash = d["config_hash"]
    if d.has("unit_count"):
        obj.unit_count = d["unit_count"]
    if d.has("status"):
        obj.status = d["status"]
    if d.has("epoch"):
        obj.epoch = d["epoch"]
    if d.has("curr_owner_node_id"):
        obj.curr_owner_node_id = d["curr_owner_node_id"]
    if d.has("next_owner_node_id"):
        obj.next_owner_node_id = d["next_owner_node_id"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["config_hash"] = config_hash
    d["unit_count"] = unit_count
    d["status"] = status
    d["epoch"] = epoch
    d["curr_owner_node_id"] = curr_owner_node_id
    d["next_owner_node_id"] = next_owner_node_id
    return d
