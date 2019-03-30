# hiredis-ccc

Redis cluster client based on hiredis-vip https://github.com/vipshop/hiredis-vip

Compile on windows with Visual Studio 2017

* Install vcpkg and required package https://github.com/Microsoft/vcpkg 

     vcpkg install libevent:x64-windows
    
* Open build_msvc/hiredisccc.sln for DLL, build_msvc/hiredisccc_static.sln for static library

Compile on Linux

* Clone code and make

    git clone https://github.com/soft-way/hiredis-ccc.git
    
    cd hiredis-ccc
    
    ./bootstrap.sh
    
    ./configure
    
    make
    
    make install
    
