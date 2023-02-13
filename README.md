# event-driven-ansible
Dockerfile for testing event driven ansible

# Start Container on K8S

```
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: ansible-eventdriven
  name: ansible-eventdriven
  namespace: webapps
spec:
  containers:
  - image: eu.gcr.io/********/ansible-eventdriven:latest
    name: ansible-eventdriven
    imagePullPolicy: Always
    ports:
    - containerPort: 8080
  dnsPolicy: ClusterFirst
  imagePullSecrets:
    - name: regcred-gcr
  restartPolicy: Always
```

# Sending Events
## Via Kafka

```
{
  "message": "hello from kafka"
}
```

## Via CURL

```
curl -H 'Content-Type: application/json' -d "{\"message\": \"hello from commandlinel\"}" http://127.0.0.1:8080/endpoint
```