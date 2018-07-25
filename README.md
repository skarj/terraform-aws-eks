# Terraform EKS Cluser

This configuration includes the  following resources:

  * EKS Cluster: AWS managed Kubernetes cluster of master servers
  * AutoScaling Group containing 2 m4.large instances (by default) based on the latest EKS Amazon Linux 2 AMI: Operator managed Kuberneted
    worker nodes for running Kubernetes service deployments
  * Associated VPC, Internet Gateway, Security Groups, and Subnets: Operator managed networking resources for the EKS Cluster and worker
    node instances
  * Associated IAM Roles and Policies: Operator managed access resources for EKS and worker node instances

NOTE: This full configuration utilizes the [Terraform http provider](https://www.terraform.io/docs/providers/http/index.html) to call out to icanhazip.com to determine your local workstation external IP for easily configuring EC2 Security Group access to the Kubernetes master servers. Feel free to replace this as necessary.


### Requirements
  * AWS account
  * Terraform installed and configured to use AWS credentials
  * set of IAM credentials with suitable access to create AutoScaling, EC2, EKS, and IAM resources
  * kubectl must be at least version 1.10 to support exec authentication with usage of aws-iam-authenticator.


### Usage
  * check default variables in variables.tf: node instance type, required count of nodes, etc.
  * apply terraform configuration

        terraform init
        terraform apply

  * configure kubectl. Get config_map_aws_auth config from

        terraform output

  * save the file to the default kubectl folder, with your cluster name in the file name. For example, if your cluster name is devel, save the file to ~/.kube/config-devel.
  * check kubectl

        export KUBECONFIG=$KUBECONFIG:~/.kube/config-devel
        kubectl get svc


### Documentation
  * [Getting Started with AWS EKS](https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html)
  * [Getting Started with Amazon EKS](https://www.terraform.io/docs/providers/http/index.html)