**Tier-3 Layer Application on AWS EC2 – Custom VPC**

I recently deployed a simple Python Flask application on AWS following the classic 3-tier architecture:

🔹 Front-end (Presentation Layer): Web server serving HTML and redirecting to backend
🔹 Back-end (Application Layer): Flask app acting as middleware with logic to connect DB
🔹 Database (Data Layer): DB server accessed only via backend

**Traffic Flow**

**User Browser → Front-end → Back-end → Database → Response
If all works, the app shows “connected to DB”.**

**Default VPC Setup**

This worked fine in the default VPC (public subnet) where all servers were accessible.

**Custom VPC Setup (Challenge)**

In a custom VPC (public + private subnets), I placed all servers in the private subnet.
For Custom VPC configure I followed very simple setup .

<img width="792" height="427" alt="image" src="https://github.com/user-attachments/assets/90df66cb-789d-414c-b305-071d384d6307" />

<img width="784" height="440" alt="image" src="https://github.com/user-attachments/assets/b0e27d3e-b425-46d5-9ba9-65e6d8b6f12e" />

After creation Successfully creation =>

<img width="807" height="413" alt="image" src="https://github.com/user-attachments/assets/f965e830-73f1-4dc3-8111-89f2f845b4f6" />

👉 **Problem: The front-end was no longer accessible from the internet.**

**Solution**

I added an Application Load Balancer (ALB) in the public subnet as the single entry point with manage of loads on server.
**New Flow:
User Browser → ALB (Public Subnet) → Front-end (Private) → Back-end (Private) → Database (Private)**

Infra Setup (Simplified)

2 Front-end servers (private, different AZs)

2 Back-end servers (private, different AZs)

1 Database server (private)

1 ALB (public subnet)

1 Bastion Host (public subnet, for secure access to private servers for configuration).


****Note-**
**1-I kept only 1 NAT Gateway , All private subnets Instances will be able to access interent via NAT Gatway ..Since NAT Gateway is payble servcie so I kept only one.
2-For high availbility need to define NAT Gateway per AZ.
3-⚠️ Note: Avoid enabling S3 .
4- I also ignore Load Balancer for back-end since I made Front -end server  as reverse poxy .** **to avoid Load balancer charage for demo purpose.**

**✅ This project helped me practice high availability setup and secure architecture in AWS using custom VPC.****
