Return-Path: <linux-nfs+bounces-17059-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 712CACB9F6A
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 23:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF31B30022DB
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 22:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805662D94AA;
	Fri, 12 Dec 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJsfWRvy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F342D839B;
	Fri, 12 Dec 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579182; cv=none; b=O2PmXKNzn3fnn+94LUgSzAXqtHzOOcYaS7sZmsTKQ0ojFhn17D2/MvmGOpxmDwzEfSObm0bnLi+m9Si/hvn9lkBTDX6ZyIrxJbmLU65mNTn3282DeVGIpouF+3YkPPePH9b53hX13NqiXIiHUqod3AJ2yA2UkwPMYqPU44+bc+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579182; c=relaxed/simple;
	bh=dIE975TUgkAuUNw4EjZWFUdwmYqV3JHWMaIbUC7wnxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=flFLpYLdp6powqBMeWRsz7gBP3y/Zu9j9NFNDO/mCWvjYRpKO7NzZPl8j9swYSXl6ORRUzSL2svG1ZVUk67BTYu6cWh+39yXmqLb+SRGSkeB1qignbbjOXfK0Zoo9KN4ajmv2C2YaUouqo/PQSLhD1cwZvH6rG4qzQ6Hd3UHyxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJsfWRvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C5BC4CEF5;
	Fri, 12 Dec 2025 22:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765579181;
	bh=dIE975TUgkAuUNw4EjZWFUdwmYqV3JHWMaIbUC7wnxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SJsfWRvyEjyFcSBbcy7d7I8tJP/VBXJWI7tR8u5WRmeDUStmYmLwrn2e8nn7ZuGnN
	 wCbxp9soyBaPWxBJ+XFDH2r6dl68NXxoXXJW5mn7Mg1Mkh6LJ+WDLVfwFIjuX18G1s
	 ehBnSCaov7XW0Lca7yJb7m1YSFIBCfrqvHPZNcZe2yVG9hHejFWGJnhCAqB+eEzpqV
	 +d15HUt7lE1Xi/w55lVtFNqkOzJ2KWZFNK11urS2SijD2qC4n38pBs53+8u911r0IG
	 qY230Avi+psyXSIVHd2lih2qApHsiAbPvw9IV5lAugIB1EDw6wuZRherPL28xE64R9
	 bH803UIbVLzaw==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 13 Dec 2025 07:39:13 +0900
Subject: [PATCH RFC 1/6] sunrpc: split svc_set_num_threads() into two
 functions
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251213-nfsd-dynathread-v1-1-de755e59cbc4@kernel.org>
References: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
In-Reply-To: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8388; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=dIE975TUgkAuUNw4EjZWFUdwmYqV3JHWMaIbUC7wnxw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpPJmn8cWhIfZNCyBWM8NYjCh5ziIOmcH9PoNF2
 OWFq8hnBlaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaTyZpwAKCRAADmhBGVaC
 FYoWD/9R9Djb7EaVW5MEtVc3jAinkSGiG4ujhO6oNXDMjMAXsQ7z6i08GYp75xksEBqhr8MUQFa
 oAp+siOiQxmtBsLZT0SO8uSOOTEvKsXXGufRKSFnuv9KNHQ2HwIwaI18VZHrJFtQgQ4coSF5pzo
 ZlQGjrlFtobqe+Tt1DYkusKmJsEn95jst89Fu9eZ35A+hznOtg06cIyDqazpVGAMGVuhR9Vmy+o
 FR22oBeJNxmBAc94k/4j33/6qH7RQtW/SdLA2Ev7kIItjYcBl9kyq3ZogsYDcQT0q8qY2Av8Yxm
 7QXO6ffK4vR7T3BW5WClwVODP9LVxCyG1Sm1L6h5ARhZ/VNcY0F+7wlxll6Aur8ckLtdQbdJn2C
 B+pmxj9eEa3DVQcoKx5kxe1uliYOiPvj4lGOvdrDj9evuymh23E00GNrL9ZvAXgJ+RZ6BbixgrC
 be/V8+e1eoC6MZQf+evDuD+PFxuFd4wn6TKcpG21a4PvBWDcnCbup0eqqZ/0lxxHe64WiqemYyQ
 AtJ5iQ76UKB4Kf8E2h8pw255ezmLZ9u9B+bsF6fO0kGThiBkWRkj12pAOjNs92zELB28YaBI2YZ
 3D99hgZZLaIpfaQ9piDCAtdYS69/9XXuQNBM36Uy4jOGQz5fjf/oN7O79NaCPI2SbZCIavtyKtg
 OUBN1HCh8let/Fg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

