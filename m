Return-Path: <linux-nfs+bounces-1419-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C84B83CCE7
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF332898F3
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 19:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB108472;
	Thu, 25 Jan 2024 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0MfeoNrr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC6813665E
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212428; cv=none; b=ssMMHGEbSgcidTpBHbZ/8VqYgBv1NKDrPxKw4I4T6VcOo6pBEE9lFUW0R3oVhkG6dCistFWeLOC8zrizm7EGcxt/lygv1TZ71sv1zyWsfxqYnoMvmp4WLZvnjClXuIp38BRTkrtQaQx2cEhXWsAN9lhQBoHxrH2B+k+TYteJeGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212428; c=relaxed/simple;
	bh=kH4C69gXhYzpUQZNXdH8fdQsSdqyLfCEoP54BXBFA0U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwmMSMCfeAevu1bDwgMxCiukjTbbUzZwLZl6kVPltBGdDtSRf653kDlsFlnTSQMzOYfYf9lhhNAnQ83OKL3am3y9BuVs+Yfcot09ktMTTX9oQ9Mdu+FqdqxM30tuSTFWnC0BMd7A4v00kAOhOIauYGZ5VoqlNCheDIbRINNanjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0MfeoNrr; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-602c714bdbeso1127117b3.1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 11:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706212425; x=1706817225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPYWgezIyTTIaXhRwEKknhgUQv07nyNgQ9eiW6X1xO4=;
        b=0MfeoNrrRu3u1BadiiEkcgNJl/NlH4BgaX0oXpyjbuvkLD1nOF5dAjaXsGAmxVo83o
         hTvBvOuFVVu/mKvkM0+7Gz+Qhrb71SOI0hERGRg8lwQC66BNgCtJqqaJA3sJCTzVuMDH
         mp6LOrGcgSRTQyb3Y4ejKI0iQ2xxEx4Lwx9EgIWRyyG+ypMu4lwVKs6uIEBmEE/aeUlZ
         CgWl2BPHy5oQJwfSLe1SCn/WIEPup6HdAwxzyVHw85ePGYcVZrrGLk6sNHUPCFsZ3qyl
         0fB0Oa+qeXSG+LgbDPO8E1m7y8kzS6WXwyVwVsdFPXMJ6tvp41324y6cUhfxQ7rep7i6
         M3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212425; x=1706817225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPYWgezIyTTIaXhRwEKknhgUQv07nyNgQ9eiW6X1xO4=;
        b=Bi5svypjkuMXtJrBXp2s0Zx3ri42Y4WoVOKzcXuy+8LaqsKp+lYzK2eSLyWtIgh82L
         QhnzSNzToTEDSPPQuTsGvfKw1rF4RrFNwbck+gHeuMO5xmPA/YWqOF/5BSvUwYl4l+LZ
         IbUOF4YJxiSAmu1ao9FRcxpaVwNa05DDUC6efdH1EiIL7MFK3Yd2MmgQOfzVDzkEuoqf
         eSIa3aXnD9a2Hgc6QHdhs9bS9QJRmK1Kq242M26fxafYjz2LCAiz+QJftbar62Hu1uFr
         hQs29btsV/BfAuFwxYzO+95YSnHmR3Ec/bGzoiEZ4yJUSiXVZ9hKMbD8aqtNf6r8roW6
         XmBA==
X-Gm-Message-State: AOJu0YybErTg4759XhbklKVKHvHFC2G2xr04PrhKkw53USRJqkyzQR+D
	xPnNh4uOJFF+JDlBEMr167I0IDRLQsGBufhSzveXy6MSigTl0BVDS61+NE5NE+9uiIiEITtDMzH
	B
X-Google-Smtp-Source: AGHT+IFsOzuXZk//qgRYJuivzgjH+lWF4lFiDhXOwk7PVdoNeNzae2rMkZQa8lF5kaippUhdt4JC2A==
X-Received: by 2002:a0d:dfd8:0:b0:5ff:64d6:ee4e with SMTP id i207-20020a0ddfd8000000b005ff64d6ee4emr50517ywe.26.1706212425169;
        Thu, 25 Jan 2024 11:53:45 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i18-20020a0ddf12000000b005ffd0b5988asm854691ywe.65.2024.01.25.11.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:53:44 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 09/13] nfsd: make all of the nfsd stats per-network namespace
