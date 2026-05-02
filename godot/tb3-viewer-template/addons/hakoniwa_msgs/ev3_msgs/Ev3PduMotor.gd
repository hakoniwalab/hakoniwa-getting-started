class_name HakoPdu_ev3_msgs_Ev3PduMotor
extends RefCounted


var power: int = 0
var stop: int = 0
var reset_angle: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/ev3_msgs/Ev3PduMotor.gd").new()
    if d.has("power"):
        obj.power = d["power"]
    if d.has("stop"):
        obj.stop = d["stop"]
    if d.has("reset_angle"):
        obj.reset_angle = d["reset_angle"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["power"] = power
    d["stop"] = stop
    d["reset_angle"] = reset_angle
    return d
