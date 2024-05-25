Настройка pfsense после деплоя - https://yandex.cloud/en-ru/marketplace/products/opennix/pfsense

- VPC (main-vpc)
  - Subnet 10.10.10.0/24 - pfSense (NAT)
  - Subnet 10.10.20.0/24 - app_compose, prometheus, srv_runner