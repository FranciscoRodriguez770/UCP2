ansible-playbook -i hosts 01-configuracion-inicial.yaml
ansible-playbook -i hosts 02-instalar-nfs-server.yaml
ansible-playbook -i hosts 03-instalar-kubernetes.yaml
ansible-playbook -i hosts 04-config-k8smaster.yaml
ansible-playbook -i hosts 05-config-k8sworkers.yaml
ansible-playbook -i hosts 06-deploy-app.yaml

