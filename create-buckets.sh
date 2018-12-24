#!/bin/bash -e

source regions.sh

for region in "${PHP71_REGIONS[@]}"; do
  bucket_name="lambda-php-laravel-layer-${region}"

  echo "Creating bucket ${bucket_name}..."

  aws s3 mb s3://$bucket_name --region $region
done
