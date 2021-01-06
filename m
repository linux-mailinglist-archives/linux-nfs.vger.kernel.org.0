Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7672EBAE0
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jan 2021 08:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbhAFHxh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jan 2021 02:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbhAFHxf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jan 2021 02:53:35 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BDCC061357
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 23:52:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 190so1669444wmz.0
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 23:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yj+dMIVOxQKOSZHFgj0Qd97RHVYCrYCFa8zwk7EIKWI=;
        b=m0kmBmrB34dIKPLMsPFZqjiYoN+47aHwY69o/hHOzkvf6X+GzSoYxZsElL5fS+8QTs
         yt4aucTh94c/Qda6Mp9VbGvIe95QCDRl3KHSJVpZmKr263SX37fHCKAU9/Ph3dGj6M/u
         aNAzhzdIoXQNl8h0UGeqYeWHdMhe8z0qGQaBGGRuX+yDCf35jRH2mb9WhwNw0+4289Kr
         lQBxwe8b2tikD+AYCs15SA7zx1E+bhcTHn0PZHiM/Ezp5rrgFRESVTnIpBdOnTqJ6ImN
         9lulcvNDkY/bDdL6u6y6m7Od43gRmG+XSVgVRQAuAlgqLjOP4godY0d1oIGvnsoznhsM
         OWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yj+dMIVOxQKOSZHFgj0Qd97RHVYCrYCFa8zwk7EIKWI=;
        b=LhDCDzqPX8QsBX7cptegDxyZoECJyeQIZj09KalSX103jGaUvLb9nk/vqk+xErO0dk
         HmGIlYqrH1dN+hVZ6lS6i46dgt9HfdBJ38mtDHN6vP3vpK/f0WD0PHOgtfPH/5igoUCg
         cBNyPYh3CPNZglVuM56fZg968DBmKhdbhyxEZ1R7IVHdSTqG5Adl+GE2H4l8q7qJAe3/
         FOH1esHAapqlkYf+gwiy0OoR9OA/CTmk+qV8X75gIWC9StHS9meY2M+fjlFukQ6G2N7q
         4MCigFmFeVtbx+dMBQ8dUp6cMBKw9PGwK8GSnb5xVzjedVxIaTmoU9KSOamOunjqJ+jf
         a6Iw==
X-Gm-Message-State: AOAM5330d8Ok2ieQLI5MBwvwsYocnQ0MsnRQVhZIVrA2QbAqnA7I5/Zi
        BzVN95kHIjgvyXwlZAepJ/U=
X-Google-Smtp-Source: ABdhPJxeMGhU/gQPRhJXo1GBxsiW9JODYUK7Cvbrve9LN3c2hiWpZl1vVdJdarIDXMayDsaRehL3tw==
X-Received: by 2002:a1c:9d8b:: with SMTP id g133mr2485123wme.189.1609919572792;
        Tue, 05 Jan 2021 23:52:52 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id h16sm1865536wmb.41.2021.01.05.23.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 23:52:52 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@poochiereds.net>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/3] nfsd: protect concurrent access to nfsd stats counters
Date:   Wed,  6 Jan 2021 09:52:35 +0200
Message-Id: <20210106075236.4184-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210106075236.4184-1-amir73il@gmail.com>
References: <20210106075236.4184-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd stats counters can be updated by concurrent nfsd threads without any
protection.

Convert some nfsd_stats and nfsd_net struct members to use percpu counters.

The longest_chain* members of struct nfsd_net remain unprotected.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/netns.h    | 23 +++++++------
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfscache.c | 52 +++++++++++++++++++++---------
 fs/nfsd/nfsctl.c   |  5 ++-
 fs/nfsd/nfsfh.c    |  2 +-
 fs/nfsd/stats.c    | 77 ++++++++++++++++++++++++++++++++++++--------
 fs/nfsd/stats.h    | 80 +++++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/vfs.c      |  4 +--
 8 files changed, 192 insertions(+), 53 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 7346acda9d76..c330f5bd0cf3 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -10,6 +10,7 @@
 
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <linux/percpu_counter.h>
 
 /* Hash tables for nfs4_clientid state */
 #define CLIENT_HASH_BITS                 4
@@ -21,6 +22,14 @@
 struct cld_net;
 struct nfsd4_client_tracking_ops;
 
