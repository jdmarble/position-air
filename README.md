
```sh
ansible-playbook cluster-playbook.yml \
  --extra-vars='@vars/chickencoup.net.yaml.enc' --vault-id=vault-password \
  --inventory-file=inventory/chickencoup.net.yaml
```

```sh
ansible-playbook cluster-playbook.yml \
  --extra-vars='@vars/jdmarble.net.yaml.enc' --vault-id=vault-password \
  --inventory-file=inventory/jdmarble.net.yaml
```
