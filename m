Return-Path: <linux-nfs+bounces-8065-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCA39D1A5E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A63281601
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8248F1E7C19;
	Mon, 18 Nov 2024 21:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDXRtRc5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C761E766A;
	Mon, 18 Nov 2024 21:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964841; cv=none; b=O3FtxO/3rY4ImdfqNiQ5vTbO/J3DTAzIft7fh1FUZoDyJedy3PN55phF7awWjlola6JMwN7ovYnKjX5vKJ2zguTW6T6EJOD/4IIEB3y50ToXSFH+LjhOPs9jTq9VQAG5XnPKexSh9jBfo4j1J9KXMnfKEVkOyDP7nALWf2LulhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964841; c=relaxed/simple;
	bh=Mv9C89UEb6BwNWw2CptmrYpVgSGlhxdwnhHXXdBY01o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngPKk0r1ILuYQ0wFKrXPL/r9LGRPircuUXutooIJhK4lppCRn6sAbCnZqvk4ub3Sx8rxFEymWTvP63tXhSY2/z1jU0Twc0pg9qKHmAlhpS5/3/ODqgPA559bNap6eCP8zhshc09SEGjiTBmPDQkngAN1QbySROwn9f1d1bMzMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDXRtRc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE2EC4CEDA;
	Mon, 18 Nov 2024 21:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964841;
	bh=Mv9C89UEb6BwNWw2CptmrYpVgSGlhxdwnhHXXdBY01o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eDXRtRc5WzwbekDi9LAZkgQ1jZtQvA4vFhigWbRVkYU/iGJtCFGAJgi4kOYaqZTa5
	 fHruOTq3k7JrA9NAnZ8ErBNVt9N271Ntt6GwOWjkhDMqM2LpxCWclIUXShv9cf8HD+
	 FBb0cYlFx2U1WdDJxvwwQ28CjBIUd4jFVsqZcxvyjOHyVU+isHZ/P+3CT7GPERuXDF
	 t/2SWDvdzOm2vmGplOU29JJsy/+ZgctDSDreqEtXINX8PO8Ify7jwuDiUAAeLuD65K
	 eduzAYQfmZbQkwsLY4uaMMNqv1STMAT4ieVjSnp6U3NwDw7HiWe+IsNklUouriHXv7
	 7hMTCxb1v37IA==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Eirik Fuller <efuller@redhat.com>
Subject: [PATCH 5.15.y 02/18] nfsd: move init of percpu reply_cache_stats counters back to nfsd_init_net
Date: Mon, 18 Nov 2024 16:20:16 -0500
Message-ID: <20241118212035.3848-5-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118212035.3848-1-cel@kernel.org>
References: <20241118212035.3848-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit ed9ab7346e908496816cffdecd46932035f66e2e ]