+enum {
+	/* cache misses due only to checksum comparison failures */
+	NFSD_NET_PAYLOAD_MISSES,
+	/* amount of memory (in bytes) currently consumed by the DRC */
+	NFSD_NET_DRC_MEM_USAGE,
+	NFSD_NET_COUNTERS_NUM
+};
+
 /*
  * Represents a nfsd "container". With respect to nfsv4 state tracking, the
  * fields of interest are the *_id_hashtbls and the *_name_tree. These track
@@ -149,20 +158,16 @@ struct nfsd_net {
 
 	/*
 	 * Stats and other tracking of on the duplicate reply cache.
-	 * These fields and the "rc" fields in nfsdstats are modified
-	 * with only the per-bucket cache lock, which isn't really safe
-	 * and should be fixed if we want the statistics to be
-	 * completely accurate.
+	 * The longest_chain* fields are modified with only the per-bucket
+	 * cache lock, which isn't really safe and should be fixed if we want
+	 * these statistics to be completely accurate.
 	 */
 
 	/* total number of entries */
 	atomic_t                 num_drc_entries;
 
-	/* cache misses due only to checksum comparison failures */
-	unsigned int             payload_misses;
-
-	/* amount of memory (in bytes) currently consumed by the DRC */
-	unsigned int             drc_mem_usage;
+	/* Per-netns stats counters */
+	struct percpu_counter    counter[NFSD_NET_COUNTERS_NUM];
 
 	/* longest hash chain seen */
 	unsigned int             longest_chain;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4727b7f03c5b..8e6507104a38 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2169,7 +2169,7 @@ nfsd4_proc_null(struct svc_rqst *rqstp)
 static inline void nfsd4_increment_op_stats(u32 opnum)
 {
 	if (opnum >= FIRST_NFS4_OP && opnum <= LAST_NFS4_OP)
-		nfsdstats.nfs4_opcount[opnum]++;
+		percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_NFS4_OP(opnum)]);
 }
 
 static const struct nfsd4_operation nfsd4_ops[];
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 80c90fc231a5..96cdf77925f3 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -121,14 +121,14 @@ nfsd_reply_cache_free_locked(struct nfsd_drc_bucket *b, struct svc_cacherep *rp,
 				struct nfsd_net *nn)
 {
 	if (rp->c_type == RC_REPLBUFF && rp->c_replvec.iov_base) {
-		nn->drc_mem_usage -= rp->c_replvec.iov_len;
+		nfsd_stats_drc_mem_usage_sub(nn, rp->c_replvec.iov_len);
 		kfree(rp->c_replvec.iov_base);
 	}
 	if (rp->c_state != RC_UNUSED) {
 		rb_erase(&rp->c_node, &b->rb_head);
 		list_del(&rp->c_lru);
 		atomic_dec(&nn->num_drc_entries);
-		nn->drc_mem_usage -= sizeof(*rp);
+		nfsd_stats_drc_mem_usage_sub(nn, sizeof(*rp));
 	}
 	kmem_cache_free(drc_slab, rp);
 }
@@ -154,6 +154,16 @@ void nfsd_drc_slab_free(void)
 	kmem_cache_destroy(drc_slab);
 }
 
