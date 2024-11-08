Return-Path: <linux-nfs+bounces-7794-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043449C2826
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7423284977
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FFB1F26E0;
	Fri,  8 Nov 2024 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgEUYWcr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385391E1C07
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109207; cv=none; b=rMqPi2MxrufGzCo9OWjqoVi2jInj75lbW3W0a3w49cjDEHwa9gEHOG1tpB3uC2nxqfvpaG0gQZoHSiikTfCa0KDV35kYvzkkYzkRvHCyVVBcMvr1D0LneRcD3tjzBKZu/yPKoU8fXn6yMzZ+sIDZQOIeFwaHJVpdi0ya8hL4nGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109207; c=relaxed/simple;
	bh=GaGEV7rWDTrwTF45V3pFKioiq3NFJqACq5nBjidSw9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQCuOr164e3zq5sM/MNkqkJP4NDA7Fuu103rgK2wsMnV4BHrIX66Sg9tbcbrAIrpygwlu18lMkXeNLWGTA6PL+hzoNAfXXgTvw1scoWkhCG14aVRqYDWzTCE+hlkkqwZ7yeA7WYiCTIrGa+u8uX/Gub7q1EIj/yp62aPEl3qx5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgEUYWcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856F6C4CED2;
	Fri,  8 Nov 2024 23:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109206;
	bh=GaGEV7rWDTrwTF45V3pFKioiq3NFJqACq5nBjidSw9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgEUYWcr3W7r8HSGRPru6lT8qMVrD8ZORAqkLCxO/MDe4ZdFf177Shj5eUF7osKX0
	 Xo7KD8yXN/i6M31+YYTZi6qE2zWFJOy6EJjHLpzE01AkIzQb3k3pi5jckXtThM6Kie
	 bRmG3RlGO+5Y9obLORWZKsq9lOJIgrBEUo7qK70qxSjW+v2YlHLNNiSWSLyIHHY+qJ
	 DIjAeKpphJUZYfe8wFQlvorKOGyvOuq4hnBoL4oBTmQJhQZ90Usg95kITFX070nzf3
	 RQuFu9166V6nbFDF0AnaGLnyZiDldlIBTUrYAgK8iKxuBlN2XoULW2BhzNYNkSHVEr
	 Zf2Vv8MK5v8aA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 02/19] nfs_common: must not hold RCU while calling nfsd_file_put_local
Date: Fri,  8 Nov 2024 18:39:45 -0500
Message-ID: <20241108234002.16392-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241108234002.16392-1-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move holding the RCU from nfs_to_nfsd_file_put_local to
nfs_to_nfsd_net_put.  It is the call to nfs_to->nfsd_serv_put that
requires the RCU anyway (the puts for nfsd_file and netns were
combined to avoid an extra indirect reference but that
micro-optimization isn't possible now).

This fixes xfstests generic/013 and it triggering:

"Voluntary context switch within RCU read-side critical section!"

[  143.545738] Call Trace:
[  143.546206]  <TASK>
[  143.546625]  ? show_regs+0x6d/0x80
[  143.547267]  ? __warn+0x91/0x140
[  143.547951]  ? rcu_note_context_switch+0x496/0x5d0
[  143.548856]  ? report_bug+0x193/0x1a0
[  143.549557]  ? handle_bug+0x63/0xa0
[  143.550214]  ? exc_invalid_op+0x1d/0x80
[  143.550938]  ? asm_exc_invalid_op+0x1f/0x30
[  143.551736]  ? rcu_note_context_switch+0x496/0x5d0
[  143.552634]  ? wakeup_preempt+0x62/0x70
[  143.553358]  __schedule+0xaa/0x1380
[  143.554025]  ? _raw_spin_unlock_irqrestore+0x12/0x40
[  143.554958]  ? try_to_wake_up+0x1fe/0x6b0
[  143.555715]  ? wake_up_process+0x19/0x20
[  143.556452]  schedule+0x2e/0x120
[  143.557066]  schedule_preempt_disabled+0x19/0x30
[  143.557933]  rwsem_down_read_slowpath+0x24d/0x4a0
[  143.558818]  ? xfs_efi_item_format+0x50/0xc0 [xfs]
[  143.559894]  down_read+0x4e/0xb0
[  143.560519]  xlog_cil_commit+0x1b2/0xbc0 [xfs]
[  143.561460]  ? _raw_spin_unlock+0x12/0x30
[  143.562212]  ? xfs_inode_item_precommit+0xc7/0x220 [xfs]
[  143.563309]  ? xfs_trans_run_precommits+0x69/0xd0 [xfs]
[  143.564394]  __xfs_trans_commit+0xb5/0x330 [xfs]
[  143.565367]  xfs_trans_roll+0x48/0xc0 [xfs]
[  143.566262]  xfs_defer_trans_roll+0x57/0x100 [xfs]
[  143.567278]  xfs_defer_finish_noroll+0x27a/0x490 [xfs]
[  143.568342]  xfs_defer_finish+0x1a/0x80 [xfs]
[  143.569267]  xfs_bunmapi_range+0x4d/0xb0 [xfs]
[  143.570208]  xfs_itruncate_extents_flags+0x13d/0x230 [xfs]
[  143.571353]  xfs_free_eofblocks+0x12e/0x190 [xfs]
[  143.572359]  xfs_file_release+0x12d/0x140 [xfs]
[  143.573324]  __fput+0xe8/0x2d0
[  143.573922]  __fput_sync+0x1d/0x30
[  143.574574]  nfsd_filp_close+0x33/0x60 [nfsd]
[  143.575430]  nfsd_file_free+0x96/0x150 [nfsd]
[  143.576274]  nfsd_file_put+0xf7/0x1a0 [nfsd]
[  143.577104]  nfsd_file_put_local+0x18/0x30 [nfsd]
[  143.578070]  nfs_close_local_fh+0x101/0x110 [nfs_localio]
[  143.579079]  __put_nfs_open_context+0xc9/0x180 [nfs]
[  143.580031]  nfs_file_clear_open_context+0x4a/0x60 [nfs]
[  143.581038]  nfs_file_release+0x3e/0x60 [nfs]
[  143.581879]  __fput+0xe8/0x2d0
[  143.582464]  __fput_sync+0x1d/0x30
[  143.583108]  __x64_sys_close+0x41/0x80
[  143.583823]  x64_sys_call+0x189a/0x20d0
[  143.584552]  do_syscall_64+0x64/0x170
[  143.585240]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  143.586185] RIP: 0033:0x7f3c5153efd7

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs_common/nfslocalio.c |  8 +++-----
 fs/nfsd/filecache.c        | 14 +++++++-------
 fs/nfsd/filecache.h        |  2 +-
 include/linux/nfslocalio.h | 18 +++++++++++++++---
 4 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 09404d142d1a..a74ec08f6c96 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -155,11 +155,9 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 	/* We have an implied reference to net thanks to nfsd_serv_try_get */
 	localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
 					     cred, nfs_fh, fmode);
