class_name HakoPdu_hako_srv_msgs_RegisterClientResponse
extends RefCounted


var service_id: int = 0
var client_id: int = 0
var request_channel_id: int = 0
var response_channel_id: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_srv_msgs/RegisterClientResponse.gd").new()
    if d.has("service_id"):
        obj.service_id = d["service_id"]
    if d.has("client_id"):
        obj.client_id = d["client_id"]
    if d.has("request_channel_id"):
        obj.request_channel_id = d["request_channel_id"]
    if d.has("response_channel_id"):
        obj.response_channel_id = d["response_channel_id"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["service_id"] = service_id
    d["client_id"] = client_id
    d["request_channel_id"] = request_channel_id
    d["response_channel_id"] = response_channel_id
    return d