+static int nfsd_reply_cache_stats_init(struct nfsd_net *nn)
+{
+	return nfsd_percpu_counters_init(nn->counter, NFSD_NET_COUNTERS_NUM);
+}
+
+static void nfsd_reply_cache_stats_destroy(struct nfsd_net *nn)
+{
+	nfsd_percpu_counters_destroy(nn->counter, NFSD_NET_COUNTERS_NUM);
+}
+
 int nfsd_reply_cache_init(struct nfsd_net *nn)
 {
 	unsigned int hashsize;
@@ -165,12 +175,16 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 	hashsize = nfsd_hashsize(nn->max_drc_entries);
 	nn->maskbits = ilog2(hashsize);
 
+	status = nfsd_reply_cache_stats_init(nn);
+	if (status)
+		goto out_nomem;
+
 	nn->nfsd_reply_cache_shrinker.scan_objects = nfsd_reply_cache_scan;
 	nn->nfsd_reply_cache_shrinker.count_objects = nfsd_reply_cache_count;
 	nn->nfsd_reply_cache_shrinker.seeks = 1;
 	status = register_shrinker(&nn->nfsd_reply_cache_shrinker);
 	if (status)
-		goto out_nomem;
+		goto out_stats_destroy;
 
 	nn->drc_hashtbl = kvzalloc(array_size(hashsize,
 				sizeof(*nn->drc_hashtbl)), GFP_KERNEL);
@@ -186,6 +200,8 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 	return 0;
 out_shrinker:
 	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
+out_stats_destroy:
+	nfsd_reply_cache_stats_destroy(nn);
 out_nomem:
 	printk(KERN_ERR "nfsd: failed to allocate reply cache\n");
 	return -ENOMEM;
@@ -196,6 +212,7 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
 	struct svc_cacherep	*rp;
 	unsigned int i;
 
+	nfsd_reply_cache_stats_destroy(nn);
 	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
 
 	for (i = 0; i < nn->drc_hashsize; i++) {
@@ -324,7 +341,7 @@ nfsd_cache_key_cmp(const struct svc_cacherep *key,
 {
 	if (key->c_key.k_xid == rp->c_key.k_xid &&
 	    key->c_key.k_csum != rp->c_key.k_csum) {
-		++nn->payload_misses;
+		nfsd_stats_payload_misses_inc(nn);
 		trace_nfsd_drc_mismatch(nn, key, rp);
 	}
 
@@ -407,7 +424,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 
 	rqstp->rq_cacherep = NULL;
 	if (type == RC_NOCACHE) {
-		nfsdstats.rcnocache++;
+		nfsd_stats_rc_nocache_inc();
 		goto out;
 	}
 
@@ -429,12 +446,12 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 		goto found_entry;
 	}
 
-	nfsdstats.rcmisses++;
+	nfsd_stats_rc_misses_inc();
 	rqstp->rq_cacherep = rp;
 	rp->c_state = RC_INPROG;
 
 	atomic_inc(&nn->num_drc_entries);
-	nn->drc_mem_usage += sizeof(*rp);
+	nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
 
 	/* go ahead and prune the cache */
 	prune_bucket(b, nn);
@@ -446,7 +463,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 
 found_entry:
 	/* We found a matching entry which is either in progress or done. */
-	nfsdstats.rchits++;
+	nfsd_stats_rc_hits_inc();
 	rtn = RC_DROPIT;
 
 	/* Request being processed */
@@ -548,7 +565,7 @@ void nfsd_cache_update(struct svc_rqst *rqstp, int cachetype, __be32 *statp)
 		return;
 	}
 	spin_lock(&b->cache_lock);
-	nn->drc_mem_usage += bufsize;
+	nfsd_stats_drc_mem_usage_add(nn, bufsize);
 	lru_put_end(b, rp);
 	rp->c_secure = test_bit(RQ_SECURE, &rqstp->rq_flags);
 	rp->c_type = cachetype;
@@ -588,13 +605,18 @@ static int nfsd_reply_cache_stats_show(struct seq_file *m, void *v)
 
 	seq_printf(m, "max entries:           %u\n", nn->max_drc_entries);
 	seq_printf(m, "num entries:           %u\n",
-			atomic_read(&nn->num_drc_entries));
+		   atomic_read(&nn->num_drc_entries));
 	seq_printf(m, "hash buckets:          %u\n", 1 << nn->maskbits);
-	seq_printf(m, "mem usage:             %u\n", nn->drc_mem_usage);
-	seq_printf(m, "cache hits:            %u\n", nfsdstats.rchits);
-	seq_printf(m, "cache misses:          %u\n", nfsdstats.rcmisses);
-	seq_printf(m, "not cached:            %u\n", nfsdstats.rcnocache);
-	seq_printf(m, "payload misses:        %u\n", nn->payload_misses);
+	seq_printf(m, "mem usage:             %lld\n",
+		   percpu_counter_sum_positive(&nn->counter[NFSD_NET_DRC_MEM_USAGE]));
+	seq_printf(m, "cache hits:            %lld\n",
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_HITS]));
+	seq_printf(m, "cache misses:          %lld\n",
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_MISSES]));
+	seq_printf(m, "not cached:            %lld\n",
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]));
+	seq_printf(m, "payload misses:        %lld\n",
+		   percpu_counter_sum_positive(&nn->counter[NFSD_NET_PAYLOAD_MISSES]));
 	seq_printf(m, "longest chain len:     %u\n", nn->longest_chain);
 	seq_printf(m, "cachesize at longest:  %u\n", nn->longest_chain_cachesize);
 	return 0;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f6d5d783f4a4..258605ee49b8 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1534,7 +1534,9 @@ static int __init init_nfsd(void)
 	retval = nfsd4_init_pnfs();
 	if (retval)
 		goto out_free_slabs;
