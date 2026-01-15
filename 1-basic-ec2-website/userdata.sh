#!/bin/bash

## Changed the Name and Links accordingly

# Update the package list and install Nginx
apt update -y
apt install nginx -y

# Enable and start nginx
systemctl enable nginx
systemctl start nginx

# Create portfolio content
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Beatriz Cruz Terraforming Portfolio</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      text-align: center;
      padding: 50px;
    }
    h1 {
      color: #333;
    }
    p {
      font-size: 18px;
      color: #666;
    }
    a {
      color: #007BFF;
      text-decoration: none;
    }
  </style>
</head>
<body>
  <h1>Hi, I'm Beatriz Cruz!</h1>
  <p>I'm trying to learn Terraform. If this breaks, nice.</p>
  <p>
    <a href="https://beatrizmaecruz.github.io" target="_blank">Mid Software Portfolio</a> |
  </p>
</body>
</html>
EOF
