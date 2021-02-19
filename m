Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2FD31FFB3
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 21:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBSUIO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 15:08:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230014AbhBSUIL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 15:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613765205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NzQQb8nP4MSONXmH6WTKRS6V21jggC4bDPddfn6VaX0=;
        b=EIoFLuLt+9Dd9OkWkJ0JudF9NkeXYCYoLFUEqJ778Ig8lueZ7s96JafF3K7I9ugQzd1USQ
        nZ5Ws+toiLfUDBHHQLbC0AVre0H8Km9Axt/PaAAiy9i5WWt5S2+78SvnKpKpCCoVRHx2m0
        Xo7IbAV0TlbQyunIwL0GmIpg2fwW2WE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-UATHkmA5OMqrrtUVoSJAYw-1; Fri, 19 Feb 2021 15:06:42 -0500
X-MC-Unique: UATHkmA5OMqrrtUVoSJAYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60E20804023
        for <linux-nfs@vger.kernel.org>; Fri, 19 Feb 2021 20:06:41 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (ovpn-112-108.phx2.redhat.com [10.3.112.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E48C189C4
        for <linux-nfs@vger.kernel.org>; Fri, 19 Feb 2021 20:06:41 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 6/7] exportd: systemd unit files
Date:   Fri, 19 Feb 2021 15:08:14 -0500
Message-Id: <20210219200815.792667-7-steved@redhat.com>
In-Reply-To: <20210219200815.792667-1-steved@redhat.com>
References: <20210219200815.792667-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Created two new systemd unit services
based on nfs-mountd and nfs-service

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 systemd/Makefile.am           |  4 +++-
 systemd/nfsv4-exportd.service | 12 ++++++++++++
 systemd/nfsv4-server.service  | 31 +++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 systemd/nfsv4-exportd.service
 create mode 100644 systemd/nfsv4-server.service

diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index 75cdd9f..5251f23 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -17,7 +17,9 @@ unit_files =  \
 
 if CONFIG_NFSV4
 unit_files += \
-    nfs-idmapd.service
+    nfs-idmapd.service \
+    nfsv4-exportd.service \
+    nfsv4-server.service
 endif
 
 if CONFIG_NFSV41
diff --git a/systemd/nfsv4-exportd.service b/systemd/nfsv4-exportd.service
new file mode 100644
index 0000000..11d663a
--- /dev/null
+++ b/systemd/nfsv4-exportd.service
@@ -0,0 +1,12 @@
+[Unit]
+Description=NFSv4 Mount Daemon
+DefaultDependencies=no
+Requires=proc-fs-nfsd.mount
+Wants=network-online.target
+After=proc-fs-nfsd.mount
+After=network-online.target local-fs.target
+BindsTo=nfsv4-server.service
+
+[Service]
+Type=forking
+ExecStart=/usr/sbin/nfsv4.exportd
diff --git a/systemd/nfsv4-server.service b/systemd/nfsv4-server.service
new file mode 100644
index 0000000..6497568
--- /dev/null
+++ b/systemd/nfsv4-server.service
@@ -0,0 +1,31 @@
+[Unit]
+Description=NFSv4 server and services
+DefaultDependencies=no
+Requires=network.target proc-fs-nfsd.mount
+Requires=nfsv4-exportd.service
+Wants=network-online.target
+Wants=nfs-idmapd.service
+Wants=nfsdcld.service
+
+After=network-online.target local-fs.target
+After=proc-fs-nfsd.mount nfsv4-exportd.service
+After=nfs-idmapd.service
+After=nfsdcld.service
+
+# GSS services dependencies and ordering
+Wants=auth-rpcgss-module.service
+After=rpc-gssd.service gssproxy.service rpc-svcgssd.service
+
+[Service]
+Type=oneshot
+RemainAfterExit=yes
+ExecStartPre=-/usr/sbin/exportfs -r
+ExecStart=/usr/sbin/rpc.nfsd -N 3
+ExecStop=/usr/sbin/rpc.nfsd 0
+ExecStopPost=/usr/sbin/exportfs -au
+ExecStopPost=/usr/sbin/exportfs -f
+
+ExecReload=-/usr/sbin/exportfs -r
+
+[Install]
+WantedBy=multi-user.target
-- 
2.29.2

