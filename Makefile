.PHONY: clean All

All:
	@echo "----------Building project:[ GT40 - Release ]----------"
	@$(MAKE) -f  "GT40.mk" && $(MAKE) -f  "GT40.mk" PostBuild
clean:
	@echo "----------Cleaning project:[ GT40 - Release ]----------"
	@$(MAKE) -f  "GT40.mk" clean
