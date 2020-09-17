TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += \
        main.cc

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../ClientTCP/release/ -lClientTCP
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../ClientTCP/debug/ -lClientTCP
else:unix: LIBS += -L$$OUT_PWD/../ClientTCP/ -lClientTCP

INCLUDEPATH += $$PWD/../ClientTCP
DEPENDPATH += $$PWD/../ClientTCP

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../ClientTCP/release/libClientTCP.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../ClientTCP/debug/libClientTCP.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../ClientTCP/release/ClientTCP.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../ClientTCP/debug/ClientTCP.lib
else:unix: PRE_TARGETDEPS += $$OUT_PWD/../ClientTCP/libClientTCP.a
