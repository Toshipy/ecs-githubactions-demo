aws cloudformation create-stack --stack-name ecs-stack --template-body file://root-stack.yml
aws cloudformation create-stack --stack-name ecs-stack --template-body file://cf-vpc_ver1.yml

aws cloudformation update-stack --stack-name ecs-stack --template-body file://cf-vpc.yml

aws s3 cp child_stack_template s3://ecs-github-actions/ --recursive


npm install axios

#1
aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 851859251602.dkr.ecr.ap-northeast-1.amazonaws.com

#2
docker build -t ecs-web .

#3
docker tag ecs-web:latest 851859251602.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-web:latest
docker tag 851859251602.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-web:latest 851859251602.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-web:1.0.0

docker images |grep 851859251602

#4
docker push 851859251602.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-web:latest
docker push 851859251602.dkr.ecr.ap-northeast-1.amazonaws.com/ecs-web:1.0.0

https://hooks.slack.com/services/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
