/**
 * Copyright 2020 Barefoot Coders, LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

data "aws_iam_policy_document" "komiser" {
  statement {
    actions = [
     "ec2:DescribeRegions",
     "ec2:DescribeInstances",
     "ec2:DescribeVolumes",
     "ec2:DescribeVpcs",
     "ec2:DescribeSecurityGroups",
     "ec2:DescribeNatGateways",
     "ec2:DescribeRouteTables",
     "ec2:DescribeSnapshots",
     "ec2:DescribeNetworkAcls",
     "ec2:DescribeKeyPairs",
     "ec2:DescribeInternetGateways",      
    ]
    resources = ["*"]
  }

  statement {
    actions = [
     "ec2:DescribeAddresses",
     "ec2:DescribeSnapshots",
     "ec2:DescribeSubnets",
     "elasticloadbalancing:DescribeLoadBalancers",
     "autoscaling:DescribeAutoScalingGroups",
     "ce:GetCostAndUsage",
     "s3:ListAllMyBuckets",
     "apigateway:GET",   
     "lambda:ListFunctions",
     "dynamodb:ListTables",
     "dynamodb:DescribeTable",
     "rds:DescribeDBInstances",
     "cloudwatch:DescribeAlarms",
     "cloudfront:ListDistributions",
     "ecs:ListServices",
     "ecs:ListTasks",
     "ecs:ListClusters",
     "sqs:ListQueues",
     "route53:ListHostedZones",
     "sns:ListTopics",
     "iam:ListGroups",
     "iam:ListRoles",
     "iam:ListPolicies",
     "iam:ListUsers",
     "s3:GetBucketLocation",
     "apigateway:GET",
     "acm:ListCertificates",
     "mq:ListBrokers",
     "cloudwatch:GetMetricStatistics",
     "cloudtrail:LookupEvents",
     "ce:GetCostAndUsage",
     "ce:GetCostForecast",
     "datapipeline:ListPipelines",
     "ec2:DescribeReservedInstances",
     "ec2:DescribeSpotFleetRequests",
     "ec2:DescribeScheduledInstances",
     "eks:ListClusters",
     "elasticache:DescribeCacheClusters",
     "es:ListDomainNames",
     "logs:DescribeLogGroups",
     "glue:GetCrawlers",
     "glue:GetJobs",
     "organizations:DescribeOrganization",
     "iam:GetUser",
     "kinesis:ListStreams",
     "kinesis:ListShards",
     "kms:ListKeys",
     "redshift:DescribeClusters",
     "tag:GetResources",
     "route53:ListResourceRecordSets",
     "support:DescribeCases",
     "swf:ListDomains",
     "ecs:DescribeServices",
     "ecs:DescribeTasks",
     "ecs:DescribeClusters",
     "glacier:ListVaults",
     "ec2:DescribeSpotFleetInstances",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "komiser" {
  name   = var.iam_policy_name
  path   = var.iam_policy_path
  policy = data.aws_iam_policy_document.komiser.json
}

resource "aws_iam_user" "komiser" {
  name = var.iam_user_name
  path = var.iam_user_path
}

resource "aws_iam_user_policy_attachment" "komiser" {
  user       = aws_iam_user.komiser.name
  policy_arn = aws_iam_policy.komiser.arn
}

resource "aws_iam_access_key" "komiser" {
  user    = aws_iam_user.komiser.name
  pgp_key = var.iam_user_secret_pgp_key
}
