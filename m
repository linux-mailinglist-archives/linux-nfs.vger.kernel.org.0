Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B85635FA5B
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 20:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhDNSJq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 14:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351728AbhDNSJD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 14:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618423721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jsnJj+9/9XbK0c0AA4WngcXNll8DiPUseToJ3rpbxjw=;
        b=fR9lyWyibRIO/2p/PQqTarjSE5zi0+Qy00wOdJPRHytAlk01UmKB9rQrDLxKbKSZ9W9VBs
        kZdIb+qjVSrcwefhHUF6rU/oK4WpRzQcLz50JtIHovwjHhovdUA7Pe3TcjRVsNuQcmTqnG
        jlsyNmBuiDRllAAcPbJ+FTCZ7gAbef4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-yrrpW3oLNfmRsrgtEQO0AA-1; Wed, 14 Apr 2021 14:08:34 -0400
X-MC-Unique: yrrpW3oLNfmRsrgtEQO0AA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D38A410054F6
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 18:08:33 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-83.phx2.redhat.com [10.3.112.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FA3760862
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 18:08:33 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 3/3] nfs-utils: Update nfs4_unique_id module parameter from the nfs.conf value
Date:   Wed, 14 Apr 2021 14:10:40 -0400
Message-Id: <20210414181040.7108-4-steved@redhat.com>
In-Reply-To: <20210414181040.7108-1-steved@redhat.com>
References: <20210414181040.7108-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Alice Mitchell <ajmitchell@redhat.com>

systemd service to grab the config value and feed it to the kernel module

Signed-off-by: Alice Mitchell <ajmitchell@redhat.com>
Signed-off-by: Steve Dickson <steved@redhat.com>
---
 configure.ac                  |  1 +
 nfs.conf                      |  4 +++-
 systemd/Makefile.am           |  3 +++
 systemd/nfs-client.target     |  3 +++
 systemd/nfs-conf-export.sh    | 28 ++++++++++++++++++++++++++++
 systemd/nfs-config.service.in | 18 ++++++++++++++++++
 systemd/nfs.conf.man          | 19 ++++++++++++++++++-
 7 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100755 systemd/nfs-conf-export.sh
 create mode 100644 systemd/nfs-config.service.in

diff --git a/configure.ac b/configure.ac
index f2e1bd30..2db7214e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -684,6 +684,7 @@ AC_CONFIG_COMMANDS_PRE([eval eval _sysconfdir=$sysconfdir])
 AC_CONFIG_FILES([
 	Makefile
 	systemd/rpc-gssd.service
+	systemd/nfs-config.service
 	linux-nfs/Makefile
 	support/Makefile
 	support/export/Makefile
diff --git a/nfs.conf b/nfs.conf
index 31994f61..faa58071 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -1,9 +1,11 @@
 #
 # This is a general configuration for the
-# NFS daemons and tools
+# NFS daemons and tools and kernel module parameters
 #
 [general]
 # pipefs-directory=/var/lib/nfs/rpc_pipefs
+[kernel]
+# nfs4_unique_id = [${machine-id} || ${hostname}]
 #
 [exports]
 # rootdir=/export
diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index 650ad25c..c48fc80d 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -9,6 +9,7 @@ unit_files =  \
     nfs-mountd.service \
     nfs-server.service \
     nfs-utils.service \
+    nfs-config.service \
     rpc-statd-notify.service \
     rpc-statd.service \
     \
@@ -75,4 +76,6 @@ genexec_PROGRAMS = nfs-server-generator rpc-pipefs-generator
 install-data-hook: $(unit_files)
 	mkdir -p $(DESTDIR)/$(unitdir)
 	cp $(unit_files) $(DESTDIR)/$(unitdir)
+	mkdir -p $(DESTDIR)/$(libexecdir)/nfs-utils
+	install  nfs-conf-export.sh $(DESTDIR)/$(libexecdir)/nfs-utils/
 endif
diff --git a/systemd/nfs-client.target b/systemd/nfs-client.target
index 8a8300a1..3ca45752 100644
--- a/systemd/nfs-client.target
+++ b/systemd/nfs-client.target
@@ -11,6 +11,9 @@ Wants=rpc-statd-notify.service
 Wants=auth-rpcgss-module.service
 After=rpc-gssd.service rpc-svcgssd.service gssproxy.service
 
+# Run the config settings that are in nfs.conf
+After=nfs-config.service
+
 [Install]
 WantedBy=multi-user.target
 WantedBy=remote-fs.target
diff --git a/systemd/nfs-conf-export.sh b/systemd/nfs-conf-export.sh
new file mode 100755
index 00000000..905ece1b
--- /dev/null
+++ b/systemd/nfs-conf-export.sh
@@ -0,0 +1,28 @@
+#!/bin/bash
+#
+# This script pulls values out of /etc/nfs.conf and configures
+# the appropriate kernel modules which cannot read it directly
+
+NFSMOD=/sys/module/nfs/parameters/nfs4_unique_id
+NFSPROBE=/etc/modprobe.d/nfs.conf
+
+# Now read the values from nfs.conf
+MACHINEID=`nfsconf --get kernel nfs4_unique_id`
+if [ $? -ne 0 ] || [ "$MACHINEID" == "" ]
+then
+# No config value found, nothing to do
+	exit 0
+fi
+
+# Kernel module is already loaded, update the live one
+if [ -e $NFSMOD ]; then
+echo -n "$MACHINEID" >> $NFSMOD
+fi
+
+# Rewrite the modprobe file for next reboot
+echo "# This file is overwritten by systemd nfs-config.service" > $NFSPROBE
+echo "# with values taken from /etc/nfs.conf" >> $NFSPROBE
+echo "# Do not hand modify" >> $NFSPROBE
+echo "options nfs nfs4_unique_id=\"$MACHINEID\"" >> $NFSPROBE
+
+echo "Set to: $MACHINEID"
diff --git a/systemd/nfs-config.service.in b/systemd/nfs-config.service.in
new file mode 100644
index 00000000..08a09a5c
--- /dev/null
+++ b/systemd/nfs-config.service.in
@@ -0,0 +1,18 @@
+[Unit]
+Description=Preprocess NFS configuration
+PartOf=nfs-client.target
+Before=nfs-client.target
+After=local-fs.target
+DefaultDependencies=no
+
+[Service]
+Type=oneshot
+# This service needs to run any time any nfs service
+# is started, so changes to local config files get
+# incorporated.  Having "RemainAfterExit=no" (the default)
+# ensures this happens.
+RemainAfterExit=no
+ExecStart=/usr/libexec/nfs-utils/nfs-conf-export.sh
+
+[Install]
+WantedBy=nfs-client.target
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index 4436a38a..8f073fe5 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -101,7 +101,7 @@ When a list is given, the members should be comma-separated.
 .TP
 .B general
 Recognized values:
-.BR pipefs-directory .
+.BR pipefs-directory.
 
 See
 .BR blkmapd (8),
@@ -148,6 +148,23 @@ is equivalent to providing the
 .B \-\-log\-auth
 option.
 
+.TP
+.B kernel
+.br
+Recognized value:
+.BR nfs4_unique_id .
+
+Setting 
+.B "nfs4_unique_id= ${machine-id}"
+will set the nfs4_unique_id kernel module parameter
+to the systems machine_id (/etc/machine-id)
+.BR
+
+Setting
+.BR "nfs4_unique_id= ${hostname}"
+will set the nfs4_unique_id kernel module parameter
+to the systems hostname (/etc/hostname)
+
 .TP
 .B nfsdcltrack
 Recognized values:
-- 
2.30.2

