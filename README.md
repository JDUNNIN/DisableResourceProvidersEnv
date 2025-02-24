# Instructions

I have configured both environment variable `OTEL_JAVA_DISABLED_RESOURCE_PROVIDERS=io.opentelemetry.instrumentation.resources.ProcessResourceProvider` and jvm.option `-Dotel.java.disabled.resource.providers=io.opentelemetry.instrumentation.resources.ProcessResourceProvider`.

Please follow these steps to recreate the issue.

Run jaegertracing/all-in-one container using:
```
podman run -e COLLECTOR_OTLP_ENABLED=true -p 16686:16686 -p 4317:4317 jaegertracing/all-in-one:1.64.0
```

Get jaeger containerId using:
```
podman ps
```

Get jaeger container IP address using
```
podman inspect -f {{.NetworkSettings.IPAddress}} <containerId>
```

Update the file server.env to replace all of `<jaegerIp>` with the real container IP address.

Build the test container image using:
```
podman build -t test2402 .
```

Run the test container using:
```
podman run -it -p 9080:9080 test2402:latest
```


Send request to server using:
```
curl localhost:9080/api/docs
```

Look in jaeger UI at http://locahost:16686/search and find results for TestEnv service. See in `Process` section that `process.command_line` is still there.