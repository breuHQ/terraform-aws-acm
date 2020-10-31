# ACM module with Route53 DNS validation

Configuration in this modules creates new Route53 zone and ACM certificate (valid for the domain name and wildcard).

Also, ACM certificate is being validate using DNS method.

## Intputs

| Name                      | Description                                                                                                  | Type   | Default  | Required |     |
| ------------------------- | ------------------------------------------------------------------------------------------------------------ | ------ | -------- | -------- | --- |
| domain_name               | A domain name for which the certificate should be issued.                                                    | string | `` | yes |
| subject_alternative_names | a list of alternative DNS names against which the certificate is required, cannot be used with `is_wildcard` | list   | []       | no       |
| is_wildcard               | if the certificate to be create is a wildcard certificate, cannot be used with `subject_alternative_names`   | bool   | no       | false    |

## Outputs

| Name            | Description                |
| --------------- | -------------------------- |
| certificate_id  | The ID of the certificate  |
| certificate_arn | The ARN of the certificate |
