output "script_id" {
  value       = vultr_startup_script.matchbox.id
  description = "The Vultr startup script ID"
}

output "script_name" {
  value       = vultr_startup_script.matchbox.name
  description = "The Vultr startup script name"
}
