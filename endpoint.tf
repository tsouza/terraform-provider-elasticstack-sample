resource "elasticstack_fleet_agent_policy" "endpoint_1" {
  name = "onweek-endpoint-1"
}

resource "aws_lightsail_instance" "onweek_windows_test_3" {
  name              = "onweek_windows_test_3"
  availability_zone = "us-east-1a"
  blueprint_id      = "windows_server_2019"
  bundle_id         = "micro_win_2_0"

  user_data = <<EOF
<powershell>
$ProgressPreference = 'SilentlyContinue'
Set-PSDebug -Trace 1
Set-Location -Path "C:\Users\Administrator\Desktop"
Add-MpPreference -ExclusionPath "C:\Users\Administrator\Desktop"

Invoke-WebRequest -Uri "https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-7.12.1-windows-x86_64.zip" -OutFile "agent.zip"
Expand-Archive -Path "agent.zip" -DestinationPath "C:\Users\Administrator\Desktop\agent"
Start-Process -Wait -FilePath "C:\Users\Administrator\Desktop\agent\elastic-agent-7.12.1-windows-x86_64\elastic-agent.exe" -ArgumentList "install","-f","--kibana-url=${ec_deployment.onweek_demo.kibana[0].https_endpoint}","--enrollment-token=${elasticstack_fleet_agent_policy.endpoint_1.enrollment_secret}"

Start-Sleep -Seconds 120

Invoke-WebRequest -Uri "https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20200918-fix/mimikatz_trunk.zip" -OutFile "mimikatz_trunk.zip"
Expand-Archive -Path "mimikatz_trunk.zip" -DestinationPath "C:\Users\Administrator\Desktop\mimikatz"
</powershell>
EOF


}