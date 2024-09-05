Return-Path: <linux-nfs+bounces-6234-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2D096DE45
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 17:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5669A28B148
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 15:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3739C19D8A3;
	Thu,  5 Sep 2024 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ux4dnqrn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2351990DB;
	Thu,  5 Sep 2024 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550282; cv=none; b=g18JR1mf/rt5MQQPDSUhsdU6VGOUVm5d5PXXaTcWs1uYSoZT2s5M/NHMyA80WN7LBhK2JdJpp/lYx6C2QJjMi8Clls+cKpwSHyTT+VzyQj8CYhx72XFTCnogok7DIwpo0Ky4Lrf8oSrLSKm4ugX+GtoYbRhC5NAIcp4RykVmkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550282; c=relaxed/simple;
	bh=4Z28YdEqejVig7rYSP+hULTIR4H2m2iWsvNC6I+VmFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYwpHrseLKQsFGUdVjmj+yE4KzjCepxZ+FkmhJRzc368fVGm6bQ5gGKN2ozoPT7EdCB9ZGg+h1hkQ6+WcAOLLuLPvMGeED46frurgS6VKmv6RR/kjnXIsE+M8K5CJ0eQBmNcL08B2U42mOa0PRMJ2Y5jyZ3NBqwG12fXmi7BSvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ux4dnqrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A09C4CEC3;
	Thu,  5 Sep 2024 15:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725550281;
	bh=4Z28YdEqejVig7rYSP+hULTIR4H2m2iWsvNC6I+VmFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ux4dnqrn3x1Bz2QQXV0dfGAlI4fVj9caikP5teQ9/GqMxDttzHN+UGJLBhx/+nt8h
	 ZmHCA6otl26gl+zCKRdYc8OYiQxTWHCGRIG7cwXGWoq/cT+IscPxM5MM9drqQfs9XM
	 g9JcKZLi8mlZpqnj2VHBEiPerQzOEfNQpiciVUc8Ws9Jh4UyT6xvSh1zfcSftVm9wF
	 Sqwux5CrJeLaa793LyHD4uJiat8d4C92fZZrnc+A1VUzoK2vgP2SgLdK5fX3dYk//i
	 22nxjXdb/TfQgYMa6bPr0aZeP91nvUB3dMB28LnQsvJuNTE2/Oipt26UhavfxlhaTK
	 E+d/1HbVt4IEg==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Petr Vorel <pvorel@suse.cz>,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.10.y 05/19] NFSD: Replace nfsd_prune_bucket()
Date: Thu,  5 Sep 2024 11:30:47 -0400
Message-ID: <20240905153101.59927-6-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240905153101.59927-1-cel@kernel.org>
References: <20240905153101.59927-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit a9507f6af1450ed26a4a36d979af518f5bb21e5d ]

Enable nfsd_prune_bucket() to drop the bucket lock while calling
kfree(). Use the same pattern that Jeff recently introduced in the
NFSD filecache.

A few percpu operations are moved outside the lock since they
temporarily disable local IRQs which is expensive and does not
need to be done while the lock is held.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Stable-dep-of: c135e1269f34 ("NFSD: Refactor the duplicate reply cache shrinker")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c | 78 +++++++++++++++++++++++++++++++++++++---------
 fs/nfsd/trace.h    | 22 +++++++++++++
 2 files changed, 85 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 938b37dc1679..e60313ce0fb6 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -117,6 +117,21 @@ static void nfsd_cacherep_free(struct svc_cacherep *rp)
 	kmem_cache_free(drc_slab, rp);
 }
 
+static unsigned long
+nfsd_cacherep_dispose(struct list_head *dispose)
+{
+	struct svc_cacherep *rp;
+	unsigned long freed = 0;
+
+	while (!list_empty(dispose)) {
+		rp = list_first_entry(dispose, struct svc_cacherep, c_lru);
+		list_del(&rp->c_lru);
+		nfsd_cacherep_free(rp);
+		freed++;
+	}
+	return freed;
+}
+
 static void
 nfsd_cacherep_unlink_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
 			    struct svc_cacherep *rp)
@@ -259,6 +274,41 @@ nfsd_cache_bucket_find(__be32 xid, struct nfsd_net *nn)
 	return &nn->drc_hashtbl[hash];
 }
 
