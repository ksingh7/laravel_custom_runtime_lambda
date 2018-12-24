# PHP Laravel AWS Lambda Serverless Application

```
git clone 
```
- Edit ``build.sh`` if you like to add a specific library to your Lambda Layer (optional)
- Edit ``regions.sh`` if you like to add multiple AWS regions to make your Lambda Layer available to
- Edit ``create-buckets.sh`` ``upload.sh`` ``publish.sh`` and ``unpublish.sh`` if you like to change the bucket name
- Edit ``php.ini`` if you like to enable PHP extentions of your choice (Make sure you have installed them using ``build.sh``)

### Seting up Laravel Project


### Create Lambda Customer Layer
- Execute ``make`` to generate ``php71.zip`` in ``pwd``. This is your Lambda Custom Layer file
- Execute ``create-buckets.sh`` to create bucket before uploading Lambda Layer to S3
- Execute ``upload.sh`` to upload Lambda Layer to S3
- Execute ``publish.sh`` to publish your custome Lambda Layer
- Optionally you can also make your Lambda Layer publicly available by editing necessary section from ``publish.sh``
- Once Lambda layer is published to AWS Lambda, login to Lambda console > Layers and grab the Layer ARN
- Edit ``template.yaml`` and update Lambda Layer ARN 


#### Creating PHP Laravel Serverless Application

```
aws s3 mb s3://lambda-php-laravel-layer-us-east-1 \
    --region us-east-1 \
    --profile ksingh-lambda-v2
```
```
sam package \
    --template-file template.yaml \
    --output-template-file output/serverless-laravel.yaml \
    --s3-bucket lambda-php-laravel-layer-us-east-1 \
    --profile ksingh-lambda-v2 
   
```

```
sam deploy \
    --template-file output/serverless-laravel.yaml \
    --stack-name serverless-laravel \
    --capabilities CAPABILITY_IAM \
    --profile ksingh-lambda-v2

```

#### Destroying PHP Laravel Serverless Application

```
aws cloudformation delete-stack \
  --stack-name serverless-laravel \ 
  --profile ksingh-lambda-v2 
```

```
aws s3 rb --force s3://lambda-php-laravel-layer-us-east-1 \
  --profile ksingh-lambda-v2
```