Date: Thu, 25 Jan 2024 14:53:19 -0500
Message-ID: <5887c5d18cfc60e1c83187d191c8fd85f022e98b.1706212208.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706212207.git.josef@toxicpanda.com>
References: <cover.1706212207.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a global set of counters that we modify for all of the nfsd
operations, but now that we're exposing these stats across all network
namespaces we need to make the stats also be per-network namespace.  We
already have some caching stats that are per-network namespace, so move
these definitions into the same counter and then adjust all the helpers
and users of these stats to provide the appropriate nfsd_net struct so
that the stats are maintained for the per-network namespace objects.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nfsd/cache.h     |  2 --
 fs/nfsd/netns.h     | 17 ++++++++++++--
 fs/nfsd/nfs4proc.c  |  6 ++---
 fs/nfsd/nfs4state.c |  3 ++-
 fs/nfsd/nfscache.c  | 36 ++++++------------------------
 fs/nfsd/nfsctl.c    | 12 +++-------
 fs/nfsd/nfsfh.c     |  3 ++-
 fs/nfsd/stats.c     | 26 ++++++++++++----------
 fs/nfsd/stats.h     | 54 ++++++++++++++++-----------------------------
 fs/nfsd/vfs.c       |  5 +++--
 10 files changed, 68 insertions(+), 96 deletions(-)

diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
index 4cbe0434cbb8..66a05fefae98 100644
--- a/fs/nfsd/cache.h
+++ b/fs/nfsd/cache.h
@@ -80,8 +80,6 @@ enum {
 
 int	nfsd_drc_slab_create(void);
 void	nfsd_drc_slab_free(void);
-int	nfsd_net_reply_cache_init(struct nfsd_net *nn);
-void	nfsd_net_reply_cache_destroy(struct nfsd_net *nn);
 int	nfsd_reply_cache_init(struct nfsd_net *);
 void	nfsd_reply_cache_shutdown(struct nfsd_net *);
 int	nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index e3605cb5f044..0cef4bb407a9 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -11,6 +11,7 @@
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 #include <linux/filelock.h>
+#include <linux/nfs4.h>
 #include <linux/percpu_counter.h>
 #include <linux/siphash.h>
 
@@ -29,7 +30,19 @@ enum {
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
@@ -164,7 +177,7 @@ struct nfsd_net {
 	atomic_t                 num_drc_entries;
 
 	/* Per-netns stats counters */
-	struct percpu_counter    counter[NFSD_NET_COUNTERS_NUM];
+	struct percpu_counter    counter[NFSD_STATS_COUNTERS_NUM];
 
 	/* longest hash chain seen */
 	unsigned int             longest_chain;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 14712fa08f76..648ff427005e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2490,10 +2490,10 @@ nfsd4_proc_null(struct svc_rqst *rqstp)
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
@@ -2768,7 +2768,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 					   status, nfsd4_op_name(op->opnum));
 
 		nfsd4_cstate_clear_replay(cstate);
-		nfsd4_increment_op_stats(op->opnum);
+		nfsd4_increment_op_stats(nn, op->opnum);
 	}
 
 	fh_put(current_fh);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fbf8b426950e..83c260ab485d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8457,6 +8457,7 @@ __be32
 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 {
 	__be32 status;
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct file_lock_context *ctx;
 	struct file_lock *fl;
 	struct nfs4_delegation *dp;
@@ -8486,7 +8487,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 			}
 break_lease:
 			spin_unlock(&ctx->flc_lock);
-			nfsd_stats_wdeleg_getattr_inc();
+			nfsd_stats_wdeleg_getattr_inc(nn);
 			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
 			if (status != nfserr_jukebox ||
 					!nfsd_wait_for_delegreturn(rqstp, inode))
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 3d4a9d181c43..cfcc6ac8f255 100644
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
@@ -501,7 +480,7 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct nfsd_cacherep *key,
 int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
 		      unsigned int len, struct nfsd_cacherep **cacherep)
 {
-	struct nfsd_net		*nn;
+	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct nfsd_cacherep	*rp, *found;
 	__wsum			csum;
 	struct nfsd_drc_bucket	*b;
@@ -510,7 +489,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
 	int rtn = RC_DOIT;
 
 	if (type == RC_NOCACHE) {
-		nfsd_stats_rc_nocache_inc();
+		nfsd_stats_rc_nocache_inc(nn);
 		goto out;
 	}
 
@@ -520,7 +499,6 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
 	 * Since the common case is a cache miss followed by an insert,
 	 * preallocate an entry.
 	 */
-	nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	rp = nfsd_cacherep_alloc(rqstp, csum, nn);
 	if (!rp)
 		goto out;
@@ -537,7 +515,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
 
 	nfsd_cacherep_dispose(&dispose);
 
-	nfsd_stats_rc_misses_inc();
+	nfsd_stats_rc_misses_inc(nn);
 	atomic_inc(&nn->num_drc_entries);
 	nfsd_stats_drc_mem_usage_add(nn, sizeof(*rp));
 	goto out;
@@ -545,7 +523,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, unsigned int start,
 found_entry:
 	/* We found a matching entry which is either in progress or done. */
 	nfsd_reply_cache_free_locked(NULL, rp, nn);
-	nfsd_stats_rc_hits_inc();
+	nfsd_stats_rc_hits_inc(nn);
 	rtn = RC_DROPIT;
 	rp = found;
 
@@ -689,11 +667,11 @@ int nfsd_reply_cache_stats_show(struct seq_file *m, void *v)
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
index b57480b50e35..ea3c8114245c 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1671,7 +1671,7 @@ static __net_init int nfsd_net_init(struct net *net)
 	retval = nfsd_idmap_init(net);
 	if (retval)
 		goto out_idmap_error;
-	retval = nfsd_net_reply_cache_init(nn);
+	retval = nfsd_stat_counters_init(nn);
 	if (retval)
 		goto out_repcache_error;
 	nn->nfsd_versions = NULL;
@@ -1701,7 +1701,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	nfsd_proc_stat_shutdown(net);
-	nfsd_net_reply_cache_destroy(nn);
+	nfsd_stat_counters_destroy(nn);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
 	nfsd_netns_free_versions(nn);
@@ -1724,12 +1724,9 @@ static int __init init_nfsd(void)
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
@@ -1763,8 +1760,6 @@ static int __init init_nfsd(void)
 out_free_lockd:
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
-out_free_stat:
-	nfsd_stat_counters_destroy();
 out_free_pnfs:
 	nfsd4_exit_pnfs();
 out_free_slabs:
@@ -1782,7 +1777,6 @@ static void __exit exit_nfsd(void)
 	nfsd_drc_slab_free();
 	remove_proc_entry("fs/nfs/exports", NULL);
 	remove_proc_entry("fs/nfs", NULL);
-	nfsd_stat_counters_destroy();
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
 	nfsd4_exit_pnfs();
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index dbfa0ac13564..40fecf7b224f 100644
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
index 394a65a33942..44e275324b06 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -34,15 +34,17 @@ struct svc_stat		nfsd_svcstats = {
 
 static int nfsd_show(struct seq_file *seq, void *v)
 {
+	struct net *net = pde_data(file_inode(seq->file));
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
@@ -63,10 +65,10 @@ static int nfsd_show(struct seq_file *seq, void *v)
 	seq_printf(seq, "proc4ops %u", LAST_NFS4_OP + 1);
 	for (i = 0; i <= LAST_NFS4_OP; i++) {
 		seq_printf(seq, " %lld",
-			   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_NFS4_OP(i)]));
+			   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_NFS4_OP(i)]));
 	}
 	seq_printf(seq, "\nwdeleg_getattr %lld",
-		percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_WDELEG_GETATTR]));
+		percpu_counter_sum_positive(&nn->counter[NFSD_STATS_WDELEG_GETATTR]));
 
 	seq_putc(seq, '\n');
 #endif
