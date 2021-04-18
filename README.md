## Run instructions

### Terraform
terraform apply
terraform output (to display the outputs)

sed s/%IP%/$(terraform output -raw JenkinsIp)/g ../Ansible/inventory_template > ../Ansible/inventory

### Ansible
ansible-playbook -i ../Ansible/inventory -u ubuntu -e privsub=$(terraform output -raw PrivSubId) -e privsub2=$(terraform output -raw PrivSub2Id) -e pubsub=$(terraform output -raw PubSubId) -e pubsub2=$(terraform output -raw PubSub2Id) -e rdsendpoint=$(terraform output -raw RDSEndpoint) -e jenkinsip=$(terraform output -raw JenkinsIp)  ../Ansible/playbook.yaml