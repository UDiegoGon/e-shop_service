# **Detalles de la Arquitectura**

## _Diagrama_ 


## _Datos de la infraestructura_
---
La infraestructura se despliega gracias a una solucion de terraform la en la cual se definen los siguientes recusos:

* 1 VPC:
El vpc que contendra las instancias y en el que se englovan todos los recursos. Tiene 

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



## _Servicios AWS usados_

## _GIF de desmostración_
