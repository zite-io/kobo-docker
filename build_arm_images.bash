#!/usr/bin/env bash
set -e

if [ ! -d ../phusion_baseimage-docker ]; then
    echo '`../phusion_baseimage-docker` not found; cloning from GitHub.'
    (
        cd ..
        git clone --single-branch https://github.com/kobotoolbox/phusion_baseimage-docker -b armhf
    )
fi

echo 'Checking out current `armhf` branch of `phusion_baseimage-docker`.'
(
    cd ../phusion_baseimage-docker
    git fetch
    git checkout origin/armhf
)

echo 'Building and tagging Docker image `kobotoolbox/phusion_armhf`.'
(
    cd ../phusion_baseimage-docker/image
    docker build -t kobotoolbox/phusion_armhf .
)


declare -a images_ordered=('base' 'base-kobos' 'base-mongo' 'mongo' 'base-nginx' 'nginx' 'base-rabbit' 'rabbit' 'postgres_base' 'postgres')
for image_name in "${images_ordered[@]}"; do
    (
        echo "Building and tagging image \`kobotoolbox/${image_name}\`."
        cd "base_images/${image_name}"
        docker build -t "kobotoolbox/${image_name}" .
    )
done


if [ ! -d ../kpi ]; then
    echo '`../kpi` not found; cloning from GitHub.'
    (
        cd ..
        git clone --single-branch https://github.com/kobotoolbox/kpi -b armhf
    )
fi

echo 'Checking out current `armhf` branch of `kpi`.'
(
    cd ../kpi
    git fetch
    git checkout origin/armhf
)

(
    cd ../kpi

    echo 'Building and tagging Docker image `kobotoolbox/koboform_base`.'
    docker build -t kobotoolbox/koboform_base -f Dockerfile.koboform_base .

    echo 'Building and tagging Docker image `kobotoolbox/kpi`.'
    docker build -t kobotoolbox/kpi .
)


if [ ! -d ../kobocat ]; then
    echo '`../kobocat` not found; cloning from GitHub.'
    (
        cd ..
        git clone --single-branch https://github.com/kobotoolbox/kobocat -b armhf
    )
fi

echo 'Checking out current `armhf` branch of `kobocat`.'
(
    cd ../kobocat
    git fetch
    git checkout origin/armhf
)

(
    cd ../kobocat
    
    echo 'Building and tagging Docker image `kobotoolbox/kobocat_base`.'
    docker build -t kobotoolbox/kobocat_base -f Dockerfile.kobocat_base .

    echo 'Building and tagging Docker image `kobotoolbox/kobocat`.'
    docker build -t kobotoolbox/kobocat .
)


if [ ! -d ../enketo-express ]; then
    echo 'Directory `../enketo-express` not found; cloning from GitHub.'
    (
        cd ..
        git clone --single-branch https://github.com/kobotoolbox/enketo-express -b armhf
    )
fi

echo 'Checking out current `armhf` branch of `enketo-express`.'
(
    cd ../enketo-express
    git fetch
    git checkout origin/armhf
)

(
    cd ../enketo-express
    echo 'Building and tagging Docker image `kobotoolbox/enketo_express`.'
    docker build -t kobotoolbox/enketo_express .
)

