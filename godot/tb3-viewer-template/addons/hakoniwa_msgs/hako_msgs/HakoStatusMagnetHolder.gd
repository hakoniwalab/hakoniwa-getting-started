class_name HakoPdu_hako_msgs_HakoStatusMagnetHolder
extends RefCounted


var magnet_on: bool = false
var contact_on: bool = false

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/HakoStatusMagnetHolder.gd").new()
    if d.has("magnet_on"):
        obj.magnet_on = d["magnet_on"]
    if d.has("contact_on"):
        obj.contact_on = d["contact_on"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["magnet_on"] = magnet_on
    d["contact_on"] = contact_on
    return d
