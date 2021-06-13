#!/bin/bash

set -eo pipefail

dir=${BACKUP_DIRECTORY}
s3_bucket=${S3_BUCKET}
s3_access_key=${S3_ACCESS_KEY}
s3_secret_key=${S3_SECRET_KEY}
override_hostname=${OVERRIDE_HOSTNAME}

function write_log {
        echo "`date +'%Y%m%d %H%M%S'`: $1"
}

if [ -z "$dir" ] || [ -z "$s3_bucket" ] || [ -z "$s3_access_key" ] || [ -z "$s3_secret_key" ]; then
        write_log "One or more parameter empty"
        exit 1
fi

if [ ! -d "$dir" ]; then
        write_log "Directory $dir does not exists"
	exit 1
fi

if [ -n "$override_hostname" ]; then
	hostname=$override_hostname
else
	hostname=$(hostname)
fi

date=$(date +'%Y%m%d')
timestamp=$(date +'%Y%m%d_%H%M%S')
object="s3://${s3_bucket}/${hostname}/${date}/${timestamp}/"
write_log "Uploading directory $dir"
s3cmd --access_key=$s3_access_key --secret_key=$s3_secret_key -m binary/octet-stream sync ${dir}/ $object
