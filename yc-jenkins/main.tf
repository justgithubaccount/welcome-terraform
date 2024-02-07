terraform {
  required_providers {
    yandex = {
      # https://developer.hashicorp.com/terraform/language/providers/requirements#source-addresses
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  # https://cloud.yandex.ru/docs/overview/concepts/geo-scope
  zone = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-jenkins" {
  name = "jenkins"

  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd89nebr9a651021u19i"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    # https://cloud.yandex.ru/docs/compute/concepts/vm-metadata
    user-data = "${file("meta.txt")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-jenkins.network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-jenkins.network_interface.0.nat_ip_address
}