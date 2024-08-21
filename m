Return-Path: <linux-nfs+bounces-5518-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63E795A0B2
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87421C22A4F
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 14:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6F91B2EC1;
	Wed, 21 Aug 2024 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw3tPOkT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857FC1B252D;
	Wed, 21 Aug 2024 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252217; cv=none; b=Le0+gPsy2hr4y83ilXUdu4x9Er0ltJqD6T7zpxeX/7M6CrwsTOSU6+ybP5aGjUZrkEscro7XW99SfhKxiswivPGRx0iPrjcnX/yhG5jVrKu647dplOIsKx9OhWlSayTzdD5cteX/81Gqk7oua5pEhIb4lpjCYtdlGpubZ9hU5ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252217; c=relaxed/simple;
	bh=L8APQXERg0iQFJeUwUevCqLYpCCgTwe3QlfMIbZbqAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bS4Vpnh9wnUIV8hb/AE31f8ezWlfVSXayIaYZjlJQ0EWezs/l2AvMldbyGv/WJJUwmrMWDLvV/xfVyI3/PWdUY2VrWBPtnVDGlFBjXgPOk6/DXzuVdBumlhmwQ8ADX9ettTRDGwVe146kuZUuoh8XIiimF6dVtpH8FWEm5o84fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw3tPOkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912E2C4AF09;
	Wed, 21 Aug 2024 14:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252217;
	bh=L8APQXERg0iQFJeUwUevCqLYpCCgTwe3QlfMIbZbqAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aw3tPOkTHH8wojVPPGu5At7jBjuAxGWcRXuP+wtibeh5LMztahqHNt6vw2bVqB8I4
	 RVpvkJTqwHpBIgJuWlcUu0adDtQUQiJ9jIgvImyeQlrZX8+A0ROlKpDRSshRqXNVNO
	 nUSQ0aQEdKlw/qup8rYfE+uHFH+QKye/5HKFiJxzaoOh79Bei7PxjkNmbliAYJBOK2
	 SQLpWIpuGaHehAYcqTtbcjxUugojLeR/NZMV9X5Ja89gTMvbvcpiwxhQrG+8tno+w7
	 KO/UaRDV2N5rVOIxhkSGJ4crlSLf65SBGQBt6+WpKGtmEP3We31RwziJyNS2bCk/Ar
	 MywBs7Mc3FGUQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.15.y 16/18] nfsd: make all of the nfsd stats per-network namespace
Date: Wed, 21 Aug 2024 10:55:46 -0400
Message-ID: <20240821145548.25700-17-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821145548.25700-1-cel@kernel.org>
References: <20240821145548.25700-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 4b14885411f74b2b0ce0eb2b39d0fffe54e5ca0d ]

