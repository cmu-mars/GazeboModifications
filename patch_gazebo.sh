#!/bin/bash

function unpack_deb {
  bn=$(basename $1)
  bn="${bn%.*}"
  rm -rf $bn
  mkdir $bn
  cd $bn
  ar x ../$1
  tar xf data.tar.xz
  rm data.tar.xz
  mkdir DEBIAN
  cd DEBIAN
  tar xf ../control.tar.gz
  rm md5sums
  cd ..
  rm control.tar.gz
  rm debian-binary
  cd ..
  echo "$bn"
} 

echo "Processing libgazebo"
echo "  Unpacking 'libgazebo7_7.0.0+dfsg-2_amd64.deb'..."
lgz=$(unpack_deb libgazebo7_7.0.0+dfsg-2_amd64.deb)
echo "  Copying libXXXX files..."
cd $lgz
cd usr/lib/x86_64-linux-gnu
for i in *.7.0.0*; do cp /usr/lib/x86_64-linux-gnu/$i .; done
touch PATCHED
cd ../../..
cd .. 
echo "  Repackaging..."
dpkg -b ${lgz} export/${lgz}.deb
echo "  Done."

echo "Processing gazebo"
echo "  Unpacking 'gazebo7_7.0.0+dfsg-2_amd64.deb'..."
gz=$(unpack_deb gazebo7_7.0.0+dfsg-2_amd64.deb)
echo "  Copying bin files"
cd $gz
cp /usr/bin/gazebo-7.0.0 usr/bin/
cp /usr/bin/gz-7.0.0 usr/bin/
cp /usr/bin/gzclient-7.0.0 usr/bin/
cp /usr/bin/gzprop usr/bin
cp /usr/bin/gzserver-7.0.0 usr/bin
touch usr/bin/PATCHED
cd ..
echo " Repackaging..."
dpkg -b ${gz} export/${gz}.deb
echo " Done"

echo "You may need to copy and repackage in apt repo ... dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz"


# function doMD5Sums {
 # echo "  Calculating MD5 hashes..."
 # rm -f md4sums
  # while IFS='' read -r line || [[ -n "$line" ]]; do
    # array=(${line})
    # md5=$(md5sum ${array[1]})
    # echo $md5 >> md5sums
  # done < $1
# }  
  
# echo "Processing gazebo7_7.0.0+dfsg-2_amd64.deb..."

# cd gazebo7
# ar x ../gazebo7_7.0.0+dfsg-2_amd64.deb
# mkdir data
# cd data
# tar xf ../data.tar.xz
# echo "Copying new files from system..."
# cp /usr/bin/gazebo-7.0.0 usr/bin/
# cp /usr/bin/gz-7.0.0 usr/bin/
# cp /usr/bin/gzclient-7.0.0 usr/bin/
# cp /usr/bin/gzprop usr/bin
# cp /usr/bin/gzserver-7.0.0 usr/bin

# cd ..
# mkdir control; cd control
# tar xf ../control.tar.gz
# cd ../data
# doMD5Sums  ../control/md5sums
# mv md5sums ../control

# echo "  Rearchiving... "
# rm ../data.tar.xz
# tar cJf ../data.tar.xz .
# cd ..
# rm -rf data

# echo "  Finishng up..."
# cd control
# rm ../control.tar.gz
# tar czf ../control.tar.gz .
# cd ..
# rm -rf control
# cd ..
# mv gazebo7_7.0.0+dfsg-2_amd64.deb gazebo7_7.0.0+dfsg-2_amd64.deb-old
# ar cr gazebo7_7.0.0+dfsg-2_amd64.deb gazebo7/*
# rm -rf gazebo7/*

# echo "Processing libgazebo7_7.0.0+dfsg-2_amd64.deb..."

# cd libgazebo7
# ar x ../libgazebo7_7+dfsg-2_amd64.deb
# mkdir data; cd data
# echo "Copying new files from system..."
# tar xf ../data.tar.xz
# cd usr/lib/x86_64-linux-gnu
# for i in *.7.0.0*; do cp /usr/lib/x86_64-linux-gnu/$i .; done
# cd ../../..
# mkdir control; cd control
# tar xf ../control.tar.gz
# cd ../data
# doMD5Sums  ../control/md5sums
# mv md5sums ../control
# echo "  Rearchiving... "

# rm ../data.tar.xz
# tar cJf ../data.tar.xz .
# cd ..
# rm -rf data
# echo "  Finishng up..."
# cd control
# rm ../control.tar.gz
# tar czf ../control.tar.gz .
# cd ..
# rm -rf control
# cd ..
# mv libgazebo7_7.0.0+dfsg-2_amd64.deb libgazebo7_7.0.0+dfsg-2_amd64.deb-old
# ar cr libgazebo7_7.0.0+dfsg-2_amd64.deb libgazebo7/*
# rm -rf libgazebo7/*

