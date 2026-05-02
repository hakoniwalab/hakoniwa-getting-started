class_name HakoPdu_sensor_msgs_JointState
extends RefCounted


const TimeScript = preload("../builtin_interfaces/Time.gd")


const HeaderScript = preload("../std_msgs/Header.gd")


var header = null
var name: Array[String] = []
var position: PackedFloat64Array = PackedFloat64Array()
var velocity: PackedFloat64Array = PackedFloat64Array()
var effort: PackedFloat64Array = PackedFloat64Array()

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/sensor_msgs/JointState.gd").new()
    if d.has("header"):
        obj.header = HeaderScript.from_dict(d["header"])
    if d.has("name"):
        obj.name = d["name"]
    if d.has("position"):
        obj.position = d["position"]
    if d.has("velocity"):
        obj.velocity = d["velocity"]
    if d.has("effort"):
        obj.effort = d["effort"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["name"] = name
    d["position"] = position
    d["velocity"] = velocity
    d["effort"] = effort
    return d
