from conan import ConanFile

class AppTemplateQt(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = "cmake_find_package"

    def requirements(self):
        self.requires("qt/6.4.1")

    def configure(self):
        self.options['qt'].shared = True
