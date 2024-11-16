Return-Path: <linux-nfs+bounces-8030-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8057C9CFC49
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 02:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C171B2AB76
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 01:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A6819146E;
	Sat, 16 Nov 2024 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fobKJeWW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95486191461
	for <linux-nfs@vger.kernel.org>; Sat, 16 Nov 2024 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731721288; cv=none; b=XWYP2lsJE4vAZfzD82D269tFvNicxCnNBvr/H01i0mNN/uS4cw7Q29HJWaIsRrmMJNPlFXMguL0kKWFH2TfdEMlaub2ppltYZ3qBUUHcFOvmeSE2oGfhWBIQUc5LGEgznXDGSpF4SdJmh07NBI2MZIFLv3pi5vI/Ztvi4uZNLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731721288; c=relaxed/simple;
	bh=L5wfPCaLJjPkFgVurR8XaDemDeVNvwFRQ66h8WHTcH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgZOJPesHEQ9lfVCs7IfjZRyaHUZopJUKz1GWOz4JT8I48bgFuzooK4dt9LMjukog+ekRXgEYJ/w9MCnG8NdCtLaMVWsje6dx272BUh3Heu3Jb+FZRJXFFGjm8SXb4bmpJEd1xV8vi7MjRxBcsFfyRkb1EKz1/H+I7mK+cvJnTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fobKJeWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1360C4CED7;
	Sat, 16 Nov 2024 01:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731721286;
	bh=L5wfPCaLJjPkFgVurR8XaDemDeVNvwFRQ66h8WHTcH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fobKJeWWvWWPlKi2KXuUqnxsTQmDl7I4cqhtxOZonexh7GUkApkkn/qZnOGcNFtA2
	 r08p/MiTnBDeVVS9Zr49ybYhhHKzrYuZIeFKL4L35edQCWEoQG6FLZdRwQ9WL3PkbP
	 yTA0e+WrNQD4SC7Zg2o7YOiPYGmmCxZzeYH6RsPdDnXKWKU0Hqj+RRPkI5zlFM6KE5
	 UHD2Vo68r4RdgRNroBWV5ZRSIN8Ptp2E9xSJa8OoSGE/Jbv/hYRFfnpIVItnkxXaEa
	 aPR8yOmc9wSV65oagm3hLX59fLYCfV/CuuAAscAHqBxRf6hB5FS1HYhhTcq0Rd4mmB
	 ta+dUAcd9rGWg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v3 13/14] nfs: probe for LOCALIO when v4 client reconnects to server
Date: Fri, 15 Nov 2024 20:41:05 -0500
Message-ID: <20241116014106.25456-14-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241116014106.25456-1-snitzer@kernel.org>
References: <20241116014106.25456-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce nfs_local_probe_async() for the NFS client to initiate
if/when it reconnects with server. For NFSv4 it is a simple matter to
call nfs_local_probe_async() from nfs4_do_reclaim (during NFSv4
grace).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/client.c           |  1 +
 fs/nfs/internal.h         |  3 +++
 fs/nfs/localio.c          | 14 ++++++++++++++
 fs/nfs/nfs4state.c        |  1 +
 include/linux/nfs_fs_sb.h |  1 +
 5 files changed, 20 insertions(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 16530c71fd152..3b0918ade53cd 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -186,6 +186,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	seqlock_init(&clp->cl_boot_lock);
 	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
 	nfs_uuid_init(&clp->cl_uuid);
+	INIT_WORK(&clp->cl_local_probe_work, nfs_local_probe_async_work);
 #endif /* CONFIG_NFS_LOCALIO */
 
 	clp->cl_principal = "*";
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index a252191b9335c..ad9c56bc977bf 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -455,6 +455,8 @@ extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 /* localio.c */
 extern void nfs_local_probe(struct nfs_client *);
+extern void nfs_local_probe_async(struct nfs_client *);
+extern void nfs_local_probe_async_work(struct work_struct *);
 extern struct nfsd_file *nfs_local_open_fh(struct nfs_client *,
 					   const struct cred *,
 					   struct nfs_fh *,
@@ -471,6 +473,7 @@ extern bool nfs_server_is_local(const struct nfs_client *clp);
 
 #else /* CONFIG_NFS_LOCALIO */
 static inline void nfs_local_probe(struct nfs_client *clp) {}
+static inline void nfs_local_probe_async(struct nfs_client *clp) {}
 static inline struct nfsd_file *
 nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		  struct nfs_fh *fh, struct nfs_file_localio *nfl,
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 4b6bf4ea7d7fc..1eee5aac28843 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -193,6 +193,20 @@ void nfs_local_probe(struct nfs_client *clp)
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe);
 
+void nfs_local_probe_async_work(struct work_struct *work)
+{
+	struct nfs_client *clp =
+		container_of(work, struct nfs_client, cl_local_probe_work);
+
+	nfs_local_probe(clp);
+}
+
+void nfs_local_probe_async(struct nfs_client *clp)
+{
+	queue_work(nfsiod_workqueue, &clp->cl_local_probe_work);
+}
+EXPORT_SYMBOL_GPL(nfs_local_probe_async);
+
 static inline struct nfsd_file *nfs_local_file_get(struct nfsd_file *nf)
 {
 	return nfs_to->nfsd_file_get(nf);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 9a9f60a2291b4..542cdf71229fe 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1955,6 +1955,7 @@ static int nfs4_do_reclaim(struct nfs_client *clp, const struct nfs4_state_recov
 	}
 	rcu_read_unlock();
 	nfs4_free_state_owners(&freeme);
+	nfs_local_probe_async(clp);
 	if (lost_locks)
 		pr_warn("NFS: %s: lost %d locks\n",
 			clp->cl_hostname, lost_locks);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index ed66df1093e89..f00bfcee7120e 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -131,6 +131,7 @@ struct nfs_client {
 	struct timespec64	cl_nfssvc_boot;
 	seqlock_t		cl_boot_lock;
 	nfs_uuid_t		cl_uuid;
+	struct work_struct	cl_local_probe_work;
 #endif /* CONFIG_NFS_LOCALIO */
 };
 
-- 
2.44.0


