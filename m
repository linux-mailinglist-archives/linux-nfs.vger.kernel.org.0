Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29B146D839
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Dec 2021 17:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbhLHQee (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Dec 2021 11:34:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234361AbhLHQee (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Dec 2021 11:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638981061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWtfFMhV8ZlHb4H7iomk7wEI0G6PB/8hi+1UIFEVvD4=;
        b=hs9GZudWXfgu+4B+Z1Ii4tDwqgd1gpo7DT+k24t26q4NbvVVq1okLGXwbVETjSy3p9HKaH
        B8NUOYDEid1CPhS6fe140Eu/ieiD2rN0PjBtcMPJ+ze31Y2slc7QKZX3O792jRNcAoGqPY
        htuqX3Aj/f4KsjB/rj9xFq51V0BXM94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-285-F3XaE0U5PrC762keywDi4g-1; Wed, 08 Dec 2021 11:31:00 -0500
X-MC-Unique: F3XaE0U5PrC762keywDi4g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A07591014B4E
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:30:59 +0000 (UTC)
Received: from dobby.home.dicksonnet.net (unknown [10.2.16.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 554652B178
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:30:59 +0000 (UTC)
From:   Steve Dickson <steved@redhat.com>
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH v2 3/3] mount: Remove NFS v2 support from mount.nfs
Date:   Wed,  8 Dec 2021 11:30:57 -0500
Message-Id: <20211208163057.954500-4-steved@redhat.com>
In-Reply-To: <20211208163057.954500-1-steved@redhat.com>
References: <20211208163057.954500-1-steved@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch removes the ability to do NFS v2
mounts. They will now fail with EOPNOTSUPP.

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/mount/configfile.c  |  2 +-
 utils/mount/network.c     |  4 ++--
 utils/mount/nfsmount.conf |  2 +-
 utils/mount/stropts.c     | 10 +++++++++-
 4 files changed, 13 insertions(+), 5 deletions(-)

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
index fa67a66f..3c4e218a 100644
--- a/utils/mount/stropts.c
+++ b/utils/mount/stropts.c
@@ -357,6 +357,7 @@ static int nfs_insert_sloppy_option(struct mount_options *options)
 
 static int nfs_set_version(struct nfsmount_info *mi)
 {
+
 	if (!nfs_nfs_version(mi->type, mi->options, &mi->version))
 		return 0;
 
@@ -1016,7 +1017,6 @@ static int nfs_try_mount(struct nfsmount_info *mi)
 	}
 
 	switch (mi->version.major) {
-		case 2:
 		case 3:
 			result = nfs_try_mount_v3v2(mi, FALSE);
 			break;
@@ -1247,6 +1247,14 @@ static int nfsmount_start(struct nfsmount_info *mi)
 	if (!nfs_validate_options(mi))
 		return EX_FAIL;
 
+	/* 
+	 * NFS v2 has been deprecated
+	 */
+	if (mi->version.major == 2) {
+		mount_error(mi->spec, mi->node, EOPNOTSUPP);
+		return EX_FAIL;
+	}
+
 	/*
 	 * Avoid retry and negotiation logic when remounting
 	 */
-- 
2.31.1

