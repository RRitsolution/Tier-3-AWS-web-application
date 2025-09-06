**##Tier-3 Layer Application on AWS EC2 – Custom VPC##**
Let’s say I want to deploy a simple Python Flask-based application which has the main application logic code acting as the middleware (back-end) between the front-end and database.
Then I will deploy a front-end web server acting as the presentation layer, which will serve a normal HTML page showing a link to the application page, connected to the back-end server.
Finally, I will deploy a database server which is connected to the back-end server.

**Traffic Flow of this Application**
**User (Client) Browser → Front-end Server → Back-end Server → Database Server**
Whenever the user hits the front-end server URL, it redirects to the back-end, then to the database server, and finally shows “connected to DB” (as per code definition) if all goes well.

**Points to Understand for Flow of Application.**
User connects to the front-end because the front-end web server allows connections via HTTP/80 publicly (0.0.0.0/0).
Then the front-end connects to the back-end because of the logic defined in the front-end HTML configuration to redirect to the back-end.
The back-end allows connection requests from the front-end and redirects to the database because of the logic defined in the back-end Python application code (allowing traffic from the front-end and connecting to the DB).
Finally, it shows “connected to DB” because the database server allows connection requests from the back-end using the user defined for the DB (and the same user is configured in the back-end).
**
**Default VPC Setup****
This complete setup worked for me when I did it on AWS in the default VPC (Public Subnet).
**
**Custom VPC Setup****
Then I tried to do this in my own VPC (Public/Private subnet) where all servers (Front-end, Back-end, DB) were kept in the Private subnet (not accessible via public, no route to IGW).
In general, this was not possible since my front-end server, which is now in private, could not be accessed via Browser (Internet).

**Solution**
To fix this, I needed a common entry point for user-facing traffic that redirects requests to the front-end, then back-end, and DB.
For this issue, a Load Balancer came into the picture. I added it in the public subnet, in front of the front-end server. The Load Balancer is public facing of user requests and balancing the traffic by forwarding requests to front-end servers in a managed manner.
New Traffic Flow of this Application (Private Subnet Setup)
User (Client) Browser → Front-end Load Balancer (Public Subnet) → 2-Front-end (Private Subnet) →2 Back-end (Private Subnet) → Database (Private Subnet)
So lets start this setup and deployment.

**Infracture Setup-**
Custom VPC setup//
Just search VPC in your favaroute Region and click on creation then select VPC with more it will auto configure all by next-2 click .
Remember avoid S3 and NAT gateway is paid AWS service so be carefull and delete while lab is done.

**Servers Setup//**
2 Front-end Server for high availbility purpose in different-2 AZ-Private Subnet
2 Back-end server for high availbility purpose in different-2 AZ
1 DB server in private Subnet kept it as simple
1 ALB in public subnet
1 EC2 in public subnet as Bastaion server to configure packages on all servers in private subnet


1 DB server (I kept it simple as of now)
1-ALB in Public subnet 
