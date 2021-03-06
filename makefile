## An alternative way to build jabber - using R5 BeOS make system  
## NOTE: you need OpenSSL lib (http://bebits.com/app/4317) installed 
## in maximal configuration.
## 
## Build rules
##		make depend      # create .dependencies file 
##		make [default]   # build jabber4haiku binaries
##		make resources   # copy resources used by jabber binary into build dir
##
## Do not forget to run "make depend" before working with makefile build!!! 


## Application Specific Settings ---------------------------------------------

# specify the name of the binary
NAME=Jabber

# specify the type of binary
#	APP:	Application
#	SHARED:	Shared library or add-on
#	STATIC:	Static library archive
#	DRIVER: Kernel Driver
TYPE=APP

#	add support for new Pe and Eddie features
#	to fill in generic makefile

#%{
# @src->@ 

#	specify the source files to use
#	full paths or paths relative to the makefile can be included
# 	all files, regardless of directory, will have their object
#	files created in the common object directory.
#	Note that this means this makefile will not work correctly
#	if two source files with the same name (source.c or source.cpp)
#	are included from different directories.  Also note that spaces
#	in folder names do not work well with this makefile.
SRCS=jabber/Agent.cpp\
	 jabber/CommandMessage.cpp\
	 jabber/UserID.cpp\
	 jabber/AboutWindow.cpp\
	 jabber/BetterTextView.cpp\
	 jabber/BuddyInfoWindow.cpp\
	 jabber/ChangeNameWindow.cpp\
	 jabber/ChatTextView.cpp\
	 jabber/CustomStatusWindow.cpp\
	 jabber/LoginPreferencesView.cpp\
	 jabber/EditingFilter.cpp\
	 jabber/MessagesPreferencesView.cpp\
	 jabber/ModalAlertFactory.cpp\
	 jabber/PeopleListItem.cpp\
	 jabber/PreferencesWindow.cpp\
	 jabber/RosterItem.cpp\
	 jabber/RosterSuperitem.cpp\
	 jabber/RosterView.cpp\
	 jabber/RotateChatFilter.cpp\
	 jabber/SendTalkWindow.cpp\
	 jabber/SoundPreferencesView.cpp\
	 jabber/TalkListItem.cpp\
	 jabber/TalkManager.cpp\
	 jabber/TalkWindow.cpp\
	 jabber/TransportItem.cpp\
	 jabber/TransportPreferencesView.cpp\
	 jabber/BlabberApp.cpp\
	 jabber/main.cpp\
	 jabber/AgentList.cpp\
	 jabber/BlabberMainWindow.cpp\
	 jabber/BlabberSettings.cpp\
	 jabber/BuddyWindow.cpp\
	 jabber/JabberSpeak.cpp\
	 jabber/JRoster.cpp\
	 jabber/SoundSystem.cpp\
	 jabber/GenericFunctions.cpp\
	 jabber/BitmapButton.cpp\
	 jabber/FileItem.cpp\
	 jabber/StatusView.cpp\
	 jabber/PictureView.cpp\
	 jabber/MessageRepeater.cpp\
	 jabber/KeepAlive.cpp\
	 jabber/PortTalker.cpp\
	 jabber/JabberSSLPlug.cpp\
	 jabber/JabberSocketPlug.cpp\
	 jabber/FileXMLReader.cpp\
	 jabber/AppLocation.cpp\
	 shared/split-pane/SplitPane.cpp\
	 jabber/XMLEntity.cpp\
	 jabber/XMLReader.cpp

OP_SYSTEM=$(shell uname)

#	specify the resource files to use
#	full path or a relative path to the resource file can be used.
ifeq "$(OP_SYSTEM)" "Haiku"
RDEFS= jabber/Resource.rdef
else
RSRCS= jabber/Resource.rsrc
endif

# @<-src@ 
#%}

#	end support for Pe and Eddie

#	specify additional libraries to link against
#	there are two acceptable forms of library specifications
#	-	if your library follows the naming pattern of:
#		libXXX.so or libXXX.a you can simply specify XXX
#		library: libbe.so entry: be
#		
#	- 	if your library does not follow the standard library
#		naming scheme you need to specify the path to the library
#		and it's name
#		library: my_lib.a entry: my_lib.a or path/my_lib.a
LIBS=be game root translation tracker ssl crypto expat network $(STDCPPLIBS)

