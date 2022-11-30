# **Detalles de la Arquitectura**

## _Diagrama_ 


## _Datos de la infraestructura_
---
La infraestructura se despliega gracias a una solucion de terraform la en la cual se definen los siguientes recusos:

* 1 VPC:
El vpc que contendra las instancias y en el que se englovan todos los recursos. Le le aplica el CIDR 172.16.0.0 por variable.

```terraform 
resource "aws_vpc" "vpc1" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc1"
  }
}
```
* 2 Subnets:
Se configuran dos subnets hacia el VPC para las dos instancias que luego se depliegaran. Tienen CIDR 172.16.1.0 y 172.16.2.0
```terraform
resource "aws_subnet" "subnet_privada1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.private_subnet
  availability_zone       = var.vpc_aws_az
  map_public_ip_on_launch = "true"
  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet_privada2" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.private_subnet-2
  availability_zone       = var.vpc_aws_az-2
  map_public_ip_on_launch = "true"
  tags = {
    Name = "subnet2"
  }
}
```
* 1 Default Gateway
```terraform
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "gw1"
  }
}
```




## _Servicios AWS usados_

## _GIF de desmostración_
