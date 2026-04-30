# Hakoniwa — Getting Started

> The entry point to the Hakoniwa simulation ecosystem.

**Hakoniwa** is a reproducible, scalable, next-generation distributed simulation platform for robotics.  
This repository is your starting point — it explains the ecosystem, shows how the pieces fit together, and walks you through your first working example.

---

## Why Hakoniwa?

Traditional robotics simulation stacks tend to become monoliths:

- tightly coupled dependencies
- heavy environment setup
- locked into a specific language or framework

Hakoniwa takes a different approach:

- **Framework-independent** — works without ROS
- **Micro-determinism** — all nodes share the same simulation clock, fully synchronized
- **Separation of concerns** — loosely coupled modules you can mix and match

The result is a simulation environment where C++, Python, Godot, and MuJoCo can all participate in the same timed world — connected only through PDU contracts and Hakoniwa Time.

---

## The Ecosystem

```text
┌─────────────────────────────────────────────────────────────┐
│                Registry (Asset Casting)                      │
│  xacro/URDF  →  hakoniwa-mbody-registry  →  URDF/MJCF/GLB  │
└───────────────────────────┬─────────────────────────────────┘
                            │
              ┌─────────────▼──────────────┐
              │     Core & PDU             │
              │  Shared Memory             │
              │  (Time / PDU)              │
              └──────┬──────────┬──────────┘
                     │          │
       ┌─────────────▼──┐   ┌───▼──────────────────┐
       │ Visualization  │   │ Physics               │
       │ hakoniwa-godot │   │ hakoniwa-mujoco-robots│
       │ Godot Project  │   │ MuJoCo + Hakoniwa PDU │
       └────────────────┘   └──────────────────────┘
```

| Layer | Repository | Role |
|---|---|---|
| Registry | [hakoniwa-mbody-registry](https://github.com/hakoniwalab/hakoniwa-mbody-registry) | Convert xacro/URDF to URDF, MJCF, GLB, and Godot profiles |
| Core & PDU | [hakoniwa-core-pro](https://github.com/hakoniwalab/hakoniwa-core-pro) | Simulation time master and asset lifecycle |
| PDU | [hakoniwa-pdu-registry](https://github.com/hakoniwalab/hakoniwa-pdu-registry) | ROS IDL-based binary contract definitions |
| PDU | [hakoniwa-pdu-endpoint](https://github.com/hakoniwalab/hakoniwa-pdu-endpoint) | Modular communication (SHM / Zenoh / MQTT / Storage) |
| Visualization | [hakoniwa-godot](https://github.com/hakoniwalab/hakoniwa-godot) | Godot as a synchronized distributed simulation node |
| Physics | [hakoniwa-mujoco-robots](https://github.com/hakoniwalab/hakoniwa-mujoco-robots) | High-fidelity rigid body physics via MuJoCo |

---

## Core Concepts

### Simulation Time

Every node shares a single simulation clock managed by `hako-master`.  
Nodes do not poll — they receive data asynchronously via event-driven callbacks.  
This guarantees deterministic, reproducible runs.

### PDU — The Data Contract

A PDU (Protocol Data Unit) is the unit of communication between nodes.  
Binary layout is derived from ROS 2 IDL (`.msg` / `.srv`) and committed as a versioned artifact.  
The same layout is shared across C++, Python, GDScript, C#, and JavaScript — no per-build drift.

### Endpoint — Modular Communication

```text
Endpoint = Cache + Comm + PDU_Def
```

| Cache Mode | Best for |
|---|---|
| `latest` | UI updates, visualization |
| `queue` | State transitions, control, logging |

Transport (SHM / Zenoh / MQTT / Storage) is switched by JSON config — no code changes required.

---

## Your First Example: TurtleBot3

This example connects the full stack end-to-end:

```text
M-Body Asset (URDF/GLB)
        │
        ▼
MuJoCo (Physics)  ──PDU──▶  PDU Endpoint  ──▶  Godot (Visualization)
                                 ▲
                    Python Controller (Gamepad / Twist)
```

- MuJoCo simulates rigid body physics and LiDAR point clouds with sensor noise
- Python sends Twist commands via PDU
- Godot renders the robot in sync with Hakoniwa Time

> This is one combination. Hakoniwa is not limited to this stack.  
> The same Core & PDU layer works with any language or physics engine you connect.

*Step-by-step instructions coming soon.*

---

## Where to Go Next

| I want to... | Start here |
|---|---|
| Understand the PDU system | [hakoniwa-pdu-registry](https://github.com/hakoniwalab/hakoniwa-pdu-registry) |
| Add a robot model | [hakoniwa-mbody-registry](https://github.com/hakoniwalab/hakoniwa-mbody-registry) |
| Connect Godot | [hakoniwa-godot](https://github.com/hakoniwalab/hakoniwa-godot) |
| Run physics simulation | [hakoniwa-mujoco-robots](https://github.com/hakoniwalab/hakoniwa-mujoco-robots) |
| Understand time sync | [hakoniwa-core-pro](https://github.com/hakoniwalab/hakoniwa-core-pro) |

---

## Design Philosophy

> "A deterministic simulation environment, uncompromised, in the hands of every robotics developer."

- **Language Freedom** — Python (cffi), C# (Unity/Godot), C++ bindings. Write logic in the language you know.
- **Auditability** — Full replay via Storage Comm. Deep inspection via `hako_pdu_storage_debug`.
- **Modularity** — Pick only the components you need. No mandatory framework overhead.