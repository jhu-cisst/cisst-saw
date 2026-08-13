#
# Author(s):  Anton Deguet
# Created on: 2014-03-14
#
# (C) Copyright 2014-2026 Johns Hopkins University (JHU), All Rights Reserved.
#
# --- begin cisst license - do not edit ---
#
# This software is provided "as is" under an open source license, with
# no warranty.  The complete license can be found in license.txt and
# http://www.cisst.org/cisst/license.txt.
#
# --- end cisst license ---

cmake_minimum_required (VERSION 3.16)

project (cisst-saw)

# include cisst
set (cisst_DIR "${CMAKE_CURRENT_BINARY_DIR}/cisst")
add_subdirectory (cisst)
cisst_use_cisst_output_directories ()

# saw components to be compiled, order matters
cisst_offer_saw_component (sawKeyboard ON)
cisst_offer_saw_component (sawTextToSpeech ON)
cisst_offer_saw_component (sawSocketStreamer ON)
cisst_offer_saw_component (saw3Dconnexion OFF)
cisst_offer_saw_component (sawControllers OFF)
cisst_offer_saw_component (sawConstraintController OFF)
cisst_offer_saw_component (sawIntuitiveDaVinci OFF)
cisst_offer_saw_component (sawNDITracker OFF)
cisst_offer_saw_component (sawOpenIGTLink OFF)
cisst_offer_saw_component (sawSartoriusScale OFF)
cisst_offer_saw_component (sawSensablePhantom OFF)
cisst_offer_saw_component (sawRobotIO1394 OFF)
cisst_offer_saw_component (sawATIForceSensor OFF)
cisst_offer_saw_component (sawAtracsysFusionTrack OFF)
cisst_offer_saw_component (sawOptoforceSensor OFF)
cisst_offer_saw_component (sawUniversalRobot OFF)
cisst_offer_saw_component (sawGalilController OFF)
cisst_offer_saw_component (sawCopleyController OFF)
cisst_offer_saw_component (sawIntuitiveResearchKit OFF)
cisst_offer_saw_component (sawMaxonEPOS OFF)
cisst_offer_saw_component (sawForceDimensionSDK OFF)
cisst_offer_saw_component (sawHaplyService OFF)
