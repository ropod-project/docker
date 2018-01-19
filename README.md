# ropod-base-cpp

Docker base image for C++ components of the ROPOD project.

# Build 

``docker build -t blumenthal/ropod-base-cpp .``

# Usage


```
docker run -it --mount type=bind,source=<root_of_source_repositories>,target=/workspace blumenthal/ropod-base-cpp
```
For older Docker versions use:

```
docker run -it -v <root_of_source_repositories>:/workspace blumenthal/ropod-base-cpp
```