+/*
+ * Remove and return no more than @max expired entries in bucket @b.
+ * If @max is zero, do not limit the number of removed entries.
+ */
+static void
+nfsd_prune_bucket_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
+			 unsigned int max, struct list_head *dispose)
+{
+	unsigned long expiry = jiffies - RC_EXPIRE;
+	struct svc_cacherep *rp, *tmp;
+	unsigned int freed = 0;
+
+	lockdep_assert_held(&b->cache_lock);
+
+	/* The bucket LRU is ordered oldest-first. */
+	list_for_each_entry_safe(rp, tmp, &b->lru_head, c_lru) {
+		/*
+		 * Don't free entries attached to calls that are still
+		 * in-progress, but do keep scanning the list.
+		 */
+		if (rp->c_state == RC_INPROG)
+			continue;
+
+		if (atomic_read(&nn->num_drc_entries) <= nn->max_drc_entries &&
+		    time_before(expiry, rp->c_timestamp))
+			break;
+
+		nfsd_cacherep_unlink_locked(nn, b, rp);
+		list_add(&rp->c_lru, dispose);
+
+		if (max && ++freed > max)
+			break;
+	}
+}
+
 static long prune_bucket(struct nfsd_drc_bucket *b, struct nfsd_net *nn,
 			 unsigned int max)
 {
@@ -282,11 +332,6 @@ static long prune_bucket(struct nfsd_drc_bucket *b, struct nfsd_net *nn,
 	return freed;
 }
 
-static long nfsd_prune_bucket(struct nfsd_drc_bucket *b, struct nfsd_net *nn)
-{
-	return prune_bucket(b, nn, 3);
-}
-
 /*
  * Walk the LRU list and prune off entries that are older than RC_EXPIRE.
  * Also prune the oldest ones when the total exceeds the max number of entries.
@@ -442,6 +487,8 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 	__wsum			csum;
 	struct nfsd_drc_bucket	*b;
 	int type = rqstp->rq_cachetype;
+	unsigned long freed;
+	LIST_HEAD(dispose);
 	int rtn = RC_DOIT;
 
 	rqstp->rq_cacherep = NULL;
@@ -466,20 +513,18 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 	found = nfsd_cache_insert(b, rp, nn);
 	if (found != rp)
 		goto found_entry;
-
-	nfsd_stats_rc_misses_inc();
 	rqstp->rq_cacherep = rp;
 	rp->c_state = RC_INPROG;
+	nfsd_prune_bucket_locked(nn, b, 3, &dispose);
+	spin_unlock(&b->cache_lock);
 
+	freed = nfsd_cacherep_dispose(&dispose);
+	trace_nfsd_drc_gc(nn, freed);
+
+	nfsd_stats_rc_misses_inc();
 	atomic_inc(&nn->num_drc_entries);
 	nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
-
-	nfsd_prune_bucket(b, nn);
-
-out_unlock:
-	spin_unlock(&b->cache_lock);
-out:
-	return rtn;
+	goto out;
 
 found_entry:
 	/* We found a matching entry which is either in progress or done. */
@@ -517,7 +562,10 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 
 out_trace:
 	trace_nfsd_drc_found(nn, rqstp, rtn);
-	goto out_unlock;
+out_unlock:
+	spin_unlock(&b->cache_lock);
+out:
+	return rtn;
 }
 
 /**
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 445d00f00eab..0e6c7ed9da1b 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1171,6 +1171,28 @@ TRACE_EVENT(nfsd_drc_mismatch,
 		__entry->ingress)
 );
 
+TRACE_EVENT_CONDITION(nfsd_drc_gc,
+	TP_PROTO(
+		const struct nfsd_net *nn,
+		unsigned long freed
+	),
+	TP_ARGS(nn, freed),
+	TP_CONDITION(freed > 0),
+	TP_STRUCT__entry(
+		__field(unsigned long long, boot_time)
+		__field(unsigned long, freed)
+		__field(int, total)
+	),
+	TP_fast_assign(
+		__entry->boot_time = nn->boot_time;
+		__entry->freed = freed;
+		__entry->total = atomic_read(&nn->num_drc_entries);
+	),
+	TP_printk("boot_time=%16llx total=%d freed=%lu",
+		__entry->boot_time, __entry->total, __entry->freed
+	)
+);
+
 TRACE_EVENT(nfsd_cb_args,
 	TP_PROTO(
 		const struct nfs4_client *clp,
-- 
2.45.1


