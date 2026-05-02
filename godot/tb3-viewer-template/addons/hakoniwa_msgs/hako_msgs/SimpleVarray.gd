class_name HakoPdu_hako_msgs_SimpleVarray
extends RefCounted


var data: Array = []
var fixed_array: Array = []
var p_mem1: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/SimpleVarray.gd").new()
    if d.has("data"):
        obj.data = d["data"]
    if d.has("fixed_array"):
        obj.fixed_array = d["fixed_array"]
    if d.has("p_mem1"):
        obj.p_mem1 = d["p_mem1"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["data"] = data
    d["fixed_array"] = fixed_array
    d["p_mem1"] = p_mem1
    return d
