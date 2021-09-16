# HEADS UP: this is just scratch code; this script never executes and its
# contents must be relocated to the terraform startup script.

##############################################################
# Install GPU drivers on Compute Nodes for Centos 7-x
# This will NOT be configured for A100's.
##############################################################
SERVER_TYPE="compute"

if [ "$SERVER_TYPE" == "compute" ]; then
    sudo yum clean all
    sudo yum install -y kernel | grep -q 'already installed' || sudo reboot
    sudo yum install -y kernel-devel-$(uname -r) kernel-headers-$(uname -r)
    sudo yum install epel-release
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-rhel7.repo
    sudo yum clean all
    sudo yum -y install nvidia-driver-latest-dkms cuda
    sudo yum -y install cuda-drivers
    sudo yum install -y nvidia-cuda-toolkit
    echo 'export PATH=/usr/local/cuda-11.4/bin${PATH:+:${PATH}}' >> ~/.bashrc
fi

##############################################################
# Update gcc to handle c++17 standards and install qsim from source
# TODO: RHEL/Centos deprecated python3-dev??
##############################################################
if [ "$SERVER_TYPE" == "compute" ]; then
    sudo yum install -y centos-release-scl
    sudo yum install -y devtoolset-7-gcc*
    scl enable devtoolset-7 bash
    sudo yum install -y python3 python3-devel.x86_64 python3-pip
    sudo python3 -m pip install pybind11 cirq-core
    git clone https://github.com/quantumlib/qsim
    cd qsim
    make pybind
    echo 'export PYTHONPATH=$PYTHONPATH:"$PWD"' >> ~/.bashrc
fi

##############################################################
# Make sure necessary environment variables are initialized and restart
##############################################################
if [ "$SERVER_TYPE" == "compute" ]; then
    sudo reboot
fi
