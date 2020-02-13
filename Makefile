ANSIBLE=ansible-playbook

site:
	$(ANSIBLE) --become ./playbooks/site.yml

initial:
	$(ANSIBLE) --ask-pass --user root -t base ./playbooks/site.yml

