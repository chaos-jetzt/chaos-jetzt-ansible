ANSIBLE=ansible-playbook

site:
	$(ANSIBLE) --become ./playbooks/site.yml

initial:
	$(ANSIBLE) --ask-pass --user root -t base ./playbooks/site.yml

docker:
	$(ANSIBLE) --become -t docker ./playbooks/site.yml

dev:
	$(ANSIBLE) --become --limit 'dev' ./playbooks/site.yml
