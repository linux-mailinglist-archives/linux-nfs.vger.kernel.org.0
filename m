Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06FB31FFB1
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Feb 2021 21:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBSUIM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Feb 2021 15:08:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46174 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229862AbhBSUIK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 19 Feb 2021 15:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613765204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YJgva8VIb7R0wtpwx6NfXF+idOe/+K3Eke2LA+rB6H8=;
        b=Z4nEZwSZJjZCrvHJ4hXWqN2vg1etpfjfUwEDFmeYxTVIwF5AFwa6bwpmESUOlOtsLCKkxZ
        2kO/KaFh383n8d2orm6+aj1DCZFA/ZbeGJiSHrlGDFLtxCUB59gGmD4hZ6y873RAsUCW7l
        RAsfcIi0jb5GRMSShX4aonw01etN8lA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-1TLDOl-eNfCNZX8WDD5tSg-1; Fri, 19 Feb 2021 15:06:42 -0500
X-MC-Unique: 1TLDOl-eNfCNZX8WDD5tSg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5B9780402C
        for <linux-nfs@vger.kernel.org>; Fri, 19 Feb 2021 20:06:41 +0000 (UTC)
Received: from madhat.home.dicksonnet.net (ovpn-112-108.phx2.redhat.com [10.3.112.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8402E189C4
        for <linux-nfs@vger.kernel.org>; Fri, 19 Feb 2021 20:06:41 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 7/7] exportd: Added config variable to compile in the NFSv4 only server.
Date:   Fri, 19 Feb 2021 15:08:15 -0500
Message-Id: <20210219200815.792667-8-steved@redhat.com>
In-Reply-To: <20210219200815.792667-1-steved@redhat.com>
References: <20210219200815.792667-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Added the --enable-nfsv4server configuration flag
that will compile/install nfsv4.exportd and
install the systemd unit files.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 configure.ac        | 13 +++++++++++++
 systemd/Makefile.am |  6 +++++-
 utils/Makefile.am   |  3 +++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index ffd6247..40fb802 100644
--- a/configure.ac
+++ b/configure.ac
@@ -257,6 +257,19 @@ AC_ARG_ENABLE(nfsdcltrack,
 	enable_nfsdcltrack=$enableval,
 	enable_nfsdcltrack="yes")
 
+if test "$enable_nfsv4" = yes; then
+AC_ARG_ENABLE(nfsv4server,
+	[AC_HELP_STRING([--enable-nfsv4server],
+			[enable support for NFSv4 only server  @<:@default=no@:>@])],
+	enable_nfsv4server=$enableval,
+	enable_nfsv4server="no")
+	if test "$enable_nfsv4server" = yes; then
+		AC_DEFINE(HAVE_NFSV4SERVER_SUPPORT, 1,
+                          [Define this if you want NFSv4 server only support compiled in])
+	fi
+	AM_CONDITIONAL(CONFIG_NFSV4SERVER, [test "$enable_nfsv4server" = "yes" ])
+fi
+
 dnl Check for TI-RPC library and headers
 AC_LIBTIRPC
 
diff --git a/systemd/Makefile.am b/systemd/Makefile.am
index 5251f23..650ad25 100644
--- a/systemd/Makefile.am
+++ b/systemd/Makefile.am
@@ -17,7 +17,11 @@ unit_files =  \
 
 if CONFIG_NFSV4
 unit_files += \
-    nfs-idmapd.service \
+    nfs-idmapd.service
+endif
+
+if CONFIG_NFSV4SERVER
+unit_files += \
     nfsv4-exportd.service \
     nfsv4-server.service
 endif
diff --git a/utils/Makefile.am b/utils/Makefile.am
index 2a54b90..ab58419 100644
--- a/utils/Makefile.am
+++ b/utils/Makefile.am
@@ -5,6 +5,9 @@ OPTDIRS =
 if CONFIG_NFSV4
 OPTDIRS += idmapd
 OPTDIRS += nfsidmap
+endif
+
+if CONFIG_NFSV4SERVER
 OPTDIRS += exportd
 endif
 
-- 
2.29.2