We have a global set of counters that we modify for all of the nfsd
operations, but now that we're exposing these stats across all network
namespaces we need to make the stats also be per-network namespace.  We
already have some caching stats that are per-network namespace, so move
these definitions into the same counter and then adjust all the helpers
and users of these stats to provide the appropriate nfsd_net struct so
that the stats are maintained for the per-network namespace objects.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
[ cel: adjusted to apply to v5.15.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/cache.h    |  2 --
 fs/nfsd/netns.h    | 17 ++++++++++++++--
 fs/nfsd/nfs4proc.c |  6 +++---
 fs/nfsd/nfscache.c | 36 +++++++---------------------------
 fs/nfsd/nfsctl.c   | 12 +++---------
 fs/nfsd/nfsfh.c    |  3 ++-
 fs/nfsd/stats.c    | 24 ++++++++++++-----------
 fs/nfsd/stats.h    | 49 ++++++++++++++++------------------------------
 fs/nfsd/vfs.c      |  6 ++++--
 9 files changed, 64 insertions(+), 91 deletions(-)

diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
index 4c9b87850ab1..f21259ead64b 100644
--- a/fs/nfsd/cache.h
+++ b/fs/nfsd/cache.h
@@ -80,8 +80,6 @@ enum {
 
 int	nfsd_drc_slab_create(void);
 void	nfsd_drc_slab_free(void);
-int	nfsd_net_reply_cache_init(struct nfsd_net *nn);
-void	nfsd_net_reply_cache_destroy(struct nfsd_net *nn);
 int	nfsd_reply_cache_init(struct nfsd_net *);
 void	nfsd_reply_cache_shutdown(struct nfsd_net *);
 int	nfsd_cache_lookup(struct svc_rqst *);
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index d1428f96aa5c..55ab92326384 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -10,6 +10,7 @@
 
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <linux/nfs4.h>
 #include <linux/percpu_counter.h>
 #include <linux/siphash.h>
 
@@ -28,7 +29,19 @@ enum {
 	NFSD_STATS_PAYLOAD_MISSES,
 	/* amount of memory (in bytes) currently consumed by the DRC */
 	NFSD_STATS_DRC_MEM_USAGE,
-	NFSD_NET_COUNTERS_NUM
+	NFSD_STATS_RC_HITS,		/* repcache hits */
+	NFSD_STATS_RC_MISSES,		/* repcache misses */
+	NFSD_STATS_RC_NOCACHE,		/* uncached reqs */
+	NFSD_STATS_FH_STALE,		/* FH stale error */
+	NFSD_STATS_IO_READ,		/* bytes returned to read requests */
+	NFSD_STATS_IO_WRITE,		/* bytes passed in write requests */
+#ifdef CONFIG_NFSD_V4
+	NFSD_STATS_FIRST_NFS4_OP,	/* count of individual nfsv4 operations */
+	NFSD_STATS_LAST_NFS4_OP = NFSD_STATS_FIRST_NFS4_OP + LAST_NFS4_OP,
+#define NFSD_STATS_NFS4_OP(op)	(NFSD_STATS_FIRST_NFS4_OP + (op))
+	NFSD_STATS_WDELEG_GETATTR,	/* count of getattr conflict with wdeleg */
+#endif
+	NFSD_STATS_COUNTERS_NUM
 };
 
 /*
@@ -168,7 +181,7 @@ struct nfsd_net {
 	atomic_t                 num_drc_entries;
 
 	/* Per-netns stats counters */
-	struct percpu_counter    counter[NFSD_NET_COUNTERS_NUM];
+	struct percpu_counter    counter[NFSD_STATS_COUNTERS_NUM];
 
 	/* longest hash chain seen */
 	unsigned int             longest_chain;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e0ff2212866a..11dcf3debb1d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2435,10 +2435,10 @@ nfsd4_proc_null(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
-static inline void nfsd4_increment_op_stats(u32 opnum)
+static inline void nfsd4_increment_op_stats(struct nfsd_net *nn, u32 opnum)
 {
 	if (opnum >= FIRST_NFS4_OP && opnum <= LAST_NFS4_OP)
-		percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_NFS4_OP(opnum)]);
+		percpu_counter_inc(&nn->counter[NFSD_STATS_NFS4_OP(opnum)]);
 }
 
 static const struct nfsd4_operation nfsd4_ops[];
@@ -2713,7 +2713,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 					   status, nfsd4_op_name(op->opnum));
 
 		nfsd4_cstate_clear_replay(cstate);
-		nfsd4_increment_op_stats(op->opnum);
+		nfsd4_increment_op_stats(nn, op->opnum);
 	}
 
 	fh_put(current_fh);
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index b81308cac392..448700939dfe 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -176,27 +176,6 @@ void nfsd_drc_slab_free(void)
 	kmem_cache_destroy(drc_slab);
 }
 