#	specify additional paths to directories following the standard
#	libXXX.so or libXXX.a naming scheme.  You can specify full paths
#	or paths relative to the makefile.  The paths included may not
#	be recursive, so include all of the paths where libraries can
#	be found.  Directories where source files are found are
#	automatically included.
LIBPATHS=/boot/home/config/lib /boot/common/lib

#	additional paths to look for system headers
#	thes use the form: #include <header>
#	source file directories are NOT auto-included here
SYSTEM_INCLUDE_PATHS =/boot/home/config/include

#	additional paths to look for local headers
#	thes use the form: #include "header"
#	source file directories are automatically included
LOCAL_INCLUDE_PATHS = shared/split-pane

#	specify the level of optimization that you desire
#	NONE, SOME, FULL
OPTIMIZE= 

#	specify any preprocessor symbols to be defined.  The symbols will not
#	have their values set automatically; you must supply the value (if any)
#	to use.  For example, setting DEFINES to "DEBUG=1" will cause the
#	compiler option "-DDEBUG=1" to be used.  Setting DEFINES to "DEBUG"
#	would pass "-DDEBUG" on the compiler's command line.
DEFINES= BONE DEBUG

#	specify special warning levels
#	if unspecified default warnings will be used
#	NONE = supress all warnings
#	ALL = enable all warnings
WARNINGS = 

#	specify whether image symbols will be created
#	so that stack crawls in the debugger are meaningful
#	if TRUE symbols will be created
SYMBOLS = 

#	specify debug settings
#	if TRUE will allow application to be run from a source-level
#	debugger.  Note that this will disable all optimzation.
DEBUGGER = 

#	specify additional compiler flags for all files
COMPILER_FLAGS =

#	specify additional linker flags
LINKER_FLAGS =

#	specify the version of this particular item
#	(for example, -app 3 4 0 d 0 -short 340 -long "340 "`echo -n -e '\302\251'`"1999 GNU GPL") 
#	This may also be specified in a resource.
APP_VERSION = 

#	(for TYPE == DRIVER only) Specify desired location of driver in the /dev
#	hierarchy. Used by the driverinstall rule. E.g., DRIVER_PATH = video/usb will
#	instruct the driverinstall rule to place a symlink to your driver's binary in
#	~/add-ons/kernel/drivers/dev/video/usb, so that your driver will appear at
#	/dev/video/usb when loaded. Default is "misc".
DRIVER_PATH = 

## include the makefile-engine
include $(BUILDHOME)/etc/makefile-engine

# package version
VERSION=1.2.1-gcc$(GCC_MAJOR_VERSION)

dist:
	mkdir dist

# For the zip files we need to create a file with the comment line
dist/comment:
	mkdir dist/comment

ZIP_COMMENT = comment/$(VERSION)

dist/$(ZIP_COMMENT): dist/comment
	echo "////////////////////////////////////////////////////" > dist/$(ZIP_COMMENT)
	echo "// Jabber $(VERSION) for Haiku OS" >> dist/$(ZIP_COMMENT)
	echo "// To INSTALL this package, please expand it to /boot" >> dist/$(ZIP_COMMENT)
	echo "////////////////////////////////////////////////////" >> dist/$(ZIP_COMMENT)

package: clean dist dist/$(ZIP_COMMENT)
	-rm -rf dist/boot/
	make
	-mkdir -p dist/boot/common/data/licenses
	-mkdir -p dist/boot/apps/Jabber
	-mkdir -p dist/boot/home/config/be/Applications
	cp -r resources dist/boot/apps/Jabber
	rm -rf `find dist/boot/ -type d -name .svn`
	cp $(TARGET) dist/boot/apps/Jabber
	-cp resources/license.txt "dist/boot/common/data/licenses/Other(Jabber)"
	ln -s /boot/apps/Jabber/Jabber dist/boot/home/config/be/Applications
	echo "Package: Jabber" > dist/boot/.OptionalPackageDescription
	echo "Version: $(VERSION)" >> dist/boot/.OptionalPackageDescription
	echo "Description: XMPP Instant Messaging Client for Haiku OS." >> dist/boot/.OptionalPackageDescription
	echo "License: Other(Jabber)" >> dist/boot/.OptionalPackageDescription
	echo "URL: http://dev.osdrawer.net/projects/show/jabber4beos" >> dist/boot/.OptionalPackageDescription
	cd dist/boot && zip -9  -r -y -z ../Jabber-$(VERSION)-`date +%F`.zip * .OptionalPackageDescription* < ../$(ZIP_COMMENT)

