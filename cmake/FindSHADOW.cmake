# - Check for the presence of SHADOW
#
# The following variables are set when SHADOW is found:
#  HAVE_SHADOW       = Set to true, if all components of SHADOW
#                          have been found.
#  SHADOW_INCLUDES   = Include path for the header files of SHADOW
#  SHADOW_LIBRARIES  = Link these to use SHADOW

## -----------------------------------------------------------------------------
## Check for the header files

find_path (SHADOW_INCLUDES shd-library.h
  PATHS /usr/local/include /usr/include ${CMAKE_EXTRA_INCLUDES}
  PATH_SUFFIXES shadow
  )

## -----------------------------------------------------------------------------
## Check for the library
set(FIND_SHADOW_PATHS "/usr/local/lib /usr/lib /lib ${CMAKE_EXTRA_LIBRARIES}")

find_library (SHADOW_FILETRANSFER_LIBRARIES NAMES libshadow-service-filetransfer.a shadow-service-filetransfer PATHS ${FIND_SHADOW_PATHS})
find_library (SHADOW_TORRENT_LIBRARIES NAMES libshadow-service-torrent.a shadow-service-torrent PATHS ${FIND_SHADOW_PATHS})
find_library (SHADOW_BROWSER_LIBRARIES NAMES libshadow-service-browser.a shadow-service-browser PATHS ${FIND_SHADOW_PATHS})

mark_as_advanced(${SHADOW_FILETRANSFER_LIBRARIES} ${SHADOW_TORRENT_LIBRARIES} ${SHADOW_BROWSER_LIBRARIES})
set(SHADOW_LIBRARIES ${SHADOW_FILETRANSFER_LIBRARIES} ${SHADOW_TORRENT_LIBRARIES} ${SHADOW_BROWSER_LIBRARIES})

## -----------------------------------------------------------------------------
## Actions taken when all components have been found

if (SHADOW_INCLUDES AND SHADOW_LIBRARIES)
  set (HAVE_SHADOW TRUE)
else (SHADOW_INCLUDES AND SHADOW_LIBRARIES)
  if (NOT SHADOW_FIND_QUIETLY)
    if (NOT SHADOW_INCLUDES)
      message (STATUS "Unable to find SHADOW header files!")
    endif (NOT SHADOW_INCLUDES)
    if (NOT SHADOW_LIBRARIES)
      message (STATUS "Unable to find SHADOW library files!")
    endif (NOT SHADOW_LIBRARIES)
  endif (NOT SHADOW_FIND_QUIETLY)
endif (SHADOW_INCLUDES AND SHADOW_LIBRARIES)

if (HAVE_SHADOW)
  if (NOT SHADOW_FIND_QUIETLY)
    message (STATUS "Found components for SHADOW")
    message (STATUS "SHADOW_INCLUDES = ${SHADOW_INCLUDES}")
    message (STATUS "SHADOW_LIBRARIES     = ${SHADOW_LIBRARIES}")
    message (STATUS "    SHADOW_FILETRANSFER_LIBRARIES = ${SHADOW_FILETRANSFER_LIBRARIES}")
    message (STATUS "    SHADOW_TORRENT_LIBRARIES      = ${SHADOW_TORRENT_LIBRARIES}")
    message (STATUS "    SHADOW_BROWSER_LIBRARIES      = ${SHADOW_BROWSER_LIBRARIES}")
  endif (NOT SHADOW_FIND_QUIETLY)
else (HAVE_SHADOW)
  if (SHADOW_FIND_REQUIRED)
    message (FATAL_ERROR "Could not find SHADOW!")
  endif (SHADOW_FIND_REQUIRED)
endif (HAVE_SHADOW)

mark_as_advanced (
  HAVE_SHADOW
  SHADOW_LIBRARIES
  SHADOW_INCLUDES
  )
