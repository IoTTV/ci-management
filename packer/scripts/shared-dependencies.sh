#! /bin/bash -ex

mkdir -p /extlibs/

# Boost
# First dependency downloaded because it takes the longest. Hopefully
# this will change once sources are moved off of Sourceforge. Github's
# zipfile is not the same. The zip file is kept because the build system
# checks for it.
mkdir -p /extlibs/boost
cd /extlibs/boost
wget -nv https://storage.googleapis.com/iotivity/boost/boost_1_58_0.zip && unzip boost_1_58_0.zip

# Compile & Install Boost
cd /extlibs/boost/boost_1_58_0
./bootstrap.sh --with-libraries=system,filesystem,date_time,thread,regex,log,iostreams,program_options,atomic
./b2 -j4 install && ldconfig

# expat
mkdir -p /extlibs/expat
cd /extlibs/expat
wget -nv https://launchpad.net/ubuntu/+archive/primary/+files/expat_2.1.0.orig.tar.gz \
&& tar zxf expat_2.1.0.orig.tar.gz \
&& rm expat_2.1.0.orig.tar.gz

# gtest
mkdir -p /extlibs/gtest
cd /extlibs/gtest
wget -nv https://googletest.googlecode.com/files/gtest-1.7.0.zip \
&& unzip gtest-1.7.0.zip \
&& rm gtest-1.7.0.zip

# tinydtls
mkdir -p /extlibs/tinydtls
cd /extlibs/tinydtls
wget -nv 'http://downloads.sourceforge.net/project/tinydtls/r4/tinydtls-0.8.1.tar.gz' \
&& tar zxf tinydtls-0.8.1.tar.gz \
&& rm tinydtls-0.8.1.tar.gz

# sqlite
mkdir -p /extlibs/sqlite3/
cd /extlibs/sqlite3/
[ ! -f sqlite3.c ] && wget -nv 'http://www.sqlite.org/2015/sqlite-amalgamation-3081101.zip' \
&& unzip sqlite-amalgamation-3081101.zip \
&& mv sqlite-amalgamation-3081101/sqlite3.c . \
&& mv sqlite-amalgamation-3081101/sqlite3.h . \
&& rm -r sqlite-amalgamation-3081101 \
&& rm sqlite-amalgamation-3081101.zip

cd /extlibs/

# libyaml
git clone https://github.com/jbeder/yaml-cpp.git /extlibs/yaml

# raxmpp
git clone https://gerrit.iotivity.org/gerrit/iotivity-xmpp /extlibs/raxmpp

# hippomocks
git clone https://github.com/dascandy/hippomocks /extlibs/hippomocks \
&& cd /extlibs/hippomocks \
&& git checkout -qf 2f40aa11e31499432283b67f9d3449a3cd7b9c4d

# tinycbor
git clone https://github.com/01org/tinycbor /extlibs/tinycbor \
&& cd /extlibs/tinycbor \
&& git checkout -b v0.2 v0.2