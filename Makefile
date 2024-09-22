###
# USAGE
#
# make                  # print all targets
# make login            # run 'terraform login', 'az login' and 'az account set'
# make init             # run 'terraform init'
# ENV=dev make plan     # run 'terraform plan' in 'dev' environment (stage)
# ENV=dev make apply    # run 'terraform apply' in 'dev' environment (stage)
# ENV=dev make destroy  # run 'terraform destroy' in 'dev' environment (stage)
###

###
# FEATURES
###
ENABLE_AWS		:= FALSE
ENABLE_AZURE	:= FALSE
ENABLE_GCP		:= FALSE

###
# VARIABLES
###
AZ							:= $(shell command -v az 2> /dev/null)
TERRAFORM				:= $(shell command -v terraform 2> /dev/null)
TERRAFORM-DOCS	:= $(shell command -v terraform-docs 2> /dev/null)
YAMLLINT        := $(shell command -v yamllint 2> /dev/null)
.DEFAULT_GOAL		:= help

###
# Azure
AZ_SUBSCRIPTION := my-azure-subscription

###
# AWS
# https://github.com/acch/terraform-boilerplate/issues/2
# ...

###
# Google Cloud
# https://github.com/acch/terraform-boilerplate/issues/3
# ...

###
# TARGETS
###
.PHONY: check check-env help login fmt lint list show init validate test refresh plan apply destroy docs clean

check:
# check for necessary tools
ifeq (, $(TERRAFORM))
	$(error No terraform in $(PATH))
endif

# Azure
ifeq ($(ENABLE_AZURE),TRUE)
ifeq (, $(AZ))
	$(error No az in $(PATH))
endif
endif

# AWS
# https://github.com/acch/terraform-boilerplate/issues/2
# ...

# Google Cloud
# https://github.com/acch/terraform-boilerplate/issues/3
# ...

check-env: check
# check for necessary environment variables
ifndef ENV
	$(error ENV is not defined. Define environment (stage) as 'ENV=dev' or 'ENV=prod')
endif

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Print targets and their descriptions
	@echo
	@echo "Usage:"
	@echo "  ENV=<environment> make <target>"
	@echo
	@echo "The following targets are available:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
	@echo

login: check ## Log in and set active subscription
	@$(TERRAFORM) -version
	$(TERRAFORM) login

# Azure
ifeq ($(ENABLE_AZURE),TRUE)
	@$(AZ) version \
		--output table

	$(AZ) account clear
	$(AZ) login \
		--output none
	$(AZ) account set \
		--name $(AZ_SUBSCRIPTION)
	@$(AZ) account show \
		--output table
endif

# AWS
# https://github.com/acch/terraform-boilerplate/issues/2
# ...

# Google Cloud
# https://github.com/acch/terraform-boilerplate/issues/3
# ...

fmt: check ## Reformat configuration in standard style
	$(TERRAFORM) fmt \
		-write=true \
		-recursive

lint: check ## Check if configuration is formatted
	$(TERRAFORM) fmt \
		-write=false \
		-recursive \
		-diff \
		-check

list: check ## List resources in state
	$(TERRAFORM) workspace show
	$(TERRAFORM) state list

show: check ## Show current state
	$(TERRAFORM) workspace show
	$(TERRAFORM) show

init: check ## Prepare working directory
	@$(TERRAFORM) -version

	$(TERRAFORM) init \
		-upgrade \
		-input=false

validate: check ## Check whether configuration is valid
	$(TERRAFORM) validate

	$(YAMLLINT) config/ \
	  --strict

test: check ## Execute integration tests
	@for dir in modules/*/tests ; do \
		echo "----- Testing $${dir%/tests} -----" ; \
		( \
			cd $${dir%/tests} ; \
			$(TERRAFORM) init \
				-backend=false \
				-input=false ; \
			$(TERRAFORM) test \
		) \
	done

refresh: check-env ## Update state to match remote systems
	@$(TERRAFORM) -version

ifneq ($(shell terraform workspace show), $(ENV))
	@echo 'Switching to the [$(ENV)] environment ...';
	$(TERRAFORM) workspace select -or-create=true $(ENV);
endif

	$(TERRAFORM) refresh \
		-var "env=$(ENV)" \
		-input=false

plan: check-env ## Show required changes
	@$(TERRAFORM) -version

ifneq ($(shell terraform workspace show), $(ENV))
	@echo 'Switching to the [$(ENV)] environment ...';
	$(TERRAFORM) workspace select -or-create=true $(ENV);
endif

	$(TERRAFORM) plan \
		-var "env=$(ENV)" \
		-out $(ENV).tfplan \
		-input=false

apply: check-env ## Create or update infrastructure
	@$(TERRAFORM) -version

ifneq ($(shell terraform workspace show), $(ENV))
	@echo 'Switching to the [$(ENV)] environment ...';
	$(TERRAFORM) workspace select -or-create=true $(ENV);
endif

	$(TERRAFORM) apply \
		-input=false \
		$(ENV).tfplan
	@rm -f $(ENV).tfplan

destroy: check-env ## Destroy previously-created infrastructure
	@$(TERRAFORM) -version

ifneq ($(shell terraform workspace show), $(ENV))
	@echo 'Switching to the [$(ENV)] environment ...';
	$(TERRAFORM) workspace select -or-create=true $(ENV);
endif

	$(TERRAFORM) destroy \
		-var "env=$(ENV)" \
	  -input=false

docs: ## Generate documentation
ifeq (, $(TERRAFORM-DOCS))
	$(error No terraform-docs in $(PATH))
endif

	@$(TERRAFORM-DOCS) --version
	$(TERRAFORM-DOCS) markdown table "$(CURDIR)" \
		--lockfile=false \
		--output-file README.md \
		--recursive

clean: ## Clean temporary files
	find "$(CURDIR)" \( -type f -name ".terraform.lock.hcl" -o -type d -name ".terraform" -o -type f -name "*.tfplan" \) -exec rm -rf {} +
