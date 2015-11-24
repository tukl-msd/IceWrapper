TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

TARGET = 3D-ICE-SystemC-Client

systemc_home = $$(SYSTEMC_HOME)
isEmpty(systemc_home) {
    systemc_home = /opt/systemc
}
message(SystemC home is $${systemc_home})

systemc_target_arch = $$(SYSTEMC_TARGET_ARCH)
isEmpty(systemc_target_arch) {
    systemc_target_arch = linux64
}
message(SystemC target architecture is $${systemc_target_arch})

libthreed_ice_home = $$(LIBTHREED_ICE_HOME)
isEmpty(libthreed_ice_home) {
	libthreed_ice_home = /opt/3D-ICE/
}
message(LIBTHREED_ICE_HOME path is $${libthreed_ice_home})

libsuperlu_home = $$(LIBSUPERLU_HOME)
isEmpty(libsuperlu_home) {
	libsuperlu_home = /opt/SuperLU_4.3/
}
message(LIBSUPERLU_HOME path is $${libthreed_ice_home})

LIBS += -L$${libthreed_ice_home}/lib -lthreed-ice-2.2.5
LIBS += -L$${libsuperlu_home}/lib -lsuperlu_4.3
LIBS += -lblas
LIBS += -L$${systemc_home}/lib-$${systemc_target_arch} -lsystemc

INCLUDEPATH += $${libthreed_ice_home}/include
INCLUDEPATH += $${libsuperlu_home}/SRC
INCLUDEPATH += $${systemc_home}/include

SOURCES += IceWrapper.cpp
SOURCES += 3D-ICE-SystemC-Client.cpp

QMAKE_CXXFLAGS += -std=c++11

