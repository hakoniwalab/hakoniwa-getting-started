class_name HakoPdu_hako_msgs_DroneVisualStateArray
extends RefCounted


const DroneVisualStateScript = preload("./DroneVisualState.gd")


var sequence_id: int = 0
var chunk_index: int = 0
var chunk_count: int = 0
var start_index: int = 0
var valid_count: int = 0
var drones: Array = []

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/DroneVisualStateArray.gd").new()
    if d.has("sequence_id"):
        obj.sequence_id = d["sequence_id"]
    if d.has("chunk_index"):
        obj.chunk_index = d["chunk_index"]
    if d.has("chunk_count"):
        obj.chunk_count = d["chunk_count"]
    if d.has("start_index"):
        obj.start_index = d["start_index"]
    if d.has("valid_count"):
        obj.valid_count = d["valid_count"]
    if d.has("drones"):
        obj.drones = []
        for item in d["drones"]:
            obj.drones.append(DroneVisualStateScript.from_dict(item))
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["sequence_id"] = sequence_id
    d["chunk_index"] = chunk_index
    d["chunk_count"] = chunk_count
    d["start_index"] = start_index
    d["valid_count"] = valid_count
    var drones_array: Array = []
    for item in drones:
        drones_array.append(item.to_dict())
    d["drones"] = drones_array
    return d
