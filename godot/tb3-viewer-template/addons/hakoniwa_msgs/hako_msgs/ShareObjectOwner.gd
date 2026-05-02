class_name HakoPdu_hako_msgs_ShareObjectOwner
extends RefCounted


const TwistScript = preload("../geometry_msgs/Twist.gd")


const Vector3Script = preload("../geometry_msgs/Vector3.gd")


var object_name: String = ""
var owner_id: int = 0
var last_update: int = 0
var pos = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/ShareObjectOwner.gd").new()
    if d.has("object_name"):
        obj.object_name = d["object_name"]
    if d.has("owner_id"):
        obj.owner_id = d["owner_id"]
    if d.has("last_update"):
        obj.last_update = d["last_update"]
    if d.has("pos"):
        obj.pos = TwistScript.from_dict(d["pos"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["object_name"] = object_name
    d["owner_id"] = owner_id
    d["last_update"] = last_update
    d["pos"] = pos.to_dict()
    return d
