# Automated Interactions Between Infrastructure Management Processes

## Installing the FusionInventory Agent
```bash
ansible-playbook -i hosts playbook.yaml --tags fusioninventory
```

## Using the GLPI API
```bash
ansible-playbook -i dynamic-inventory.sh playbook.yaml --ask-become-pass --tags fusioninventory
```

## Monitoring with Nagios and Check Nagios
```bash
ansible-playbook -i dynamic-inventory.sh playbook.yaml --ask-become-pass --tags nagios
```

## SNMP and Check SNMP in Nagios
```bash
ansible-playbook -i dynamic-inventory.sh playbook.yaml --ask-become-pass --tags snmp
```

## Help

- Connecting to the machines

```bash
ssh pc1 -l root
ssh pc2 -l root
ssh pc3 -l root
```	

- Making bash scripts executable
    
```bash
chmod +x *.sh
```
