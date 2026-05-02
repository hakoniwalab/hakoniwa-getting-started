class_name HakoPdu_hako_msgs_ManualPosAttControl
extends RefCounted


const TwistScript = preload("../geometry_msgs/Twist.gd")


const Vector3Script = preload("../geometry_msgs/Vector3.gd")


var do_operation: bool = false
var posatt = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/ManualPosAttControl.gd").new()
    if d.has("do_operation"):
        obj.do_operation = d["do_operation"]
    if d.has("posatt"):
        obj.posatt = TwistScript.from_dict(d["posatt"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["do_operation"] = do_operation
    d["posatt"] = posatt.to_dict()
    return d
