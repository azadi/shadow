## the plug-ins need to include shd-library.h
include_directories(${CMAKE_SOURCE_DIR}/src/plugins)
install(FILES shd-library.h DESTINATION include/)
install(FILES ${CMAKE_SOURCE_DIR}/src/utility/shd-cdf.h DESTINATION include/)

## plug-ins need to disable fortification to ensure syscalls are intercepted
add_definitions(-D_GNU_SOURCE)
add_cflags("-fno-inline -fno-strict-aliasing -U_FORTIFY_SOURCE")

## now use LLVM to build each plug-in that was not disabled in setup.py
include(LLVMTools)
get_property(LLVMHoistGlobalsPATH TARGET LLVMHoistGlobals PROPERTY LOCATION)
message(STATUS "LLVMHoistGlobalsPATH = ${LLVMHoistGlobalsPATH}")

if(NOT BUILD_FILETRANSFER STREQUAL OFF)
    add_subdirectory(filetransfer)
endif(NOT BUILD_FILETRANSFER STREQUAL OFF)

if(NOT BUILD_TORCTL STREQUAL OFF)
    add_subdirectory(torctl)
endif(NOT BUILD_TORCTL STREQUAL OFF)

if(NOT BUILD_SCALLION STREQUAL OFF)
    add_subdirectory(scallion)
endif(NOT BUILD_SCALLION STREQUAL OFF)
