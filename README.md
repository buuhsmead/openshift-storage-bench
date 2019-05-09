# OpenShift Storage Benchmark container

## Description

This container is intended to use for benchmarking the storage layer in a OpenShift Container Platform.

## Template usage

Create a new project, for example:

    oc new-project bench
    
Remove all quotas and limits from the project if they exist.

Run the template with the openshift-storage-bench application name with a storage volume size of 2Gi allocated in the glusterfs-storage storageclass:

    oc process -f openshift-storage-bench-template.yaml \
      -p APP_NAME=openshift-storage-bench -p VOLUME_SIZE=10Gi \
      -p STORAGE_CLASS=glusterfs-storage | oc create -f -
      
## Container usage

Connect to the shell of the pod:

    oc rsh $(oc get pods -o name | grep openshift-storage-bench)

### dd server latency test (small ios) example

    dd if=/dev/zero of=/data/testfile bs=512 count=1000 oflag=dsync && \
    rm -f /data/testfile
    
### dd server throughput (write speed) example

    dd if=/dev/zero of=/data/testfile bs=1G count=1 oflag=dsync && \
    rm -f /data/testfile

### bonnie++ example (with 2G ram allocation and a 4G storage file)

    bonnie++ -d /data -s 4G -r 2048 -b -f -m glusterfs
    
### sysbench example (make sure the volume claim needs to be 150Gi)

    sysbench --test=fileio --file-total-size=150G prepare
    sysbench --test=fileio --file-total-size=150G --file-test-mode=rndrw \
      --init-rng=on --max-time=300 --max-requests=0 run
    sysbench --test=fileio --file-total-size=150G cleanup
    
### iozone example

    iozone -Ra -g 2G