-/**
- * nfsd_net_reply_cache_init - per net namespace reply cache set-up
- * @nn: nfsd_net being initialized
- *
- * Returns zero on succes; otherwise a negative errno is returned.
- */
-int nfsd_net_reply_cache_init(struct nfsd_net *nn)
-{
-	return nfsd_percpu_counters_init(nn->counter, NFSD_NET_COUNTERS_NUM);
-}
-
-/**
- * nfsd_net_reply_cache_destroy - per net namespace reply cache tear-down
- * @nn: nfsd_net being freed
- *
- */
-void nfsd_net_reply_cache_destroy(struct nfsd_net *nn)
-{
-	nfsd_percpu_counters_destroy(nn->counter, NFSD_NET_COUNTERS_NUM);
-}
-
 int nfsd_reply_cache_init(struct nfsd_net *nn)
 {
 	unsigned int hashsize;
@@ -478,7 +457,7 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key,
  */
 int nfsd_cache_lookup(struct svc_rqst *rqstp)
 {
-	struct nfsd_net		*nn;
+	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct svc_cacherep	*rp, *found;
 	__wsum			csum;
 	struct nfsd_drc_bucket	*b;
@@ -489,7 +468,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 
 	rqstp->rq_cacherep = NULL;
 	if (type == RC_NOCACHE) {
-		nfsd_stats_rc_nocache_inc();
+		nfsd_stats_rc_nocache_inc(nn);
 		goto out;
 	}
 
@@ -499,7 +478,6 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 	 * Since the common case is a cache miss followed by an insert,
 	 * preallocate an entry.
 	 */
-	nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	rp = nfsd_cacherep_alloc(rqstp, csum, nn);
 	if (!rp)
 		goto out;
@@ -517,7 +495,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 	freed = nfsd_cacherep_dispose(&dispose);
 	trace_nfsd_drc_gc(nn, freed);
 
-	nfsd_stats_rc_misses_inc();
+	nfsd_stats_rc_misses_inc(nn);
 	atomic_inc(&nn->num_drc_entries);
 	nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
 	goto out;
@@ -525,7 +503,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 found_entry:
 	/* We found a matching entry which is either in progress or done. */
 	nfsd_reply_cache_free_locked(NULL, rp, nn);
-	nfsd_stats_rc_hits_inc();
+	nfsd_stats_rc_hits_inc(nn);
 	rtn = RC_DROPIT;
 	rp = found;
 
@@ -675,11 +653,11 @@ int nfsd_reply_cache_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "mem usage:             %lld\n",
 		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_DRC_MEM_USAGE]));
 	seq_printf(m, "cache hits:            %lld\n",
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_HITS]));
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_HITS]));
 	seq_printf(m, "cache misses:          %lld\n",
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_MISSES]));
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_MISSES]));
 	seq_printf(m, "not cached:            %lld\n",
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]));
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_NOCACHE]));
 	seq_printf(m, "payload misses:        %lld\n",
 		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_PAYLOAD_MISSES]));
 	seq_printf(m, "longest chain len:     %u\n", nn->longest_chain);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index e49a778e1815..e7fa64834d7d 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1458,7 +1458,7 @@ static __net_init int nfsd_init_net(struct net *net)
 	retval = nfsd_idmap_init(net);
 	if (retval)
 		goto out_idmap_error;
-	retval = nfsd_net_reply_cache_init(nn);
+	retval = nfsd_stat_counters_init(nn);
 	if (retval)
 		goto out_repcache_error;
 	nn->nfsd_versions = NULL;
