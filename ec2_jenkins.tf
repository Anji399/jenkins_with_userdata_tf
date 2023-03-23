
resource "aws_instance" "ec2_jenkins" {
  ami           = "${lookup(var.ami_id, var.region)}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name = "${var.key_name}"
}
resource "null_resource" "name" {  
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = "${file("C:/Users/user/Downloads/feb.pem")}"
    host = aws_instance.ec2_jenkins.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install java-11-amazon-corretto-headless -y",
      "sudo yum install maven -y",
      "sudo yum install wget -y",
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo yum upgrade -y",
      "sudo yum install -y jenkins",
      "sudo systemctl enable jenkins",
      "sudo systemctl start jenkins",
      "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
    ]
  }
  depends_on = [aws_instance.ec2_jenkins]
}

output "website_url" {
      value = join("",["http://",aws_instance.ec2_jenkins.public_dns,":","8080"])
}  
