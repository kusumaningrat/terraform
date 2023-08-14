terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "example" {
  name = "example-node"
  build {
    context = "."
    tag = [ "v1" ]
  }
}

resource "docker_container" "example-node" {
  image = docker_image.example.name
  name  = "example-node"
  
  ports {
    internal = 5000
    external = 8085
  }
}