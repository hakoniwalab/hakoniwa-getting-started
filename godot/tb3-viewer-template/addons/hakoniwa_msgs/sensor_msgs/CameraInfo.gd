class_name HakoPdu_sensor_msgs_CameraInfo
extends RefCounted


const TimeScript = preload("../builtin_interfaces/Time.gd")


const RegionOfInterestScript = preload("./RegionOfInterest.gd")


const HeaderScript = preload("../std_msgs/Header.gd")


var header = null
var height: int = 0
var width: int = 0
var distortion_model: String = ""
var d: PackedFloat64Array = PackedFloat64Array()
var k: PackedFloat64Array = PackedFloat64Array()
var r: PackedFloat64Array = PackedFloat64Array()
var p: PackedFloat64Array = PackedFloat64Array()
var binning_x: int = 0
var binning_y: int = 0
var roi = null

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/sensor_msgs/CameraInfo.gd").new()
    if d.has("header"):
        obj.header = HeaderScript.from_dict(d["header"])
    if d.has("height"):
        obj.height = d["height"]
    if d.has("width"):
        obj.width = d["width"]
    if d.has("distortion_model"):
        obj.distortion_model = d["distortion_model"]
    if d.has("d"):
        obj.d = d["d"]
    if d.has("k"):
        obj.k = d["k"]
    if d.has("r"):
        obj.r = d["r"]
    if d.has("p"):
        obj.p = d["p"]
    if d.has("binning_x"):
        obj.binning_x = d["binning_x"]
    if d.has("binning_y"):
        obj.binning_y = d["binning_y"]
    if d.has("roi"):
        obj.roi = RegionOfInterestScript.from_dict(d["roi"])
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["header"] = header.to_dict()
    d["height"] = height
    d["width"] = width
    d["distortion_model"] = distortion_model
    d["d"] = d
    d["k"] = k
    d["r"] = r
    d["p"] = p
    d["binning_x"] = binning_x
    d["binning_y"] = binning_y
    d["roi"] = roi.to_dict()
    return d
