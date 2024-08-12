Return-Path: <linux-nfs+bounces-5335-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2BB94F9B7
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2024 00:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C017F28403A
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 22:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD678198E88;
	Mon, 12 Aug 2024 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyVQ3QcG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8567E198850;
	Mon, 12 Aug 2024 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502264; cv=none; b=kU+HwYDHGTrsM7lc/o6IpgRkTi1Ea7kpppUkklLXqgEWNvhSN+8mPmeCSSVmWNSoPD0qYHoNgIRdnkxPqPPgqxoI6cQ5tZABxr442GSqBrYLFJhyFMUj7gYi8ozpkGWDBy5yq6Vojq05mtMC7zPK6pSC+/BFR5KQ8I34c6q+KIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502264; c=relaxed/simple;
	bh=A9vqvqYYvBU9ozFuUkqJsDTUAyIyy/ojCgNdEIeVcUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCPPXKXiEBlO3Ev4LnZFhBCAUHH+CHxS+nooSYjSAwZdFau+uYgGsdxcmCYEgyQHaLbMgCXc1Gfc4LB/UnTnUZVAVkqhlzC726tOaHj9GyhixREQPgVOofFWgJRwUjdSl2EtpoUPXiwjokdK1W3gmy4g8iEAIJn2gTGqStOAqdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyVQ3QcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE06C4AF0D;
	Mon, 12 Aug 2024 22:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723502264;
	bh=A9vqvqYYvBU9ozFuUkqJsDTUAyIyy/ojCgNdEIeVcUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fyVQ3QcGe5dRt8lvTx9KMVDaTbYopZyiIdTBNIjpSrprcCg5F0KskSmwuDOcSoi52
	 1hPXroBZ6302D5JbnN/FHeb1D4wUKlys9x4QlK5EuSjNgm8klznK9A9vtdVgrTdDwu
	 kDu/pz91dZhffkflRqbW7KUkD09kKQo+AXqN/WFA8b/PtDwa0NfryKHZyBN06yeUtQ
	 oAlYKoGk9gq/FPurPlRP6V0FcUTIJv7uNinNTPDrYy+NHZj1MmbDIKGm+8AtgElrT9
	 k7mBKNLzaUoqPxlpG/keM0OfGY953kqPTwyAWCPwDHLQn24mbxANcG7BVgOBJUWK/t
	 Gr3EkJ1FHQkGg==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.6.y 09/12] nfsd: expose /proc/net/sunrpc/nfsd in net namespaces
Date: Mon, 12 Aug 2024 18:36:01 -0400
Message-ID: <20240812223604.32592-10-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240812223604.32592-1-cel@kernel.org>
References: <20240812223604.32592-1-cel@kernel.org>
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
index a13e81e45071..42d0e3c14f0c 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1532,6 +1532,7 @@ static __net_init int nfsd_net_init(struct net *net)
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
+	nfsd_proc_stat_init(net);
 
 	return 0;
 
@@ -1552,6 +1553,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	nfsd_proc_stat_shutdown(net);
 	nfsd_net_reply_cache_destroy(nn);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
@@ -1575,7 +1577,7 @@ static int __init init_nfsd(void)
 	retval = nfsd4_init_pnfs();
 	if (retval)
 		goto out_free_slabs;
-	retval = nfsd_stat_init();	/* Statistics */
+	retval = nfsd_stat_counters_init();	/* Statistics */
 	if (retval)
 		goto out_free_pnfs;
 	retval = nfsd_drc_slab_create();
@@ -1611,7 +1613,7 @@ static int __init init_nfsd(void)
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
 out_free_stat:
-	nfsd_stat_shutdown();
+	nfsd_stat_counters_destroy();
 out_free_pnfs:
 	nfsd4_exit_pnfs();
 out_free_slabs:
@@ -1628,7 +1630,7 @@ static void __exit exit_nfsd(void)
 	nfsd_drc_slab_free();
 	remove_proc_entry("fs/nfs/exports", NULL);
 	remove_proc_entry("fs/nfs", NULL);
-	nfsd_stat_shutdown();
+	nfsd_stat_counters_destroy();
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
 	nfsd4_exit_pnfs();
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index 12c299a05433..246882eb7f95 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -108,31 +108,22 @@ void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
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
index 7ed4325ac691..38811aa7d13e 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -40,8 +40,10 @@ extern struct svc_stat		nfsd_svcstats;
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


