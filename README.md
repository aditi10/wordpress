In this document we are creating Wordpress Stack

Prerequisites
1. Configure aws credentials in ~/.aws/credentials
2. Route 53 public and private hosted zones to be present. We will be using zone_id in script
3. Create s3 bucket where terraform stores its state file
4. EC2 key pair should be present Eg: mytest.pem

The following components are created using terraforn script:
There are four main modules
1. VPC
	--> Public Subnet: Where wordpress will created
	--> Private subnet: Where RDS will be placed
	--> RouteTable, Nat Gateway, Internet Gateway and route entries
        --> Security Groups
2. Wordpress Instance
3. AutoScaling Group
4. Elastic load balancer

git clone https://github.com/aditi10/wordpress.git

Update values in wp.tpl script which spawns wordpress application
Provide dbname, dbpass, dbuser, mysql_host
The format of mysql_host=mysql-private.<private-dns-hosted-zone>

In env.tf : Provide bucket details which was created prior to store terraform state file
In deploy.tf : This is config file where we can configure various parameters according to needs. 

Required to change following parameters:
Provide keyname which is pem file present in your AWS account
Eg: Pemfile mytest.pem
keyname="mytest"
Eg :zone_id_private=Z32IWVH5QCFBQY and zone_id_public=Z32IWVH5QCFBQ
zone_id_private and zone_id_public as created in your AWS account.

Remaining parameters could be same.

cd terraform/environment/demo/

terraform init
terraform plan
terraform apply

Connect to wordpress 
http://<Ip>/wordpress
OR
http://<wordpress-000-d.<public-hosted-zone-name>>/wordpress


