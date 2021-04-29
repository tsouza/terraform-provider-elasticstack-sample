resource "aws_lightsail_static_ip" "onweek_windows_test_ip_1" {
  name = "onweek_windows_test_ip_1"
}

resource "aws_lightsail_instance" "onweek_windows_test_1" {
  name              = "onweek_windows_test_1"
  availability_zone = "us-east-1a"
  blueprint_id      = "windows_server_2019"
  bundle_id         = "micro_win_2_0"

  user_data = <<EOF
<powershell>
$ProgressPreference = 'SilentlyContinue'
Set-PSDebug -Trace 1
Set-Location -Path "C:\Users\Administrator\Desktop"

Invoke-WebRequest -Uri "https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-7.12.1-windows-x86_64.zip" -OutFile "agent.zip"
Expand-Archive -Path "agent.zip" -DestinationPath "C:\Users\Administrator\Desktop\agent"

Start-Sleep -Seconds 10

Add-MpPreference -ExclusionPath "C:\Users\Administrators\Desktop"
Invoke-WebRequest -Uri "https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20200918-fix/mimikatz_trunk.zip" -OutFile "mimikatz_trunk.zip"
Expand-Archive -Path "mimikatz_trunk.zip" -DestinationPath "C:\Users\Administrator\Desktop\mimikatz"
</powershell>
EOF
}

resource "aws_lightsail_instance_public_ports" "onweek_test" {
  instance_name = aws_lightsail_instance.onweek_windows_test_1.name

  port_info {
    protocol  = "tcp"
    from_port = 3389
    to_port   = 3389
  }
}
resource "aws_lightsail_static_ip_attachment" "onweek_test" {
  static_ip_name = aws_lightsail_static_ip.onweek_windows_test_ip_1.id
  instance_name  = aws_lightsail_instance.onweek_windows_test_1.id
}

output "windows_ip" {
  value = aws_lightsail_static_ip.onweek_windows_test_ip_1.ip_address
}