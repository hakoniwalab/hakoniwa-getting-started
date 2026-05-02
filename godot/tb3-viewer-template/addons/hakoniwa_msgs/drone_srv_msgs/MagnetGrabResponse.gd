class_name HakoPdu_drone_srv_msgs_MagnetGrabResponse
extends RefCounted


var ok: bool = false
var magnet_on: bool = false
var contact_on: bool = false
var message: String = ""

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/drone_srv_msgs/MagnetGrabResponse.gd").new()
    if d.has("ok"):
        obj.ok = d["ok"]
    if d.has("magnet_on"):
        obj.magnet_on = d["magnet_on"]
    if d.has("contact_on"):
        obj.contact_on = d["contact_on"]
    if d.has("message"):
        obj.message = d["message"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["ok"] = ok
    d["magnet_on"] = magnet_on
    d["contact_on"] = contact_on
    d["message"] = message
    return d
