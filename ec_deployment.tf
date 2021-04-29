data "ec_stack" "latest" {
  version_regex = "latest"
  region        = "us-east-1"
}

resource "ec_deployment" "onweek_demo" {
  region                 = "us-east-1"
  version                = data.ec_stack.latest.version
  deployment_template_id = "aws-io-optimized-v2"
  elasticsearch {
    topology {
      id   = "hot_content"
      size = "4g"
    }
  }
  kibana {
    topology {
      size = "1g"
    }
  }
}