@@ -108,14 +110,14 @@ void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
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
index 38811aa7d13e..c24be4ddbe7d 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -10,26 +10,7 @@
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
-	NFSD_STATS_WDELEG_GETATTR,	/* count of getattr conflict with wdeleg */
-#endif
-	NFSD_STATS_COUNTERS_NUM
-};
-
 struct nfsd_stats {
-	struct percpu_counter	counter[NFSD_STATS_COUNTERS_NUM];
-
 	atomic_t	th_cnt;		/* number of available threads */
 };
 
@@ -40,43 +21,46 @@ extern struct svc_stat		nfsd_svcstats;
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
@@ -97,9 +81,9 @@ static inline void nfsd_stats_drc_mem_usage_sub(struct nfsd_net *nn, s64 amount)
 }
 
 #ifdef CONFIG_NFSD_V4
-static inline void nfsd_stats_wdeleg_getattr_inc(void)
+static inline void nfsd_stats_wdeleg_getattr_inc(struct nfsd_net *nn)
 {
-	percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_WDELEG_GETATTR]);
+	percpu_counter_inc(&nn->counter[NFSD_STATS_WDELEG_GETATTR]);
 }
 #endif
 #endif /* _NFSD_STATS_H */
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f57749cd6f0b..33af4bc7f423 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1002,7 +1002,8 @@ static __be32 nfsd_finish_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			       unsigned long *count, u32 *eof, ssize_t host_err)
 {
 	if (host_err >= 0) {
-		nfsd_stats_io_read_add(fhp->fh_export, host_err);
+		struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+		nfsd_stats_io_read_add(nn, fhp->fh_export, host_err);
 		*eof = nfsd_eof_on_read(file, offset, host_err, *count);
 		*count = host_err;
 		fsnotify_access(file);
@@ -1185,7 +1186,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 		goto out_nfserr;
 	}
 	*cnt = host_err;
-	nfsd_stats_io_write_add(exp, *cnt);
+	nfsd_stats_io_write_add(nn, exp, *cnt);
 	fsnotify_modify(file);
 	host_err = filemap_check_wb_err(file->f_mapping, since);
 	if (host_err < 0)
-- 
2.43.0


