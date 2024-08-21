Return-Path: <linux-nfs+bounces-5516-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 420F095A0AE
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00095287A8D
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5931B2ECB;
	Wed, 21 Aug 2024 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llyy+KIh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432A51B2EC8;
	Wed, 21 Aug 2024 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252214; cv=none; b=Bs8ZlvmNI/7fbhu1ltZ/Doc+VeL+UhT8BTFE7injipxCA2UTOqaXzUZTVmBUhkS/TO9KYRJZ07TQGZorM/c53zlwhE2/MZghBiQFuQ2ZyEWiKaUhMP0fM+ENAwzuAApGj5trYpY7PrF+8pcw3MsdNGaPRpUTABbr8YING/fJF0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252214; c=relaxed/simple;
	bh=Ng2wryBZs3XNWr24ouKyRCGiOfTgjJNjzaseu9+7SN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzvherGzxtYxF7HpmeKlGU2V/sah+v7AAAES2yy0M/gMLlACo89DdTBydbbSJR/Iq6Xai1BvvO+FXelTqLh4x1nIBTQFOSHy+7Ow0VDD+RppujyzyXRxiATqyBjPcFTii1bsm2FdBucRH/q6X7HLEtwXif9fh++PuAGtAEUuZzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llyy+KIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2F6C32781;
	Wed, 21 Aug 2024 14:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252213;
	bh=Ng2wryBZs3XNWr24ouKyRCGiOfTgjJNjzaseu9+7SN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=llyy+KIhX1W+DSaq+oJyefG4aRwkXqkbZGFplrgiu5YOCgr8yBfA2Y5OTTqbGkJae
	 60YVZl0l/611Xyrj1O8h8pfL13qAiiPxXLh7o2X3Ybxy06a4ijBxJT87whjtz+H1Cf
	 EgiXuHSO2K9ne2K67GJtVK36hAVIcjM9u4NmYMKTsKVrTQ0dYAUyIXTcyXMxC66agz
	 01Mj8uf7tyAUmfRXW4XQcKpHD1N7gTA403fc9O//OJXnhPdrQXaoY3W0+w8a4KKbKV
	 autV7Etw1ocap9L6LUUyM0XSIXmzxAxxMLbcYVh7TA0X/UFqcxgvZWponyf1fDeAOr
	 ZVyBSDv8L179A==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.15.y 14/18] nfsd: rename NFSD_NET_* to NFSD_STATS_*
Date: Wed, 21 Aug 2024 10:55:44 -0400
Message-ID: <20240821145548.25700-15-cel@kernel.org>
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

[ Upstream commit d98416cc2154053950610bb6880911e3dcbdf8c5 ]

We're going to merge the stats all into per network namespace in
subsequent patches, rename these nn counters to be consistent with the
rest of the stats.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/netns.h    | 4 ++--
 fs/nfsd/nfscache.c | 4 ++--
 fs/nfsd/stats.h    | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 51a4b7885cae..d1428f96aa5c 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -25,9 +25,9 @@ struct nfsd4_client_tracking_ops;
 
 enum {
 	/* cache misses due only to checksum comparison failures */
-	NFSD_NET_PAYLOAD_MISSES,
+	NFSD_STATS_PAYLOAD_MISSES,
 	/* amount of memory (in bytes) currently consumed by the DRC */
-	NFSD_NET_DRC_MEM_USAGE,
+	NFSD_STATS_DRC_MEM_USAGE,
 	NFSD_NET_COUNTERS_NUM
 };
 
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 7e1a53c10a7c..b81308cac392 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -673,7 +673,7 @@ int nfsd_reply_cache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&nn->num_drc_entries));
 	seq_printf(m, "hash buckets:          %u\n", 1 << nn->maskbits);
 	seq_printf(m, "mem usage:             %lld\n",
-		   percpu_counter_sum_positive(&nn->counter[NFSD_NET_DRC_MEM_USAGE]));
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_DRC_MEM_USAGE]));
 	seq_printf(m, "cache hits:            %lld\n",
 		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_HITS]));
 	seq_printf(m, "cache misses:          %lld\n",
@@ -681,7 +681,7 @@ int nfsd_reply_cache_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "not cached:            %lld\n",
 		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]));
 	seq_printf(m, "payload misses:        %lld\n",
-		   percpu_counter_sum_positive(&nn->counter[NFSD_NET_PAYLOAD_MISSES]));
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_PAYLOAD_MISSES]));
 	seq_printf(m, "longest chain len:     %u\n", nn->longest_chain);
 	seq_printf(m, "cachesize at longest:  %u\n", nn->longest_chain_cachesize);
 	return 0;
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index ac58c4b2ab70..a660f0fb799f 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -80,17 +80,17 @@ static inline void nfsd_stats_io_write_add(struct svc_export *exp, s64 amount)
 
 static inline void nfsd_stats_payload_misses_inc(struct nfsd_net *nn)
 {
-	percpu_counter_inc(&nn->counter[NFSD_NET_PAYLOAD_MISSES]);
+	percpu_counter_inc(&nn->counter[NFSD_STATS_PAYLOAD_MISSES]);
 }
 
 static inline void nfsd_stats_drc_mem_usage_add(struct nfsd_net *nn, s64 amount)
 {
-	percpu_counter_add(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
+	percpu_counter_add(&nn->counter[NFSD_STATS_DRC_MEM_USAGE], amount);
 }
 
 static inline void nfsd_stats_drc_mem_usage_sub(struct nfsd_net *nn, s64 amount)
 {
-	percpu_counter_sub(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
+	percpu_counter_sub(&nn->counter[NFSD_STATS_DRC_MEM_USAGE], amount);
 }
 
 #endif /* _NFSD_STATS_H */
-- 
2.45.2


