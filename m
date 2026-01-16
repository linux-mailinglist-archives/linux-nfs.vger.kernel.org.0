Return-Path: <linux-nfs+bounces-18058-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED10D38900
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 22:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 724E830F48A2
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2467530B535;
	Fri, 16 Jan 2026 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/8uh2cV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2114306B0A
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600301; cv=none; b=jQVeHumg0wW8MuZBtR9TLXdYpwWnSaOHzMSqAzkof0GAs8btFeF5aA4zVmpvdIqO0b3KIxn1tEFNKzrcKYDoEyRkbOYUnScsbdw6uave4GQ7un1XGGPbciWbS3cJwsaPoGP1GAG0V9bZcbjTaxjok5ZF5v7zlbIxG/UoyHaoNxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600301; c=relaxed/simple;
	bh=nY9k9G4Ixr2DZoRqnpiW0z/MI/BtTiN+CMvIkLH9j/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoBaImevaPf1aJMvUK7Ud6wLFakeCcbIP4tdk9S4Jm8/GLDUL1j5IJYc2QlxMSohB4lF43W2pr5rmn3doBy2iCOHzGFxY31nq1Plam48ZOE6wM4KHrtyot7LQ9Wf2L1QG0ooiDEsGV9oAWQMMTC9pL42AD9lXpaDDb351S11dsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/8uh2cV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96082C2BC86;
	Fri, 16 Jan 2026 21:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768600300;
	bh=nY9k9G4Ixr2DZoRqnpiW0z/MI/BtTiN+CMvIkLH9j/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/8uh2cV8RiZys/JZ0gBH1rCG+r08rW6Qd6Zm5CRGazM5vaRCHEdCEVVZG+yNoDW0
	 qVxOgOqYqVR2VBTe8G+F/LhQAQCbqygUXcUWpOhufnfQ6ofbde09cb2VdVJREl93zt
	 oFKqWBgF767XWbZGhX4Enop+0ia66Mjf7YrlssUdSfQt/JaH6fFNL8KqOdeBxeKc+3
	 MtYQJ7DipqjdKB4t3cXdnDH+ckbtk1NhQKROYxtBfdGx1E5jt+mKjbknS0dLpa4g7x
	 l5Dn+16DAfmgFeJcZE1+WhEjdejtaI9JHPOnvjhHfdWzboSCcEIp3SRnn6LBKA8c/t
	 43X6N/blbY9Zw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 08/14] NFS: Move nfs40_shutdown_client into nfs40client.c
Date: Fri, 16 Jan 2026 16:51:29 -0500
Message-ID: <20260116215135.846062-9-anna@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116215135.846062-1-anna@kernel.org>
References: <20260116215135.846062-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/nfs40.h       | 3 +++
 fs/nfs/nfs40client.c | 9 +++++++++
 fs/nfs/nfs40proc.c   | 1 +
 fs/nfs/nfs4_fs.h     | 1 -
 fs/nfs/nfs4client.c  | 8 --------
 5 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/nfs40.h b/fs/nfs/nfs40.h
index 272e1ffdb161..9369bb08825a 100644
--- a/fs/nfs/nfs40.h
+++ b/fs/nfs/nfs40.h
@@ -3,6 +3,9 @@
 #define __LINUX_FS_NFS_NFS4_0_H
 
 
+/* nfs40client.c */
+void nfs40_shutdown_client(struct nfs_client *);
+
 /* nfs40proc.c */
 extern const struct nfs4_minor_version_ops nfs_v4_0_minor_ops;
 
diff --git a/fs/nfs/nfs40client.c b/fs/nfs/nfs40client.c
index bab073b6506b..8397d75a2f46 100644
--- a/fs/nfs/nfs40client.c
+++ b/fs/nfs/nfs40client.c
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/nfs_fs.h>
 #include "nfs4_fs.h"
+#include "nfs4session.h"
 #include "callback.h"
 #include "internal.h"
 #include "netns.h"
@@ -44,6 +45,14 @@ static bool nfs4_same_verifier(nfs4_verifier *v1, nfs4_verifier *v2)
 	return memcmp(v1->data, v2->data, sizeof(v1->data)) == 0;
 }
 
+void nfs40_shutdown_client(struct nfs_client *clp)
+{
+	if (clp->cl_slot_tbl) {
+		nfs4_shutdown_slot_table(clp->cl_slot_tbl);
+		kfree(clp->cl_slot_tbl);
+	}
+}
+
 /**
  * nfs40_walk_client_list - Find server that recognizes a client ID
  *
diff --git a/fs/nfs/nfs40proc.c b/fs/nfs/nfs40proc.c
index 5968a3318d14..0399e2e68c6b 100644
--- a/fs/nfs/nfs40proc.c
+++ b/fs/nfs/nfs40proc.c
@@ -5,6 +5,7 @@
 #include <linux/nfs_fs.h>
 #include "internal.h"
 #include "nfs4_fs.h"
+#include "nfs40.h"
 #include "nfs4trace.h"
 
 static void nfs40_call_sync_prepare(struct rpc_task *task, void *calldata)
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 18f04906c5fa..3a81a658e5d2 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -482,7 +482,6 @@ extern const u32 nfs4_pathconf_bitmap[3];
 extern const u32 nfs4_fsinfo_bitmap[3];
 extern const u32 nfs4_fs_locations_bitmap[3];
 
-void nfs40_shutdown_client(struct nfs_client *);
 void nfs41_shutdown_client(struct nfs_client *);
 int nfs40_init_client(struct nfs_client *);
 int nfs41_init_client(struct nfs_client *);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 517cf8af2943..d83a8a2a3c70 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -189,14 +189,6 @@ void nfs41_shutdown_client(struct nfs_client *clp)
 }
 #endif	/* CONFIG_NFS_V4_1 */
 
-void nfs40_shutdown_client(struct nfs_client *clp)
-{
-	if (clp->cl_slot_tbl) {
-		nfs4_shutdown_slot_table(clp->cl_slot_tbl);
-		kfree(clp->cl_slot_tbl);
-	}
-}
-
 struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 {
 	char buf[INET6_ADDRSTRLEN + 1];
-- 
2.52.0


