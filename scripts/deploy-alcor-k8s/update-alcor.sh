#!/bin/bash

if [ ! -d /root/alcor ]; then
        git clone https://github.com/futurewei-cloud/alcor.git /root/alcor
else
        cd /root/alcor
        git stash
        git fetch
        git checkout master
        git pull
        #git reset --hard 28cfda5157c0f5e3bfaa4330c6b536217230b5d2
fi

echo "***** Delete Work Folder *****"
rm -rf /root/work

sed -i 's/<java.version>11<\/java.version>/<java.version>8<\/java.version>/g' /root/alcor/lib/pom.xml
sed -i 's/<source>11<\/source>/<source>8<\/source>/g' /root/alcor/lib/pom.xml
sed -i 's/<target>11<\/target>/<target>8<\/target>/g' /root/alcor/lib/pom.xml
sed -i 's/getFastPath() == null ? false/getFastPath() == null ? true/g' /root/alcor/services/data_plane_manager/src/main/java/com/futurewei/alcor/dataplane/service/impl/DpmServiceImpl.java
sed -i 's/return new UnicastGoalState() ? return null/g' /root/alcor/services/data_plane_manager/src/main/java/com/futurewei/alcor/dataplane/client/grpc/DataPlaneClientImpl.java
sed -i 's/#logging.level.root=INFO/logging.level.root=DEBUG/g' /root/alcor/kubernetes/services/dpm_manager.yaml
sed -i 's/#logging.level.root=DEBUG/logging.level.root=DEBUG/g' /root/alcor/kubernetes/services/dpm_manager.yaml
sed -i 's/#logging.level.root=INFO/logging.level.root=DEBUG/g' /root/alcor/services/data_plane_manager/src/main/resources/application.properties
sed -i 's/portEntity.setStatus(StatusEnum.SUCCESS.getStatus())/portEntity.setStatus(com.futurewei.alcor.common.enumClass.NetworkStatusEnum.ACTIVE.getNetworkStatus())/g' /root/alcor/services/port_manager/src/main/java/com/futurewei/alcor/portmanager/service/PortServiceImpl.java
echo "***** Build Alcor Images *****"
/root/alcor/scripts/build.sh