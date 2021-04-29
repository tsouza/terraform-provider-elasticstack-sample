provider "ec" {}

data "ec_stack" "latest" {
  version_regex = "latest"
  region        = "us-east-1"
}

resource "ec_deployment" "onweek_demo" {
  name                   = "onweek_demo"
  region                 = "us-east-1"
  version                = data.ec_stack.latest.version
  deployment_template_id = "aws-io-optimized-v2"
  elasticsearch {
    topology {
      id         = "hot_content"
      size       = "4g"
      zone_count = 1
    }
  }
  kibana {
    topology {
      size       = "1g"
      zone_count = 1
    }
  }
}

provider "elasticstack" {
  elasticsearch_url = ec_deployment.onweek_demo.elasticsearch[0].https_endpoint
  username          = ec_deployment.onweek_demo.elasticsearch_username
  password          = ec_deployment.onweek_demo.elasticsearch_password
}

resource "elasticstack_auth_user" "onweek_demo_user" {
  username = "onweek_demo_user"
  password = "onweek_demo_user"
  roles    = ["superuser"]
}