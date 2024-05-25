resource "yandex_compute_instance" "app_compose" {
  name = "app-compose"

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian_image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.main_subnet.id
    nat       = false
  }

  metadata = {
    ssh-keys = "debian:${file(var.public_key_path)}"
  }
}

resource "yandex_compute_instance" "prometheus" {
  name = "prometheus"

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian_image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.main_subnet.id
    nat       = false
  }

  metadata = {
    ssh-keys = "debian:${file(var.public_key_path)}"
  }
}

resource "yandex_compute_instance" "srv_runner" {
  name = "srv-runner"

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian_image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.main_subnet.id
    nat       = false
  }

  metadata = {
    ssh-keys = "debian:${file(var.public_key_path)}"
  }
}
