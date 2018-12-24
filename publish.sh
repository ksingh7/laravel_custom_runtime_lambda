#!/bin/bash -e

source regions.sh

MD5SUM=$(md5 -q php71.zip)
S3KEY="php71/${MD5SUM}"

for region in "${PHP71_REGIONS[@]}"; do
  bucket_name="lambda-php-laravel-layer-${region}"

  echo "Publishing Lambda Layer php71 in region ${region}..."
  # Must use --cli-input-json so AWS CLI doesn't attempt to fetch license URL
  version=$(aws --region $region lambda publish-layer-version --cli-input-json "{\"LayerName\": \"php71-laravel\",\"Description\": \"PHP 7.1 Laravel Lambda Runtime\",\"Content\": {\"S3Bucket\": \"${bucket_name}\",\"S3Key\": \"${S3KEY}\"},\"CompatibleRuntimes\": [\"provided\"],\"LicenseInfo\": \"http://www.php.net/license/3_01.txt\"}"  --output text --query Version)
  echo "Published Lambda Layer php71-laravel in region ${region} version ${version}"

## Enable this if you like to make your layer public

#  echo "Setting public permissions on Lambda Layer php71 version ${version} in region ${region}..."
#  aws --region $region lambda add-layer-version-permission --layer-name php71 --version-number $version --statement-id=public --action lambda:GetLayerVersion --principal '*' > /dev/null
#  echo "Public permissions set on Lambda Layer php71 version ${version} in region ${region}"

done
