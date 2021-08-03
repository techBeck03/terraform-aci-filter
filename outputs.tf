output "dn" {
  value       = aci_rest.vzFilter.id
  description = "Distinguished name of `vzFilter` object."
}

output "name" {
  value       = aci_rest.vzFilter.content.name
  description = "Filter name."
}
