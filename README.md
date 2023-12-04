# Interactions automatisées entre des processus de gestion d'infrastructure

## Installation de l'agent fusioninventory
```bash
ansible-playbook -i hosts playbook.yaml --tags fusioninventory
```

## Utilisation de l'API de GLPI
```bash
ansible-playbook -i dynamic-inventory.sh playbook.yaml --ask-become-pass --tags fusioninventory
```

## Supervision avec Nagios
```bash
ansible-playbook -i dynamic-inventory.sh playbook.yaml --ask-become-pass --tags nagios
```

## Aide

- Se connecter aux machines

```bash
ssh pc1 -l root
ssh pc2 -l root
ssh pc3 -l root
```	

- Faire un chmod +x sur les scripts bash
    
```bash
chmod +x *.sh
```