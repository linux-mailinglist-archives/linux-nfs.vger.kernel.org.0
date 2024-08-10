Return-Path: <linux-nfs+bounces-5294-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ED894DE6E
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 22:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A911C21450
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 20:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1A113D285;
	Sat, 10 Aug 2024 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ge6TOuRT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31071311A3;
	Sat, 10 Aug 2024 20:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320079; cv=none; b=s/DN4m1iuAP6dcxhvCHeTE/rlfbEk4s8eWV6UdPWfDFqx5mJGRA3yaf2ZzVp3qZy9cVrzm8druPtSKyFOOLJ/NJ3MZg4GmEqCy2B/+/zLRHWQtO0n4nD4dDSaxjnZKLZvP7ReNeltUktyPe2SU+brERic8iKnp8mrEerJ9R2f5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320079; c=relaxed/simple;
	bh=EtRfMRn3/3/P819z7fDvQseKq+OZZwntejtQQzOLf5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkkiGh3v2UHswuzUNZQa3oGtQ5s21YRKv0B5sDQK+UisbQnoCaDClDaUq1CAGtTeBLARMDczu+V4e1Hov/gdk8HirCzpl9cZYtIuVhXUt8Gz+90nQ0c2HLpbphxWsNS9oVeU27I5o/lLaU9GTHnkivVYO+n6f4IUJo22hVtOuM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ge6TOuRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE220C32781;
	Sat, 10 Aug 2024 20:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723320079;
	bh=EtRfMRn3/3/P819z7fDvQseKq+OZZwntejtQQzOLf5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ge6TOuRTvJvUi0VELlr+5IO+7MJunu9EHNm6ylnmpbqeZZ0ASkEMqxCYRMfIQsmMi
	 P39+G6IxMHY/3nz3VknAj21+J9ZAVdxgzmfsHvaIk2N3kF/B8wkxafZBfU3/CKQuBs
	 i1CMxbMyycjRPJrnZSq2PKtlspXCSl1UcW/CCWiPwR+riwrgpUUyYY82P0LIRFhYa5
	 M95pSAD3p918UCix/dyDDvA/qpzMc8iQHQ0pmPkZS7H+MFYug31A9t7PeRanC8X6Xd
	 PghW0iBoMZXjhrYRNmoMdsRQbR/IMzykYy17wpV5dESUoinwoKQcsQDInS+Q7PR0Ur
	 PqDzQfOAFUOWw==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	ltp@lists.linux.it,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.1.y 14/18] nfsd: rename NFSD_NET_* to NFSD_STATS_*
Date: Sat, 10 Aug 2024 16:00:05 -0400
Message-ID: <20240810200009.9882-15-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240810200009.9882-1-cel@kernel.org>
References: <20240810200009.9882-1-cel@kernel.org>
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
index 049565bbef2d..178d7063fffc 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -696,7 +696,7 @@ int nfsd_reply_cache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&nn->num_drc_entries));
 	seq_printf(m, "hash buckets:          %u\n", 1 << nn->maskbits);
 	seq_printf(m, "mem usage:             %lld\n",
-		   percpu_counter_sum_positive(&nn->counter[NFSD_NET_DRC_MEM_USAGE]));
+		   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_DRC_MEM_USAGE]));
 	seq_printf(m, "cache hits:            %lld\n",
 		   percpu_counter_sum_positive(&nfsdstats.counter[NFSD_STATS_RC_HITS]));
 	seq_printf(m, "cache misses:          %lld\n",
@@ -704,7 +704,7 @@ int nfsd_reply_cache_stats_show(struct seq_file *m, void *v)
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
2.45.1