Commit f5f9d4a314da ("nfsd: move reply cache initialization into nfsd
startup") moved the initialization of the reply cache into nfsd startup,
but didn't account for the stats counters, which can be accessed before
nfsd is ever started. The result can be a NULL pointer dereference when
someone accesses /proc/fs/nfsd/reply_cache_stats while nfsd is still
shut down.

This is a regression and a user-triggerable oops in the right situation:

- non-x86_64 arch
- /proc/fs/nfsd is mounted in the namespace
- nfsd is not started in the namespace
- unprivileged user calls "cat /proc/fs/nfsd/reply_cache_stats"

Although this is easy to trigger on some arches (like aarch64), on
x86_64, calling this_cpu_ptr(NULL) evidently returns a pointer to the
fixed_percpu_data. That struct looks just enough like a newly
initialized percpu var to allow nfsd_reply_cache_stats_show to access
it without Oopsing.

Move the initialization of the per-net+per-cpu reply-cache counters
back into nfsd_init_net, while leaving the rest of the reply cache
allocations to be done at nfsd startup time.

Kudos to Eirik who did most of the legwork to track this down.

Cc: stable@vger.kernel.org # v6.3+
Fixes: f5f9d4a314da ("nfsd: move reply cache initialization into nfsd startup")
Reported-and-tested-by: Eirik Fuller <efuller@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2215429
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Stable-dep-of: 4b14885411f7 ("nfsd: make all of the nfsd stats per-network namespace")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/cache.h    |  2 ++
 fs/nfsd/nfscache.c | 25 ++++++++++++++-----------
 fs/nfsd/nfsctl.c   | 10 +++++++++-
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
index f21259ead64b..4c9b87850ab1 100644
--- a/fs/nfsd/cache.h
+++ b/fs/nfsd/cache.h
@@ -80,6 +80,8 @@ enum {
 
 int	nfsd_drc_slab_create(void);
 void	nfsd_drc_slab_free(void);
+int	nfsd_net_reply_cache_init(struct nfsd_net *nn);
+void	nfsd_net_reply_cache_destroy(struct nfsd_net *nn);
 int	nfsd_reply_cache_init(struct nfsd_net *);
 void	nfsd_reply_cache_shutdown(struct nfsd_net *);
 int	nfsd_cache_lookup(struct svc_rqst *);
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 2b5417e06d80..587ff31deb6e 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -148,12 +148,23 @@ void nfsd_drc_slab_free(void)
 	kmem_cache_destroy(drc_slab);
 }
 
-static int nfsd_reply_cache_stats_init(struct nfsd_net *nn)
+/**
+ * nfsd_net_reply_cache_init - per net namespace reply cache set-up
+ * @nn: nfsd_net being initialized
+ *
+ * Returns zero on succes; otherwise a negative errno is returned.
+ */
+int nfsd_net_reply_cache_init(struct nfsd_net *nn)
 {
 	return nfsd_percpu_counters_init(nn->counter, NFSD_NET_COUNTERS_NUM);
 }
 
-static void nfsd_reply_cache_stats_destroy(struct nfsd_net *nn)
+/**
+ * nfsd_net_reply_cache_destroy - per net namespace reply cache tear-down
+ * @nn: nfsd_net being freed
+ *
+ */
+void nfsd_net_reply_cache_destroy(struct nfsd_net *nn)
 {
 	nfsd_percpu_counters_destroy(nn->counter, NFSD_NET_COUNTERS_NUM);
 }
@@ -169,16 +180,12 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 	hashsize = nfsd_hashsize(nn->max_drc_entries);
 	nn->maskbits = ilog2(hashsize);
 
-	status = nfsd_reply_cache_stats_init(nn);
-	if (status)
-		goto out_nomem;
-
 	nn->nfsd_reply_cache_shrinker.scan_objects = nfsd_reply_cache_scan;
 	nn->nfsd_reply_cache_shrinker.count_objects = nfsd_reply_cache_count;
 	nn->nfsd_reply_cache_shrinker.seeks = 1;
 	status = register_shrinker(&nn->nfsd_reply_cache_shrinker);
 	if (status)
-		goto out_stats_destroy;
+		return status;
 
 	nn->drc_hashtbl = kvzalloc(array_size(hashsize,
 				sizeof(*nn->drc_hashtbl)), GFP_KERNEL);
@@ -194,9 +201,6 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 	return 0;
 out_shrinker:
 	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
-out_stats_destroy:
-	nfsd_reply_cache_stats_destroy(nn);
-out_nomem:
 	printk(KERN_ERR "nfsd: failed to allocate reply cache\n");
 	return -ENOMEM;
 }
@@ -216,7 +220,6 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
 									rp, nn);
 		}
 	}
-	nfsd_reply_cache_stats_destroy(nn);
 
 	kvfree(nn->drc_hashtbl);
 	nn->drc_hashtbl = NULL;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 1c39a4e6294d..cc538b8c0287 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1458,6 +1458,9 @@ static __net_init int nfsd_init_net(struct net *net)
 	retval = nfsd_idmap_init(net);
 	if (retval)
 		goto out_idmap_error;
+	retval = nfsd_net_reply_cache_init(nn);
+	if (retval)
+		goto out_repcache_error;
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
@@ -1466,6 +1469,8 @@ static __net_init int nfsd_init_net(struct net *net)
 
 	return 0;
 
+out_repcache_error:
+	nfsd_idmap_shutdown(net);
 out_idmap_error:
 	nfsd_export_shutdown(net);
 out_export_error:
@@ -1474,9 +1479,12 @@ static __net_init int nfsd_init_net(struct net *net)
 
 static __net_exit void nfsd_exit_net(struct net *net)
 {
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	nfsd_net_reply_cache_destroy(nn);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
-	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
+	nfsd_netns_free_versions(nn);
 }
 
 static struct pernet_operations nfsd_net_ops = {
-- 
2.45.2


