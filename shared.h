#pragma once

#include <QDebug>
#include <QSet>
#include <QString>
#include <QStringList>

extern int logLevel;
#define LogError()   if (logLevel < 0) {} else qDebug() << "ERROR:"
#define LogWarning() if (logLevel < 1) {} else qDebug() << "WARNING:"
#define LogNormal()  if (logLevel < 2) {} else qDebug() << "INFO:"
#define LogDebug()   if (logLevel < 3) {} else qDebug() << "DEBUG:"

extern QString appBinaryPath;
extern bool runStripEnabled;
extern bool bundleAllButBlacklistedLibs;
extern bool bundleEverything;
extern bool fhsLikeMode;
extern QString fhsPrefix;
extern QStringList extraQtPlugins;
extern QStringList excludedLibraries;

class LibraryInfo
{
public:
    bool isDylib;
    QString libraryDirectory;
    QString libraryName;
    QString libraryPath;
    QString binaryDirectory;
    QString binaryName;
    QString binaryPath;
    QString rpathUsed;
    QString version;
    QString installName;
    QString deployedInstallName;
    QString sourceFilePath;
    QString libraryDestinationDirectory;
    QString binaryDestinationDirectory;
};

class DylibInfo
{
public:
    QString binaryPath;
};

class LddInfo
{
public:
    QString installName;
    QString binaryPath;
    QList<DylibInfo> dependencies;
};

bool operator==(const LibraryInfo& a, const LibraryInfo& b);
QDebug operator<<(QDebug debug, const LibraryInfo& info);

class AppDirInfo
{
public:
    QString path;
    QString binaryPath;
    QStringList libraryPaths;
};

class DeploymentInfo
{
public:
    QString qtPath;
    QString pluginPath;
    QStringList deployedLibraries;
    quint64 usedModulesMask;
    QSet<QString> rpathsUsed;
    bool useLoaderPath;
    bool isLibrary;
    bool requiresQtWidgetsLibrary;
};

inline QDebug operator<<(QDebug debug, const AppDirInfo& info);

void changeQtLibraries(const QString appPath, const QString& qtPath);
void changeQtLibraries(const QList<LibraryInfo> libraries,
                       const QStringList& binaryPaths,
                       const QString& qtPath);

LddInfo findDependencyInfo(const QString& binaryPath);
LibraryInfo parseLddLibraryLine(const QString& line,
                                const QString& appDirPath,
                                const QSet<QString>& rpaths);
QString findAppBinary(const QString& appDirPath);
QList<LibraryInfo> getQtLibraries(const QString& path,
                                  const QString& appDirPath,
                                  const QSet<QString>& rpaths);
QList<LibraryInfo> getQtLibraries(const QStringList& lddLines,
                                  const QString& appDirPath,
                                  const QSet<QString>& rpaths);
QString copyLibrary(const LibraryInfo& library, const QString path);
DeploymentInfo deployQtLibraries(const QString& appDirPath,
                                 const QStringList& additionalExecutables,
                                 const QString& qmake);
DeploymentInfo deployQtLibraries(QList<LibraryInfo> libraries,
                                 const QString& bundlePath,
                                 const QStringList& binaryPaths,
                                 bool useLoaderPath);
void createQtConf(const QString& appDirPath);
void createQtConfForQtWebEngineProcess(const QString& appDirPath);
void deployPlugins(const QString& appDirPath, DeploymentInfo deploymentInfo);
bool deployQmlImports(const QString& appDirPath,
                      DeploymentInfo deploymentInfo,
                      QStringList& qmlDirs,
                      QStringList& qmlImportPaths);
void changeIdentification(const QString& id, const QString& binaryPath);
void changeInstallName(const QString& oldName,
                       const QString& newName,
                       const QString& binaryPath);
void runStrip(const QString& binaryPath);
void stripAppBinary(const QString& bundlePath);
QString findAppBinary(const QString& appDirPath);
QStringList findAppLibraries(const QString& appDirPath);
bool patchQtCore(const QString& path, const QString& variable, const QString& value);
int createAppImage(const QString& appBundlePath);
bool checkAppImagePrerequisites(const QString& appBundlePath);
void findUsedModules(DeploymentInfo& info);
void deployTranslations(const QString& appDirPath, quint64 usedQtModules);
bool deployTranslations(const QString& sourcePath,
                        const QString& target,
                        quint64 usedQtModules);
