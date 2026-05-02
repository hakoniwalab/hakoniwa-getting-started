class_name HakoPdu_hako_msgs_ExecutionUnitRuntimeEpoch
extends RefCounted


var epoch: PackedByteArray = PackedByteArray()

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/ExecutionUnitRuntimeEpoch.gd").new()
    if d.has("epoch"):
        obj.epoch = d["epoch"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["epoch"] = epoch
    return d
