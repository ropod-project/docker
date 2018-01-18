#!/bin/bash

# Default values
SUDO="sudo"
INSTALL_DIR="/usr/local/"
J="-j1"

# Handle command line options
while :; do
  case $1 in
    --no-sudo)       
      SUDO=""
      ;;
    --install-path)       # Takes an option argument, ensuring it has been specified.
      if [ -n "$2" ]; then
           INSTALL_DIR=$2
          shift
       else
           printf 'ERROR: "--install-path" requires a non-empty option argument.\n' >&2
           exit 1
       fi
       ;;
    --install-path=?*)
       INSTALL_DIR=${1#*=} # Delete everything up to "=" and assign the remainder.
       ;;
    --install-path=)         # Handle the case of an empty --file=
      printf 'ERROR: "--install-path" requires a non-empty option argument.\n' >&2
      exit 1
      ;;

    -j)       # Takes an option argument, ensuring it has been specified.
      if [ -n "$2" ]; then
           J="-j${2}"
          shift
       else
           printf 'ERROR: "-j" requires a non-empty option argument.\n' >&2
           exit 1
       fi
       ;;
    -j=?*)
       J_TMP=${1#*=} # Delete everything up to "=" and assign the remainder.
       J="-j${J_TMP}"
       ;;
    -j=)         # Handle the case of an empty --file=
      printf 'ERROR: "-j" requires a non-empty option argument.\n' >&2
      exit 1
      ;;


    --)              # End of all options.
       shift
       break
       ;;
    -?*)
       printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
        ;;
    *)               # Default case: If no more options then break out of the loop.
        break
  esac

shift
done

################ Communication modules #########################
echo ""
echo "### ZMQ communication modules  ###"

echo "CZMQ dependencies:"
if [ ! -d libsodium ]; then
  git clone https://github.com/jedisct1/libsodium.git
fi
cd libsodium
./autogen.sh
./configure 
make ${J}
${SUDO} make install
${SUDO} ldconfig
cd ..

echo "ZMQ library:"
# Wee need a stable verison of libzmq du to incompatibilities with Zyre. 
# Unfortunately there are no tags github so we have to use a tar ball.
#git clone https://github.com/zeromq/libzmq.git
#cd libzmq
if [ ! -d zeromq-4.1.2 ]; then
  wget http://download.zeromq.org/zeromq-4.1.2.tar.gz
  tar -xvf zeromq-4.1.2.tar.gz
fi 
cd zeromq-4.1.2
./autogen.sh
./configure --with-libsodium=no --prefix=${INSTALL_DIR}
make ${J}
${SUDO} make install
${SUDO} ldconfig
cd ..

echo "CZMQ library:"
#git clone https://github.com/zeromq/czmq
#cd czmq
if [ ! -d czmq-3.0.2 ]; then
  wget https://github.com/zeromq/czmq/archive/v3.0.2.tar.gz
  tar zxvf v3.0.2.tar.gz
fi
cd czmq-3.0.2/
./autogen.sh
./configure --prefix=${INSTALL_DIR}
make ${J}
${SUDO} make install
${SUDO} ldconfig
cd ..

echo "Zyre library:"
if [ ! -d zyre-1.1.0 ]; then
  wget https://github.com/zeromq/zyre/archive/v1.1.0.tar.gz
  tar zxvf v1.1.0.tar.gz
fi
cd zyre-1.1.0/
sh ./autogen.sh
./configure --prefix=${INSTALL_DIR}
make ${J}
${SUDO} make install
${SUDO} ldconfig
cd ..

