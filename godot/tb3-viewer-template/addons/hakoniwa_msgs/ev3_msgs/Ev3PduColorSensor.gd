class_name HakoPdu_ev3_msgs_Ev3PduColorSensor
extends RefCounted


var color: int = 0
var reflect: int = 0
var rgb_r: int = 0
var rgb_g: int = 0
var rgb_b: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/ev3_msgs/Ev3PduColorSensor.gd").new()
    if d.has("color"):
        obj.color = d["color"]
    if d.has("reflect"):
        obj.reflect = d["reflect"]
    if d.has("rgb_r"):
        obj.rgb_r = d["rgb_r"]
    if d.has("rgb_g"):
        obj.rgb_g = d["rgb_g"]
    if d.has("rgb_b"):
        obj.rgb_b = d["rgb_b"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["color"] = color
    d["reflect"] = reflect
    d["rgb_r"] = rgb_r
    d["rgb_g"] = rgb_g
    d["rgb_b"] = rgb_b
    return d
