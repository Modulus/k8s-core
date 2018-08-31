To get the admin password

```
printf $(kubectl get secret --namespace build jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo
```