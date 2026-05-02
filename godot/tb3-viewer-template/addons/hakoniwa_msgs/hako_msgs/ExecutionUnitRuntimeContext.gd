class_name HakoPdu_hako_msgs_ExecutionUnitRuntimeContext
extends RefCounted


var config_hash: int = 0
var epoch: int = 0
var owner_id: int = 0
var context: PackedByteArray = PackedByteArray()

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/ExecutionUnitRuntimeContext.gd").new()
    if d.has("config_hash"):
        obj.config_hash = d["config_hash"]
    if d.has("epoch"):
        obj.epoch = d["epoch"]
    if d.has("owner_id"):
        obj.owner_id = d["owner_id"]
    if d.has("context"):
        obj.context = d["context"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["config_hash"] = config_hash
    d["epoch"] = epoch
    d["owner_id"] = owner_id
    d["context"] = context
    return d