svc_set_num_threads() will set the number of running threads for a given
pool. If the pool argument is set to NULL however, it will distribute
the threads among all of the pools evenly.

These divergent codepaths complicate the move to dynamic threading.
Simplify the API by splitting these two cases into different helpers:

Add a new svc_set_pool_threads() function that sets the number of
threads in a single, given pool. Modify svc_set_num_threads() to
distribute the threads evenly between all of the pools and then call
svc_set_pool_threads() for each.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svc.c             |  4 ++--
 fs/nfs/callback.c          |  8 +++----
 fs/nfsd/nfssvc.c           | 21 ++++++++----------
 include/linux/sunrpc/svc.h |  3 ++-
 net/sunrpc/svc.c           | 54 +++++++++++++++++++++++++++++++++++++---------
 5 files changed, 61 insertions(+), 29 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index d68afa196535a8785bab2931c2b14f03a1174ef9..fbf132b4e08d11a91784c21ee0209fd7c149fd9d 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -340,7 +340,7 @@ static int lockd_get(void)
 		return -ENOMEM;
 	}
 
-	error = svc_set_num_threads(serv, NULL, 1);
+	error = svc_set_num_threads(serv, 1);
 	if (error < 0) {
 		svc_destroy(&serv);
 		return error;
@@ -368,7 +368,7 @@ static void lockd_put(void)
 	unregister_inet6addr_notifier(&lockd_inet6addr_notifier);
 #endif
 
-	svc_set_num_threads(nlmsvc_serv, NULL, 0);
+	svc_set_num_threads(nlmsvc_serv, 0);
 	timer_delete_sync(&nlmsvc_retry);
 	svc_destroy(&nlmsvc_serv);
 	dprintk("lockd_down: service destroyed\n");
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index c8b837006bb27277ab34fe516f1b63992fee9b7f..44b35b7f8dc022f1d8c069eaf2f7d334c93f77fc 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -119,9 +119,9 @@ static int nfs_callback_start_svc(int minorversion, struct rpc_xprt *xprt,
 	if (serv->sv_nrthreads == nrservs)
 		return 0;
 
-	ret = svc_set_num_threads(serv, NULL, nrservs);
+	ret = svc_set_num_threads(serv, nrservs);
 	if (ret) {
-		svc_set_num_threads(serv, NULL, 0);
+		svc_set_num_threads(serv, 0);
 		return ret;
 	}
 	dprintk("nfs_callback_up: service started\n");
@@ -242,7 +242,7 @@ int nfs_callback_up(u32 minorversion, struct rpc_xprt *xprt)
 	cb_info->users++;
 err_net:
 	if (!cb_info->users) {
-		svc_set_num_threads(cb_info->serv, NULL, 0);
+		svc_set_num_threads(cb_info->serv, 0);
 		svc_destroy(&cb_info->serv);
 	}
 err_create:
@@ -268,7 +268,7 @@ void nfs_callback_down(int minorversion, struct net *net)
 	nfs_callback_down_net(minorversion, serv, net);
 	cb_info->users--;
 	if (cb_info->users == 0) {
-		svc_set_num_threads(serv, NULL, 0);
+		svc_set_num_threads(serv, 0);
 		dprintk("nfs_callback_down: service destroyed\n");
 		svc_destroy(&cb_info->serv);
 	}
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 93f7435cafd2362d9ddb28815277c824067cb370..aafec8ff588b85b0e26d40b76ef00953dc6472b4 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -594,7 +594,7 @@ void nfsd_shutdown_threads(struct net *net)
 	}
 
 	/* Kill outstanding nfsd threads */
-	svc_set_num_threads(serv, NULL, 0);
+	svc_set_num_threads(serv, 0);
 	nfsd_destroy_serv(net);
 	mutex_unlock(&nfsd_mutex);
 }
@@ -702,12 +702,9 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 	if (nn->nfsd_serv == NULL || n <= 0)
 		return 0;
 
-	/*
-	 * Special case: When n == 1, pass in NULL for the pool, so that the
-	 * change is distributed equally among them.
-	 */
+	/* Special case: When n == 1, distribute threads equally among pools. */
 	if (n == 1)
-		return svc_set_num_threads(nn->nfsd_serv, NULL, nthreads[0]);
+		return svc_set_num_threads(nn->nfsd_serv, nthreads[0]);
 
 	if (n > nn->nfsd_serv->sv_nrpools)
 		n = nn->nfsd_serv->sv_nrpools;
