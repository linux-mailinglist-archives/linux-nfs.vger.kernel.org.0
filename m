Return-Path: <linux-nfs+bounces-7810-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFDE9C2837
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47B81B22BA2
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F971A9B53;
	Fri,  8 Nov 2024 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaSLmFUS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70C1F7568
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109228; cv=none; b=cfr3PROUCZiew09RAlnfmYqfbtS+pJruSiXQiNBuRt8MfzQOkCmyMkqLPpmH8jXdCWUcUTamaJjnYGWJpWfQZOTMsGZODpHdqejIdswkBL+VOkXtKtl0STbbO0Fn0oehi3LluAZVYpjN2Gv5T3+VRyqgHrgeeTTlpQ8cwMzCUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109228; c=relaxed/simple;
	bh=mhJ74S92bHkgHVyB2t8drBz+1krFb56JlKM6706TYZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQF03vV8leQlPVceK/fxhTvL+GjvNC61wNmZKJvlG1Yc1ubQRpCp+XgQl8kUkgmxjESBm+CPQp+wUkvqwgnZNht/4Ap8lpZAMkqqZcKbV4iWWDtdTT0p/zGGQ2uofECBJa6x3/tcCIRLZzjFeOm7LRPcrO5pt6FQ31YG8D9zlHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaSLmFUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8E9C4CECE;
	Fri,  8 Nov 2024 23:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109228;
	bh=mhJ74S92bHkgHVyB2t8drBz+1krFb56JlKM6706TYZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RaSLmFUS2D9xwayP3+40igwSGpDBqxbVsm4DLpW1GQ2ZLUHW+UYhV24fk579FH+5K
	 2FONETycDWsghQCS3VS/sRvcsrN1y90YgVTjSyaxObbbUlLIH8EHbabavCGb7GjFaM
	 yt2rCkmxePwh+v1tczyGZfRFHE5vwGRP+HnlnkhV+myyg4XKouD0Ahh7N9VGqNlD/p
	 YLFxnlC5Lg3QPvM31e0GzednH0tz+zX1Pa09HSMZRToYRMvkgDOq5ViFP7v12LKrJU
	 INWuLT8jfBI4WbBFh/6acuqPAi1LA3C1/y0o2lUJ/kDGReTnzQOn19vZQxEFHUXnrG
	 2PoHqMW+T/blw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 18/19] nfs: probe for LOCALIO when v4 client reconnects to server
Date: Fri,  8 Nov 2024 18:40:01 -0500
Message-ID: <20241108234002.16392-19-snitzer@kernel.org>
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

Introduce nfs_local_probe_async() for the NFS client to initiate
if/when it reconnects with server.  For NFSv4 it is a simple matter to
call nfs_local_probe_async() from nfs4_do_reclaim (during NFSv4
grace).

[NFSv3 also needs to reestablish LOCALIO if/when a client reconnects
 to server, but the stateless nature of v3 means the implementation is
 more tricky so its been factored out to the following commit.]

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/internal.h         |  2 ++
 fs/nfs/localio.c          | 15 +++++++++++++++
 fs/nfs/nfs4state.c        |  1 +
 include/linux/nfs_fs_sb.h |  1 +
 4 files changed, 19 insertions(+)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 57af3ab3adbe..efd42efd9405 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -456,6 +456,7 @@ extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 /* localio.c */
 extern void nfs_local_disable(struct nfs_client *);
 extern void nfs_local_probe(struct nfs_client *);
+extern void nfs_local_probe_async(struct nfs_client *);
 extern struct nfsd_file *nfs_local_open_fh(struct nfs_client *,
 					   const struct cred *,
 					   struct nfs_fh *,
@@ -473,6 +474,7 @@ extern bool nfs_server_is_local(const struct nfs_client *clp);
 #else /* CONFIG_NFS_LOCALIO */
 static inline void nfs_local_disable(struct nfs_client *clp) {}
 static inline void nfs_local_probe(struct nfs_client *clp) {}
+static inline void nfs_local_probe_async(struct nfs_client *clp) {}
 static inline struct nfsd_file *
 nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		  struct nfs_fh *fh, struct nfs_file_localio *nfl,
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index d10d863aaf23..710e537b3402 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -214,6 +214,21 @@ void nfs_local_probe(struct nfs_client *clp)
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe);
 
+static void nfs_local_probe_async_work(struct work_struct *work)
+{
+	struct nfs_client *clp =
+		container_of(work, struct nfs_client, cl_local_probe_work);
+
+	nfs_local_probe(clp);
+}
+
+void nfs_local_probe_async(struct nfs_client *clp)
+{
+	INIT_WORK(&clp->cl_local_probe_work, nfs_local_probe_async_work);
+	queue_work(nfsiod_workqueue, &clp->cl_local_probe_work);
+}
+EXPORT_SYMBOL_GPL(nfs_local_probe_async);
+
 static inline struct nfsd_file *nfs_local_file_get(struct nfsd_file *nf)
 {
 	return nfs_to->nfsd_file_get(nf);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index dafd61186557..2ebb9ac56b7b 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1957,6 +1957,7 @@ static int nfs4_do_reclaim(struct nfs_client *clp, const struct nfs4_state_recov
 	}
 	rcu_read_unlock();
 	nfs4_free_state_owners(&freeme);
+	nfs_local_probe_async(clp);
 	if (lost_locks)
 		pr_warn("NFS: %s: lost %d locks\n",
 			clp->cl_hostname, lost_locks);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 239d86ef166c..63d7e0f478d8 100644
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


