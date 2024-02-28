output "microservice1_ip" {
  description = "ip da maquina virtual"
  value       = aws_instance.microservice1.public_ip
}

output "microservice2_ip" {
  description = "ip da maquina virtual"
  value       = aws_instance.microservice2.public_ip
}
