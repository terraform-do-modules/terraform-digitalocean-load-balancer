## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| algorithm | The load balancing algorithm used to determine which backend Droplet will be selected by a client. It must be either round\_robin or least\_connections. The default value is round\_robin. | `string` | `"round_robin"` | no |
| disable\_lets\_encrypt\_dns\_records | A boolean value indicating whether to disable automatic DNS record creation for Let's Encrypt certificates that are added to the load balancer. Default value is false. | `bool` | `false` | no |
| droplet\_ids | A list of the IDs of each droplet to be attached to the Load Balancer. | `list(string)` | `[]` | no |
| droplet\_tag | The name of a Droplet tag corresponding to Droplets to be assigned to the Load Balancer. | `string` | `null` | no |
| enable\_backend\_keepalive | A boolean value indicating whether HTTP keepalive connections are maintained to target Droplets. Default value is false. | `bool` | `false` | no |
| enable\_proxy\_protocol | A boolean value indicating whether PROXY Protocol should be used to pass information from connecting client requests to the backend service. Default value is false. | `bool` | `false` | no |
| enabled | Whether to create the resources. Set to `false` to prevent the module from creating any resources. | `bool` | `true` | no |
| enabled\_redirect\_http\_to\_https | A boolean value indicating whether HTTP requests to the Load Balancer on port 80 will be redirected to HTTPS on port 443. Default value is false. | `bool` | `false` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| firewall | List of objects that represent the configuration of each healthcheck. | `list(any)` | `[]` | no |
| forwarding\_rule | List of objects that represent the configuration of each forwarding\_rule. | `list(any)` | `[]` | no |
| healthcheck | List of objects that represent the configuration of each healthcheck. | `list(any)` | `[]` | no |
| http\_idle\_timeout\_seconds | Specifies the idle timeout for HTTPS connections on the load balancer in seconds. | `number` | `null` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| lb\_size | The size of the Load Balancer. It must be either lb-small, lb-medium, or lb-large. Defaults to lb-small. Only one of size or size\_unit may be provided. | `string` | `"lb-small"` | no |
| managedby | ManagedBy, eg 'terraform-do-modules' or 'hello@clouddrove.com' | `string` | `"terraform-do-modules"` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| project\_id | The ID of the project that the load balancer is associated with. If no ID is provided at creation, the load balancer associates with the user's default project. | `string` | `null` | no |
| region | The region to create VPC, like `london-1` , `bangalore-1` ,`newyork-3` `toronto-1`. | `string` | `"blr-1"` | no |
| size\_unit | The size of the Load Balancer. It must be in the range (1, 100). Defaults to 1. Only one of size or size\_unit may be provided. | `number` | `1` | no |
| sticky\_sessions | List of objects that represent the configuration of each healthcheck. | `list(any)` | `[]` | no |
| vpc\_uuid | The ID of the VPC where the load balancer will be located. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Load Balancer. |
| ip | The ip of the Load Balancer. |
| urn | The uniform resource name for the Load Balancer. |

