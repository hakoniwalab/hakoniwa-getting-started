class_name HakoPdu_hako_srv_msgs_ServiceRequestHeader
extends RefCounted


var request_id: int = 0
var service_name: String = ""
var client_name: String = ""
var opcode: int = 0
var status_poll_interval_msec: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_srv_msgs/ServiceRequestHeader.gd").new()
    if d.has("request_id"):
        obj.request_id = d["request_id"]
    if d.has("service_name"):
        obj.service_name = d["service_name"]
    if d.has("client_name"):
        obj.client_name = d["client_name"]
    if d.has("opcode"):
        obj.opcode = d["opcode"]
    if d.has("status_poll_interval_msec"):
        obj.status_poll_interval_msec = d["status_poll_interval_msec"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["request_id"] = request_id
    d["service_name"] = service_name
    d["client_name"] = client_name
    d["opcode"] = opcode
    d["status_poll_interval_msec"] = status_poll_interval_msec
    return d
