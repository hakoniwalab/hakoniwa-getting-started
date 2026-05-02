class_name HakoPdu_hako_srv_msgs_ServiceResponseHeader
extends RefCounted


var request_id: int = 0
var service_name: String = ""
var client_name: String = ""
var status: int = 0
var processing_percentage: int = 0
var result_code: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_srv_msgs/ServiceResponseHeader.gd").new()
    if d.has("request_id"):
        obj.request_id = d["request_id"]
    if d.has("service_name"):
        obj.service_name = d["service_name"]
    if d.has("client_name"):
        obj.client_name = d["client_name"]
    if d.has("status"):
        obj.status = d["status"]
    if d.has("processing_percentage"):
        obj.processing_percentage = d["processing_percentage"]
    if d.has("result_code"):
        obj.result_code = d["result_code"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["request_id"] = request_id
    d["service_name"] = service_name
    d["client_name"] = client_name
    d["status"] = status
    d["processing_percentage"] = processing_percentage
    d["result_code"] = result_code
    return d
