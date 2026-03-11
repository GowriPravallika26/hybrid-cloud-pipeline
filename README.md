Hybrid Cloud Data Pipeline (AWS + GCP)
Project Overview

* This project implements a Hybrid Cloud Data Pipeline that integrates services from AWS and Google Cloud Platform to process and transfer data between cloud environments.

* The system uses AWS services simulated locally using LocalStack and GCP services deployed through Terraform. Data generated in AWS is processed and forwarded to GCP using a Python bridge service.

* This project demonstrates multi-cloud architecture, Infrastructure as Code, and event-driven data pipelines, which are key concepts in modern Cloud Computing and DevOps environments.

Architecture

AWS Side
SQS (Simple Queue Service) – Receives incoming messages/events
S3 Bucket – Stores generated data
DynamoDB – Tracks processed records


Bridge Service

A Python-based bridge service reads messages from AWS SQS and forwards them to Google Cloud Pub/Sub.

GCP Side

* Pub/Sub Topic – Receives forwarded messages
* Cloud Function – Processes incoming events
* Cloud SQL (PostgreSQL) – Stores processed results

Architecture Flow

AWS (LocalStack)
     |
     | 1. Message Generated
     v
Amazon SQS Queue
     |
     | 2. Python Bridge Service
     v
Google Pub/Sub Topic
     |
     | 3. Event Trigger
     v
Cloud Function
     |
     | 4. Store Data
     v
Cloud SQL Database


Technologies Used
Cloud Platforms
Amazon Web Services
Google Cloud Platform

Infrastructure & DevOps
Terraform
Docker
LocalStack

Programming
Python
Node.js (optional APIs)

Project Structure
hybrid-cloud-pipeline/
│
├── terraform/
│   ├── providers.tf
│   ├── aws-resources.tf
│   ├── gcp-resources.tf
│   ├── cloud-function.tf
│   └── variables.tf
│
├── bridge/
│   ├── bridge.py
│   └── requirements.txt
│
├── function/
│   ├── main.py
│   └── requirements.txt
│
├── docker-compose.yml
├── .env.example
└── README.md

Prerequisites
Before running this project, install:
Docker
Terraform
Python 3.10+
Google Cloud SDK
Git

You must also have a Google Cloud service account key file (key.json).

Environment Variables

Create a .env file based on .env.example.

Example:

GCP_PROJECT_ID=your-project-id
GCP_REGION=us-central1
PATH_TO_GCP_KEYFILE=./key.json

AWS_ACCESS_KEY_ID=test
AWS_SECRET_ACCESS_KEY=test
AWS_DEFAULT_REGION=us-east-1


Running the Project
Step 1: Start LocalStack
docker-compose up -d

Verify container:
docker ps

Step 2: Deploy Infrastructure
Go to the Terraform directory:
cd terraform

Initialize Terraform:
terraform init

Apply infrastructure:
terraform apply

Enter values when prompted:

gcp_keyfile_path = ../key.json
gcp_project_id   = your-project-id
gcp_region       = us-central1

Step 3: Start Bridge Service
Build and run bridge container:
docker build -t bridge-service .
docker run bridge-service

This service reads messages from AWS SQS and publishes them to Google Pub/Sub.

Step 4: Trigger the Pipeline
Send a test message to SQS:
awslocal sqs send-message \
--queue-url http://localhost:4566/000000000000/data-processing-queue \
--message-body "Hello Hybrid Cloud"

The pipeline will process the message and store the result in Cloud SQL.


Features

Hybrid cloud architecture
Event-driven processing
Infrastructure as Code using Terraform
Containerized services
Local AWS simulation using LocalStack
Serverless event processing using Cloud Functions


Author
N.Gowri Pravallika
B.Tech – Computer Science and Engineering