@@ -1483,7 +1483,7 @@ static __net_exit void nfsd_exit_net(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	nfsd_proc_stat_shutdown(net);
-	nfsd_net_reply_cache_destroy(nn);
+	nfsd_stat_counters_destroy(nn);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
 	nfsd_netns_free_versions(nn);
@@ -1506,12 +1506,9 @@ static int __init init_nfsd(void)
 	retval = nfsd4_init_pnfs();
 	if (retval)
 		goto out_free_slabs;
-	retval = nfsd_stat_counters_init();	/* Statistics */
-	if (retval)
-		goto out_free_pnfs;
 	retval = nfsd_drc_slab_create();
 	if (retval)
-		goto out_free_stat;
+		goto out_free_pnfs;
 	nfsd_lockd_init();	/* lockd->nfsd callbacks */
 	retval = create_proc_exports_entry();
 	if (retval)
@@ -1541,8 +1538,6 @@ static int __init init_nfsd(void)
 out_free_lockd:
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
-out_free_stat:
-	nfsd_stat_counters_destroy();
 out_free_pnfs:
 	nfsd4_exit_pnfs();
 out_free_slabs:
@@ -1559,7 +1554,6 @@ static void __exit exit_nfsd(void)
 	nfsd_drc_slab_free();
 	remove_proc_entry("fs/nfs/exports", NULL);
 	remove_proc_entry("fs/nfs", NULL);
-	nfsd_stat_counters_destroy();
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
 	nfsd4_exit_pnfs();
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 3a2ad88ae648..e73e9d44f1b0 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -327,6 +327,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 __be32
 fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 {
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct svc_export *exp = NULL;
 	struct dentry	*dentry;
 	__be32		error;
@@ -395,7 +396,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 out:
 	trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
 	if (error == nfserr_stale)
-		nfsd_stats_fh_stale_inc(exp);
+		nfsd_stats_fh_stale_inc(nn, exp);
 	return error;
 }
 
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 22d57f92187e..c21dbd7d0086 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -34,15 +34,17 @@ struct svc_stat		nfsd_svcstats = {
 
 static int nfsd_show(struct seq_file *seq, void *v)
 {
+	struct net *net = PDE_DATA(file_inode(seq->file));
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	int i;
 
 	seq_printf(seq, "rc %lld %lld %lld\nfh %lld 0 0 0 0\nio %lld %lld\n",
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_HITS]),
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_MISSES]),
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]),
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_FH_STALE]),
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_IO_READ]),
-		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_IO_WRITE]));
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_HITS]),
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_MISSES]),
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_NOCACHE]),
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_FH_STALE]),
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_IO_READ]),
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_IO_WRITE]));
 
 	/* thread usage: */
 	seq_printf(seq, "th %u 0", atomic_read(&nfsdstats.th_cnt));
@@ -63,7 +65,7 @@ static int nfsd_show(struct seq_file *seq, void *v)
 	seq_printf(seq,"proc4ops %u", LAST_NFS4_OP + 1);
 	for (i = 0; i <= LAST_NFS4_OP; i++) {
 		seq_printf(seq, " %lld",
-			   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_NFS4_OP(i)]));
+			   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_NFS4_OP(i)]));
 	}
 
 	seq_putc(seq, '\n');
@@ -106,14 +108,14 @@ void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
 		percpu_counter_destroy(&counters[i]);
 }
 
-int nfsd_stat_counters_init(void)
+int nfsd_stat_counters_init(struct nfsd_net *nn)
 {
-	return nfsd_percpu_counters_init(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
+	return nfsd_percpu_counters_init(nn->counter, NFSD_STATS_COUNTERS_NUM);
 }
 
-void nfsd_stat_counters_destroy(void)
+void nfsd_stat_counters_destroy(struct nfsd_net *nn)
 {
-	nfsd_percpu_counters_destroy(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
+	nfsd_percpu_counters_destroy(nn->counter, NFSD_STATS_COUNTERS_NUM);
 }
 
 void nfsd_proc_stat_init(struct net *net)
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 31756a9a8a0a..28f5c720e9b3 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -10,25 +10,7 @@
 #include <uapi/linux/nfsd/stats.h>
 #include <linux/percpu_counter.h>
 
-
-enum {
-	NFSD_STATS_RC_HITS,		/* repcache hits */
-	NFSD_STATS_RC_MISSES,		/* repcache misses */
-	NFSD_STATS_RC_NOCACHE,		/* uncached reqs */
-	NFSD_STATS_FH_STALE,		/* FH stale error */
-	NFSD_STATS_IO_READ,		/* bytes returned to read requests */
-	NFSD_STATS_IO_WRITE,		/* bytes passed in write requests */
-#ifdef CONFIG_NFSD_V4
-	NFSD_STATS_FIRST_NFS4_OP,	/* count of individual nfsv4 operations */
-	NFSD_STATS_LAST_NFS4_OP = NFSD_STATS_FIRST_NFS4_OP + LAST_NFS4_OP,
-#define NFSD_STATS_NFS4_OP(op)	(NFSD_STATS_FIRST_NFS4_OP + (op))
-#endif
-	NFSD_STATS_COUNTERS_NUM
-};
-
 struct nfsd_stats {
-	struct percpu_counter	counter[NFSD_STATS_COUNTERS_NUM];
-
 	atomic_t	th_cnt;		/* number of available threads */
 };
 
@@ -39,43 +21,46 @@ extern struct svc_stat		nfsd_svcstats;
 int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
-int nfsd_stat_counters_init(void);
-void nfsd_stat_counters_destroy(void);
+int nfsd_stat_counters_init(struct nfsd_net *nn);
+void nfsd_stat_counters_destroy(struct nfsd_net *nn);
 void nfsd_proc_stat_init(struct net *net);
 void nfsd_proc_stat_shutdown(struct net *net);
 
-static inline void nfsd_stats_rc_hits_inc(void)
+static inline void nfsd_stats_rc_hits_inc(struct nfsd_net *nn)
 {
-	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_HITS]);
+	percpu_counter_inc(&nn->counter[NFSD_STATS_RC_HITS]);
 }
 
