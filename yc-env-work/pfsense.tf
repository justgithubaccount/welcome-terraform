data "yandex_compute_image" "pfsense_image" {
  family = "opennix-pfsense"
}

resource "yandex_compute_instance" "pfsense_instance" {
  name = "pfsense"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.pfsense_image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.main_vpc_subnet.id
    nat       = true  # public
  }

  metadata = {
    ssh-keys = "freebsd:${file(var.public_key_path)}"
  }
}

resource "yandex_vpc_route_table" "pfsense_route_table" {
  depends_on = [yandex_compute_instance.pfsense_instance]

  name       = "pfsense-route-table"
  network_id = yandex_vpc_network.vpc_network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.pfsense_instance.network_interface.0.ip_address
  }
}

resource "yandex_vpc_subnet" "main_subnet" {
  name = "main-subnet"
  zone = var.zone
  network_id = yandex_vpc_network.vpc_network.id
  v4_cidr_blocks = ["10.10.20.0/24"]
  route_table_id = yandex_vpc_route_table.pfsense_route_table.id
}
