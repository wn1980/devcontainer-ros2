# ros2-devcontainer

To run X apps, e.g. `rviz2`, type this commands in host terminal:
```
$ xhost local:root
$ xhost -si:localuser:root
```

# GPU
```
"runArgs": ["--runtime=nvidia"] or "runArgs": ["--gpus all"]
```