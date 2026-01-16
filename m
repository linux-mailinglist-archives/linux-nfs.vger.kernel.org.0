Return-Path: <linux-nfs+bounces-18060-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C561BD38901
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 22:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BD7C30FA37E
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D2B30B51E;
	Fri, 16 Jan 2026 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQdJS74f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF4330B528
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600302; cv=none; b=fdaevlBsIiu103mw0HNMP284ME5i0MmQ0gi73X9JI9BafeP0WH9n7RdHpI6yHjQ183HAYcFNErtK66/gDK3sY8ySL727rpxRv9EqZzZt8JwpystFEndWFL3hf26Eg4y2rTbrBA+sdKF7mgElM1xtJeeqKzkFYgW1ZBZYy1pYoSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600302; c=relaxed/simple;
	bh=F0pZPilCdTYcYY+Wjt4vMmT3t2Kif+FSqMxSLDp5T8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePr17wkDAXZsKvPl5RgoTUa86Z0Cn8Bo34x7c10lGbnpvVgms3TTDB76TARN2VMdY76illptl2kdKjXa9YmBK5o04Rwomka0Is2C8UUHLBR6zAydV35VCrAREgod8XU1a+w8+eN2W5V/1JKYjG91bVxfiui8gUIViIXcWqefhz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQdJS74f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CE4C19423;
	Fri, 16 Jan 2026 21:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768600301;
	bh=F0pZPilCdTYcYY+Wjt4vMmT3t2Kif+FSqMxSLDp5T8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQdJS74fTWKx4LvBoJDhQsa0VFHEOn14vmr9g3STtKXF8Y5xavjDaXzVmlrvLEW9/
	 rUx5zJRIYNFegyaTfEwlfSDGWoy2qLRZfuzpYZX1VHiEqI7gZ/9scQln4d/vsqjLz7
	 7pFuLhGeqzDGMm7UDcUY3WfVVa0jpiG3hA39ub/Psj2y5gnbh6ZYzrHnxQlIZ+Yl3y
	 9ZoWcRw4ssLsYkBhDGNiWTFteYenaYzdtNjQugVGyILK3eSsxo2Si09w1UgAbSX7fm
	 RRMTRgoZy6+PNgRRGbAab/UrryQwdc7cakIuay4Jrkvww3NsLmNZyqj2i1X+jsWTRW
	 4pfAbwH4SrWMw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 10/14] NFS: Move NFS v4.0 pathdown recovery into nfs40client.c
Date: Fri, 16 Jan 2026 16:51:31 -0500
Message-ID: <20260116215135.846062-11-anna@kernel.org>
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
 fs/nfs/nfs40.h       |  1 +
 fs/nfs/nfs40client.c | 23 +++++++++++++++++++++++
 fs/nfs/nfs4state.c   | 23 +----------------------
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/nfs40.h b/fs/nfs/nfs40.h
index 5a9c5d367b12..ee09aac738c8 100644
--- a/fs/nfs/nfs40.h
+++ b/fs/nfs/nfs40.h
@@ -6,6 +6,7 @@
 /* nfs40client.c */
 void nfs40_shutdown_client(struct nfs_client *);
 int nfs40_init_client(struct nfs_client *);
+void nfs40_handle_cb_pathdown(struct nfs_client *clp);
 
 /* nfs40proc.c */
 extern const struct nfs4_minor_version_ops nfs_v4_0_minor_ops;
diff --git a/fs/nfs/nfs40client.c b/fs/nfs/nfs40client.c
index b0719403495d..0f88e7cbdc5e 100644
--- a/fs/nfs/nfs40client.c
+++ b/fs/nfs/nfs40client.c
@@ -3,6 +3,7 @@
 #include "nfs4_fs.h"
 #include "nfs4session.h"
 #include "callback.h"
+#include "delegation.h"
 #include "internal.h"
 #include "netns.h"
 #include "nfs40.h"
@@ -80,6 +81,28 @@ int nfs40_init_client(struct nfs_client *clp)
 	return 0;
 }
 
+/*
+ * nfs40_handle_cb_pathdown - return all delegations after NFS4ERR_CB_PATH_DOWN
+ * @clp: client to process
+ *
+ * Set the NFS4CLNT_LEASE_EXPIRED state in order to force a
+ * resend of the SETCLIENTID and hence re-establish the
+ * callback channel. Then return all existing delegations.
+ */
+void nfs40_handle_cb_pathdown(struct nfs_client *clp)
+{
+	set_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state);
+	nfs_expire_all_delegations(clp);
+	dprintk("%s: handling CB_PATHDOWN recovery for server %s\n", __func__,
+			clp->cl_hostname);
+}
+
+void nfs4_schedule_path_down_recovery(struct nfs_client *clp)
+{
+	nfs40_handle_cb_pathdown(clp);
+	nfs4_schedule_state_manager(clp);
+}
+
 /**
  * nfs40_walk_client_list - Find server that recognizes a client ID
  *
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 5eaa45fd69ea..c7ee5318b660 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -54,6 +54,7 @@
 #include <linux/sunrpc/clnt.h>
 
 #include "nfs4_fs.h"
+#include "nfs40.h"
 #include "callback.h"
 #include "delegation.h"
 #include "internal.h"
@@ -1294,28 +1295,6 @@ int nfs4_client_recover_expired_lease(struct nfs_client *clp)
 	return ret;
 }
 
-/*
- * nfs40_handle_cb_pathdown - return all delegations after NFS4ERR_CB_PATH_DOWN
- * @clp: client to process
- *
- * Set the NFS4CLNT_LEASE_EXPIRED state in order to force a
- * resend of the SETCLIENTID and hence re-establish the
- * callback channel. Then return all existing delegations.
- */
-static void nfs40_handle_cb_pathdown(struct nfs_client *clp)
-{
-	set_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state);
-	nfs_expire_all_delegations(clp);
-	dprintk("%s: handling CB_PATHDOWN recovery for server %s\n", __func__,
-			clp->cl_hostname);
-}
-
-void nfs4_schedule_path_down_recovery(struct nfs_client *clp)
-{
-	nfs40_handle_cb_pathdown(clp);
-	nfs4_schedule_state_manager(clp);
-}
-
 static int nfs4_state_mark_reclaim_reboot(struct nfs_client *clp, struct nfs4_state *state)
 {
 
-- 
2.52.0


