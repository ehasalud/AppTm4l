#!/bin/bash

# Get the directory where this script is stored. It should be the AppTm4l directory
AppTm4ldir=$(readlink -f $(dirname $0))

# Ask for sudo password the first time
read -s -p "Enter your sudo password and press enter: " password

# Install all required programs
required="git ant subversion make cmake openjdk-7-jdk libjpeg8-dev build-essential libssl-dev g++ patch libsdl1.2-dev"
echo $password | sudo -S apt-get install -y $required

# Move to home directory and create a temp directory
AppTm4ltemp=$HOME/AppTm4l_sources
cd

if [ -d "$AppTm4ltemp" ]; then
	echo "Deleting old AppTm4l temp directory"
	rm -rf $AppTm4ltemp
fi

mkdir $AppTm4ltemp
cd $AppTm4ltemp

### Installation of libv4l ###
cd $AppTm4ltemp
printf "\n\n"
echo "Installing libv4l"

libv4ldir="libv4l"
git clone git://git.debian.org/git/collab-maint/libv4l.git $libv4ldir
cd $libv4ldir

./configure
make
echo $password | sudo -S make install


### Installation of v4l4j ###
cd $AppTm4ltemp
printf "\n\n"
echo "Installing v4l4j"

echo $password | sudo -S apt-get install -y libv4l-dev

svn co http://v4l4j.googlecode.com/svn/v4l4j/trunk v4l4j-trunk
cd v4l4j-trunk

# Build and install
# First, get the path to java and export it
javapath=$(readlink -f $(which java) | awk '{split($0,a,"jre"); print a[1]}')
export JDK_HOME=$javapath
ant clean all
echo $password | sudo -S ant install


### Installation of Ffmpeg ###
printf "\n\n"
echo "Installing Ffmpeg"
cd $AppTm4ltemp
ffmpegtemp=$AppTm4ltemp/ffmpeg_sources
mkdir $ffmpegtemp

# YASM
printf "\n"
echo "Installing YASM"
cd $ffmpegtemp
wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz
tar xzvf yasm-1.2.0.tar.gz
cd yasm-1.2.0
./configure
make
echo $password | sudo -S make install
make distclean
. ~/.profile

# x264
printf "\n"
echo "Installing x264"
cd $ffmpegtemp
git clone --depth 1 git://git.videolan.org/x264.git
cd x264
./configure --enable-static
make
echo $password | sudo -S make install
make distclean

# Ffmpeg
printf "\n"
echo "Installing Ffmpeg"
cd $ffmpegtemp
git clone --depth 1 git://source.ffmpeg.org/ffmpeg
cd ffmpeg
./configure --extra-libs="-ldl" --enable-gpl --enable-libx264 --enable-nonfree
make
echo $password | sudo -S make install
make distclean
hash -r
. ~/.profile


### Installation of crtmpserver ###
printf "\n\n"
echo "Installing crtmpserver"

cd $AppTm4ltemp
svn co --username anonymous --password "" https://svn.rtmpd.com/crtmpserver/trunk crtmpserver
cd crtmpserver

# If it is an arm platform, patch some files
machine=$(uname -m)
if [[ $machine == *arm* ]]; then
	# Path the files
	printf "\n"
	echo "It is an ARM platform. Patching the crmtpsever files"
	for i in $AppTm4ldir/crtmpserver-patch/*.patch; do
		patch -p1 < $i
	done
fi

# Bulid crmtpserver
cd builders/cmake
COMPILE_STATIC=1 cmake -DCMAKE_BUILD_TYPE=Release .
make

# Copy the executable to a directory in the path
printf "\n"
echo "Copying the executable file of crtmpserver"
echo $password | sudo -S cp crtmpserver/crtmpserver /usr/local/bin


### Installation of mutt/postfix ###
printf "\n\n"
echo "Installing mutt/postfix"

echo $password | sudo -S debconf-set-selections -v <<< "postfix postfix/main_mailer_type select Internet Site"
echo $password | sudo -S debconf-set-selections -v <<< "postfix postfix/mailname string `hostname`"

echo $password | sudo -S apt-get install -y mutt
