#!/usr/bin/env bash

set -e

# default - vars
STAGE="stable"
[ -z "${BUILD}" ] && BUILD=""

version=20.08

# build gvmlibs
gvmlibs_version=$version
build_gvmlibs="${BUILD}"

# platforms=linux/amd64,linux/arm64,linux/ppc64le,linux/s390x,linux/386,linux/arm/v7,linux/arm/v6
platforms=linux/amd64,linux/arm64
# platforms=linux/amd64

echo "
################################################################################
################### Build gvmlibs ##############################################
################################################################################
Image: reineltdev/gvmlibs:${gvmlibs_version}${build_gvmlibs}"
docker buildx build -f ./Dockerfile-gvmlibs --build-arg STAGE=${STAGE} \
  -t "reineltdev/gvmlibs:${gvmlibs_version}${build_gvmlibs}" \
  -t "reineltdev/gvmlibs:latest" \
  --platform $platforms --push .

# build gsa
# gsa_version=$version
# build_gsa="${BUILD}"
echo "
################################################################################
################### Build gsa ##################################################
################################################################################
Image: reineltdev/gsa:${gsa_version}${build_gsa}"
docker buildx build -f ./Dockerfile-gsa --build-arg STAGE=${STAGE} \
  -t "reineltdev/gsa:latest" \
  -t "reineltdev/gsa:${gsa_version}${build_gsa}" \
  --platform $platforms --push .

#build openvas
openvas_version=$version
build_openvas="${BUILD}"
echo "
################################################################################
################### Build openvas ##############################################
################################################################################
Image: reineltdev/openvas:${openvas_version}${build_openvas}"
docker buildx build -f ./Dockerfile-openvas --build-arg STAGE=${STAGE} \
  -t "reineltdev/openvas:latest" \
  -t "reineltdev/openvas:${openvas_version}${build_openvas}" \
  --platform $platforms --push .

# build gvmd
gvmd_version=$version
build_gvmd="${BUILD}"
echo "
################################################################################
################### Build gvmd #################################################
################################################################################
Image: reineltdev/gvmd:${gvmd_version}${build_gvmd}"
docker buildx build -f ./Dockerfile-gvmd --build-arg STAGE=${STAGE} \
  -t "reineltdev/gvmd:${gvmd_version}${build_gvmd}" \
  -t "reineltdev/gvmd:latest" \
  --platform $platforms --push .

exit

postgres_gvm_version=$version
build_postgres_gvm="${BUILD}"
echo "
################################################################################
################### Build postgres-gvm #########################################
################################################################################
Image: reineltdev/postgres-gvm:${postgres_gvm_version}${build_postgres_gvm}"
docker buildx build -f ./Dockerfile-postgres-gvm --build-arg STAGE=${STAGE} \
  -t "reineltdev/postgres-gvm:latest" \
  -t "reineltdev/postgres-gvm:${postgres_gvm_version}${build_postgres_gvm}" \
  --platform $platforms --push .

# push
# if [ "${1}" == "push" ]; then
#   docker push "reineltdev/gvmlibs:${gvmlibs_version}${build_gvmlibs}"
#   docker push "reineltdev/gvmlibs:latest"

#   docker push "reineltdev/gsa:${gsa_version}${build_gsa}"
#   docker push "reineltdev/gsa:latest"

#   docker push "reineltdev/openvas:${openvas_version}${build_openvas}"
#   docker push "reineltdev/openvas:latest"

#   docker push "reineltdev/gvmd:${gvmd_version}${build_gvmd}"
#   docker push "reineltdev/gvmd:latest"

#   docker push "reineltdev/postgres-gvm:${postgres_gvm_version}${build_postgres_gvm}"
#   docker push "reineltdev/postgres-gvm:latest"
# fi
