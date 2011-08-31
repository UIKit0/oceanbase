#!/bin/bash
#for taobao abs
export temppath=$1
temppath=$1
cd $temppath/rpm
if [ `cat /etc/redhat-release|cut -d " " -f 7|cut -d "." -f 1` = 4 ]
then
sed -i  "s/^Release:.*$/Release: "$4".el4/" $2.spec
else
sed -i  "s/^Release:.*$/Release: "$4".el5/" $2.spec
fi
sed -i  "s/^Version:.*$/Version: "$3"/" $2.spec
cd $temppath
chmod +x build.sh
./build.sh init
export TBLIB_ROOT=/opt/csr/common
./configure  --with-test-case=no --with-release=yes --with-tblib-root=/opt/csr/common
make PREFIX=/home/admin/oceanbase rpms
mv *.rpm rpm/