-	nfsd_stat_init();	/* Statistics */
+	retval = nfsd_stat_init();	/* Statistics */
+	if (retval)
+		goto out_free_pnfs;
 	retval = nfsd_drc_slab_create();
 	if (retval)
 		goto out_free_stat;
@@ -1554,6 +1556,7 @@ static int __init init_nfsd(void)
 	nfsd_drc_slab_free();
 out_free_stat:
 	nfsd_stat_shutdown();
+out_free_pnfs:
 	nfsd4_exit_pnfs();
 out_free_slabs:
 	nfsd4_free_slabs();
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 66f2ef67792a..9e31b2b5c6d2 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -422,7 +422,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	}
 out:
 	if (error == nfserr_stale)
-		nfsdstats.fh_stale++;
+		nfsd_stats_fh_stale_inc();
 	return error;
 }
 
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index e928e224205a..1d3b881e7382 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -36,13 +36,13 @@ static int nfsd_proc_show(struct seq_file *seq, void *v)
 {
 	int i;
 
-	seq_printf(seq, "rc %u %u %u\nfh %u 0 0 0 0\nio %u %u\n",
-		      nfsdstats.rchits,
-		      nfsdstats.rcmisses,
-		      nfsdstats.rcnocache,
-		      nfsdstats.fh_stale,
-		      nfsdstats.io_read,
-		      nfsdstats.io_write);
+	seq_printf(seq, "rc %lld %lld %lld\nfh %lld 0 0 0 0\nio %lld %lld\n",
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_HITS]),
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_MISSES]),
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]),
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_FH_STALE]),
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_IO_READ]),
+		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_IO_WRITE]));
 
 	/* thread usage: */
 	seq_printf(seq, "th %u 0", nfsdstats.th_cnt);
@@ -61,8 +61,10 @@ static int nfsd_proc_show(struct seq_file *seq, void *v)
 	/* Show count for individual nfsv4 operations */
 	/* Writing operation numbers 0 1 2 also for maintaining uniformity */
 	seq_printf(seq,"proc4ops %u", LAST_NFS4_OP + 1);
-	for (i = 0; i <= LAST_NFS4_OP; i++)
-		seq_printf(seq, " %u", nfsdstats.nfs4_opcount[i]);
+	for (i = 0; i <= LAST_NFS4_OP; i++) {
+		seq_printf(seq, " %lld",
+			   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_NFS4_OP(i)]));
+	}
 
 	seq_putc(seq, '\n');
 #endif
@@ -82,14 +84,63 @@ static const struct proc_ops nfsd_proc_ops = {
 	.proc_release	= single_release,
 };
 
