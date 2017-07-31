#
# Author(s):  Anton Deguet
# Created on: 2014-03-14
#
# (C) Copyright 2014-2017 Johns Hopkins University (JHU), All Rights Reserved.
#
# --- begin cisst license - do not edit ---
#
# This software is provided "as is" under an open source license, with
# no warranty.  The complete license can be found in license.txt and
# http://www.cisst.org/cisst/license.txt.
#
# --- end cisst license ---

cmake_minimum_required (VERSION 2.8)

project (cisst-saw)

option (BUILD_cisstNetlib "Build cisstNetlib.  You will need to compile a first time AND THEN turn on CISST_HAS_CISSTNETLIB so CMake can find all the cisstNetlib libraries.  To note, on Linux we recommend to install gfortran first" OFF)
if (BUILD_cisstNetlib)
  add_subdirectory (cisstNetlib)
  # for cisst to find this build version of cisstNetlib
  set (FORCE_CISSTNETLIB_CONFIG ON)
  set (CMAKE_PREFIX_PATH "${CMAKE_CURRENT_BINARY_DIR}/cisstNetlib" ${CMAKE_PREFIX_PATH})
else ()
  set (FORCE_CISSTNETLIB_CONFIG OFF)
endif ()

# include cisst 
set (cisst_DIR "${CMAKE_CURRENT_BINARY_DIR}/cisst")
add_subdirectory (cisst)

# use cisst settings for compilers
include (cisst/cisstSettings.cmake)

# place generated binaries along cisst binaries
cisst_use_cisst_output_directories ()

# saw components to be compiled, order matters
cisst_offer_saw_component (sawKeyboard ON)
cisst_offer_saw_component (sawTextToSpeech ON)
cisst_offer_saw_component (saw3Dconnexion OFF)
cisst_offer_saw_component (sawCANBus OFF)
cisst_offer_saw_component (sawControllers OFF)
cisst_offer_saw_component (sawConstraintController OFF)
cisst_offer_saw_component (sawTrajectories OFF)
cisst_offer_saw_component (sawBarrett OFF)
cisst_offer_saw_component (sawCMUSphinx4 OFF)
cisst_offer_saw_component (sawClaronMicronTracker OFF)
cisst_offer_saw_component (sawDataPlayer OFF)
cisst_offer_saw_component (sawGLUTSimulator OFF)
cisst_offer_saw_component (sawIntuitiveDaVinci OFF)

set (IS_QNX FALSE)
if ("${CMAKE_SYSTEM_NAME}" STREQUAL "QNX")
  set (IS_QNX TRUE)
endif ("${CMAKE_SYSTEM_NAME}" STREQUAL "QNX")
cisst_offer_saw_component (sawJR3ForceSensor OFF)

cisst_offer_saw_component (sawLoPoMoCo OFF)
cisst_offer_saw_component (sawMedtronicStealthlink OFF)
cisst_offer_saw_component (sawMicroScribeDigitizer OFF)
cisst_offer_saw_component (sawNDITracker OFF)
cisst_offer_saw_component (sawNovintFalcon OFF)
cisst_offer_saw_component (sawOpenAL OFF)
cisst_offer_saw_component (sawOpenDynamicsEngine OFF)
cisst_offer_saw_component (sawOpenIGTLink OFF)
cisst_offer_saw_component (sawOpenNI OFF)
cisst_offer_saw_component (sawOpenSceneGraph OFF)
cisst_offer_saw_component (sawSartoriusScale OFF)
cisst_offer_saw_component (sawSensablePhantom OFF)
cisst_offer_saw_component (sawRobotIO1394 OFF)
cisst_offer_saw_component (sawATIForceSensor OFF)
cisst_offer_saw_component (sawAtracsysFusionTrack OFF)
cisst_offer_saw_component (sawOptoforceSensor OFF)
cisst_offer_saw_component (sawUniversalRobot OFF)
cisst_offer_saw_component (sawIntuitiveResearchKit OFF)

