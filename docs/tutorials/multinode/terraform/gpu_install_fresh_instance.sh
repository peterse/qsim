# This is scratch code that should prepare a fresh centos7 instance with
# gpu-enabled qsim

sudo yum install -y git

##############################################################
# Install GPU drivers on Compute Nodes for Centos 7-x
# This will NOT be configured for A100's.
##############################################################
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
echo 'export PATH=/usr/local/cuda-11.4/bin${PATH:+:${PATH}}' >> "$HOME"/.bashrc
export PATH=/usr/local/cuda-11.4/bin${PATH:+:${PATH}}

##############################################################
# Update gcc to handle c++17 standards and install qsim from source
# TODO: RHEL/Centos deprecated python3-dev??
##############################################################
sudo yum install -y centos-release-scl
sudo yum install -y devtoolset-7-gcc*
source /opt/rh/devtoolset-7/enable
sudo yum install -y python3 python3-devel.x86_64 python3-pip
sudo python3 -m pip install pybind11 cirq-core
git clone https://github.com/quantumlib/qsim
cd qsim
make pybind
echo 'export PYTHONPATH=$PYTHONPATH:"$PWD"' >> "$HOME"/.bashrc
