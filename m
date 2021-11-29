Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3344C46207E
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 20:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhK2Tc4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Nov 2021 14:32:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbhK2Tay (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Nov 2021 14:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638214056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EqtWwlu6DjkxMTUbe9OyrhBywgujYhrkzosPQ+wmSC8=;
        b=RdhzQpXdvp4X4L4Uh7Af00X8WH416w/5ZW8OFjjYJJxQHqptwlPbcKYEvmFhewK8/wBHoh
        RJzd748vVQGESIQrhKdt2I8nRFfcdPtEnejXKwC4DkdBEodkpL+AvX/ScqA4XAEWu0ZkC/
        7Lre/RcL86Ae6J3soyH64y4F5/ci8eo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-4O1ZxaRgNnu1hDJTI7TA4g-1; Mon, 29 Nov 2021 14:27:35 -0500
X-MC-Unique: 4O1ZxaRgNnu1hDJTI7TA4g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44A151015DA1
        for <linux-nfs@vger.kernel.org>; Mon, 29 Nov 2021 19:27:34 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (ovpn-112-138.phx2.redhat.com [10.3.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E49A179452
        for <linux-nfs@vger.kernel.org>; Mon, 29 Nov 2021 19:27:33 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH RFC 3/3] mount: Remove NFS v2 support from mount.nfs
Date:   Mon, 29 Nov 2021 14:27:31 -0500
Message-Id: <20211129192731.783466-4-steved@redhat.com>
In-Reply-To: <20211129192731.783466-1-steved@redhat.com>
References: <20211129192731.783466-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch removes the ability to do NFS v2
mounts. They will now fail with EOPNOTSUPP.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/mount/configfile.c  | 2 +-
 utils/mount/network.c     | 4 ++--
 utils/mount/nfsmount.conf | 2 +-
 utils/mount/stropts.c     | 3 +++
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/utils/mount/configfile.c b/utils/mount/configfile.c
index 3d3684ef..1d88cbfc 100644
--- a/utils/mount/configfile.c
+++ b/utils/mount/configfile.c
@@ -71,7 +71,7 @@ struct mnt_alias {
 int mnt_alias_sz = (sizeof(mnt_alias_tab)/sizeof(mnt_alias_tab[0]));
 
 static const char *version_keys[] = {
-	"v2", "v3", "v4", "vers", "nfsvers", "minorversion", NULL
+	"v3", "v4", "vers", "nfsvers", "minorversion", NULL
 };
 
 static int strict;
diff --git a/utils/mount/network.c b/utils/mount/network.c
index 35261171..bfda5c41 100644
--- a/utils/mount/network.c
+++ b/utils/mount/network.c
@@ -97,7 +97,7 @@ static const char *nfs_transport_opttbl[] = {
 };
 
 static const char *nfs_version_opttbl[] = {
-	"v2",
+	"v2", /* no longer supported */
 	"v3",
 	"v4",
 	"vers",
@@ -1286,7 +1286,7 @@ nfs_nfs_version(char *type, struct mount_options *options, struct nfs_version *v
 	else if (found < 0)
 		return 1;
 	else if (found <= 2 ) {
-		/* v2, v3, v4 */
+		/* v3, v4 */
 		version_val = version_key + 1;
 		version->v_mode = V_SPECIFIC;
 	} else if (found > 2 ) {
diff --git a/utils/mount/nfsmount.conf b/utils/mount/nfsmount.conf
index 6bdc225a..342063f7 100644
--- a/utils/mount/nfsmount.conf
+++ b/utils/mount/nfsmount.conf
@@ -28,7 +28,7 @@
 # This statically named section defines global mount 
 # options that can be applied on all NFS mount.
 #
-# Protocol Version [2,3,4]
+# Protocol Version [3,4]
 # This defines the default protocol version which will
 # be used to start the negotiation with the server.
 # Defaultvers=4
diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
index fa67a66f..f6f0c1d5 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -357,6 +357,7 @@ static int nfs_insert_sloppy_option(struct mount_options *options)
 
 static int nfs_set_version(struct nfsmount_info *mi)
 {
+
 	if (!nfs_nfs_version(mi->type, mi->options, &mi->version))
 		return 0;
 
@@ -1017,6 +1018,8 @@ static int nfs_try_mount(struct nfsmount_info *mi)
 
 	switch (mi->version.major) {
 		case 2:
+			errno = EOPNOTSUPP;
+			break;
 		case 3:
 			result = nfs_try_mount_v3v2(mi, FALSE);
 			break;
-- 
2.31.1

