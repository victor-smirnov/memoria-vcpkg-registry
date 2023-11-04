# Memoria Framwork's supporting libraries vcpkg registry

This is the vcpkg registry provides dependencied used by Memoria Framework's building process. Currently it packages Seastar framework and Memoria but later it may provide other packages as will.

Specific version Seastar that this registry is referencing has some build issues is Vcpkg-provided Boost libraries. Seastar is using Boost testing API that Vcpkg's version of Boost Testing does not provide. So Seastar Testing library is not working if with-boost feature is specified.

Some of libraries that are needed for Seastar are not available in the Vcpkg, co currently they have to be provided separatelty. Please refer to the [Dockerfile](https://github.com/victor-smirnov/memoria-vcpkg-registry/blob/main/Dockerfile) for the references how to configure Ubuntu 22.04 for building Seastar.


