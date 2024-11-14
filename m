Return-Path: <linux-nfs+bounces-7965-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EADBC9C81A4
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 05:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7362837CD
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 04:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891E513D53E;
	Thu, 14 Nov 2024 04:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqiV/jXe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F6B1E9076
	for <linux-nfs@vger.kernel.org>; Thu, 14 Nov 2024 04:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556812; cv=none; b=NCnr2lG2tD8TTt2SEoSW24XSyNw+m3V+LEkR0ctSbsZC3fEwjoyNmbl0LQe/EMSLyyCpj8hNlqFalWBcp+JEnG8esdtza8DlzVci6CvMLaa2e8+foMxskMoywfw+oFpHSBlGU25dJyzaAcGWNDnUs9cF8zDAZP67h0j+cjlBbO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556812; c=relaxed/simple;
	bh=h4sYR9GOomMUsWtu+kr79Nc160k0fnqRMvT+m4WeMDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9xBxwp92hgKN4VX1MFfMDDz7pMJYs9rdbNWxYJmZgCfJhuROm2+1Uem1ImwPR5E3DX4LNXsyK6zT/zWR4NLXEKfvBzBxwWl1XjEqYj4b+2OmhfEtxDz5U8YlrMLU8lNC42UlEasQy6tphKKbHlVp3jkWLifQn1gaHEDL2OFydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqiV/jXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F307C4CED0;
	Thu, 14 Nov 2024 04:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731556812;
	bh=h4sYR9GOomMUsWtu+kr79Nc160k0fnqRMvT+m4WeMDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZqiV/jXeKNHS6MWKrhItwDneWjgzFTOmcD8xupAqq/uYGUmQQAH/i9xd14/GSyvhJ
	 cq661ai2SxQ98whPDeGy7Q5m1UiEYdwaortKUkCj7XeoJ+ORSBjDlGLJSA+Nt19WYe
	 39Z+XxP6756PfMi35IplXk01obkrTuz2nHDDqzRSAwu0Nv7X93BdwOI/TLzWwY4yd2
	 ei348xO7ulUz3Oh3/4/Nv0ZjMZSslegFoiLjTkDUf0dz3EUyuuyy1kAu8tKFg7G7zP
	 dQkyi0Ss20MDiAwjKDDHxgyMVzOEnEj5WMuJKICZ3XrqOw8RYSKPxqMtziZSB+n9XW
	 WZHiAyrL4nyuA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v2 14/15] nfs: probe for LOCALIO when v4 client reconnects to server
Date: Wed, 13 Nov 2024 22:59:51 -0500
Message-ID: <20241114035952.13889-15-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241114035952.13889-1-snitzer@kernel.org>
References: <20241114035952.13889-1-snitzer@kernel.org>
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
index a657318fede46..9765aad6e3dab 100644
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
index 239d86ef166c0..63d7e0f478d89 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -132,6 +132,7 @@ struct nfs_client {
 	struct timespec64	cl_nfssvc_boot;
 	seqlock_t		cl_boot_lock;
 	nfs_uuid_t		cl_uuid;
+	struct work_struct	cl_local_probe_work;
 #endif /* CONFIG_NFS_LOCALIO */
 };
 
-- 
2.44.0


