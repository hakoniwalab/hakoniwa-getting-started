class_name HakoPdu_hako_msgs_ShareObjectOwnerRequest
extends RefCounted


var object_name: String = ""
var request_type: int = 0
var new_owner_id: int = 0
var request_time: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/ShareObjectOwnerRequest.gd").new()
    if d.has("object_name"):
        obj.object_name = d["object_name"]
    if d.has("request_type"):
        obj.request_type = d["request_type"]
    if d.has("new_owner_id"):
        obj.new_owner_id = d["new_owner_id"]
    if d.has("request_time"):
        obj.request_time = d["request_time"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["object_name"] = object_name
    d["request_type"] = request_type
    d["new_owner_id"] = new_owner_id
    d["request_time"] = request_time
    return d
