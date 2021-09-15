##############################################################
# Install GPU drivers on Compute Nodes for Centos 7-x
# This will NOT be configured for A100's.
##############################################################
SERVER_TYPE="compute"

if [ "$SERVER_TYPE" == "compute" ]; then
    yum clean all
    yum install -y kernel | grep -q 'already installed' || sudo reboot
    yum install -y kernel-devel-$(uname -r) kernel-headers-$(uname -r)
    yum install epel-release
    yum install -y yum-utilsyum-config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-rhel7.repo
    yum clean all
    yum -y install nvidia-driver-latest-dkms cuda
    yum -y install cuda-drivers
fi