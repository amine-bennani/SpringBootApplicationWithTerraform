import boto3

ec2 = boto3.client('ec2', region_name='us-east-1')

instances = ec2.describe_instances()

info = []

for reservation in instances['Reservations']:
    for instance in reservation['Instances']:
        private_ip = instance['PrivateIpAddress']
        name = [tag['Value'] for tag in instance['Tags'] if tag['Key'] == 'Name'][0]
        environment = [tag['Value'] for tag in instance['Tags'] if tag['Key'] == 'Environment'][0]
        info.append(f"{private_ip},{name},{environment}")

with open('info', 'w') as f:
    for item in info:
        f.write("%s\n" % item)
