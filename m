Return-Path: <linux-nfs+bounces-11693-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B762AB595E
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 18:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868143B9832
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 16:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E172BEC2A;
	Tue, 13 May 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVzAoj8v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0493A14A8B
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152513; cv=none; b=OvNyoXDBkXmJQrfLVnpozbVkInmYIIHbv1EoMtVTsI2Lg21MArD/8L4EqOAwyiuknROIKxOZQzmJmdag4kP1h91zpRQFT10TDctEBEfODv9Wb9/1oNgM6tG0elOXXQ2n/taLB9Ug2yP3ZMz60KJGgq7n+hUf3+XCk32R2Np2ddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152513; c=relaxed/simple;
	bh=37sJthC8Beru//pr+IQheG69RNByOl/NV12JIrbsZ3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZGzcgdZAhUdBdyTtXaxPjpXgneFzlaN89gGdqxRxnrwwzgvqzhh3MIISiNmv2BWal13iJa/d+AZHuBQfQkbCCmLxMtnA4Vf5zajBp9fxq4on0TC6psrUcVC1+pcmuzLSX1FfM1PfZzLXbuBp3C4RJtkbA2gk8FTtR+mkb8WMCsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVzAoj8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51422C4CEEF;
	Tue, 13 May 2025 16:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747152512;
	bh=37sJthC8Beru//pr+IQheG69RNByOl/NV12JIrbsZ3w=;
	h=From:To:Cc:Subject:Date:From;
	b=gVzAoj8v8oLV0ytZ0SYV39J5O5qQLU24eAfnx8eMyr9qdgVLB3/93Vpxo3OT58vXj
	 DFR+dWW+HFCIKzb38dl1f8rnjDG4EC9lhu8MGmHqtstdvb68h7bMUc9g3Qx14LZYdM
	 +O85JhWkGLtGyntgLmwAcy6OQn/3LcPvljLvz3XI1G3UkEPjyJrjZN6o1qI8ROFvx8
	 Lr4yMmC2En/8hWIG5Gxh2dV9+h1FxeOIlt35MDIJkHrHSmK0dLzaBc9ObjGV3gcE11
	 9P30dfsCdvZkNqljiD9EEQgxpUmPbqmQDuB0nWRPnySSLhuPu5Uu3hpTko5RHQ51Ax
	 5CxPD45+0VPrA==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@hammerspace.com>,
	anna@kernel.org
Cc: jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: always probe for LOCALIO support asynchronously
Date: Tue, 13 May 2025 12:08:31 -0400
Message-ID: <20250513160831.19997-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was reported that NFS client mounts of AWS Elastic File System
(EFS) volumes is slow, this is because the AWS firewall disallows
LOCALIO (because it doesn't consider the use of NFS_LOCALIO_PROGRAM
valid), see: https://bugzilla.redhat.com/show_bug.cgi?id=2335129

Switch to performing the LOCALIO probe asynchronously to address the
potential for the NFS LOCALIO protocol being disallowed and/or slowed
by the remote server's response.

While at it, fix nfs_local_probe_async() to always take/put a
reference on the nfs_client that is using the LOCALIO protocol.
Also, unexport the nfs_local_probe() symbol and make it private to
fs/nfs/localio.c

This change has the side-effect of initially issuing reads, writes and
commits over the wire via SUNRPC until the LOCALIO probe completes.

Suggested-by: Jeff Layton <jlayton@kernel.org> # to always probe async
Fixes: 76d4cb6345da ("nfs: probe for LOCALIO when v4 client reconnects to server")
Cc: stable@vger.kernel.org # 6.14+
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/client.c                           | 2 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 2 +-
 fs/nfs/internal.h                         | 1 -
 fs/nfs/localio.c                          | 6 ++++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 6d63b958c4bb..d8fe7c0e7e05 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -439,7 +439,7 @@ struct nfs_client *nfs_get_client(const struct nfs_client_initdata *cl_init)
 			spin_unlock(&nn->nfs_client_lock);
 			new = rpc_ops->init_client(new, cl_init);
 			if (!IS_ERR(new))
-				 nfs_local_probe(new);
+				 nfs_local_probe_async(new);
 			return new;
 		}
 
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index 4a304cf17c4b..656d5c50bbce 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -400,7 +400,7 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 		 * keep ds_clp even if DS is local, so that if local IO cannot
 		 * proceed somehow, we can fall back to NFS whenever we want.
 		 */
-		nfs_local_probe(ds->ds_clp);
+		nfs_local_probe_async(ds->ds_clp);
 		max_payload =
 			nfs_block_size(rpc_max_payload(ds->ds_clp->cl_rpcclient),
 				       NULL);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 6655e5f32ec6..69c2c10ee658 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -455,7 +455,6 @@ extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 /* localio.c */
-extern void nfs_local_probe(struct nfs_client *);
 extern void nfs_local_probe_async(struct nfs_client *);
 extern void nfs_local_probe_async_work(struct work_struct *);
 extern struct nfsd_file *nfs_local_open_fh(struct nfs_client *,
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 4ec952f9f47d..a4bacd9a5052 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -171,7 +171,7 @@ static bool nfs_server_uuid_is_local(struct nfs_client *clp)
  * - called after alloc_client and init_client (so cl_rpcclient exists)
  * - this function is idempotent, it can be called for old or new clients
  */
-void nfs_local_probe(struct nfs_client *clp)
+static void nfs_local_probe(struct nfs_client *clp)
 {
 	/* Disallow localio if disabled via sysfs or AUTH_SYS isn't used */
 	if (!localio_enabled ||
@@ -191,14 +191,16 @@ void nfs_local_probe(struct nfs_client *clp)
 		nfs_localio_enable_client(clp);
 	nfs_uuid_end(&clp->cl_uuid);
 }
-EXPORT_SYMBOL_GPL(nfs_local_probe);
 
 void nfs_local_probe_async_work(struct work_struct *work)
 {
 	struct nfs_client *clp =
 		container_of(work, struct nfs_client, cl_local_probe_work);
 
+	if (!refcount_inc_not_zero(&clp->cl_count))
+		return;
 	nfs_local_probe(clp);
+	nfs_put_client(clp);
 }
 
 void nfs_local_probe_async(struct nfs_client *clp)
-- 
2.44.0


