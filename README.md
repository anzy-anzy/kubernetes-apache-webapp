🚀 Kubernetes Apache WebApp on AWS EKS
🧠 Introduction

This project demonstrates how to containerize and deploy a web application using Docker, Kubernetes, and Amazon EKS (Elastic Kubernetes Service).
The goal was to create a highly available, scalable, and cloud-native infrastructure to host an Apache web application, showcasing how DevOps practices streamline deployment using Infrastructure as Code (IaC) and container orchestration.

The process involves:

Containerizing the Apache application with Docker.

Pushing the image to Docker Hub for accessibility.

Provisioning an EKS cluster using eksctl.

Deploying the web application using Kubernetes manifests (Deployment and Service).

Exposing the application via an AWS LoadBalancer to make it accessible to the public.

```mermaid
graph TD
  Browser -->|HTTP| ELB[Elastic Load Balancer]
  ELB --> Pod1[Apache Pod 1]
  ELB --> Pod2[Apache Pod 2]
  subgraph EKS["Amazon EKS Cluster"]
    Pod1 -->|serves HTML| Index1[index.html]
    Pod2 -->|serves HTML| Index2[index.html]
  end
  subgraph DockerHub["Docker Hub"]
    Image[anslem2025/kubernetes-apache-webapp:latest] -->|pulled| Pod1
    Image -->|pulled| Pod2
  end
  EKS --> AWSInfra[VPC/Subnets/SecurityGroups]
```
🧰 Tools Used

AWS CLI – for AWS configuration and authentication

eksctl – to provision and manage the EKS cluster

kubectl – to deploy and manage Kubernetes resources

Docker Hub – to store and pull the application image

⚙️ Steps to Reproduce
## 1) Install and Configure AWS CLI
## 2) install eksctl
```bash
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz"
tar -xzf eksctl_$(uname -s)_amd64.tar.gz
sudo mv eksctl /usr/local/bin
eksctl version
```

## 3) Create an EKS Cluster
```bash
eksctl create cluster \
--name playground-cluster \
--region us-west-2 \
--nodes 3 \
--node-type t3.medium \
--managed
```
This creates:

An EKS control plane

3 worker nodes (EC2 instances)

Networking and IAM roles automatically

wait 5-10mins 

<img width="1920" height="923" alt="Screenshot (729)" src="https://github.com/user-attachments/assets/dd410458-385f-41e3-b8ab-10854cbc33c8" />

<img width="1920" height="934" alt="Screenshot (730)" src="https://github.com/user-attachments/assets/55797682-08a3-4bef-a42b-bc177878f022" />

<img width="1920" height="986" alt="Screenshot (731)" src="https://github.com/user-attachments/assets/cf050fee-f0ef-4e65-9c4b-ed759bece234" />

## 4) Connect kubectl to EKS

Once the cluster is ready, configure kubectl to communicate with it:

```bash
aws eks --region us-west-2 update-kubeconfig --name playground-cluster
```
- Test the connection:

```bash
kubectl get nodes
```

<img width="1920" height="905" alt="Screenshot (733)" src="https://github.com/user-attachments/assets/dd90c781-d344-4b50-aba8-51e9cacfaa76" />

## 5) Create Your Kubernetes Deployment File
<img width="1520" height="663" alt="Screenshot (735)" src="https://github.com/user-attachments/assets/1fa6e8f0-602d-4098-b665-28a254be067e" />

- Apply it
 ```bash
  kubectl apply -f deployment.yaml
 ```
- Verify
```bash
  kubectl get deployments
kubectl get pods
```
<img width="1920" height="915" alt="Screenshot (734)" src="https://github.com/user-attachments/assets/f4aa86b7-972e-49f7-98df-77bbd5f42142" />

## 6) Expose the Deployment with a LoadBalancer
- Create a service.yaml file:
<img width="1483" height="722" alt="Screenshot (736)" src="https://github.com/user-attachments/assets/e779a5ae-d759-4737-949e-c7d90b2ba935" />

 - Apply it
   ```bash
   kubectl apply -f service.yaml
   ```
 - Verif
   ```bash
   kubectl get services
   ```

<img width="1920" height="919" alt="Screenshot (739)" src="https://github.com/user-attachments/assets/2121a573-3ea8-4131-94ba-1a1d1fce1499" />

- You’ll see an EXTERNAL-IP or DNS  — copy that and open it in your browser:

 <img width="1920" height="901" alt="Screenshot (740)" src="https://github.com/user-attachments/assets/42b96387-e3eb-4ff9-80bf-95bd98c0d0ad" />

 ## Troubleshooting and Useful kubectl Commands
 
 ```bash
kubectl describe pod
```
<img width="1920" height="893" alt="Screenshot (741)" src="https://github.com/user-attachments/assets/6bc119d2-975f-4d75-884f-c30f25b33d6c" />

<img width="1920" height="881" alt="Screenshot (742)" src="https://github.com/user-attachments/assets/0821f1a1-f97c-42dc-9849-40914e5674fd" />

- kubectl describe service
  <img width="1920" height="899" alt="Screenshot (743)" src="https://github.com/user-attachments/assets/be4ee436-16c0-4660-823c-c0d7da070ded" />

  ##  Clean Up Resources
  ```bash
  eksctl delete cluster --name playground-cluster --region us-west-2
  ```
🧾 Conclusion

This project successfully demonstrates a complete containerized deployment workflow — from Docker image creation to Kubernetes orchestration on AWS.
By leveraging EKS, Docker, and Kubernetes, we achieved:

Automated deployment

High availability

Load-balanced access

Full cloud-native scalability

This end-to-end implementation reflects real-world DevOps practices, combining containerization, orchestration, and cloud infrastructure management.
