############################################################################
#
#   Copyright (C) 2012 PX4 Development Team. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in
#    the documentation and/or other materials provided with the
#    distribution.
# 3. Neither the name PX4 nor the names of its contributors may be
#    used to endorse or promote products derived from this software
#    without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
# OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
# AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
############################################################################

#
# Mavlink Application

#APPNAME		 = Corona
#PRIORITY	 = SCHED_PRIORITY_DEFAULT
#STACKSIZE	 = 4096

#DESKTOP=$(PWD)/../libraries


build: pre-build

#clean:
#	cd /Users/buzz/PX4/Firmware
#	

pre-build:
	(cd ArduPlane && make -f ../libraries/Desktop/NuttX.mk generate-sketch-src)
	
#	
#build:
#	(cd ArduPlane && make -f ../libraries/Desktop/NuttX.mk)


CXXSRCS := tmp/ArduPlane.build/ArduPlane.cpp


INCLUDES := /Users/buzz/PX4/Firmware/apps/Corona/libraries/Desktop/include /Users/buzz/PX4/Firmware/nuttx/include

include $(APPDIR)/mk/app.mk


#SKETCHBOOK := /Users/buzz/PX4/Firmware/apps/Corona/
#SKETCHLIBS		:=	$(wildcard $(addprefix $(SKETCHBOOK)/libraries/,$(LIBTOKENS)))
#SKETCHLIBSRCDIRS	:=	$(SKETCHLIBS) $(SKETCHBOOK)/libraries/Desktop/support $(addsuffix /utility,$(SKETCHLIBS))
#SKETCHLIBINCLUDES	:=	$(addprefix -I,$(SKETCHLIBSRCDIRS))
#SKETCH_INCLUDES	:=	$(SKETCHLIBINCLUDES)

TMPDIR			:=	/Users/buzz/PX4/Firmware/apps/Corona/tmp
BUILDROOT		:=	$(abspath $(TMPDIR)/$(SKETCH).build)


SKETCHLIBSRCDIRS= \
/Users/buzz/PX4/Firmware/apps/Corona/ArduPlane \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/APM_OBC \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/APM_RC \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_ADC \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_AHRS \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Airspeed \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_AnalogSource \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Baro \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Camera \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Common \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Compass \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Declination \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_GPS \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_IMU \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_InertialSensor \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Math \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Mount \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_PeriodicProcess \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_RangeFinder \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Relay \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/Arduino_Mega_ISR_Registry \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/DataFlash \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/FastSerial \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/Filter \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/GCS_MAVLink \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/I2C \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/PID \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/RC_Channel \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/SITL \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/memcheck \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/Desktop/support \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/APM_OBC/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/APM_RC/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_ADC/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_AHRS/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Airspeed/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_AnalogSource/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Baro/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Camera/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Common/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Compass/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Declination/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_GPS/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_IMU/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_InertialSensor/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Math/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Mount/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_PeriodicProcess/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_RangeFinder/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/AP_Relay/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/Arduino_Mega_ISR_Registry/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/DataFlash/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/FastSerial/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/Filter/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/GCS_MAVLink/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/I2C/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/PID/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/RC_Channel/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/SITL/utility \
/Users/buzz/PX4/Firmware/apps/Corona/libraries/memcheck/utility


SKETCHLIBINCLUDES	:=	$(addprefix -I,$(SKETCHLIBSRCDIRS))
SKETCH_INCLUDES	=	$(SKETCHLIBINCLUDES)

CXXFLAGS := -D__AVR_ATmega2560__ -Wshadow  -I/Users/buzz/PX4/Firmware/apps/Corona/libraries/Desktop/include $(SKETCH_INCLUDES)  -DDESKTOP_BUILD=1
#CXXFLAGS := -D__AVR_ATmega2560__  -DDESKTOP_BUILD=1