-void
-nfsd_stat_init(void)
+int nfsd_percpu_counters_init(struct percpu_counter counters[], int num)
 {
+	int i, err = 0;
+
+	for (i = 0; !err && i < num; i++)
+		err = percpu_counter_init(&counters[i], 0, GFP_KERNEL);
+
+	if (!err)
+		return 0;
+
+	for (; i > 0; i--)
+		percpu_counter_destroy(&counters[i-1]);
+
+	return err;
+}
+
+void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		percpu_counter_set(&counters[i], 0);
+}
+
+void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		percpu_counter_destroy(&counters[i]);
+}
+
+static int nfsd_stat_counters_init(void)
+{
+	return nfsd_percpu_counters_init(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
+}
+
+static void nfsd_stat_counters_destroy(void)
+{
+	nfsd_percpu_counters_destroy(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
+}
+
+int nfsd_stat_init(void)
+{
+	int err;
+
+	err = nfsd_stat_counters_init();
+	if (err)
+		return err;
+
 	svc_proc_register(&init_net, &nfsd_svcstats, &nfsd_proc_ops);
+
+	return 0;
 }
 
-void
-nfsd_stat_shutdown(void)
+void nfsd_stat_shutdown(void)
 {
+	nfsd_stat_counters_destroy();
 	svc_proc_unregister(&init_net, "nfsd");
 }
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index 5e3cdf21556a..87c3150c200f 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -8,27 +8,85 @@
 #define _NFSD_STATS_H
 
 #include <uapi/linux/nfsd/stats.h>
+#include <linux/percpu_counter.h>
 
 
-struct nfsd_stats {
-	unsigned int	rchits;		/* repcache hits */
-	unsigned int	rcmisses;	/* repcache hits */
-	unsigned int	rcnocache;	/* uncached reqs */
-	unsigned int	fh_stale;	/* FH stale error */
-	unsigned int	io_read;	/* bytes returned to read requests */
-	unsigned int	io_write;	/* bytes passed in write requests */
-	unsigned int	th_cnt;		/* number of available threads */
+enum {
+	NFSD_STATS_RC_HITS,		/* repcache hits */
+	NFSD_STATS_RC_MISSES,		/* repcache misses */
+	NFSD_STATS_RC_NOCACHE,		/* uncached reqs */
+	NFSD_STATS_FH_STALE,		/* FH stale error */
+	NFSD_STATS_IO_READ,		/* bytes returned to read requests */
+	NFSD_STATS_IO_WRITE,		/* bytes passed in write requests */
 #ifdef CONFIG_NFSD_V4
-	unsigned int	nfs4_opcount[LAST_NFS4_OP + 1];	/* count of individual nfsv4 operations */
+	NFSD_STATS_FIRST_NFS4_OP,	/* count of individual nfsv4 operations */
+	NFSD_STATS_LAST_NFS4_OP = NFSD_STATS_FIRST_NFS4_OP + LAST_NFS4_OP,
+#define NFSD_STATS_NFS4_OP(op)	(NFSD_STATS_FIRST_NFS4_OP + (op))
 #endif
+	NFSD_STATS_COUNTERS_NUM
+};
+
+struct nfsd_stats {
+	struct percpu_counter	counter[NFSD_STATS_COUNTERS_NUM];
 
+	/* Protected by nfsd_mutex */
+	unsigned int	th_cnt;		/* number of available threads */
 };
 
 
 extern struct nfsd_stats	nfsdstats;
+
 extern struct svc_stat		nfsd_svcstats;
 
-void	nfsd_stat_init(void);
-void	nfsd_stat_shutdown(void);
+int nfsd_percpu_counters_init(struct percpu_counter counters[], int num);
+void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num);
+void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num);
+int nfsd_stat_init(void);
+void nfsd_stat_shutdown(void);
+
+static inline void nfsd_stats_rc_hits_inc(void)
+{
+	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_HITS]);
+}
+
+static inline void nfsd_stats_rc_misses_inc(void)
+{
+	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_MISSES]);
+}
+
+static inline void nfsd_stats_rc_nocache_inc(void)
+{
+	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]);
+}
+
+static inline void nfsd_stats_fh_stale_inc(void)
+{
+	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_FH_STALE]);
+}
+
+static inline void nfsd_stats_io_read_add(s64 amount)
+{
+	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_READ], amount);
+}
+
+static inline void nfsd_stats_io_write_add(s64 amount)
+{
+	percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_WRITE], amount);
+}
+
+static inline void nfsd_stats_payload_misses_inc(struct nfsd_net *nn)
+{
+	percpu_counter_inc(&nn->counter[NFSD_NET_PAYLOAD_MISSES]);
+}
+
+static inline void nfsd_stats_drc_mem_usage_add(struct nfsd_net *nn, s64 amount)
+{
+	percpu_counter_add(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
+}
+
+static inline void nfsd_stats_drc_mem_usage_sub(struct nfsd_net *nn, s64 amount)
+{
+	percpu_counter_sub(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
+}
 
 #endif /* _NFSD_STATS_H */
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 04937e51de56..d560c1bb2ec2 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -889,7 +889,7 @@ static __be32 nfsd_finish_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			       unsigned long *count, u32 *eof, ssize_t host_err)
 {
 	if (host_err >= 0) {
-		nfsdstats.io_read += host_err;
+		nfsd_stats_io_read_add(host_err);
 		*eof = nfsd_eof_on_read(file, offset, host_err, *count);
 		*count = host_err;
 		fsnotify_access(file);
@@ -1040,7 +1040,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 		goto out_nfserr;
 	}
 	*cnt = host_err;
-	nfsdstats.io_write += *cnt;
+	nfsd_stats_io_write_add(*cnt);
 	fsnotify_modify(file);
 
 	if (stable && use_wgather) {
-- 
2.17.1

