# Docker Image for AWS JavaScript S3 Explorer

Docker image for [AWS JavaScript S3 Explorer](https://github.com/awslabs/aws-js-s3-explorer/tree/v2-alpha) based on [RedHat ubi-minimal](https://developers.redhat.com/products/rhel/ubi/) with selected NGINX CIS Benchmarks.

> Note: `index.html` is modified to remove dependencies to 3rd-party resources (`.js`, `.css`) hosted externally. These resource are hosted locally instead. Web clients only need to access AWS S3 Endpoints.

## Quickstart

```sh
# Build
docker build . -t s3explorer

# Run
docker run --rm -it -p 8080:8080 s3explorer

# Go to http://localhost:8080
```

## Bucket CORS Configuration

> Note: The configuration below allow ALL (`*`) origin. Configure the allowed origin accordingly.

CORS for Writable S3 Bucket

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <CORSRule>
    <AllowedOrigin>*</AllowedOrigin>
    <AllowedMethod>HEAD</AllowedMethod>
    <AllowedMethod>GET</AllowedMethod>
    <AllowedMethod>POST</AllowedMethod>
    <AllowedMethod>PUT</AllowedMethod>
    <AllowedMethod>DELETE</AllowedMethod>
    <AllowedHeader>*</AllowedHeader>
    <MaxAgeSeconds>3000</MaxAgeSeconds>
    <ExposeHeader>ETag</ExposeHeader>
    <ExposeHeader>x-amz-meta-custom-header</ExposeHeader>
    <ExposeHeader>x-amz-server-side-encryption</ExposeHeader>
    <ExposeHeader>x-amz-request-id</ExposeHeader>
    <ExposeHeader>x-amz-id-2</ExposeHeader>
    <ExposeHeader>date</ExposeHeader>
  </CORSRule>
</CORSConfiguration>
```

CORS for Read-Only S3 Bucket

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <CORSRule>
    <AllowedOrigin>*</AllowedOrigin>
    <AllowedMethod>HEAD</AllowedMethod>
    <AllowedMethod>GET</AllowedMethod>
    <AllowedHeader>*</AllowedHeader>
    <MaxAgeSeconds>3000</MaxAgeSeconds>
    <ExposeHeader>ETag</ExposeHeader>
    <ExposeHeader>x-amz-meta-custom-header</ExposeHeader>
    <ExposeHeader>x-amz-server-side-encryption</ExposeHeader>
    <ExposeHeader>x-amz-request-id</ExposeHeader>
    <ExposeHeader>x-amz-id-2</ExposeHeader>
    <ExposeHeader>date</ExposeHeader>
  </CORSRule>
</CORSConfiguration>
```

## Reference

[AWS JavaScript S3 Explorer](https://github.com/awslabs/aws-js-s3-explorer/tree/v2-alpha)
