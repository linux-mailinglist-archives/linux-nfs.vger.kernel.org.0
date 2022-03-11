Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9764D68F3
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Mar 2022 20:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351073AbiCKTIs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Mar 2022 14:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351080AbiCKTIq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Mar 2022 14:08:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF01F4ECCB
        for <linux-nfs@vger.kernel.org>; Fri, 11 Mar 2022 11:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647025660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fBJs7SaLaOuVPjkP5j1dbtF7vVu9lC6LDsocaKc5yFQ=;
        b=f+zt9RBTLHQjBr1sB1XbR6xIVMmT7WlP/9AY097yu1HpXo3G26sFSBkbaKsBLE1nZ7hF6Q
        g3qh//IJDVK8aS9lL2Sd+dYo+Wsw9DvFU635qGsRtfUVZDr+eJ4NxXyxRplhseTJDXIv1x
        hXpkw3WXswMJFNfacUv1JjVQXyb8g9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-yeO4DIdzNpaHEMFS_Wkb6Q-1; Fri, 11 Mar 2022 14:07:37 -0500
X-MC-Unique: yeO4DIdzNpaHEMFS_Wkb6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3C151854E27;
        Fri, 11 Mar 2022 19:07:36 +0000 (UTC)
Received: from nyarly.rlyeh.local (ovpn-116-72.gru2.redhat.com [10.97.116.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 80DF160BF4;
        Fri, 11 Mar 2022 19:07:10 +0000 (UTC)
From:   Thiago Becker <tbecker@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     steved@redhat.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, kolga@netapp.com,
        Thiago Becker <tbecker@redhat.com>
Subject: [RFC v2 PATCH 7/7] readahead: documentation
Date:   Fri, 11 Mar 2022 16:06:17 -0300
Message-Id: <20220311190617.3294919-8-tbecker@redhat.com>
In-Reply-To: <20220311190617.3294919-1-tbecker@redhat.com>
References: <20220311190617.3294919-1-tbecker@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1946283
Signed-off-by: Thiago Becker <tbecker@redhat.com>
---
 tools/nfs-readahead-udev/Makefile.am          |  2 +
 .../nfs-readahead-udev/nfs-readahead-udev.man | 47 +++++++++++++++++++
 tools/nfs-readahead-udev/readahead.conf       | 14 ++++++
 3 files changed, 63 insertions(+)
 create mode 100644 tools/nfs-readahead-udev/nfs-readahead-udev.man

diff --git a/tools/nfs-readahead-udev/Makefile.am b/tools/nfs-readahead-udev/Makefile.am
index 010350aa..eaa9b90e 100644
--- a/tools/nfs-readahead-udev/Makefile.am
+++ b/tools/nfs-readahead-udev/Makefile.am
@@ -10,6 +10,8 @@ udev_rules_DATA = 99-nfs_bdi.rules
 ra_confdir = $(sysconfdir)
 ra_conf_DATA = readahead.conf
 
+man5_MANS = nfs-readahead-udev.man
+
 99-nfs_bdi.rules: 99-nfs_bdi.rules.in $(builddefs)
 	$(SED) "s|_libexecdir_|@libexecdir@|g" 99-nfs_bdi.rules.in > $@
 
diff --git a/tools/nfs-readahead-udev/nfs-readahead-udev.man b/tools/nfs-readahead-udev/nfs-readahead-udev.man
new file mode 100644
index 00000000..2477d5b3
--- /dev/null
+++ b/tools/nfs-readahead-udev/nfs-readahead-udev.man
@@ -0,0 +1,47 @@
+.\" Manpage for nfs-readahead-udev.
+.nh
+.ad l
+.TH man 5 "08 Mar 2022" "1.0" "nfs-readahead-udev man page"
+.SH NAME
+
+nfs-readahead-udev \- Find the readahead for a given NFS mount
+
+.SH SYNOPSIS
+
+nfs-readahead-udev <device>
+
+.SH DESCRIPTION
+
+\fInfs-readahead-udev\fR is a tool intended to be used with udev to set the \fIread_ahead_kb\fR parameter of NFS mounts, according to the configuration file (see \fICONFIGURATION\fR). \fIdevice\fR is the device number for the NFS backing device as provided by the kernel.
+
+.SH CONFIGURATION
+
+The configuration file (\fI/etc/readahead.conf\fR) contains the readahead configuration, and is formatted as follows.
+
+<LINES> ::= <LINES> <LINE> | <LINE>
+
+<LINE> ::= <TOKENS> <ENDL>
+
+<TOKENS> ::= <TOKENS> <TOKEN> | <TOKEN>
+
+<TOKEN> ::= default | <PAIR>
+
+<PAIR> ::= mountpoint = <mountpoint> | fstype = <nfs|nfs4> | readahead = <readahead>
+
+\fImountpoint\fR is the path in the system where the file system is mounted.
+
+\fIreadahead\fR is an integer to readahead.
+
+\fIfstype\fR is either \fInfs\fR or \fInfs4\fR. 
+
+.SH SEE ALSO
+
+mount.nfs(8), nfs(5), udev(7), bcc-readahead(8)
+
+.SH BUGS
+
+No known bugs.
+
+.SH AUTHOR
+
+Thiago Rafael Becker <trbecker@gmail.com>
diff --git a/tools/nfs-readahead-udev/readahead.conf b/tools/nfs-readahead-udev/readahead.conf
index 988b30c7..bce830f1 100644
--- a/tools/nfs-readahead-udev/readahead.conf
+++ b/tools/nfs-readahead-udev/readahead.conf
@@ -1 +1,15 @@
+# nfs-readahead-udev configuration file.
+#
+# This file configures the readahead for nfs mounts when those are anounced by the kernel.
+# The file is composed on lines that can contain either the default configuration (applied to
+# any nfs mount that does not match any of the other lines) or a combination of
+#   mountpoint=<mountpoint> where mountpoint is the mount point for the file system
+#   fstype=<nfs|nfs4> specifies that this configuration should only apply to a specific nfs
+#     version.
+# Every line must contain a readahead option, with the expected readahead value.
 default				readahead=128
+
+# mountpoint=/mnt		readahead=4194304
+# fstype=nfs			readahead=4194304
+# fstype=nfs4			readahead=4194304
+# mountpoint=/mnt	fstype=nfs4	readahead=4194304
-- 
2.35.1

