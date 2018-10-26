DISTRO := kinetic

TOOLCHAIN_CONFIG_SRC := toolchains/toolchain-$(TARGET).cmake
TOOLCHAIN_CONFIG := $(ROS_HOME)/rostoolchain.cmake
INSTALL_FILE := $(ROS_HOME)/$(DISTRO)-ros_comm.rosinstall

CMAKE_FLAGS := -DCMAKE_BUILD_TYPE=Release
CMAKE_FLAGS += -DCMAKE_TOOLCHAIN_FILE=$(TOOLCHAIN_CONFIG)
CMAKE_FLAGS += -DCMAKE_FIND_ROOT_PATH=/\;$(CROSS_PREFIX)/

#CMAKE_FLAGS += -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
#CMAKE_ARGS := --cmake-args --debug-output --trace-expand

help: $(ROS_WORKSPACE)
	$(ROS_WORKSPACE)/src/catkin/bin/catkin_make_isolated --help

build: $(ROS_WORKSPACE) $(TOOLCHAIN_CONFIG)
	$(ROS_WORKSPACE)/src/catkin/bin/catkin_make_isolated --install -C $(ROS_WORKSPACE) $(CMAKE_FLAGS) $(CMAKE_ARGS)

$(TOOLCHAIN_CONFIG): $(TOOLCHAIN_CONFIG_SRC)
	cp $(TOOLCHAIN_CONFIG_SRC) $(TOOLCHAIN_CONFIG)

$(ROS_HOME)/rosdep:
	mkdir -p $(ROS_HOME)
	rosdep update

$(INSTALL_FILE): $(ROS_HOME)/rosdep
	rosinstall_generator ros_comm --rosdistro $(DISTRO) --deps --tar > $(INSTALL_FILE)

$(ROS_WORKSPACE): $(INSTALL_FILE)
	mkdir -p $(ROS_WORKSPACE)
	wstool init -j8 $(ROS_WORKSPACE)/src $(INSTALL_FILE)
