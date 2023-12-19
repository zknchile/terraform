resource "oci_core_instance" "generated_oci_core_instance" {
	agent_config {
		is_management_disabled = "false"
		is_monitoring_disabled = "false"
		plugins_config {
			desired_state = "DISABLED"
			name = "Vulnerability Scanning"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "OS Management Service Agent"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Compute Instance Run Command"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Compute Instance Monitoring"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Block Volume Management"
		}
	}
	availability_config {
		is_live_migration_preferred = "true"
		recovery_action = "RESTORE_INSTANCE"
	}
	availability_domain = var.availability_domain
	compartment_id = var.compartment_id
	create_vnic_details {
		assign_ipv6ip = "false"
		assign_private_dns_record = "true"
		assign_public_ip = "false"
		subnet_id = "ocid1.subnet.oc1.sa-santiago-1.aaaaaaaai5w7ulrbdg7le43gck6hkpi36kc6ifeimnpl3fsufr3vanvlxcma"
	}
	display_name = var.instance_name
	instance_options {
		are_legacy_imds_endpoints_disabled = "false"
	}
	is_pv_encryption_in_transit_enabled = "true"
	shape = "VM.Standard.E4.Flex"
	shape_config {
		memory_in_gbs = "16"
		ocpus = "1"
	}
	source_details {
		boot_volume_size_in_gbs = "250"
		boot_volume_vpus_per_gb = "10"
		source_id = var.source_id
		source_type = "image"
	}
}

output "instance_private_ips" {
  value = [oci_core_instance.generated_oci_core_instance.*.private_ip]
}

output "instance_id" {
  value = [oci_core_instance.generated_oci_core_instance.*.id]
}
