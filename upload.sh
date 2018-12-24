#!/bin/bash -e

source create-buckets.sh
source regions.sh

MD5SUM=$(md5 -q php71.zip)
S3KEY="php71/${MD5SUM}"

for region in "${PHP71_REGIONS[@]}"; do
  bucket_name="lambda-php-laravel-layer-${region}"

  echo "Uploading php71.zip to s3://${bucket_name}/${S3KEY}"

  aws --region $region s3 cp php71.zip "s3://${bucket_name}/${S3KEY}"
done
