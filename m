Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF7C43E47F
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Oct 2021 16:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhJ1PCM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Oct 2021 11:02:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230258AbhJ1PCL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Oct 2021 11:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635433183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WpLhrC/wdnOqPhrIvTQ+YAMlEtXdrb0vtlCrcbompYs=;
        b=J3nkb6/aZfYrdoJgZlq3kXAaxriZjLhconhpZsgX8GGDLUevFiSIT4Ejbx+9x/cS4poZL9
        xbXijRfUxKcKoXwBNhJxaQyzd70PjpxA7YCJiAroHDdeGUD/yfDLiGOcNzEfIe5k2PLzwA
        +OJwuC/Fzor4Uto6ROzJV6Y2+cmmvJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-2ZN_qtb_Ora8vk9H3foyxA-1; Thu, 28 Oct 2021 10:59:42 -0400
X-MC-Unique: 2ZN_qtb_Ora8vk9H3foyxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56D761023F4E
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 14:59:41 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (ovpn-114-186.phx2.redhat.com [10.3.114.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C7C35C1C5
        for <linux-nfs@vger.kernel.org>; Thu, 28 Oct 2021 14:59:40 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH 1/1] exportfs: Add the 's2sc' option allowing inter server to server copies
Date:   Thu, 28 Oct 2021 10:59:39 -0400
Message-Id: <20211028145939.644286-2-steved@redhat.com>
In-Reply-To: <20211028145939.644286-1-steved@redhat.com>
References: <20211028145939.644286-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The new export will enable inter server to server
copies on that particular export on the destination
server

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 support/include/nfs/export.h |  1 +
 support/nfs/exports.c        |  5 +++++
 utils/exportfs/exportfs.c    |  2 ++
 utils/exportfs/exports.man   | 14 ++++++++++++++
 4 files changed, 22 insertions(+)

diff --git a/support/include/nfs/export.h b/support/include/nfs/export.h
index 0eca828e..e563e7aa 100644
--- a/support/include/nfs/export.h
+++ b/support/include/nfs/export.h
@@ -28,6 +28,7 @@
 #define NFSEXP_NOACL		0x8000 /* reserved for possible ACL related use */
 #define NFSEXP_V4ROOT		0x10000
 #define NFSEXP_PNFS            0x20000
+#define NFSEXP_S2SC            0x40000
 /*
  * All flags supported by the kernel before addition of the
  * export_features interface:
diff --git a/support/nfs/exports.c b/support/nfs/exports.c
index 2c8f0752..7abc3e09 100644
--- a/support/nfs/exports.c
+++ b/support/nfs/exports.c
@@ -297,6 +297,7 @@ putexportent(struct exportent *ep)
 	if (ep->e_flags & NFSEXP_SECURITY_LABEL)
 		fprintf(fp, "security_label,");
 	fprintf(fp, "%spnfs,", (ep->e_flags & NFSEXP_PNFS)? "" : "no_");
+	fprintf(fp, "%ss2sc,", (ep->e_flags & NFSEXP_S2SC)? "" : "no_");
 	if (ep->e_flags & NFSEXP_FSID) {
 		fprintf(fp, "fsid=%d,", ep->e_fsid);
 	}
@@ -616,6 +617,10 @@ parseopts(char *cp, struct exportent *ep, int warn, int *had_subtree_opt_ptr)
 			setflags(NFSEXP_PNFS, active, ep);
 		else if (!strcmp(opt, "no_pnfs"))
 			clearflags(NFSEXP_PNFS, active, ep);
+		else if (!strcmp(opt, "s2sc"))
+			setflags(NFSEXP_S2SC, active, ep);
+		else if (!strcmp(opt, "no_s2sc"))
+			clearflags(NFSEXP_S2SC, active, ep);
 		else if (strncmp(opt, "anonuid=", 8) == 0) {
 			char *oe;
 			ep->e_anonuid = strtol(opt+8, &oe, 10);
diff --git a/utils/exportfs/exportfs.c b/utils/exportfs/exportfs.c
index 6ba615d1..1180d2e7 100644
--- a/utils/exportfs/exportfs.c
+++ b/utils/exportfs/exportfs.c
@@ -715,6 +715,8 @@ dump(int verbose, int export_format)
 				c = dumpopt(c, "no_acl");
 			if (ep->e_flags & NFSEXP_PNFS)
 				c = dumpopt(c, "pnfs");
+			if (ep->e_flags & NFSEXP_S2SC)
+				c = dumpopt(c, "s2sc");
 			if (ep->e_flags & NFSEXP_FSID)
 				c = dumpopt(c, "fsid=%d", ep->e_fsid);
 			if (ep->e_uuid)
diff --git a/utils/exportfs/exports.man b/utils/exportfs/exports.man
index 54b3f877..6c54d8a7 100644
--- a/utils/exportfs/exports.man
+++ b/utils/exportfs/exports.man
@@ -420,6 +420,20 @@ will only work if all clients use a consistent security policy.  Note
 that early kernels did not support this export option, and instead
 enabled security labels by default.
 
+.TP
+.IR s2sc
+This option enables inter server to server 
+copy on the export. The client will initiate
+the file copy with source server. The client
+will initiate the copy with destination server.
+This option will allow that initiation to be
+successful, allowing the copy to occur between
+the servers.
+
+This type of copy can be enable system-wide
+by enabling the inter_copy_offload_enable
+parameter.
+
 .SS User ID Mapping
 .PP
 .B nfsd
-- 
2.31.1

