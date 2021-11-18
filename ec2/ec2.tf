provider "aws" {
 region = "us-east-1"
 access_key = "*********"
 secret_key = "************"
}
resource "aws_instance" "ec2_example" {

    ami = "ami-0279c3b3186e54acd"  
    instance_type = "t2.small" 
    key_name= "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]

  provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("C:\\gitrepo\\aws\\aws_key")
      timeout     = "4m"
   }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
	 protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  },
  {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 8080
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
	 protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 8080
  }
  ]
}


resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCdVRDUTY+y6/cde1B6dytuHyo4JrDGFvDTWijc/g4p6liHD025tgLjJOB70BCDlLwx/pPD5N9Kq2yB2mhuZbS3y46OquJ70MKd9p4CL1MDiX6OdXCV6fl1H8lDYJznELu7ypcYWQJfjgAya8ujB+r+Ln6VD1lGqHLlM9Ikh361WnJlDKZFvk3nhSSz9onCujvvnatUHElWFMSfldUCKrbBAG1k6JghGnw2VcnuY/qaAHRQC50hJsZFZUsX9ZadasbntmGSwXtXRJwytu8SRqWxB1+dwSD9oYsr9PzIIQ5Unyn0x2TMngpGDwPt1ts14JaEGh6VgIX2P0APyolc5qEL Fayaz Sayyed@TORHNALG10NYY2"
}
