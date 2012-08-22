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


# base nuttx 'apps' folder we are working from.  
APPDIR := /Users/buzz/PX4/Firmware/apps

#contains 'ArduPlane' and 'libraries' etc.
SKETCHBOOK := $(APPDIR)/Corona

SKETCH := ArduPlane

DEFINES			=	-DSKETCH=\"$(SKETCH)\"


# arduplane folder:
SRCROOT			:=	$(SKETCHBOOK)/$(SKETCH)/


TMPDIR			:=	$(SKETCHBOOK)/tmp

BUILDROOT		:=	$(abspath $(TMPDIR)/$(SKETCH).build)


# resulting bundles cpp file is this: 
CXXSRCS := tmp/ArduPlane.build/ArduPlane.cpp

CONFIG_HAVE_CXX := y

# equivalently: 
SKETCHCPP		:=	$(BUILDROOT)/$(SKETCH).cpp

SRCSUFFIXES		=	*.cpp *.c


# we search all these files for "#include" statements for libs: * .c *.cpp. *pde 
SKETCHPDESRCS	:=	$(wildcard $(SRCROOT)/*.pde)
SKETCHSRCS		:=	$(wildcard $(addprefix $(SRCROOT)/,$(SRCSUFFIXES)))


# build a list of LIBTOKENS form the SRC file/s 
SYSTYPE			:=	$(shell uname)
SEXPR			=	's/^[[:space:]]*\#include[[:space:]][<\"]([^>\"./]+).*$$/\1/p'
ifeq ($(SYSTYPE),Darwin)
  LIBTOKENS        :=    $(sort $(shell cat $(SKETCHPDESRCS) $(SKETCHSRCS) | sed -nEe $(SEXPR)))
else
  LIBTOKENS        :=    $(sort $(shell cat $(SKETCHPDESRCS) $(SKETCHSRCS) | sed -nre $(SEXPR)))
endif


# list of librarys in the /libraries/ folder: 
SKETCHLIBS		:=	$(wildcard $(addprefix $(SKETCHBOOK)/libraries/,$(LIBTOKENS)))
SKETCHLIBNAMES		:=	$(notdir $(SKETCHLIBS))

#all the folders these libraries might be found in, we sneak in the Desktop/support and */utility/*  here too.
SKETCHLIBSRCDIRS	:=	$(SKETCHLIBS) $(SKETCHBOOK)/libraries/Desktop/support $(addsuffix /utility,$(SKETCHLIBS))



# build a list of all the possible library names from the library source files *.c and *.cpp
SKETCHLIBSRCS		:=	$(wildcard $(foreach suffix,$(SRCSUFFIXES),$(addsuffix /$(suffix),$(SKETCHLIBSRCDIRS))))

# remove difficult or undesirable libraries from build: 
NODESKTOP		:= I2C/I2C.cpp DataFlash/DataFlash_APM1.cpp FastSerial/FastSerial.cpp AP_Compass/AP_Compass_HMC5843.cpp AP_Baro/AP_Baro_BMP085.cpp
FILTEREDSRCS		:=	$(filter-out $(addprefix $(SKETCHBOOK)/libraries/,$(NODESKTOP)),$(SKETCHLIBSRCS))

# this defines a list of all the possible .o fils we'll be building
SKETCHLIBOBJS		:=	$(addsuffix .o,$(basename $(subst $(SKETCHBOOK),$(BUILDROOT),$(FILTEREDSRCS))))

# add the basic libraries to the include path, leave out Desktop and utility stuff. 
SKETCHLIBINCLUDES	:=	$(addprefix -I,$(SKETCHLIBS))

# Library object files
LIBOBJS			:=	$(SKETCHLIBOBJS)

# The ELF file
SKETCHELF		=	$(BUILDROOT)/$(SKETCH).elf

# Map file
SKETCHMAP		=	$(BUILDROOT)/$(SKETCH).map


CORELIB			=

# Sketch object files
SKETCHOBJS		:=	$(subst $(SRCROOT),$(BUILDROOT),$(SKETCHSRCS)) $(SKETCHCPP)
SKETCHOBJS		:=	$(addsuffix .o,$(basename $(SKETCHOBJS)))


# list of all .obj file we might need to build, not matter where they are: 
ALLOBJS			=	$(SKETCHOBJS) $(LIBOBJS) $(CORELIBOBJS)

# All of the dependency files that may be generated  
ALLDEPS			=	$(ALLOBJS:%.o=%.d)


#Targets: 
# classic build target:
all:	$(SKETCHELF)

# nuttx primary build target:
build:	$(SKETCHELF)

clean:
	rm -fr $(BUILDROOT)
	
showsources:

	@echo "SKETCHBOOK=$(SKETCHBOOK)"
	@echo "SKETCHLIBS=$(SKETCHLIBS)"
	@echo "SKETCHLIBSRCDIRS=$(SKETCHLIBSRCDIRS)"
	@echo "SKETCHLIBSRCS=$(SKETCHLIBSRCS)"
	@echo "SKETCHLIBINCLUDES=$(SKETCHLIBINCLUDES)"
	@echo "SKETCHOBJS=$(SKETCHOBJS)"
	@echo "LIBOBJS=$(LIBOBJS)"
	@echo "CORELIB=$(CORELIB)"
	@echo "ARDUINOLIBSRCS=$(ARDUINOLIBSRCS)"

# common header for rules, prints what is being built
define RULEHDR
	echo %% $(subst $(BUILDROOT)/,,$@)
	mkdir -p $(dir $@)
endef

# Link the final object 
$(SKETCHELF):	$(SKETCHOBJS) $(LIBOBJS) $(CORELIB)
	$(RULEHDR)
	$(v)$(LD) $(LDFLAGS) -o $@ $^ $(LIBS)
	echo Built $@
	
#
# Build sketch objects
#
SKETCH_INCLUDES	=	$(SKETCHLIBINCLUDES) $(ARDUINOLIBINCLUDES) $(COREINCLUDES)

$(BUILDROOT)/%.o: $(BUILDROOT)/%.cpp
	$(RULEHDR)
	$(v)$(CXX) $(CXXFLAGS) -c -o $@ $< -I$(SRCROOT) $(SKETCH_INCLUDES)

$(BUILDROOT)/%.o: $(SRCROOT)/%.cpp
	$(RULEHDR)
	$(v)$(CXX) $(CXXFLAGS) -c -o $@ $< $(SKETCH_INCLUDES)

$(BUILDROOT)/%.o: $(SRCROOT)/%.c
	$(RULEHDR)
	$(v)$(CC) $(CFLAGS) -c -o $@ $< $(SKETCH_INCLUDES)

$(BUILDROOT)/%.o: $(SRCROOT)/%.S
	$(RULEHDR)
	$(v)$(AS) $(ASFLAGS) -c -o $@ $< $(SKETCH_INCLUDES)

#
# Build library objects from sources in the sketchbook
#
SLIB_INCLUDES	=	-I$(dir $<)/utility $(SKETCHLIBINCLUDES) $(ARDUINOLIBINCLUDES) $(COREINCLUDES)

$(BUILDROOT)/libraries/%.o: $(SKETCHBOOK)/libraries/%.cpp
	$(RULEHDR)
	$(v)$(CXX) $(CXXFLAGS) -c -o $@ $< $(SLIB_INCLUDES)

$(BUILDROOT)/libraries/%.o: $(SKETCHBOOK)/libraries/%.c
	$(RULEHDR)
	$(v)$(CC) $(CFLAGS) -c -o $@ $< $(SLIB_INCLUDES)

$(BUILDROOT)/libraries/%.o: $(SKETCHBOOK)/libraries/%.S
	$(RULEHDR)
	$(v)$(AS) $(ASFLAGS) -c -o $@ $< $(SLIB_INCLUDES)




INCLUDES := /Users/buzz/PX4/Firmware/apps/Corona/libraries/Desktop/include /Users/buzz/PX4/Firmware/nuttx/include  $(SKETCHLIBSRCDIRS)

include $(APPDIR)/mk/app.mk


#SKETCHBOOK := /Users/buzz/PX4/Firmware/apps/Corona/
#SKETCHLIBS		:=	$(wildcard $(addprefix $(SKETCHBOOK)/libraries/,$(LIBTOKENS)))
#SKETCHLIBSRCDIRS	:=	$(SKETCHLIBS) $(SKETCHBOOK)/libraries/Desktop/support $(addsuffix /utility,$(SKETCHLIBS))
#SKETCHLIBINCLUDES	:=	$(addprefix -I,$(SKETCHLIBSRCDIRS))
#SKETCH_INCLUDES	:=	$(SKETCHLIBINCLUDES)

TMPDIR			:=	/Users/buzz/PX4/Firmware/apps/Corona/tmp
BUILDROOT		:=	$(abspath $(TMPDIR)/$(SKETCH).build)

SKETCHLIBINCLUDES	:=	$(addprefix -I,$(SKETCHLIBSRCDIRS))
SKETCH_INCLUDES	=	$(SKETCHLIBINCLUDES)

OPTFLAGS := -Wall -Wextra -Wdouble-promotion -Wshadow -Wfloat-equal -Wframe-larger-than=1024 \
-Wpointer-arith -Wlogical-op -Wmissing-declarations -Wpacked -Wno-unused-parameter \
-Os -fno-strict-aliasing \
-fno-strength-reduce -fomit-frame-pointer -funsafe-math-optimizations -fno-builtin-printf \
-ffunction-sections -fdata-sections -g -mcpu=cortex-m4 -mthumb -march=armv7e-m \
-mfpu=fpv4-sp-d16 -mfloat-abi=hard 

CXXFLAGS := $(OPTFLAGS) -DSKETCH=\"$(SKETCH)\" -D__AVR_ATmega2560__ -Wshadow  -I/Users/buzz/PX4/Firmware/apps/Corona/libraries/Desktop/include $(SKETCH_INCLUDES)  -DDESKTOP_BUILD=1
ASFLAGS  := $(OPTFLAGS) -DSKETCH=\"$(SKETCH)\"