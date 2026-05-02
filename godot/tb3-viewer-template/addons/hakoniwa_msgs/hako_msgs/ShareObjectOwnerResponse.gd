class_name HakoPdu_hako_msgs_ShareObjectOwnerResponse
extends RefCounted


var object_name: String = ""
var request_type: int = 0
var owner_id: int = 0
var accepted: bool = false

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/ShareObjectOwnerResponse.gd").new()
    if d.has("object_name"):
        obj.object_name = d["object_name"]
    if d.has("request_type"):
        obj.request_type = d["request_type"]
    if d.has("owner_id"):
        obj.owner_id = d["owner_id"]
    if d.has("accepted"):
        obj.accepted = d["accepted"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["object_name"] = object_name
    d["request_type"] = request_type
    d["owner_id"] = owner_id
    d["accepted"] = accepted
    return d
