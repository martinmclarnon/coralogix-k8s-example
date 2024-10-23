# Demo e-commerce Platform

This project demonstrates a simple bookstore using Kotlin, Spring Boot, and JPA. 

## Table of Contents
- [Getting Started](#getting-started)
- [Requirements](#requirements)
- [API Overview](#api-overview)
- [Tiltfile Setup](#to-use-the-tiltfile)
- [Testing](#testing)
- [License](#license)

## Getting Started

At the current state of development the "team" have developed
- one Mongo database,
- a "Create-Order-Command" service that will produce a message onto a topic, "Create-Order" in a Kafka message queue,
- a "Command-Event-Action-Audit" service that will listen to the "Create-Order" topic and write these messages to a Mongo database.

### Requirements

- Java 17 or later
- Kotlin 1.9.25 or later
- Spring Boot 3.3.4
- Maven Central for dependency management

### Installing Dependencies

The required dependencies are listed in the `build.gradle.kts` files and include some of the following key libraries:

- Spring Boot Starter Data JPA
- Spring Boot Starter Web
- Jackson Module Kotlin
- Cucumber for BDD testing
- JUnit for unit testing
- Mockito for mocking in tests

You can build individual projects and install dependencies with:

```bash
./gradlew build
```

### API Overview

```bash
POST /v1/x1wwg6t2hdc5ukvejdf5
```

This API endpoint accepts a request payload.

Request:

```json
{
  "bookId": "{{$randomUUID}}",
  "userId": "{{$randomUUID}}",
  "quantity" : "{{$randomInt}}",
  "orderDate" : "{{$randomDatePast}}"
}
```

This payload will be added to a Kafka queue and the create-order-audit application will write to a collection in a MongoDB

### Tiltfile Setup

To run local Kubernetes cluster in Docker:
```bash
$ brew install kind
```

To define your dev environment as code:
```bash
$ brew install tilt
```
#### Local CICD

Run the following commands:
```bash
$ kind create cluster --name coralogix-k8s-example
```

At the root of the Tiltfile. The argument --stream will output logs
```bash
$ tilt up --stream
```
To view Tilt dashboard, navigate to;
```bash
http://localhost:10350
```

### Testing

The projects are configured for behaviour-driven development (BDD) using Cucumber and unit testing with JUnit. Mocking is handled by Mockito.

#### Running Unit Tests
To run the unit tests, use the following command:

```bash
$ ./gradlew test
```

#### Running BDD Tests
To execute the Cucumber tests, use:

```bash
$ ./gradlew execute-bdd-tests
```
This will run all feature files located in src/test/resources/features.

Tilt will manage the tests being run via the Dockerfiles.

### License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.