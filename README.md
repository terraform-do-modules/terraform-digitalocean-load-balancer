<!-- This file was automatically generated by the `geine`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->

<p align="center"> <img src="https://user-images.githubusercontent.com/50652676/62349836-882fef80-b51e-11e9-99e3-7b974309c7e3.png" width="100" height="100"></p>


<h1 align="center">
    Terraform DigitalOcean Load Balancer


</h1>

<p align="center" style="font-size: 1.2rem;"> 
    Provides a DigitalOcean Load Balancer resource that allows you to manage Load between droplets.
     </p>

<p align="center">

<a href="https://www.terraform.io">
  <img src="https://img.shields.io/badge/Terraform-v0.15-green" alt="Terraform">
</a>
<a href="LICENSE.md">
  <img src="https://img.shields.io/badge/License-APACHE-blue.svg" alt="Licence">
</a>


</p>
<p align="center">

<a href='https://facebook.com/sharer/sharer.php?u=https://github.com/terraform-do-modules/terraform-digitalocean-load-balancer'>
  <img title="Share on Facebook" src="https://user-images.githubusercontent.com/50652676/62817743-4f64cb80-bb59-11e9-90c7-b057252ded50.png" />
</a>
<a href='https://www.linkedin.com/shareArticle?mini=true&title=Terraform+DigitalOcean+Load+Balancer&url=https://github.com/terraform-do-modules/terraform-digitalocean-load-balancer'>
  <img title="Share on LinkedIn" src="https://user-images.githubusercontent.com/50652676/62817742-4e339e80-bb59-11e9-87b9-a1f68cae1049.png" />
</a>
<a href='https://twitter.com/intent/tweet/?text=Terraform+DigitalOcean+Load+Balancer&url=https://github.com/terraform-do-modules/terraform-digitalocean-load-balancer'>
  <img title="Share on Twitter" src="https://user-images.githubusercontent.com/50652676/62817740-4c69db00-bb59-11e9-8a79-3580fbbf6d5c.png" />
</a>

</p>
<hr>


We eat, drink, sleep and most importantly love **DevOps**. We are working towards strategies for standardizing architecture while ensuring security for the infrastructure. We are strong believer of the philosophy <b>Bigger problems are always solved by breaking them into smaller manageable problems</b>. Resonating with microservices architecture, it is considered best-practice to run database, cluster, storage in smaller <b>connected yet manageable pieces</b> within the infrastructure. 

This module is basically combination of [Terraform open source](https://www.terraform.io/) and includes automatation tests and examples. It also helps to create and improve your infrastructure with minimalistic code instead of maintaining the whole infrastructure code yourself.

We have [*fifty plus terraform modules*][terraform_modules]. A few of them are comepleted and are available for open source usage while a few others are in progress.




## Prerequisites

This module has a few dependencies: 

- [Terraform 1.x.x](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [Go](https://golang.org/doc/install)
- [github.com/stretchr/testify/assert](https://github.com/stretchr/testify)
- [github.com/gruntwork-io/terratest/modules/terraform](https://github.com/gruntwork-io/terratest)







## Examples


**IMPORTANT:** Since the `master` branch used in `source` varies based on new modifications, we suggest that you use the release versions [here](https://github.com/terraform-do-modules/terraform-digitalocean-load-balancer/releases).


Here are examples of how you can use this module in your inventory structure:
### basic example
```hcl
    module "load-balancer" {
    source             = "terraform-do-modules/load-balancer/digitalocean"
    version            = "1.0.0"
    name               = local.name
    environment        = local.environment
    region             = local.region
    vpc_uuid           = module.vpc.id
    droplet_ids        = module.droplet.id

    ######
    enabled_redirect_http_to_https = false
    forwarding_rule = [
      {
        entry_port     = 80
        entry_protocol = "http"
        target_port     = 80
        target_protocol = "http"
      },
      {
        entry_port     = 443
        entry_protocol = "https"
        target_port      = 80
        target_protocol  = "http"
        certificate_name = "demo"
      }
    ]
  }
```
### complete example
```hcl
    module "load-balancer" {
    source                   = "terraform-do-modules/load-balancer/digitalocean"
    version                  = "1.0.0"
    name                     = local.name
    environment              = local.environment
    region                   = local.region
    vpc_uuid                 = module.vpc.id
    droplet_ids              = module.droplet.id

    ######
    enabled_redirect_http_to_https = false
    forwarding_rule = [
      {
        entry_port     = 80
        entry_protocol = "http"
        target_port     = 80
        target_protocol = "http"
      },
      {
        entry_port     = 443
        entry_protocol = "https"
        target_port      = 80
        target_protocol  = "http"
        certificate_name = "demo"
      }
    ]

    healthcheck = [
      {
        port     = 80
        protocol = "http"
        check_interval_seconds   = 10
        response_timeout_seconds = 5
        unhealthy_threshold      = 3
        healthy_threshold        = 5
      }
    ]
    sticky_sessions = [
      {
        type               = "cookies"
        cookie_name        = "lb-cookie"
        cookie_ttl_seconds = 300
      }
    ]

    firewall = [
      {
        deny  = ["cidr:0.0.0.0/0"]
        allow = ["cidr:143.244.136.144/32"]
      }
    ]
  }
```






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




## Testing
In this module testing is performed with [terratest](https://github.com/gruntwork-io/terratest) and it creates a small piece of infrastructure, matches the output like ARN, ID and Tags name etc and destroy infrastructure in your AWS account. This testing is written in GO, so you need a [GO environment](https://golang.org/doc/install) in your system. 

You need to run the following command in the testing folder:
```hcl
  go test -run Test
```



## Feedback 
If you come accross a bug or have any feedback, please log it in our [issue tracker](https://github.com/terraform-do-modules/terraform-digitalocean-load-balancer/issues), or feel free to drop us an email at [hello@clouddrove.com](mailto:hello@clouddrove.com).

If you have found it worth your time, go ahead and give us a ★ on [our GitHub](https://github.com/terraform-do-modules/terraform-digitalocean-load-balancer)!

## About us

At [CloudDrove][website], we offer expert guidance, implementation support and services to help organisations accelerate their journey to the cloud. Our services include docker and container orchestration, cloud migration and adoption, infrastructure automation, application modernisation and remediation, and performance engineering.

<p align="center">We are <b> The Cloud Experts!</b></p>
<hr />
<p align="center">We ❤️  <a href="https://github.com/clouddrove">Open Source</a> and you can check out <a href="https://github.com/clouddrove">our other modules</a> to get help with your new Cloud ideas.</p>

  [website]: https://clouddrove.com
  [github]: https://github.com/clouddrove
  [linkedin]: https://cpco.io/linkedin
  [twitter]: https://twitter.com/clouddrove/
  [email]: https://clouddrove.com/contact-us.html
  [terraform_modules]: https://github.com/clouddrove?utf8=%E2%9C%93&q=terraform-&type=&language=
