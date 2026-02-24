# Coordinate Frames (TF Tree) Contract

**Standard:** ENU (X = East/Forward, Y = North/Left, Z = Up)
**Units:** Meters and Radians

## The Links
* `base_link`: The physical center of the boat at the waterline. All math starts here.
* `imu_link`: The tilt sensor.
* `camera_link`: The center of the camera lens.
* `radar_link`: The center of the radar dome.

## Static Transforms (Offsets from base_link)

| Frame | X (Forward) | Y (Left) | Z (Up) | Roll | Pitch | Yaw |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `imu_link` | 0.0 | 0.0 | 0.2 | 0.0 | 0.0 | 0.0 |
| `camera_link` | 1.0 | 0.0 | 1.0 | 0.0 | 0.0 | 0.0 |
| `radar_link` | 0.8 | 0.0 | 1.2 | 0.0 | 0.0 | 0.0 |

*Note: If a physical sensor is mounted upside down or backward, we fix the rotation in the software publisher, NOT by changing this contract.*
