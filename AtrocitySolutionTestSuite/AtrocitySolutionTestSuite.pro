include(gtest_dependency.pri)

TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG += thread
CONFIG -= qt

HEADERS +=

SOURCES += \
        ControlPortTCP_Test.cc \
        main.cc

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../ControlPortTCP/release/ -lControlPortTCP
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../ControlPortTCP/debug/ -lControlPortTCP
else:unix: LIBS += -L$$OUT_PWD/../ControlPortTCP/ -lControlPortTCP

INCLUDEPATH += $$PWD/../ControlPortTCP
DEPENDPATH += $$PWD/../ControlPortTCP

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../ControlPortTCP/release/libControlPortTCP.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../ControlPortTCP/debug/libControlPortTCP.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../ControlPortTCP/release/ControlPortTCP.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../ControlPortTCP/debug/ControlPortTCP.lib
else:unix: PRE_TARGETDEPS += $$OUT_PWD/../ControlPortTCP/libControlPortTCP.a
