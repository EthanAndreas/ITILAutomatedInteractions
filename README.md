# Deploiement

```bash
ansible-playbook -i hosts playbook.yaml
```

# Parser et créer l'inventaire ansible

```bash
ansible -i inventory.sh -m ping all
```

# Parser et créer les fichiers de configuration de nagios

```bash
sudo ./nagios.sh
```
