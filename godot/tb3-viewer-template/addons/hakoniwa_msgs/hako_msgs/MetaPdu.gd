class_name HakoPdu_hako_msgs_MetaPdu
extends RefCounted


var total_len: int = 0
var magicno: int = 0
var version: int = 0
var flags: int = 0
var meta_request_type: int = 0
var hako_time_us: int = 0
var asset_time_us: int = 0
var real_time_us: int = 0
var robot_name: String = ""
var channel_id: int = 0
var body_len: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/MetaPdu.gd").new()
    if d.has("total_len"):
        obj.total_len = d["total_len"]
    if d.has("magicno"):
        obj.magicno = d["magicno"]
    if d.has("version"):
        obj.version = d["version"]
    if d.has("flags"):
        obj.flags = d["flags"]
    if d.has("meta_request_type"):
        obj.meta_request_type = d["meta_request_type"]
    if d.has("hako_time_us"):
        obj.hako_time_us = d["hako_time_us"]
    if d.has("asset_time_us"):
        obj.asset_time_us = d["asset_time_us"]
    if d.has("real_time_us"):
        obj.real_time_us = d["real_time_us"]
    if d.has("robot_name"):
        obj.robot_name = d["robot_name"]
    if d.has("channel_id"):
        obj.channel_id = d["channel_id"]
    if d.has("body_len"):
        obj.body_len = d["body_len"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["total_len"] = total_len
    d["magicno"] = magicno
    d["version"] = version
    d["flags"] = flags
    d["meta_request_type"] = meta_request_type
    d["hako_time_us"] = hako_time_us
    d["asset_time_us"] = asset_time_us
    d["real_time_us"] = real_time_us
    d["robot_name"] = robot_name
    d["channel_id"] = channel_id
    d["body_len"] = body_len
    return d
