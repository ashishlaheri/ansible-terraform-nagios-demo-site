# 🚀 AWS Auto Web Deployment using Terraform + Ansible (on WSL)

**Short Description:**
This is a demo site for practice — a fully working example showing how to deploy a static website on AWS EC2 using Terraform and Ansible from WSL.
Use it as a base if you want to upload your own working project.

---

## 🧠 Quick Start

Clone this repository:

```bash
git clone https://github.com/ashishlaheri/ansible-terraform-nagios-demo-site.git
cd ansible-terraform-nagios-demo-site
```

Then follow the steps below to configure and deploy your demo site.

---

This project automatically deploys a simple static website (`index.html` + `sample_status.html`) on an **AWS EC2 Ubuntu instance**, using:

* **Terraform** — to provision infrastructure
* **Ansible** — to configure the server and deploy the web app
* **WSL (Windows Subsystem for Linux)** — as the local environment

---

## 🧩 Project Structure

```
.
├── ansible.cfg
├── generate_ssh_key.sh
├── index.html
├── inventory_template.ini
├── main.tf
├── sample_status.html
├── site.yml
├── terraform_apply_and_write_inventory.sh
├── user_data.sh
└── variables.tf
└── nagios.yml
```

---

## ⚙️ What This Does

1. **Generates an SSH key** for AWS EC2 access
2. **Uses Terraform** to:

   * Create an EC2 instance (Ubuntu)
   * Create a Security Group allowing SSH (22) & HTTP (80)
   * Inject user data to install Apache
3. **Uses Ansible** to:

   * Install Apache (if not already)
   * Copy your website files (`index.html`, `sample_status.html`)
   * Start and enable Apache
   * Verify the site returns HTTP 200 OK

---

## 🧑‍💻 Prerequisites

Make sure you have these installed **on WSL (Ubuntu)**:

```bash
sudo apt update && sudo apt install -y \
  terraform ansible unzip curl python3-pip git awscli
```

> You’ll need an **AWS Access Key** and **Secret Key** with EC2 permissions.

---

## 🔑 Step 1 — Configure AWS CLI

Run this once to save your AWS credentials:

```bash
aws configure
```

You’ll be asked for:

```
AWS Access Key ID [None]: <your access key>
AWS Secret Access Key [None]: <your secret key>
Default region name [None]: us-east-1
Default output format [None]: json
```

---

## 🔐 Step 2 — Generate SSH Key

Run this script (it will create a new keypair for EC2):

```bash
chmod +x generate_ssh_key.sh
./generate_ssh_key.sh
```

By default, the key is created as:

```
~/.ssh/wsl_deploy_key
~/.ssh/wsl_deploy_key.pub
```

To ensure Terraform and Ansible can use it properly, **rename and secure the key**:

```bash
mv ~/.ssh/wsl_deploy_key ~/.ssh/wsl_deploy_key.pem
chmod 600 ~/.ssh/wsl_deploy_key.pem
```

You should now have:

```
~/.ssh/wsl_deploy_key.pem
~/.ssh/wsl_deploy_key.pub
```

---

## ☁️ Step 3 — Deploy to AWS using Terraform + Ansible

Make the deployment script executable, then run it:

```bash
chmod +x terraform_apply_and_write_inventory.sh
./terraform_apply_and_write_inventory.sh
```

✅ What it does:

* Initializes Terraform
* Provisions EC2 + Security Group
* Gets the instance IP
* Creates an Ansible inventory
* Runs Ansible to install Apache & deploy the site

---

## 🌍 Step 4 — Verify Your Deployment

Once completed successfully, the script will print the public IP.

Open it in your browser:

```
http://<EC2_PUBLIC_IP>/
```

You should see:

```
Welcome — Demo App
```

---

## 🧰 Manual Commands (Optional)

If you want to run Ansible again manually:

```bash
ansible-playbook -i inventory.ini site.yml -v
```

To destroy everything (clean up AWS resources):

```bash
terraform destroy -auto-approve
```

---

## ⚠️ Notes & Common Fixes

* If you see:

  ```
  chmod: cannot access '~/.ssh/wsl_deploy_key.pem'
  ```

  Make sure you renamed the private key:

  ```bash
  mv ~/.ssh/wsl_deploy_key ~/.ssh/wsl_deploy_key.pem
  chmod 600 ~/.ssh/wsl_deploy_key.pem
  ```

* If you get a world-writable directory warning:
  Move your project to your WSL home:

  ```bash
  mkdir -p ~/aws-deploy
  cp -r /mnt/c/Users/<username>/Desktop/nagios-terraform/* ~/aws-deploy/
  cd ~/aws-deploy
  ```

---

## 🧠 How It Works (Quick Summary)

| Tool                 | Purpose                                               |
| -------------------- | ----------------------------------------------------- |
| **Terraform**        | Creates AWS resources (key pair, security group, EC2) |
| **User Data Script** | Auto-installs Apache during instance boot             |
| **Ansible**          | Copies HTML files, ensures Apache is running          |
| **Apache2**          | Serves your static site on port 80                    |

---

## 🔮 Next Steps (Optional Improvements)

* Add HTTPS using **Let’s Encrypt**
* Add a **Jenkins/GitHub Actions pipeline** to run Terraform + Ansible automatically
* Use **Ansible roles** for modular setups
* Add **Docker** support to containerize your web app

---

## 👨‍💼 Author

**Ashish Kumar Laheri**
🌐 DevOps | Cloud | Automation Engineer

---

## 🧩 License

This project is open source under the [MIT License](LICENSE).
