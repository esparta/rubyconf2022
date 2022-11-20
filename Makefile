# MakeFile for the project on the presentation for RubyConf 2002:
#  "Never again without a contract: dry-validation", by @esparta@ruby.social
BUSINESS=business
BUNDLE=bundle exec

test:
	cd $(BUSINESS) && $(BUNDLE) rspec

guard:
	cd $(BUSINESS) && pwd && $(BUNDLE) guard

.PHONY: test
