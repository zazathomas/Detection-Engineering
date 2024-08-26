Create falco ns
Add helm repo - > helm repo add falcosecurity https://falcosecurity.github.io/charts
Update helm repos - > helm repo update
Install falco > helm upgrade --install falco falcosecurity/falco -n falco -f values.yaml  --create-namespace
Install custom rules > helm upgrade --install falco falcosecurity/falco -n falco -f values.yaml -f custom-rules.yaml  --create-namespace

