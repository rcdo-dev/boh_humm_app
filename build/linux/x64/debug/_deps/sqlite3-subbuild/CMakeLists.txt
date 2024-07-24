# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.16.3)

# We name the project and the target for the ExternalProject_Add() call
# to something that will highlight to the user what we are working on if
# something goes wrong and an error message is produced.

project(sqlite3-populate NONE)

include(ExternalProject)
ExternalProject_Add(sqlite3-populate
                     "UPDATE_DISCONNECTED" "False" "URL" "https://sqlite.org/2024/sqlite-autoconf-3460000.tar.gz"
                    SOURCE_DIR          "/home/rcdo/rcdo_workspace/projects/boh_humm_app/build/linux/x64/debug/_deps/sqlite3-src"
                    BINARY_DIR          "/home/rcdo/rcdo_workspace/projects/boh_humm_app/build/linux/x64/debug/_deps/sqlite3-build"
                    CONFIGURE_COMMAND   ""
                    BUILD_COMMAND       ""
                    INSTALL_COMMAND     ""
                    TEST_COMMAND        ""
                    USES_TERMINAL_DOWNLOAD  YES
                    USES_TERMINAL_UPDATE    YES
)
