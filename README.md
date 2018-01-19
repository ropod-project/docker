# ropod-base-cpp

Docker base image for C++ components of the ROPOD project.

# Usage

``docker build -t blumenthal/ropod-base-cpp .``

```
docker run -it --mount type=bind,source=<root_of_source_repositories>,target=/workspace blumenthal/ropod-base-cpp
cd /workspace
```
