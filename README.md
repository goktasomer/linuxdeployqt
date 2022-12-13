# linuxdeployqt for Qt 6

The **linuxdeployqt** tool, _adapted_ for **Qt 6**. A useful tool to easily build AppImages out of Qt projects. Contains a few minor fixes on top of the upstream project.

> Based on [the macdeployqt](https://github.com/qt/qtbase/tree/dev/src/tools/macdeployqt) project and adapted the [code here](https://github.com/probonopd/linuxdeployqt) (_thanks to [The Qt Company](https://qt.io) and [@probonopd](https://github.com/probonopd)_)

## Download

Download the latest prebuilt binary from [here](https://github.com/omergoktas/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage)

## How to use

The following command prints the basic usage information. Also detailed usage information can be found on the upstream project's GitHub [page](https://github.com/probonopd/linuxdeployqt). Be aware that there are undocumented features (i.e., [see](https://github.com/probonopd/linuxdeployqt/issues/340#issuecomment-452025959)).

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

### Example usage:

Don't forget to modify the code below according to your project's needs before executing.

```bash
# Set PATH variable to the location where the Qt is installed
export QT_PATH=/path/to/Qt/6.4.0/gcc_64
export PATH=$PATH:$QT_PATH/bin:$QT_PATH/lib

# Build and install your project
cmake -S yourproject/ -B build/
cmake --build build/ --parallel
cmake --install build/ --prefix install

# Deploy ALL dependencies (assuming the executable installed to install/bin/app in previous step)
./linuxdeployqt-continuous-x86_64.AppImage install/bin/app -bundle-everything
    
# Alternatively, you can choose to deploy only a minimal set of dependencies
./linuxdeployqt-continuous-x86_64.AppImage install/bin/app
```

## How to build

You can use the same method described in the previous step to also build this project. Alternatively you can take a look at the CI build script [here](https://github.com/omergoktas/linuxdeployqt/blob/master/.github/workflows/build.yaml). The same script can also be seen to understand how to build an AppImage.
