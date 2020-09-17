TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += \
        main.cc

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../ServerTCP/release/ -lServerTCP
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../ServerTCP/debug/ -lServerTCP
else:unix: LIBS += -L$$OUT_PWD/../ServerTCP/ -lServerTCP

INCLUDEPATH += $$PWD/../ServerTCP
DEPENDPATH += $$PWD/../ServerTCP

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../ServerTCP/release/libServerTCP.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../ServerTCP/debug/libServerTCP.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../ServerTCP/release/ServerTCP.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../ServerTCP/debug/ServerTCP.lib
else:unix: PRE_TARGETDEPS += $$OUT_PWD/../ServerTCP/libServerTCP.a

LIBS += -lpthread

ANDROID_ABIS = armeabi-v7a
