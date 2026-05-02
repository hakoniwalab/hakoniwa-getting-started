class_name HakoPdu_hako_msgs_Collision
extends RefCounted


const PointScript = preload("../geometry_msgs/Point.gd")


const Vector3Script = preload("../geometry_msgs/Vector3.gd")


var collision: bool = false
var contact_num: int = 0
var relative_velocity = null
var contact_position: Array = []
var restitution_coefficient: float = 0.0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/Collision.gd").new()
    if d.has("collision"):
        obj.collision = d["collision"]
    if d.has("contact_num"):
        obj.contact_num = d["contact_num"]
    if d.has("relative_velocity"):
        obj.relative_velocity = Vector3Script.from_dict(d["relative_velocity"])
    if d.has("contact_position"):
        obj.contact_position = []
        for item in d["contact_position"]:
            obj.contact_position.append(PointScript.from_dict(item))
    if d.has("restitution_coefficient"):
        obj.restitution_coefficient = d["restitution_coefficient"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["collision"] = collision
    d["contact_num"] = contact_num
    d["relative_velocity"] = relative_velocity.to_dict()
    var contact_position_array: Array = []
    for item in contact_position:
        contact_position_array.append(item.to_dict())
    d["contact_position"] = contact_position_array
    d["restitution_coefficient"] = restitution_coefficient
    return d
