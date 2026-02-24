# Perception-for-Maritime-Study

## Build workflow

Use the wrapper script to run checks before building:

```bash
./scripts/build.sh
```

This runs:
1. `./scripts/preflight.sh` (checks ROS env, required Gazebo dev packages, and broken symlinks in `src/`)
2. `colcon build --symlink-install`

Optional build arguments are passed through to `colcon`:

```bash
./scripts/build.sh --packages-select vrx_ros
```
