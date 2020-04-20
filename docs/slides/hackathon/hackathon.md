---
marp: true
title: 'Autopad: challenges & fixes'
paginate: false
_paginate: false
theme: uncover
---

<!-- backgroundColor: #F7F8F8 -->

![bg](assets/hackathon.jpg)
![](#fff)

## Autopod: Challenges & fixes

---

## Chalenges

---

## We need Amazon Polly!

However, almost all 3rd party clients won't have polly built in.

---

## Roll our own?

Use a code generator!

---

## AWS publish API json definition

[https://api.github.com/repos/aws/aws-sdk-js/zipball/master](https://api.github.com/repos/aws/aws-sdk-js/zipball/master)

We shall learn from it!

---


## I found this nice looking lib: aws_client in pub...

---

## But there's always brickwall waiting for you...

---

![bg contain](assets/polly_error.jpg)

```json
{
    ...,
    "OutputS3BucketName": {
      "type": "string",
      "pattern": "^[a-z0-9][\\.\\-a-z0-9]{1,61}[a-z0-9]$"
    },
    "OutputS3KeyPrefix": {
      "type": "string",
      "pattern": "^[0-9a-zA-Z\\/\\!\\-_\\.\\*\\'\\(\\)]{0,800}$"
    },
    ...
}
```

---

## The beauty of open source collaboration...

Fork it, fix it, and PR it!

---

![bg left contain](assets/polly_error.jpg)

The fix is straight forward: [Pull Request](https://github.com/agilord/aws_client/pull/149)

---

![bg left fit](assets/rest_json.jpg)

#### However it turned out `aws_client` is not yet finished for `rest-json`...

---
<!-- backgroundColor: #222831 -->
<!-- color: #fff -->

## Changing of plan...

---

#### Rust + GRPC + flutter

<div class="mermaid">
sequenceDiagram
    User->>Flutter: Play!
    activate Flutter
    Flutter->>User: Play if exists
    Flutter->>Rust: GRPC request
    activate Rust
    Rust->>AWS: JSON request
    AWS->>Rust: JSON response
    deactivate Rust
    Rust->>Flutter: GRPC response
    Flutter->>User: Store and Play!
    deactivate Flutter
</div>

---

<!-- mermaid.js -->
<script src="https://unpkg.com/mermaid@8.5.0/dist/mermaid.min.js"></script>
<script>mermaid.initialize({startOnLoad:true});</script>
