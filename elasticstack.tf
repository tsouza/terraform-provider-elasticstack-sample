provider "elasticstack" {
  elasticsearch_url = ec_deployment.onweek_demo.elasticsearch[0].https_endpoint
  username          = ec_deployment.onweek_demo.username
  password          = ec_deployment.onweek_demo.password
}