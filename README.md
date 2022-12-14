# linuxdeployqt for Qt 6

This tool simplifies the deployment of dependencies for Linux applications and enables you to build [AppImages](https://appimage.org) for your app.

> Provides bug fixes and improvements on top of [qt/macdeployqt](https://github.com/qt/qtbase/tree/dev/src/tools/macdeployqt) and [probonopd/linuxdeployqt](https://github.com/probonopd/linuxdeployqt).

## Download
You can download the latest pre-built binary from [**here**](https://github.com/omergoktas/linuxdeployqt/releases/download/latest/linuxdeployqt-x86_64.AppImage), or you can build your own from the source code using the instructions below:

```bash
# CMAKE_PREFIX_PATH should point to your Qt installation
git clone https://github.com/omergoktas/linuxdeployqt
cmake -S linuxdeployqt -B build -DCMAKE_PREFIX_PATH=/path/to/qt/6.5.0/gcc_64
cmake --build build --parallel
```

## Usage

A few examples demonstrating different use cases:

```bash
# Either put location of your Qt installation into PATH variable, i.e.:
#     export QT_PATH=/path/to/qt/6.5.0/gcc_64
#     export PATH=$PATH:$QT_PATH/bin:$QT_PATH/lib
# Or use the -qmake option as shown below:

export QMAKE=/path/to/qt/6.5.0/gcc_64/bin/qmake

# 1. Deploy Qt dependencies only (minimal)
./linuxdeployqt-x86_64.AppImage /path/to/your/app -qmake=$QMAKE

# 2. Deploy everything except essential system libraries (that come with all Linux distributions out of the box).
./linuxdeployqt-x86_64.AppImage /path/to/your/app -qmake=$QMAKE -bundle-non-qt-libs

# 3. Deploy everything except essential system libraries and build an AppImage.
./linuxdeployqt-x86_64.AppImage /path/to/your/app -qmake=$QMAKE -appimage

# 4. Deploy everything (including essential system libraries)
./linuxdeployqt-x86_64.AppImage /path/to/your/app -qmake=$QMAKE -bundle-everything
```

## Advanced usage

```
Usage: linuxdeployqt <app-binary|desktop file> [options]

Options:
   -always-overwrite        : Copy files even if the target file exists.
   -appimage                : Create an AppImage (implies -bundle-non-qt-libs).
   -bundle-non-qt-libs      : Also bundle non-core, non-Qt libraries.
   -bundle-everything       : Bundle everything including system libraries.
   -exclude-libs=<list>     : List of libraries which should be excluded,
                              separated by comma.
   -ignore-glob=<glob>      : Glob pattern relative to appdir to ignore when
                              searching for libraries.
   -executable=<path>       : Let the given executable use the deployed libraries
                              too
   -extra-plugins=<list>    : List of extra plugins which should be deployed,
                              separated by comma.
   -no-copy-copyright-files : Skip deployment of copyright files.
   -no-plugins              : Skip plugin deployment.
   -no-strip                : Don't run 'strip' on the binaries.
   -no-translations         : Skip deployment of translations.
   -qmake=<path>            : The qmake executable to use.
   -qmldir=<path>           : Scan for QML imports in the given path.
   -qmlimport=<path>        : Add the given path to QML module search locations.
   -show-exclude-libs       : Print exclude libraries list.
   -verbose=<0-3>           : 0 = no output, 1 = error/warning (default),
                              2 = normal, 3 = debug.
   -updateinformation=<update string>        : Embed update information STRING; if zsyncmake is installed, generate zsync file
   -version                 : Print version statement and exit.

linuxdeployqt takes an application as input and makes it
self-contained by copying in the Qt libraries and plugins that
the application uses.

By default it deploys the Qt instance that qmake on the $PATH points to.
The '-qmake' option can be used to point to the qmake executable
to be used instead.

Plugins related to a Qt library are copied in with the library.
```
