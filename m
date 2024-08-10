Return-Path: <linux-nfs+bounces-5295-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4042B94DE70
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 22:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BCE282C69
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 20:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E559147A62;
	Sat, 10 Aug 2024 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/QSi0Px"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE08E125BA;
	Sat, 10 Aug 2024 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320081; cv=none; b=oihjNzdB8mk1Jqo7l4Ytd1IiSN7ekCxnRunSSAtkfB/fdYFyA9CLBzmaDcFp0AHl25OgxGE/Wbse7OHkhqvlJxPpZUvcQZGInaaKlRCU3nibcxMnenJrlGaJLOhtCkXzJy69EyXLFSGGC7hnSgsIPcEHim7CDrOQM/maJ7BJfCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320081; c=relaxed/simple;
	bh=IZ6XX4/xqUE5wLc5yWjtnyFlhRkRARGUaoue/avrJKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbswSvJ3pwB1pngw3F+vuFuMjIsM7/A0eKDR2SEckepepb7j7pBrqHfrhBJHtzg5oaMevFBIi0nhc+AkAVDEmfsZ8GrLCzUMv2EMNJSFnjPA/M9MfPLgYBnyp8vFyvEIMwfRXu9Lk5niqvSD8M4XM1YXTByN5WOM5OQS99ItbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/QSi0Px; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC74FC32781;
	Sat, 10 Aug 2024 20:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723320081;
	bh=IZ6XX4/xqUE5wLc5yWjtnyFlhRkRARGUaoue/avrJKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/QSi0PxhBm9bbBcraN0iopAb4Mp4WNP9Ezp0PDERITV3CQ9JaQigyQ5vjL5/gT0y
	 PkD8upKZ2QTvAqL6pUlx+N7g5pfO9VV7HOkUpYnpf1srcte4i4ga9RQUoC95EUrlfw
	 i3EcMT8V1snGh0ysAo/9uRNy2v+tzyYb/6qmHjCjbGNvX4VpVq6O5WBmLE0fvkFlD3
	 FtSCe8aMzm7bRUqkUOVLqPPZeqaqgk6c6HM/g7ZET2XQxj05cl/Bh9fh43WgfekQxF
	 a44Z2OiEHy5dl/j5CW+Rpr4/atLaLnsI6xJ7nT+nGgRNVDEbf/QvRpYXdeVzfuzwW2
	 1hOPBI0uc8AEw==
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
Subject: [PATCH 6.1.y 15/18] nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
Date: Sat, 10 Aug 2024 16:00:06 -0400
Message-ID: <20240810200009.9882-16-cel@kernel.org>
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

[ Upstream commit 93483ac5fec62cc1de166051b219d953bb5e4ef4 ]

We are running nfsd servers inside of containers with their own network
namespace, and we want to monitor these services using the stats found
in /proc.  However these are not exposed in the proc inside of the
container, so we have to bind mount the host /proc into our containers
to get at this information.

Separate out the stat counters init and the proc registration, and move
the proc registration into the pernet operations entry and exit points
so that these stats can be exposed inside of network namespaces.

This is an intermediate step, this just exposes the global counters in
the network namespace.  Subsequent patches will move these counters into
the per-network namespace container.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c |  8 +++++---
 fs/nfsd/stats.c  | 21 ++++++---------------
 fs/nfsd/stats.h  |  6 ++++--
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 20e603ff6998..fde309b26cbb 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1458,6 +1458,7 @@ static __net_init int nfsd_init_net(struct net *net)
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
+	nfsd_proc_stat_init(net);
 
 	return 0;
 
@@ -1473,6 +1474,7 @@ static __net_exit void nfsd_exit_net(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	nfsd_proc_stat_shutdown(net);
 	nfsd_net_reply_cache_destroy(nn);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
@@ -1496,7 +1498,7 @@ static int __init init_nfsd(void)
 	retval = nfsd4_init_pnfs();
 	if (retval)
 		goto out_free_slabs;
-	retval = nfsd_stat_init();	/* Statistics */
+	retval = nfsd_stat_counters_init();	/* Statistics */
 	if (retval)
 		goto out_free_pnfs;
 	retval = nfsd_drc_slab_create();
@@ -1532,7 +1534,7 @@ static int __init init_nfsd(void)
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
 out_free_stat:
-	nfsd_stat_shutdown();
+	nfsd_stat_counters_destroy();
 out_free_pnfs:
 	nfsd4_exit_pnfs();
 out_free_slabs:
@@ -1549,7 +1551,7 @@ static void __exit exit_nfsd(void)
 	nfsd_drc_slab_free();
 	remove_proc_entry("fs/nfs/exports", NULL);
 	remove_proc_entry("fs/nfs", NULL);
-	nfsd_stat_shutdown();
+	nfsd_stat_counters_destroy();
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
 	nfsd4_exit_pnfs();
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 1fe6488a1cf9..22d57f92187e 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -106,31 +106,22 @@ void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
 		percpu_counter_destroy(&counters[i]);
 }
 
-static int nfsd_stat_counters_init(void)
+int nfsd_stat_counters_init(void)
 {
 	return nfsd_percpu_counters_init(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
 }
 
-static void nfsd_stat_counters_destroy(void)
+void nfsd_stat_counters_destroy(void)
 {
 	nfsd_percpu_counters_destroy(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
 }
 
-int nfsd_stat_init(void)
+void nfsd_proc_stat_init(struct net *net)
 {
-	int err;
-
-	err = nfsd_stat_counters_init();
-	if (err)
-		return err;
-
-	svc_proc_register(&init_net, &nfsd_svcstats, &nfsd_proc_ops);
-
-	return 0;
+	svc_proc_register(net, &nfsd_svcstats, &nfsd_proc_ops);
 }
 
-void nfsd_stat_shutdown(void)
+void nfsd_proc_stat_shutdown(struct net *net)
 {
-	nfsd_stat_counters_destroy();
-	svc_proc_unregister(&init_net, "nfsd");
+	svc_proc_unregister(net, "nfsd");
 }
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index a660f0fb799f..31756a9a8a0a 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -39,8 +39,10 @@ extern struct svc_stat		nfsd_svcstats;
 int nfsd_percpu_counters_init(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_reset(struct percpu_counter *counters, int num);
 void nfsd_percpu_counters_destroy(struct percpu_counter *counters, int num);
-int nfsd_stat_init(void);
-void nfsd_stat_shutdown(void);
+int nfsd_stat_counters_init(void);
+void nfsd_stat_counters_destroy(void);
+void nfsd_proc_stat_init(struct net *net);
+void nfsd_proc_stat_shutdown(struct net *net);
 
 static inline void nfsd_stats_rc_hits_inc(void)
 {
-- 
2.45.1


