##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
AESD_ASSIGNMENTS_VERSION = '#COMMIT VERSION NUMBER'
AESD_ASSIGNMENTS_VERSION = '8128045057fa842cd9063aa6ea7dca695289b6ad'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
#AESD_ASSIGNMENTS_SITE = '#GITHUB REPOSITORY LINK'
AESD_ASSIGNMENTS_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-teiamas.git'

AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
    # Build finder app
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
	# Build the aesdsocket binary
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
endef

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
    # Create necessary directories
    $(INSTALL) -d $(TARGET_DIR)/etc/finder-app/conf/
    $(INSTALL) -d $(TARGET_DIR)/usr/bin/

    # Install configuration files
    $(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/

    # Install scripts and utilities
    $(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin/finder-test.sh
    $(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin/finder.sh
    $(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin/writer

    # Install the aesdsocket binary to /usr/bin
    $(INSTALL) -D -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/aesdsocket

    # Install the start-stop script to /etc/init.d
    $(INSTALL) -D -m 0755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket
endef


$(eval $(generic-package))
