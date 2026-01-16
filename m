Return-Path: <linux-nfs+bounces-18059-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB133D388F7
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 22:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CB4F301CF9D
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C44301004;
	Fri, 16 Jan 2026 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5kRvf0U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC4A30C601
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600301; cv=none; b=S2bDQK1Lx7vuIQyZ2DvAVas/xDvxAsRdb9xXAsHWQJXugifXzd05geJzcH6mnQmRRUg75mrWddxwdVBHxKadoQNdATFFFah8ctzkAKtEjTX/V+t6PCbxnJUtc0m+qChI+bCLV0u9q8N9IIxM8iBXUZov+Jd9ejPyHYhtZmF57C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600301; c=relaxed/simple;
	bh=uyI3MizaylZkSXQ91BBhAPQ5d2aFMnhS5+9NNpVDXPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTo5HoBkFWsfDXiiTNm2NT5cv8wSfZPKxpp2FvWAYDuR9EjMlEaQe3+W5m/PAOSecPBG+/H8g86O9HFzJMyb048HV1+EOeHR58/niTI5u9reF4oH8bmMeTsyA69fI1q60QNPi5MQHHWn0rPYKlABbgT35CWaxI+/srLgrLoiYY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5kRvf0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D4FC116C6;
	Fri, 16 Jan 2026 21:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768600301;
	bh=uyI3MizaylZkSXQ91BBhAPQ5d2aFMnhS5+9NNpVDXPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G5kRvf0UYo2rKHXszdLVyG1Un9S5i6X/DCBaqCnF586NEpnI8rpzK5GTobcJAA5sn
	 u23Xjkum/ifXk7ghXliRJhD1W/HsqerWBOrzAfJDMNU2XR4UEZJzAwxM7MPFddhz1v
	 uTCL4+RMIoSBuNbRSsGhiRw6EGDAtnIjn6LOJoJsWgr9k7dfuXW+S29H3r4hXFRN1f
	 3NaciPQOp489SZMG8wvN3KOKj6/79xjZ+VwKTX8gyM72OffL85O2lHYiZjtUNf5Jc7
	 XYbN6A+tRRhRMWVYL2vIO2mu2mpGpeRHmLMAiBNaKESD8i4T+wGXf3CfvE+UNKqe39
	 UU5t9amgDoeMA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 09/14] NFS: Move nfs40_init_client into nfs40client.c
Date: Fri, 16 Jan 2026 16:51:30 -0500
Message-ID: <20260116215135.846062-10-anna@kernel.org>
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
 fs/nfs/nfs40client.c | 27 +++++++++++++++++++++++++++
 fs/nfs/nfs4_fs.h     |  1 -
 fs/nfs/nfs4client.c  | 27 ---------------------------
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/nfs/nfs40.h b/fs/nfs/nfs40.h
index 9369bb08825a..5a9c5d367b12 100644
--- a/fs/nfs/nfs40.h
+++ b/fs/nfs/nfs40.h
@@ -5,6 +5,7 @@
 
 /* nfs40client.c */
 void nfs40_shutdown_client(struct nfs_client *);
+int nfs40_init_client(struct nfs_client *);
 
 /* nfs40proc.c */
 extern const struct nfs4_minor_version_ops nfs_v4_0_minor_ops;
diff --git a/fs/nfs/nfs40client.c b/fs/nfs/nfs40client.c
index 8397d75a2f46..b0719403495d 100644
--- a/fs/nfs/nfs40client.c
+++ b/fs/nfs/nfs40client.c
@@ -53,6 +53,33 @@ void nfs40_shutdown_client(struct nfs_client *clp)
 	}
 }
 
+/**
+ * nfs40_init_client - nfs_client initialization tasks for NFSv4.0
+ * @clp: nfs_client to initialize
+ *
+ * Returns zero on success, or a negative errno if some error occurred.
+ */
+int nfs40_init_client(struct nfs_client *clp)
+{
+	struct nfs4_slot_table *tbl;
+	int ret;
+
+	tbl = kzalloc(sizeof(*tbl), GFP_NOFS);
+	if (tbl == NULL)
+		return -ENOMEM;
+
+	ret = nfs4_setup_slot_table(tbl, NFS4_MAX_SLOT_TABLE,
+					"NFSv4.0 transport Slot table");
+	if (ret) {
+		nfs4_shutdown_slot_table(tbl);
+		kfree(tbl);
+		return ret;
+	}
+
+	clp->cl_slot_tbl = tbl;
+	return 0;
+}
+
 /**
  * nfs40_walk_client_list - Find server that recognizes a client ID
  *
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 3a81a658e5d2..9d0bec3a23f3 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -483,7 +483,6 @@ extern const u32 nfs4_fsinfo_bitmap[3];
 extern const u32 nfs4_fs_locations_bitmap[3];
 
 void nfs41_shutdown_client(struct nfs_client *);
-int nfs40_init_client(struct nfs_client *);
 int nfs41_init_client(struct nfs_client *);
 void nfs4_free_client(struct nfs_client *);
 
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index d83a8a2a3c70..c376b2420b6c 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -331,33 +331,6 @@ static int nfs4_init_callback(struct nfs_client *clp)
 	return 0;
 }
 
-/**
- * nfs40_init_client - nfs_client initialization tasks for NFSv4.0
- * @clp: nfs_client to initialize
- *
- * Returns zero on success, or a negative errno if some error occurred.
- */
-int nfs40_init_client(struct nfs_client *clp)
-{
-	struct nfs4_slot_table *tbl;
-	int ret;
-
-	tbl = kzalloc(sizeof(*tbl), GFP_NOFS);
-	if (tbl == NULL)
-		return -ENOMEM;
-
-	ret = nfs4_setup_slot_table(tbl, NFS4_MAX_SLOT_TABLE,
-					"NFSv4.0 transport Slot table");
-	if (ret) {
-		nfs4_shutdown_slot_table(tbl);
-		kfree(tbl);
-		return ret;
-	}
-
-	clp->cl_slot_tbl = tbl;
-	return 0;
-}
-
 #if defined(CONFIG_NFS_V4_1)
 
 /**
-- 
2.52.0