@@ -733,18 +730,18 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 
 	/* apply the new numbers */
 	for (i = 0; i < n; i++) {
-		err = svc_set_num_threads(nn->nfsd_serv,
-					  &nn->nfsd_serv->sv_pools[i],
-					  nthreads[i]);
+		err = svc_set_pool_threads(nn->nfsd_serv,
+					   &nn->nfsd_serv->sv_pools[i],
+					   nthreads[i]);
 		if (err)
 			goto out;
 	}
 
 	/* Anything undefined in array is considered to be 0 */
 	for (i = n; i < nn->nfsd_serv->sv_nrpools; ++i) {
-		err = svc_set_num_threads(nn->nfsd_serv,
-					  &nn->nfsd_serv->sv_pools[i],
-					  0);
+		err = svc_set_pool_threads(nn->nfsd_serv,
+					   &nn->nfsd_serv->sv_pools[i],
+					   0);
 		if (err)
 			goto out;
 	}
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 5506d20857c318774cd223272d4b0022cc19ffb8..dd5fbbf8b3d39df6c17a7624edf344557fffd32c 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -446,7 +446,8 @@ struct svc_serv *  svc_create_pooled(struct svc_program *prog,
 				     struct svc_stat *stats,
 				     unsigned int bufsize,
 				     int (*threadfn)(void *data));
-int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
+int		   svc_set_pool_threads(struct svc_serv *, struct svc_pool *, int);
+int		   svc_set_num_threads(struct svc_serv *, int);
 int		   svc_pool_stats_open(struct svc_info *si, struct file *file);
 void		   svc_process(struct svc_rqst *rqstp);
 void		   svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 4704dce7284eccc9e2bc64cf22947666facfa86a..3fe5a7f8e57e3fa3837265ec06884b357d5373ff 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -856,15 +856,12 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 }
 
 /**
- * svc_set_num_threads - adjust number of threads per RPC service
+ * svc_set_pool_threads - adjust number of threads per pool
  * @serv: RPC service to adjust
- * @pool: Specific pool from which to choose threads, or NULL
+ * @pool: Specific pool from which to choose threads
  * @nrservs: New number of threads for @serv (0 or less means kill all threads)
  *
- * Create or destroy threads to make the number of threads for @serv the
- * given number. If @pool is non-NULL, change only threads in that pool;
- * otherwise, round-robin between all pools for @serv. @serv's
- * sv_nrthreads is adjusted for each thread created or destroyed.
+ * Create or destroy threads in @pool to bring it to @nrservs.
  *
  * Caller must ensure mutual exclusion between this and server startup or
  * shutdown.
@@ -873,12 +870,12 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
  * starting a thread.
  */
 int
-svc_set_num_threads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
+svc_set_pool_threads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 {
 	if (!pool)
-		nrservs -= serv->sv_nrthreads;
-	else
-		nrservs -= pool->sp_nrthreads;
+		return -EINVAL;
+
+	nrservs -= pool->sp_nrthreads;
 
 	if (nrservs > 0)
 		return svc_start_kthreads(serv, pool, nrservs);
@@ -886,6 +883,43 @@ svc_set_num_threads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 		return svc_stop_kthreads(serv, pool, nrservs);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(svc_set_pool_threads);
+
+/**
+ * svc_set_num_threads - adjust number of threads in serv
+ * @serv: RPC service to adjust
+ * @nrservs: New number of threads for @serv (0 or less means kill all threads)
+ *
+ * Create or destroy threads in @serv to bring it to @nrservs. If there
+ * are multiple pools then the new threads or victims will be distributed
+ * evenly among them.
+ *
+ * Caller must ensure mutual exclusion between this and server startup or
+ * shutdown.
+ *
+ * Returns zero on success or a negative errno if an error occurred while
+ * starting a thread.
+ */
+int
+svc_set_num_threads(struct svc_serv *serv, int nrservs)
+{
+	int base = nrservs / serv->sv_nrpools;
+	int remain = nrservs % serv->sv_nrpools;
+	int i, err;
+
+	for (i = 0; i < serv->sv_nrpools; ++i) {
+		int threads = base;
+
+		if (remain) {
+			++threads;
+			--remain;
+		}
+		err = svc_set_pool_threads(serv, &serv->sv_pools[i], threads);
+		if (err)
+			break;
+	}
+	return err;
+}
 EXPORT_SYMBOL_GPL(svc_set_num_threads);
 
 /**

-- 
2.52.0


