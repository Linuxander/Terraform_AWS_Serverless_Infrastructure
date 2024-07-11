# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "aws" {
  region = var.region
}

module "lambda_layers" {
  source = "./lambda/layers"
}

module "cognito" {
  source             = "./cognito"
  region             = var.region
  user_pool_name     = "user_pool_test"
  identity_pool_name = "identity_pool_test"
}

module "lambda_createUser" {
  source                    = "./lambda/createUser"
  db_host                   = split(":", module.databases.db_host)[0]
  rds_security_group_id_ref = module.networking.security_group_rds_id
  rds_subnets_ref           = module.networking.rds_subnets
  layer_arn_mysqlconnector  = module.lambda_layers.lambda_layer_mysqlconnector_arn
}

module "lambda_createPost" {
  source                    = "./lambda/createPost"
  db_host                   = split(":", module.databases.db_host)[0]
  rds_security_group_id_ref = module.networking.security_group_rds_id
  rds_subnets_ref           = module.networking.rds_subnets
  layer_arn_mysqlconnector  = module.lambda_layers.lambda_layer_mysqlconnector_arn
}

module "networking" {
  source       = "./networking"
  project_name = var.project_name
  region       = var.region
}

module "databases" {
  source                   = "./databases/rds"
  project_name             = var.project_name
  target_subnet_group_name = module.networking.subnet_group_rds_name
  target_security_group_id = module.networking.security_group_rds_id
}

module "apigw_createUser" {
  source               = "./api_gateway/createUser"
  region               = var.region
  lambda_invoke_arn    = module.lambda_createUser.lambda_create_user_arn
  lambda_function_name = module.lambda_createUser.lambda_create_user_function_name
  stage                = "test"
  method_type          = "POST"
  path_part            = "createUser"
  cognito_user_pool_arn     = module.cognito.cognito_user_pool_arn
}

module "apigw_createPost" {
  source               = "./api_gateway/createPost"
  region               = var.region
  lambda_invoke_arn    = module.lambda_createPost.lambda_create_post_arn
  lambda_function_name = module.lambda_createPost.lambda_create_post_function_name
  stage                = "test"
  method_type          = "POST"
  path_part            = "createPost"
}