-static inline void nfsd_stats_rc_misses_inc(void)
+static inline void nfsd_stats_rc_misses_inc(struct nfsd_net *nn)
 {
-	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_MISSES]);
+	percpu_counter_inc(&nn->counter[NFSD_STATS_RC_MISSES]);
 }
 
-static inline void nfsd_stats_rc_nocache_inc(void)
+static inline void nfsd_stats_rc_nocache_inc(struct nfsd_net *nn)
 {
-	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]);
+	percpu_counter_inc(&nn->counter[NFSD_STATS_RC_NOCACHE]);
 }
 
-static inline void nfsd_stats_fh_stale_inc(struct svc_export *exp)
+static inline void nfsd_stats_fh_stale_inc(struct nfsd_net *nn,
+					   struct svc_export *exp)
 {
-	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_FH_STALE]);
+	percpu_counter_inc(&nn->counter[NFSD_STATS_FH_STALE]);
 	if (exp && exp->ex_stats)
 		percpu_counter_inc(&exp->ex_stats->counter[EXP_STATS_FH_STALE]);
 }
 
-static inline void nfsd_stats_io_read_add(struct svc_export *exp, s64 amount)
+static inline void nfsd_stats_io_read_add(struct nfsd_net *nn,
+					  struct svc_export *exp, s64 amount)
 {
-	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_READ], amount);
+	percpu_counter_add(&nn->counter[NFSD_STATS_IO_READ], amount);
 	if (exp && exp->ex_stats)
 		percpu_counter_add(&exp->ex_stats->counter[EXP_STATS_IO_READ], amount);
 }
 
-static inline void nfsd_stats_io_write_add(struct svc_export *exp, s64 amount)
+static inline void nfsd_stats_io_write_add(struct nfsd_net *nn,
+					   struct svc_export *exp, s64 amount)
 {
-	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_WRITE], amount);
+	percpu_counter_add(&nn->counter[NFSD_STATS_IO_WRITE], amount);
 	if (exp && exp->ex_stats)
 		percpu_counter_add(&exp->ex_stats->counter[EXP_STATS_IO_WRITE], amount);
 }
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0f430548bfbb..871649030152 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -984,7 +984,9 @@ static __be32 nfsd_finish_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			       unsigned long *count, u32 *eof, ssize_t host_err)
 {
 	if (host_err >= 0) {
-		nfsd_stats_io_read_add(fhp->fh_export, host_err);
+		struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+
+		nfsd_stats_io_read_add(nn, fhp->fh_export, host_err);
 		*eof = nfsd_eof_on_read(file, offset, host_err, *count);
 		*count = host_err;
 		fsnotify_access(file);
@@ -1127,7 +1129,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 		goto out_nfserr;
 	}
 	*cnt = host_err;
-	nfsd_stats_io_write_add(exp, *cnt);
+	nfsd_stats_io_write_add(nn, exp, *cnt);
 	fsnotify_modify(file);
 	host_err = filemap_check_wb_err(file->f_mapping, since);
 	if (host_err < 0)
-- 
2.45.2


