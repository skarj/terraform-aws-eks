# Terraform EKS Cluster

This configuration includes the following resources:

  * EKS Cluster: AWS managed Kubernetes cluster of master servers
  * AutoScaling Group containing 2 m4.large instances (by default) based on the latest EKS Amazon Linux 2 AMI: Operator managed Kubernetes
    worker nodes for running Kubernetes service deployments
  * Associated VPC, Internet Gateway, Security Groups, and Subnets: Operator managed networking resources for the EKS Cluster and worker
    node instances
  * Associated IAM Roles and Policies: Operator managed access resources for EKS and worker node instances

NOTE: This full configuration utilizes the [Terraform http provider](https://www.terraform.io/docs/providers/http/index.html) to call out to icanhazip.com to determine your local workstation external IP for easily configuring EC2 Security Group access to the Kubernetes master servers. Feel free to replace this as necessary.


## Requirements
  * AWS account
  * Terraform installed and configured to use AWS credentials
  * set of IAM credentials with suitable access to create AutoScaling, EC2, EKS, and IAM resources
  * [aws-iam-authenticator](https://github.com/kubernetes-sigs/aws-iam-authenticator) installed and available in PATH
  * kubectl must be at least version 1.10 to support exec authentication with usage of aws-iam-authenticator


## Usage
  * check default variables in variables.tf: node instance type, required count of nodes, etc
  * apply terraform configuration

        terraform init
        terraform apply

  * configure kubectl. Get kubeconfig config from terraform output

        terraform output kubeconfig > ~/.kube/config-devel

  * check kubectl

        export KUBECONFIG=$KUBECONFIG:~/.kube/config-devel
        kubectl get svc

  * join worker nodes. Get IAM role authentication configmap from terraform output

        terraform output config_map_aws_auth > config-map-aws-auth.yaml

  * apply aconfigmap and check worker nodes

        kubectl apply -f config-map-aws-auth.yaml
        kubectl get nodes --watch


## Variables

  * cluster-name - name of EKS cluster. Default: "terraform-eks"
  * nodes-instance-type - type of EKS node instances. Default: "m4.large"
  * nodes-count - count of EKS nodes


## Outputs

  * config_map_aws_auth - AWS authenticator configuration map
  * kubeconfig -  configuration map for kubectl to connect to a new cluster


## Uninstall

  * terraform destroy


## Documentation
  * [Getting Started with AWS EKS](https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html)
  * [Getting Started with Amazon EKS](https://www.terraform.io/docs/providers/http/index.html)
  * [Configure kubectl for Amazon EKS](https://docs.aws.amazon.com/eks/latest/userguide/configure-kubectl.html)
  * [Golang installation](https://github.com/golang/go/wiki/Ubuntu)
