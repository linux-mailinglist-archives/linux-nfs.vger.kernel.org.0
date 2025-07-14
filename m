Return-Path: <linux-nfs+bounces-13013-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 408FCB034D3
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 05:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F453B5A7E
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 03:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F3D1E1DE7;
	Mon, 14 Jul 2025 03:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGIUCZmN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BE92E3713
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752462844; cv=none; b=LARaniS10Sp0yk4LIUWJiufSMkuQHHV11TYb1dftz3lyYywuZjTyMsbbKIjdGAoTNBs4i4X5Xd0lq3V0efRQRmSY5Y0RKvjJZ6dNRo06ue2xnxx/Ven1d/upfk5gZZtzUzTVP6M99WBvKcJjpVXGxuoYLgU37MUGQ4bw+bJ6WKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752462844; c=relaxed/simple;
	bh=MMiuommjO/bsxvyRTnBiKh43tQReKHeoHzE50/VF1HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpxOHJxNUU0tEDX9BqRbDmPjWzgAS4hRAwpLEGOOMxhItQUVXbJ/yExhgXgOHaKA0ryRpmhIVmRRkz9K57oeV6gZFv2s5v6qbIw/g20GMVI79J/bqsw7LS3J/HuV0Ax8hrA5e3NqslASeGNMZgjFId427TG4ewfB2oMGqaLTjps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGIUCZmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D77C4CEE3;
	Mon, 14 Jul 2025 03:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752462843;
	bh=MMiuommjO/bsxvyRTnBiKh43tQReKHeoHzE50/VF1HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vGIUCZmNwSB9KzFxQ51TQiqS+bsIvFJFZT9eDeS+/MLo/eE1SEfUSreARfEIhWmRD
	 7yqGKMvSm/KRDn80fqi+T2J6KhL1ys90Ur+yLoxYe/2c3QvLICi0dvB9dHtDJ9tmsF
	 D1zLn/TA5jZbP2/pZskOvYQ0RxKAk+AeNAAny4Po5SjBxi/rLXdA2R7zXmbupU7OoG
	 Dh4vlVFSc83mV9lMv230dRlZl21DERFoMUbDDYZCPlB0FWH0XTpfcPNFkdsI44KMvK
	 M1oTE22S5sU2/N3Ps73tjp0H1WDFhNI/ut2FHMVKRjPDNmloAawEqbO/L4jsZ3slne
	 Id66nbHN060BA==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org
Subject: [for-6.16-final PATCH 2/9] Revert "nfs_localio: change nfsd_file_put_local() to take a pointer to __rcu pointer"
Date: Sun, 13 Jul 2025 23:13:52 -0400
Message-ID: <20250714031359.10192-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250714031359.10192-1-snitzer@kernel.org>
References: <20250714031359.10192-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

