class_name HakoPdu_hako_msgs_ImpulseCollision
extends RefCounted


const PointScript = preload("../geometry_msgs/Point.gd")


const Vector3Script = preload("../geometry_msgs/Vector3.gd")


var collision: bool = false
var is_target_static: bool = false
var restitution_coefficient: float = 0.0
var self_contact_vector = null
var normal = null
var target_contact_vector = null
var target_velocity = null
var target_angular_velocity = null
var target_euler = null
var target_inertia = null
var target_mass: float = 0.0

static func from_dict(d: Dictionary):
    var obj = load("res://addons/hakoniwa_msgs/hako_msgs/ImpulseCollision.gd").new()
    if d.has("collision"):
        obj.collision = d["collision"]
    if d.has("is_target_static"):
        obj.is_target_static = d["is_target_static"]
    if d.has("restitution_coefficient"):
        obj.restitution_coefficient = d["restitution_coefficient"]
    if d.has("self_contact_vector"):
        obj.self_contact_vector = PointScript.from_dict(d["self_contact_vector"])
    if d.has("normal"):
        obj.normal = Vector3Script.from_dict(d["normal"])
    if d.has("target_contact_vector"):
        obj.target_contact_vector = PointScript.from_dict(d["target_contact_vector"])
    if d.has("target_velocity"):
        obj.target_velocity = Vector3Script.from_dict(d["target_velocity"])
    if d.has("target_angular_velocity"):
        obj.target_angular_velocity = Vector3Script.from_dict(d["target_angular_velocity"])
    if d.has("target_euler"):
        obj.target_euler = Vector3Script.from_dict(d["target_euler"])
    if d.has("target_inertia"):
        obj.target_inertia = Vector3Script.from_dict(d["target_inertia"])
    if d.has("target_mass"):
        obj.target_mass = d["target_mass"]
    return obj

func to_dict() -> Dictionary:
    var d: Dictionary = {}
    d["collision"] = collision
    d["is_target_static"] = is_target_static
    d["restitution_coefficient"] = restitution_coefficient
    d["self_contact_vector"] = self_contact_vector.to_dict()
    d["normal"] = normal.to_dict()
    d["target_contact_vector"] = target_contact_vector.to_dict()
    d["target_velocity"] = target_velocity.to_dict()
    d["target_angular_velocity"] = target_angular_velocity.to_dict()
    d["target_euler"] = target_euler.to_dict()
    d["target_inertia"] = target_inertia.to_dict()
    d["target_mass"] = target_mass
    return d
