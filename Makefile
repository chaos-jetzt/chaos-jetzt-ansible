ANSIBLE=ansible-playbook
LIMIT=all

ifeq ($(findstring dev,$(MAKECMDGOALS)),dev)
    LIMIT=dev
endif

site:
	$(ANSIBLE) --become --limit $(LIMIT) ./playbooks/site.yml

initial:
	$(ANSIBLE) --ask-pass --user root -t base --limit $(LIMIT) ./playbooks/site.yml

firewall:
	$(ANSIBLE) --become -t firewall --limit $(LIMIT) ./playbooks/site.yml

docker:
	$(ANSIBLE) --become -t docker --limit $(LIMIT) ./playbooks/site.yml

compose:
	$(ANSIBLE) --become -t compose --limit $(LIMIT) ./playbooks/site.yml

ifeq ($(MAKECMDGOALS),dev)
dev:
	$(ANSIBLE) --become --limit $(LIMIT) ./playbooks/site.yml
else
dev:
endif
