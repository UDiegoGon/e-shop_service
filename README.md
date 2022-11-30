# **Detalles de la Arquitectura**

## _Diagrama_ 
![Infraestructura Cloud drawio](https://user-images.githubusercontent.com/69463751/204718183-b4d507ed-0c38-4d2d-b509-9554703a94ea.png)


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
* 1 Default Route Table
```terraform
resource "aws_default_route_table" "defaultR" {
  default_route_table_id = aws_vpc.vpc1.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "defaultR"
  }
}
```
* 1 Cluster EKS
```terraform
resource "aws_eks_cluster" "Cluster_Obligatorio" {
 name = "Cluster_Obligatorio"
 role_arn = data.aws_iam_role.mi-role.arn

 vpc_config {
  subnet_ids = [aws_subnet.subnet_privada1.id, aws_subnet.subnet_privada2.id]
 }
}
```
* 1 Grupo de nodos
En este grupo se van a desplegar instancias de EC2 tipo t3.large para poder al
```terraform
resource "aws_eks_node_group" "GrupoNodos" {
  cluster_name  = aws_eks_cluster.Cluster_Obligatorio.name
  node_group_name = "GrupoNodos"
  node_role_arn  = data.aws_iam_role.mi-role.arn
  subnet_ids   = [aws_subnet.subnet_privada1.id, aws_subnet.subnet_privada2.id]
  instance_types = ["t3.large"]

  scaling_config {
   desired_size = 2
   max_size   = 2
   min_size   = 2
  }

 }
```


## _Servicios AWS usados_

* EC2
* VPC
* EKS
* ECR

## _GIF de desmostración_

Corriendo el script de terraform y pods en funcionamiento

![ezgif com-gif-maker](https://user-images.githubusercontent.com/69463751/204722063-93666fa9-4788-4d32-b235-00c4c25a014d.gif)

Acceso a la pagina web

![2022-11-30 01-02-02](https://user-images.githubusercontent.com/69463751/204705273-e9e88c84-b6cc-4bbb-8750-fc208b6ca2ee.gif)

## _URL de repositorio_

https://github.com/UDiegoGon/e-shop_service

