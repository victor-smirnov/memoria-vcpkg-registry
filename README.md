# Memoria Framworks' supporting libraries vcpkg registry

This is the vcpkg registry for Memoria Framework. Currently it packages Seastar framework but later it may provide other packages as will.

Specific version Seastar that this registry is referencing has some build issues is Vcpkg-provided Boost libraries. Seastar using Boost testing API that Vcpkg's version of Boost Testing does not provide. So Seastar Testing library is not working.

Some of libraries that are needed for Seastar are not available in the Vcpkg, co currently they have to be provided separatelty. Please refer to the [Docrfile](https://github.com/victor-smirnov/memoria-vcpkg-registry/blob/main/Dockerfile) for the references how to configure Ubuntu 22.04 for building Seastar.


