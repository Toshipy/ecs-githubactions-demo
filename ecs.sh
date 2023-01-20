#vpc
vpc-0850946f45a2d2694

#Subnet
subnet-0d008d40ddd0f04b6
subnet-086dab7cb0e28bc01

#SG
sg-0280dbe0e19565788
sg-086b65d7e7af9fe94

#TG
ecs-tg: arn:aws:elasticloadbalancing:ap-northeast-1:851859251602:targetgroup/ecs-tg/fb2ef5bafa8dc013
8070: arn:aws:elasticloadbalancing:ap-northeast-1:851859251602:targetgroup/ecs-webapp-8070/69640b31f4acc465

#CloudMap
ecs-internal: ns-qvuw67fpyiygjuid


#Service Discovery
aws servicediscovery create-service \
  --name ecs-webapp \
  --dns-config 'NamespaceId="ns-qvuw67fpyiygjuid",DnsRecords=[{Type="A",TTL="60"}]' \
  --health-check-custom-config FailureThreshold=1
  --region ap-northeast-1

#response
  "Arn": "arn:aws:servicediscovery:ap-northeast-1:851859251602:service/srv-y3sfsrvzg2j4rsn6",


#ECS Service
aws ecs create-service \
  --cluster 0120-ecs \
  --service-name ecs-webapp \
  --task-definition ecs-task:2 \
  --load-balancers '[{"targetGroupArn": "arn:aws:elasticloadbalancing:ap-northeast-1:851859251602:targetgroup/ecs-tg/fb2ef5bafa8dc013", "containerName": "ecs-web-container",  "containerPort": 8080 },{ "targetGroupArn": "arn:aws:elasticloadbalancing:ap-northeast-1:851859251602:targetgroup/ecs-webapp-8070/69640b31f4acc465", "containerName": "ecs-backend", "containerPort":8070 }]' \
  --desired-count 2 \
  --platform-version LATEST \
  --launch-type FARGATE \
  --network-configuration '{"awsvpcConfiguration": {"subnets":["subnet-0d008d40ddd0f04b6","subnet-086dab7cb0e28bc01"],"securityGroups": ["sg-0280dbe0e19565788","sg-086b65d7e7af9fe94"],"assignPublicIp":"DISABLED"}}' \
  --service-registries '[{"registryArn":"arn:aws:servicediscovery:ap-northeast-1:851859251602:service/srv-y3sfsrvzg2j4rsn6"}]'

