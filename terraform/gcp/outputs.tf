# Outputs:
# - Private IP
# - Public IP
# - Private node name
# - Public node name

# iSCSI server

output "iscsisrv_ip" {
  value = module.iscsi_server.iscsisrv_ip
}

output "iscsisrv_public_ip" {
  value = module.iscsi_server.iscsisrv_public_ip
}

output "iscsisrv_name" {
  value = module.iscsi_server.iscsisrv_name
}

output "iscsisrv_public_name" {
  value = []
}

# Hana nodes

output "hana_ip" {
  value = module.hana_node.hana_ip
}

output "hana_public_ip" {
  value = module.hana_node.hana_public_ip
}

output "hana_name" {
  value = module.hana_node.hana_name
}

output "hana_public_name" {
  value = []
}

# Monitoring

output "monitoring_ip" {
  value = module.monitoring.monitoring_ip
}

output "monitoring_public_ip" {
  value = module.monitoring.monitoring_public_ip
}

output "monitoring_name" {
  value = module.monitoring.monitoring_name
}

output "monitoring_public_name" {
  value = module.monitoring.monitoring_public_name
}

# drbd

output "drbd_ip" {
  value = module.drbd_node.drbd_ip
}

output "drbd_public_ip" {
  value = module.drbd_node.drbd_public_ip
}

output "drbd_name" {
  value = module.drbd_node.drbd_name
}

output "drbd_public_name" {
  value = module.drbd_node.drbd_public_name
}

# netweaver

output "netweaver_ip" {
  value = module.netweaver_node.netweaver_ip
}

output "netweaver_public_ip" {
  value = module.netweaver_node.netweaver_public_ip
}

output "netweaver_name" {
  value = module.netweaver_node.netweaver_name
}

output "netweaver_public_name" {
  value = module.netweaver_node.netweaver_public_name
}

# Ansible inventory
resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl",
    {
      hana-name           = module.hana_node.hana_name,
      hana-pip            = module.hana_node.hana_public_ip,
      hana-vip            = module.hana_node.hana_vip,
      hana-remote-python  = var.hana_remote_python,
      name_prefix         = local.deployment_name,
      iscsi-name          = module.iscsi_server.iscsisrv_name,
      iscsi-pip           = module.iscsi_server.iscsisrv_public_ip,
      iscsi-enabled       = local.iscsi_enabled,
      iscsi-remote-python = var.iscsi_remote_python
      use_sbd             = local.use_sbd
  })
  filename = "inventory.yaml"
}
