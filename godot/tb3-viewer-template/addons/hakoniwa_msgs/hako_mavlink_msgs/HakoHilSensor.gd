class_name HakoPdu_hako_mavlink_msgs_HakoHilSensor
extends RefCounted


var time_usec: int = 0
var xacc: float = 0.0
var yacc: float = 0.0
var zacc: float = 0.0
var xgyro: float = 0.0
var ygyro: float = 0.0
var zgyro: float = 0.0
var xmag: float = 0.0
var ymag: float = 0.0
var zmag: float = 0.0
var abs_pressure: float = 0.0
var diff_pressure: float = 0.0
var pressure_alt: float = 0.0
var temperature: float = 0.0
var fields_updated: int = 0
var id: int = 0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_mavlink_msgs/HakoHilSensor.gd").new()
    if d.has("time_usec"):
        obj.time_usec = d["time_usec"]
    if d.has("xacc"):
        obj.xacc = d["xacc"]
    if d.has("yacc"):
        obj.yacc = d["yacc"]
    if d.has("zacc"):
        obj.zacc = d["zacc"]
    if d.has("xgyro"):
        obj.xgyro = d["xgyro"]
    if d.has("ygyro"):
        obj.ygyro = d["ygyro"]
    if d.has("zgyro"):
        obj.zgyro = d["zgyro"]
    if d.has("xmag"):
        obj.xmag = d["xmag"]
    if d.has("ymag"):
        obj.ymag = d["ymag"]
    if d.has("zmag"):
        obj.zmag = d["zmag"]
    if d.has("abs_pressure"):
        obj.abs_pressure = d["abs_pressure"]
    if d.has("diff_pressure"):
        obj.diff_pressure = d["diff_pressure"]
    if d.has("pressure_alt"):
        obj.pressure_alt = d["pressure_alt"]
    if d.has("temperature"):
        obj.temperature = d["temperature"]
    if d.has("fields_updated"):
        obj.fields_updated = d["fields_updated"]
    if d.has("id"):
        obj.id = d["id"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["time_usec"] = time_usec
    d["xacc"] = xacc
    d["yacc"] = yacc
    d["zacc"] = zacc
    d["xgyro"] = xgyro
    d["ygyro"] = ygyro
    d["zgyro"] = zgyro
    d["xmag"] = xmag
    d["ymag"] = ymag
    d["zmag"] = zmag
    d["abs_pressure"] = abs_pressure
    d["diff_pressure"] = diff_pressure
    d["pressure_alt"] = pressure_alt
    d["temperature"] = temperature
    d["fields_updated"] = fields_updated
    d["id"] = id
    return d
