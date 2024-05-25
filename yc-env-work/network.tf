resource "yandex_vpc_network" "vpc_network" {
  name = "main-vpc"
}

resource "yandex_vpc_subnet" "main_vpc_subnet" {
  name = "main-vpc-subnet"
  zone = var.zone
  network_id = yandex_vpc_network.vpc_network.id
  v4_cidr_blocks = ["10.10.10.0/24"]
}