# initial CMake cache values for to build as many packages as possible

# Use external projects
set (CISST_USE_EXTERNAL OFF CACHE BOOL "")

# Compile for shared libraries
set (CISST_BUILD_SHARED_LIBS ON CACHE BOOL "")

# Use SI units
set (CISST_USE_SI_UNITS ON CACHE BOOL "")

# Force compilation for optional libraries
set (CISST_cisstRobot ON CACHE BOOL "")

# XML parsing
set (CISST_cisstCommonXML ON CACHE BOOL "")

# JSON
set (CISST_HAS_JSON ON CACHE BOOL "")

# cisstNetlib
set (CISSTNETLIB_USE_LOCAL_INSTALL ON CACHE BOOL "")
set (CISST_HAS_CISSTNETLIB ON CACHE BOOL "")

# Qt
set (CISST_HAS_QT5 ON CACHE BOOL "")

# FLTK
set (CISST_HAS_FLTK OFF CACHE BOOL "")
