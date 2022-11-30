#------------------------------------------CLUSTER-------------------------------------------------

resource "aws_eks_cluster" "Cluster_Obligatorio" {
 name = "Cluster_Obligatorio"
 role_arn = data.aws_iam_role.mi-role.arn

 vpc_config {
  subnet_ids = [aws_subnet.subnet_privada1.id, aws_subnet.subnet_privada2.id]
 }
}

#------------------------------------------NODOS-------------------------------------------------

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
