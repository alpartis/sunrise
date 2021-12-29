QT += quick

CONFIG += c++14

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp

RESOURCES += \
    qml.qrc \
    sunnygui.qrc

TRANSLATIONS += \
    i18n/strings_en_US.ts \
    i18n/strings_tr_TR.ts

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = .
QML_IMPORT_PATH += $$_PRO_FILE_PWD_/forms
QML_IMPORT_PATH += $$_PRO_FILE_PWD_/imports
QML_IMPORT_PATH += $$_PRO_FILE_PWD_/imports/sunnygui
QML_IMPORT_PATH += $$_PRO_FILE_PWD_/imports/ui_art_assets

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH += $$_PRO_FILE_PWD_/
QML_DESIGNER_IMPORT_PATH += $$_PRO_FILE_PWD_/forms
QML_DESIGNER_IMPORT_PATH += $$_PRO_FILE_PWD_/imports

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = bin
!isEmpty(target.path): INSTALLS += target