This reverts commit c25a89770d1f ("nfs_localio: change
nfsd_file_put_local() to take a pointer to __rcu pointer") because it
has been determined as the cause for nfsd_shutdown_net() hanging
waiting for percpu_ref_exit(&nn->nfsd_net_ref) during shutdown _after_
running a simple LOCALIO test with fio, e.g.:

  fio --nrfiles=3 --filesize=1000m --cpus_allowed_policy=split
  --group_reporting --rw=read --bs=47008 --numjobs=3 --iodepth=16
  --runtime=20 --time_based --loops=1 --ioengine=libaio --direct=1
  --verify_dump=1 --invalidate=1 --randrepeat=1 --exitall --name
  task_share1 --filename=/mnt/share1/a.test

NOTE: commit c25a89770d1f contained hunks that should've been included
in commit e6f7e1487ab5 ("nfs_localio: simplify interface to nfsd for
getting nfsd_file").  So this revert fixes the associated breakage,
but in general it means that LOCALIO is not bisect-safe.

This commit also reverts commit 1c14d71928ef ("NFSD: Clean up kdoc for
nfsd_file_put_local()") which was a fix for commit c25a89770d1f.

Fixes: 1c14d71928ef ("NFSD: Clean up kdoc for nfsd_file_put_local()")
Fixes: c25a89770d1f ("nfs_localio: change nfsd_file_put_local() to take a pointer to __rcu pointer")
Fixes: e6f7e1487ab5 ("nfs_localio: simplify interface to nfsd for getting nfsd_file")
Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfs/localio.c           | 11 ++---------
 fs/nfs_common/nfslocalio.c | 24 ++++++++++++++++++------
 fs/nfsd/filecache.c        | 13 ++++---------
 fs/nfsd/filecache.h        |  2 +-
 include/linux/nfslocalio.h | 19 ++++++++-----------
 5 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 510d0a16cfe9..ef12dd279539 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -209,16 +209,9 @@ void nfs_local_probe_async(struct nfs_client *clp)
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe_async);
 
-static inline void nfs_local_file_put(struct nfsd_file *localio)
+static inline void nfs_local_file_put(struct nfsd_file *nf)
 {
-	/* nfs_to_nfsd_file_put_local() expects an __rcu pointer
-	 * but we have a __kernel pointer.  It is always safe
-	 * to cast a __kernel pointer to an __rcu pointer
-	 * because the cast only weakens what is known about the pointer.
-	 */
-	struct nfsd_file __rcu *nf = (struct nfsd_file __rcu*) localio;
-
-	nfs_to_nfsd_file_put_local(&nf);
+	nfs_to_nfsd_file_put_local(nf);
 }
 
 /*
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 05c7c16e37ab..1dd5a8cca064 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -170,6 +170,9 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 	while ((nfl = list_first_entry_or_null(&nfs_uuid->files,
 					       struct nfs_file_localio,
 					       list)) != NULL) {
+		struct nfsd_file *ro_nf;
+		struct nfsd_file *rw_nf;
+
 		/* If nfs_uuid is already NULL, nfs_close_local_fh is
 		 * closing and we must wait, else we unlink and close.
 		 */
@@ -186,14 +189,17 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 			continue;
 		}
 
+		ro_nf = unrcu_pointer(xchg(&nfl->ro_file, NULL));
+		rw_nf = unrcu_pointer(xchg(&nfl->rw_file, NULL));
+
 		/* Remove nfl from nfs_uuid->files list */
 		list_del_init(&nfl->list);
 		spin_unlock(&nfs_uuid->lock);
-
-		nfs_to_nfsd_file_put_local(&nfl->ro_file);
-		nfs_to_nfsd_file_put_local(&nfl->rw_file);
+		if (ro_nf)
+			nfs_to_nfsd_file_put_local(ro_nf);
+		if (rw_nf)
+			nfs_to_nfsd_file_put_local(rw_nf);
 		cond_resched();
-
 		spin_lock(&nfs_uuid->lock);
 		/* Now we can allow racing nfs_close_local_fh() to
 		 * skip the locking.
@@ -297,6 +303,8 @@ EXPORT_SYMBOL_GPL(nfs_open_local_fh);
 
 void nfs_close_local_fh(struct nfs_file_localio *nfl)
 {
+	struct nfsd_file *ro_nf;
+	struct nfsd_file *rw_nf;
 	nfs_uuid_t *nfs_uuid;
 
 	rcu_read_lock();
@@ -329,8 +337,12 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 	spin_unlock(&nfs_uuid->lock);
 	rcu_read_unlock();
 
-	nfs_to_nfsd_file_put_local(&nfl->ro_file);
-	nfs_to_nfsd_file_put_local(&nfl->rw_file);
+	ro_nf = unrcu_pointer(xchg(&nfl->ro_file, NULL));
+	rw_nf = unrcu_pointer(xchg(&nfl->rw_file, NULL));
+	if (ro_nf)
+		nfs_to_nfsd_file_put_local(ro_nf);
+	if (rw_nf)
+		nfs_to_nfsd_file_put_local(rw_nf);
 
 	/* Remove nfl from nfs_uuid->files list and signal nfs_uuid_put()
 	 * that we are done.  The moment we drop the spinlock the
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 91a7ae7db9cc..06150dd171be 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -375,22 +375,17 @@ nfsd_file_put(struct nfsd_file *nf)
 
 /**
  * nfsd_file_put_local - put nfsd_file reference and arm nfsd_net_put in caller
- * @pnf: nfsd_file of which to put the reference
+ * @nf: nfsd_file of which to put the reference
  *
  * First save the associated net to return to caller, then put
  * the reference of the nfsd_file.
  */
 struct net *
-nfsd_file_put_local(struct nfsd_file __rcu **pnf)
+nfsd_file_put_local(struct nfsd_file *nf)
 {
-	struct nfsd_file *nf;
-	struct net *net = NULL;
+	struct net *net = nf->nf_net;
 
-	nf = unrcu_pointer(xchg(pnf, NULL));
-	if (nf) {
-		net = nf->nf_net;
-		nfsd_file_put(nf);
-	}
+	nfsd_file_put(nf);
 	return net;
 }
 
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 237a05c74211..d41428ce8a11 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -66,7 +66,7 @@ void nfsd_file_cache_shutdown(void);
 int nfsd_file_cache_start_net(struct net *net);
 void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
-struct net *nfsd_file_put_local(struct nfsd_file __rcu **nf);
+struct net *nfsd_file_put_local(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get_local(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 struct file *nfsd_file_file(struct nfsd_file *nf);
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 5c7c92659e73..453d9de3d70b 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -60,9 +60,9 @@ struct nfsd_localio_operations {
 						struct rpc_clnt *,
 						const struct cred *,
 						const struct nfs_fh *,
-						struct nfsd_file __rcu **pnf,
+						struct nfsd_file __rcu **,
 						const fmode_t);
-	struct net *(*nfsd_file_put_local)(struct nfsd_file __rcu **);
+	struct net *(*nfsd_file_put_local)(struct nfsd_file *);
 	struct nfsd_file *(*nfsd_file_get_local)(struct nfsd_file *);
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
 } ____cacheline_aligned;
@@ -88,19 +88,16 @@ static inline void nfs_to_nfsd_net_put(struct net *net)
 	rcu_read_unlock();
 }
 
-static inline void nfs_to_nfsd_file_put_local(struct nfsd_file __rcu **localio)
+static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
 {
 	/*
-	 * Either *localio must be guaranteed to be non-NULL, or caller
-	 * must prevent nfsd shutdown from completing as nfs_close_local_fh()
-	 * does by blocking the nfs_uuid from being finally put.
+	 * Must not hold RCU otherwise nfsd_file_put() can easily trigger:
+	 * "Voluntary context switch within RCU read-side critical section!"
+	 * by scheduling deep in underlying filesystem (e.g. XFS).
 	 */
-	struct net *net;
+	struct net *net = nfs_to->nfsd_file_put_local(localio);
 
-	net = nfs_to->nfsd_file_put_local(localio);
-
-	if (net)
-		nfs_to_nfsd_net_put(net);
+	nfs_to_nfsd_net_put(net);
 }
 
 #else   /* CONFIG_NFS_LOCALIO */
-- 
2.44.0


