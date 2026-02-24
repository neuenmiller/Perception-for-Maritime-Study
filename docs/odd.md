# Operational Design Domain (ODD)

This autonomy stack is designed to operate safely ONLY under the following conditions. If the environment violates these conditions, the system must trigger an E-Stop or return control to a human.

## 1. Environmental Limits
* **Lighting:** Daylight only. (No night operations, no heavy fog).
* **Weather:** Clear skies to light drizzle. No heavy rain or snow.
* **Sea State:** Calm water to light chop (Waves < 0.5 meters). No breaking whitecaps.

## 2. Platform Limits
* **Max Speed:** 10 knots (5 m/s).
* **Dynamics:** No sudden extreme maneuvers that would submerge the camera.

## 3. Target (Obstacle) Definitions
The perception stack is trained to detect and track:
* Navigation Buoys (Red, Green, Yellow)
* Small vessels (Kayaks, Dinghies, Jet Skis)
* Docks and shorelines

*Note: It is NOT trained to detect submerged rocks, divers, or fishing nets.*