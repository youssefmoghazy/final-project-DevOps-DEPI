#/bin/bash
#Start Minikube
echo "--------------------Starting Minikube--------------------".
minikube start
 
#Create Namespace
echo "--------------------Create Argocd Namespace--------------------"
kubectl create ns argocd || true
 
#Deploy Argocd
echo "--------------------Deploy Argocd--------------------"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
 
#Sleep 3 miniute
echo "--------------------Waiting 1m for the pods to start--------------------"
sleep 3m
 
#Change to Nodeport
echo "--------------------Change Argocd Service to NodePort--------------------"
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
 
#ArgoCD URL
echo "--------------------ArgoCD URL--------------------"
minikube service -n argocd argocd-server --url
 
#ArgoCD Pass
echo "--------------------ArgoCD UI Password--------------------"
echo "Username: admin"
echo "Password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)" 
 
