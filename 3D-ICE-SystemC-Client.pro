TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
CONFIG -= qt

TARGET = 3D-ICE-SystemC-Client

LIBS += -L/opt/3D-ICE/lib -lthreed-ice-2.2.5
LIBS += -L/opt/SuperLU_4.3/lib -lsuperlu_4.3
LIBS += -lblas
LIBS += -L/opt/systemc/lib-linux64 -lsystemc

INCLUDEPATH += /opt/3D-ICE/include
INCLUDEPATH += /opt/SuperLU_4.3/SRC
INCLUDEPATH += /opt/systemc/include

SOURCES += IceWrapper.cpp
SOURCES += 3D-ICE-SystemC-Client.cpp

QMAKE_CXXFLAGS += -std=c++11
