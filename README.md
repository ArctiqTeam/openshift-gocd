# openshift-gocd 
This small repo provides a Dockerfile  and some templates that can run gocd-server on OpenShift. 

Note: The elastic-kubernetes-agents requires higher privileges than we would normally give to a tenant on the platform, namely the node privileges. All other privileges can/should be provided scoped to the namespace(s), but node events would not be accessible to users.

Until the privilege is more multi-tenant friendly, users can keep an agent online at all times and configure autoscaling and auto registering agents. 

*Note: Sensitive information is stored in the configmap and is only for demonstration purposes. Please do not store production system sensitive configuration data in git.* 

# OAuth Integration with OpenShift
The following sidecar can be included with GoCD to provide some basic authentication to the instance. This does not integrate with GoCD, but does block users that don't have permission to the namespace from utilizing it. 

```
## OAuth Init Container
			- args:
        - --http-address=:8080
        - --https-address=
        - --openshift-service-account=gocd
        - --upstream=http://localhost:8153
        - --provider=openshift
        - --cookie-secret=SECRET                                         # This can/should be pulled from a file with a secure secret
        - --bypass-auth-except-for=/go                                   # This seemed to help get rid of redirect loops
        - --pass-basic-auth=false
        - '-openshift-sar={"namespace": "${NAMESPACE}", "verb": "list", "resource":
          "services"}'
        image: registry.access.redhat.com/openshift3/oauth-proxy:v3.11
        imagePullPolicy: IfNotPresent
        name: oauth-proxy
        ports:
        - containerPort: 8080
          name: oauth-proxy
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
```

# Troubleshooting OAuth

- The ambigious error: 
```
{"error":"invalid_request","error_description":"The request is missing a required parameter, includes an invalid parameter value, includes a parameter more than once, or is otherwise malformed.","state":"1ae8d970418f1d54643aa83911c60365:/"}
```

Digging through the docs, I was originally testing with an HTTP route, which is not supported by default as outlined [here](https://github.com/openshift/oauth-proxy/blob/master/README.md#configuring-the-proxys-service-account-in-openshift). Change the route to https (edge, in our case) and all should be good. 




# Resources
https://github.com/GaneshSPatil/openshift-elastic-agents/releases
https://blog.sakuragawa.moe/deploy-granafa-with-prometheus-and-oauth2-on-openshift/
