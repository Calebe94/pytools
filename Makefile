# tinytools - scripts to improve your productivity.
# See LICENSE file for copyright and license details.

.POSIX:

BIN_FOLDER=/usr/bin
CONFIG_FOLDER=/etc/tinytools


${BIN_FOLDER}:
	@echo "Creating ${BIN_FOLDER} folder ..."
	mkdir ${BIN_FOLDER}

${CONFIG_FOLDER}:
	@echo "Creating ${CONFIG_FOLDER} folder ..."
	mkdir ${CONFIG_FOLDER}

tsearch: ${CONFIG_FOLDER} ${BIN_FOLDER} tyaml
	@echo "Installing tsearch..."
	install -m 555 tsearch/tsearch ${BIN_FOLDER}
	install -m 555 tsearch/dmenu_tsearch ${BIN_FOLDER}
	install tsearch/params.yaml ${CONFIG_FOLDER}
	@echo "done!"

tpomodoro: ${CONFIG_FOLDER} ${BIN_FOLDER}
	@echo "Installing tpomodoro..."
	install -m 555 tpomodoro/tpomodoro ${BIN_FOLDER}
	$(eval notification_folder := /usr/share/sounds/tpomodoro/)
	[ -d $(notification_folder) ] || mkdir -p $(notification_folder)
	install tpomodoro/Notification.mp3 $(notification_folder)
	@echo "done!"

ttodo: ${CONFIG_FOLDER} ${BIN_FOLDER}
	@echo "Installing ttodo..."
	install -m 555 ttodo/ttodo ${BIN_FOLDER}
	install -m 555 ttodo/dmenu_ttodo ${BIN_FOLDER}
	@echo "done!"

tyaml: ${CONFIG_FOLDER} ${BIN_FOLDER}
	@echo "Installing tyaml..."
	install -m 555 tyaml/tyaml ${BIN_FOLDER}
	@echo "done!"

tprogbar: ${BIN_FOLDER}
	@echo "Installing tprogbar..."
	install -m 555 tprogbar/tprogbar ${BIN_FOLDER}
	@echo "done!"

uninstall:
	@echo "Removing tinytools..."
	rm -f ${BIN_FOLDER}/tsearch
	rm -f ${BIN_FOLDER}/tsearch-dmenu
	rm -f ${BIN_FOLDER}/tpomodoro
	rm -fr /usr/share/sounds/tpomodoro/
	rm -f ${BIN_FOLDER}/ttodo
	rm -f ${BIN_FOLDER}/dmenu_ttodo
	${MAKE} -C tmenu/ uninstall
	rm -f ${BIN_FOLDER}/tyaml
	${MAKE} -C tnotes/ uninstall
	rm -fr ${CONFIG_FOLDER}
	rm -f ${BIN_FOLDER}/tprogbar
	${MAKE} -C tgoeswall/ uninstall
	@echo "done!"

install: tsearch ttodo tyaml tpomodoro tprogbar
	${MAKE} -C tmenu/ install
	${MAKE} -C tgoeswall/ install
	${MAKE} -C tnotes/ install
	@echo "tinytools installed successfully!"

.PHONY: install tsearch tpomodoro ttodo tyaml uninstall tprogbar
