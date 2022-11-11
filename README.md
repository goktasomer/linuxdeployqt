# linuxdeployqt for Qt 6

The **linuxdeployqt** tool, _adapted_ for **Qt 6**. A useful tool to easily build AppImages out of Qt projects. Contains a few minor fixes on top of the upstream project.

> Based on [the macdeployqt](https://github.com/qt/qtbase/tree/dev/src/tools/macdeployqt) project and adapted the [code here](https://github.com/probonopd/linuxdeployqt) (_thanks to [The Qt Company](https://qt.io) and [@probonopd](https://github.com/probonopd)_)

## Download

Download the latest prebuilt binary from [here](https://github.com/omergoktas/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage)

## How to use

The following command prints the basic usage information. Also detailed usage information can be found on the upstream project's GitHub [page](https://github.com/probonopd/linuxdeployqt). Be aware that there are undocumented features (i.e., [see](https://github.com/probonopd/linuxdeployqt/issues/340#issuecomment-452025959)).

```bash
    ./linuxdeployqt-continuous-x86_64.AppImage -unsupported-bundle-everything -unsupported-allow-new-glibc
```

## Example usage:

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
    ./linuxdeployqt-continuous-x86_64.AppImage install/bin/app -unsupported-bundle-everything
    
    # Alternatively, you can choose to deploy only a minimal set of dependencies
    ./linuxdeployqt-continuous-x86_64.AppImage install/bin/app -unsupported-allow-new-glibc
```

## How to build

You can use the same method described in the previous step to also build this project. Alternatively you can take a look at the CI build script [here](https://github.com/omergoktas/linuxdeployqt/blob/master/.github/workflows/build.yaml). The same script can also be seen to understand how to build an AppImage.
