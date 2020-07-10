Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E689B21BB3C
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2020 18:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGJQoN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jul 2020 12:44:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24636 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727031AbgGJQoN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jul 2020 12:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594399451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yeb+RZv1xYQtYICll/cRVg75bIL08GNuV0mDaHvQlEg=;
        b=SG4D1UAypU5ypLT78h4zrTbR9F3hKFtL4eSUdN57AJ+JzTXiL6KT2D29otZiZ7OSoz/3H9
        II4zvO6ZI5WGzcHZGC/AfwUtHJz2fqtOrfFSFkF+VBT9hFUBQj5+Pl0pXHkiiD/bO05NxR
        DpMyyiA6fsuiSaPuv80BZwPIfsiXrDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-xpekWpHEMGiwUX8SPSEgZA-1; Fri, 10 Jul 2020 12:44:08 -0400
X-MC-Unique: xpekWpHEMGiwUX8SPSEgZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 361E8100AA2E
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jul 2020 16:44:07 +0000 (UTC)
Received: from ovpn-112-86.ams2.redhat.com (ovpn-112-86.ams2.redhat.com [10.36.112.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D39674F56;
        Fri, 10 Jul 2020 16:44:06 +0000 (UTC)
Message-ID: <115d8b45e84f3cecc9f5623e39f5078315d3ebbd.camel@redhat.com>
Subject: [PATCH 4/4] nfs-utils: Update nfs4_unique_id module parameter from
 the nfs.conf value
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc:     Steve Dickson <steved@redhat.com>
Date:   Fri, 10 Jul 2020 17:44:04 +0100
In-Reply-To: <5a84777afb9ed8c866841471a1a7e3c9b295604d.camel@redhat.com>
References: <5a84777afb9ed8c866841471a1a7e3c9b295604d.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

systemd service to grab the config value and feed it to the kernel module
---
 nfs.conf                      |  1 +
 systemd/Makefile.am           |  3 +++
 systemd/nfs-conf-export.sh    | 28 ++++++++++++++++++++++++++++
 systemd/nfs-config.service.in | 17 +++++++++++++++++
 4 files changed, 49 insertions(+)
 create mode 100755 systemd/nfs-conf-export.sh
 create mode 100644 systemd/nfs-config.service.in

diff --git a/nfs.conf b/nfs.conf
index 186a5b19..8bb41227 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -4,6 +4,7 @@
 #
 [general]
 # pipefs-directory=/var/lib/nfs/rpc_pipefs
+# nfs4_unique_id = ${machine-id}
 #
 [exports]
 # rootdir=/export
diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index 75cdd9f5..51acdc3f 100644
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
@@ -69,4 +70,6 @@ genexec_PROGRAMS = nfs-server-generator rpc-pipefs-generator
 install-data-hook: $(unit_files)
 	mkdir -p $(DESTDIR)/$(unitdir)
 	cp $(unit_files) $(DESTDIR)/$(unitdir)
+	mkdir -p $(DESTDIR)/$(libexecdir)/nfs-utils
+	install  nfs-conf-export.sh $(DESTDIR)/$(libexecdir)/nfs-utils/
 endif
diff --git a/systemd/nfs-conf-export.sh b/systemd/nfs-conf-export.sh
new file mode 100755
index 00000000..486e8df9
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
+MACHINEID=`nfsconf --get general nfs4_unique_id`
+if [ $? -ne 0 ] || [ "$MACHINEID" == "" ]
+then
+# No config vaue found, assume blank
+MACHINEID=""
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
index 00000000..c5ef1024
--- /dev/null
+++ b/systemd/nfs-config.service.in
@@ -0,0 +1,17 @@
+[Unit]
+Description=Preprocess NFS configuration
+PartOf=nfs-client.target
+After=nfs-client.target
+DefaultDependencies=no
+
+[Service]
+Type=oneshot
+# This service needs to run any time any nfs service
+# is started, so changes to local config files get
+# incorporated.  Having "RemainAfterExit=no" (the default)
+# ensures this happens.
+RemainAfterExit=no
+ExecStart=@_libexecdir@/nfs-utils/nfs-conf-export.sh
+
+[Install]
+WantedBy=nfs-client.target
-- 
2.18.1