-	if (IS_ERR(localio)) {
-		rcu_read_lock();
-		nfs_to->nfsd_serv_put(net);
-		rcu_read_unlock();
-	}
+	if (IS_ERR(localio))
+		nfs_to_nfsd_net_put(net);
+
 	return localio;
 }
 EXPORT_SYMBOL_GPL(nfs_open_local_fh);
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index c16671135d17..9a62b4da89bb 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -391,19 +391,19 @@ nfsd_file_put(struct nfsd_file *nf)
 }
 
 /**
- * nfsd_file_put_local - put the reference to nfsd_file and local nfsd_serv
- * @nf: nfsd_file of which to put the references
+ * nfsd_file_put_local - put nfsd_file reference and arm nfsd_serv_put in caller
+ * @nf: nfsd_file of which to put the reference
  *
- * First put the reference of the nfsd_file and then put the
- * reference to the associated nn->nfsd_serv.
+ * First save the associated net to return to caller, then put
+ * the reference of the nfsd_file.
  */
-void
-nfsd_file_put_local(struct nfsd_file *nf) __must_hold(rcu)
+struct net *
+nfsd_file_put_local(struct nfsd_file *nf)
 {
 	struct net *net = nf->nf_net;
 
 	nfsd_file_put(nf);
-	nfsd_serv_put(net);
+	return net;
 }
 
 /**
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index cadf3c2689c4..d5db6b34ba30 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -55,7 +55,7 @@ void nfsd_file_cache_shutdown(void);
 int nfsd_file_cache_start_net(struct net *net);
 void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
-void nfsd_file_put_local(struct nfsd_file *nf);
+struct net *nfsd_file_put_local(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 struct file *nfsd_file_file(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 3982fea79919..9202f4b24343 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -55,7 +55,7 @@ struct nfsd_localio_operations {
 						const struct cred *,
 						const struct nfs_fh *,
 						const fmode_t);
-	void (*nfsd_file_put_local)(struct nfsd_file *);
+	struct net *(*nfsd_file_put_local)(struct nfsd_file *);
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
 } ____cacheline_aligned;
 
@@ -66,7 +66,7 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *,
 		   struct rpc_clnt *, const struct cred *,
 		   const struct nfs_fh *, const fmode_t);
 
-static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
+static inline void nfs_to_nfsd_net_put(struct net *net)
 {
 	/*
 	 * Once reference to nfsd_serv is dropped, NFSD could be
@@ -74,10 +74,22 @@ static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
 	 * by always taking RCU.
 	 */
 	rcu_read_lock();
-	nfs_to->nfsd_file_put_local(localio);
+	nfs_to->nfsd_serv_put(net);
 	rcu_read_unlock();
 }
 
+static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
+{
+	/*
+	 * Must not hold RCU otherwise nfsd_file_put() can easily trigger:
+	 * "Voluntary context switch within RCU read-side critical section!"
+	 * by scheduling deep in underlying filesystem (e.g. XFS).
+	 */
+	struct net *net = nfs_to->nfsd_file_put_local(localio);
+
+	nfs_to_nfsd_net_put(net);
+}
+
 #else   /* CONFIG_NFS_LOCALIO */
 static inline void nfsd_localio_ops_init(void)
 {
-- 
2.44.0


