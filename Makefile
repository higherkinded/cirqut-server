####################################################
#### Section for happy users of Nix package manager
####################################################


# Build instruction.
# - build
# - dereference and copy everything into ./dist
# - make ./dist writeable (so it can be removed, etc)
# - unlink ./result
build:
	@echo	"(1/6) :: Cabal cleanup"                                 && \
		nix-shell --pure -p cabal-install --run "cabal v2-clean" && \
		echo "(2/6) :: Building the source via Nix"              && \
		nix-build release.nix --show-trace                       && \
		echo "(3/6) :: Preparing destination"                    && \
		mkdir -p dist                                            && \
		echo "(4/6) :: Dereferencing build artifacts"            && \
		cp -Lrf result/* dist/.                                  && \
		echo "(5/6) :: Setting +w on build artifacts"            && \
		chmod +w -R dist                                         && \
		echo "(6/6) :: Removing symlinks"                        && \
		rm result


###########################
### Developers sub-section


# Run nix shell
sh:
	@echo "(1/1) :: Starting Nix shell" && nix-shell

# Recreate default.nix
nix-recreate:
	@echo "(1/1) :: Recreating default.nix"
	nix-shell --pure -p cabal2nix --run "cabal2nix ." > default.nix


#######################################
#### Section for happy users of Docker
#######################################


# Create a container for crossbuilding
build-container:
	@docker build . -t 'cirqut-server/crossbuild'


# Same as 'make build' but for people using Docker
crossbuild:
	mkdir -p dist && \
	docker run -v $$PWD/dist:/opt/app/dist cirqut-server/crossbuild \
		sh -c "nix-build release.nix && cp -Lr result/* dist/. && chmod +w -R dist"


#####################
#### Utility section
#####################


clear:
	@find . \
		-name '*.hi' -or \
		-name '*.o' \
	| xargs rm


clear-emacs:
	@find . \
		-name '#*#' -or \
		-name '*~'  -or \
		-name '*.save*' \
	| xargs rm
