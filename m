Return-Path: <linux-nfs+bounces-17511-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ECCCFA6E2
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 20:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1610130570AE
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 19:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD83C34DB6F;
	Tue,  6 Jan 2026 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRt27eFD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F79349AE5;
	Tue,  6 Jan 2026 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767726011; cv=none; b=OCkYRNeTxgZO62jmpqiST5XlfAMdy+JqovrVGWBljs9/5WejGKuGHdx2M+vk3C8HJCVykcZerDxYgH8OQWK0mjWWuW1TC+XsdEcWYWao1aL7JRQeW1/uqKLxiRpFwY5c313IvbxDTShr5kN8CGxCrANQmyJhJnk6A5D96z06a+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767726011; c=relaxed/simple;
	bh=n0WiIDW/ChK5r9a2BNqla80LnCwuaRave9gwUBPtV7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kdqb+lnsuuLqStqRZeFYsQndjxONFC06OxoYgZZDPbMKqA8P4iX+ZR/0Yt6L4l6iO2ZKp9tOYDESl5vlwvFAPymfcs34Y8DsCwGLMojGDxjb0go04dQ2oRpZILaQuX1KaxJhWHosqS7yQwsb/AlgbNZ/04PE4oPQ1NdYW3FA5rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRt27eFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A62C116C6;
	Tue,  6 Jan 2026 19:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767726011;
	bh=n0WiIDW/ChK5r9a2BNqla80LnCwuaRave9gwUBPtV7c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GRt27eFDF5WSAmyjFw6XJS+SERI7Ruf2Ywp5Qt5H5UkBVUlgc1aZ4kATrkDPNCLXn
	 Kha56lC/97og8VaCqfRsyjvOPSZz8BHnjbNNBDDQXksoF0CRH3iBwlpds5JI+fJQ0Z
	 38DEiqwZnrah9PGIocoj7walY1DTeR69olpIGTN88nnxRfkcqwy5K1+7BY9TvmiYKA
	 M1jjzuAyPENOCbyjgYWeZxAQya+eFC4+XIe6efdo+hPNu5YlQJb6FL2G6tT0N33Aac
	 LN5lgCQdUE8i8KSKdz60hTt8GoOy+US6yY89pAvDk1OUcrjuTfiPMPYtYqq4hEw1NC
	 /VQzBk5yVGFVw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 06 Jan 2026 13:59:46 -0500
Subject: [PATCH v2 4/8] sunrpc: introduce the concept of a minimum number
 of threads per pool
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-nfsd-dynathread-v2-4-416e5f27b2b6@kernel.org>
References: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
In-Reply-To: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9456; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=n0WiIDW/ChK5r9a2BNqla80LnCwuaRave9gwUBPtV7c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpXVuzvMi12etU9rFVU0MZzQ7wCbJ3d4dtYPuag
 D9qRe1em6eJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV1bswAKCRAADmhBGVaC
 FaOND/9525Zr30u2wdBiuOBJ1xuQwMTQQo2BAMop3E7VFDh3LtPOQ4kK8f8DA5mlZl09Nubw+pB
 ZOuWI9GAaW5kwR+txugpiWIVh3/ZYkfgYmJWX9/hVqJ2iOjKaADBebKGnm+ZWacyuFgXQa9o/mR
 dlhgljldiT/LuwRUMRt6IBFISuO02fNopFIuAhFrzm9byGkQqE4159jexj4MFlP6BR6POAViqqP
 KOUHHkbYkhL60Gkj22hTYxLDP2Xp00uI2Y4hsbmBa9KeE4hxgSCB8NhtqW0IDNjCZ1FT0ZlPj8H
 ao/vpdtOZkWC/IGXZL54Pb67XJMm+MKPwTRJ+UxRXcG1iOLZVX8qatQ4vgSQZdL0g2c7jhPDw1/
 q6H9T4Lhy6AnyIuyzo1z9i9nFNgjvkWjNRPE+4QahaBsIv7PlMYv6A7w9CZImsA5SK+wTef/iuI
 uHUP18BlQ7YjylBZkQ5ZpmtjpCIhYtYeMiw2xCJfBPB3XYguiQlsyogrLCn9g9E6gSCBpVD8ZyB
 dzSgW76xsZ9wxEMTbM43BlMhZjp56/yj9krWpb+UWaApmLwjy5iInnUhKPl4phtZQjGDCdQBCO4
 +CoYifGK/vmjJshShi3dg7V3yZmcA56Y6YKHbRtQGDwbUE1oNkwg8DXtZWM9Hb4QNGxjAztRCMX
 gobRpxR+J5NjyAg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new pool->sp_nrthrmin field to track the minimum number of threads
in a pool. Add min_threads parameters to both svc_set_num_threads() and
svc_set_pool_threads(). If min_threads is non-zero and less than the
max, svc_set_num_threads() will ensure that the number of running
threads is between the min and the max.

If the min is 0 or greater than the max, then it is ignored, and the
maximum number of threads will be started, and never spun down.

For now, the min_threads is always 0, but a later patch will pass the
proper value through from nfsd.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svc.c             |  4 ++--
 fs/nfs/callback.c          |  8 ++++----
 fs/nfsd/nfssvc.c           |  8 ++++----
 include/linux/sunrpc/svc.h |  8 +++++---
 net/sunrpc/svc.c           | 45 +++++++++++++++++++++++++++++++++++++--------
 5 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index fbf132b4e08d11a91784c21ee0209fd7c149fd9d..e2a1b12272f564392bf8d5379e6a25852ca1431b 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -340,7 +340,7 @@ static int lockd_get(void)
 		return -ENOMEM;
 	}
 
-	error = svc_set_num_threads(serv, 1);
+	error = svc_set_num_threads(serv, 0, 1);
 	if (error < 0) {
 		svc_destroy(&serv);
 		return error;
@@ -368,7 +368,7 @@ static void lockd_put(void)
 	unregister_inet6addr_notifier(&lockd_inet6addr_notifier);
 #endif
 
-	svc_set_num_threads(nlmsvc_serv, 0);
+	svc_set_num_threads(nlmsvc_serv, 0, 0);
 	timer_delete_sync(&nlmsvc_retry);
 	svc_destroy(&nlmsvc_serv);
 	dprintk("lockd_down: service destroyed\n");
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index d01de143927bfeab2b44e60928512a03183e7244..6889818138e3a553ab55ce22293a8c87541d042d 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -119,9 +119,9 @@ static int nfs_callback_start_svc(int minorversion, struct rpc_xprt *xprt,
 	if (serv->sv_nrthreads == nrservs)
 		return 0;
 
-	ret = svc_set_num_threads(serv, nrservs);
+	ret = svc_set_num_threads(serv, 0, nrservs);
 	if (ret) {
-		svc_set_num_threads(serv, 0);
+		svc_set_num_threads(serv, 0, 0);
 		return ret;
 	}
 	dprintk("nfs_callback_up: service started\n");
@@ -242,7 +242,7 @@ int nfs_callback_up(u32 minorversion, struct rpc_xprt *xprt)
 	cb_info->users++;
 err_net:
 	if (!cb_info->users) {
-		svc_set_num_threads(cb_info->serv, 0);
+		svc_set_num_threads(cb_info->serv, 0, 0);
 		svc_destroy(&cb_info->serv);
 	}
 err_create:
@@ -268,7 +268,7 @@ void nfs_callback_down(int minorversion, struct net *net, struct rpc_xprt *xprt)
 	nfs_callback_down_net(minorversion, serv, net);
 	cb_info->users--;
 	if (cb_info->users == 0) {
-		svc_set_num_threads(serv, 0);
+		svc_set_num_threads(serv, 0, 0);
 		dprintk("nfs_callback_down: service destroyed\n");
 		xprt_svc_destroy_nullify_bc(xprt, &cb_info->serv);
 	}
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 049165ee26afca9f3d6d4ba471823597c93262a5..1b3a143e0b29603e594f8dbb1f88a20b99b67e8c 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -580,7 +580,7 @@ void nfsd_shutdown_threads(struct net *net)
 	}
 
 	/* Kill outstanding nfsd threads */
-	svc_set_num_threads(serv, 0);
+	svc_set_num_threads(serv, 0, 0);
 	nfsd_destroy_serv(net);
 	mutex_unlock(&nfsd_mutex);
 }
@@ -690,7 +690,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 
 	/* Special case: When n == 1, distribute threads equally among pools. */
 	if (n == 1)
-		return svc_set_num_threads(nn->nfsd_serv, nthreads[0]);
+		return svc_set_num_threads(nn->nfsd_serv, 0, nthreads[0]);
 
 	if (n > nn->nfsd_serv->sv_nrpools)
 		n = nn->nfsd_serv->sv_nrpools;
@@ -718,7 +718,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 	for (i = 0; i < n; i++) {
 		err = svc_set_pool_threads(nn->nfsd_serv,
 					   &nn->nfsd_serv->sv_pools[i],
-					   nthreads[i]);
+					   0, nthreads[i]);
 		if (err)
 			goto out;
 	}
@@ -727,7 +727,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 	for (i = n; i < nn->nfsd_serv->sv_nrpools; ++i) {
 		err = svc_set_pool_threads(nn->nfsd_serv,
 					   &nn->nfsd_serv->sv_pools[i],
-					   0);
+					   0, 0);
 		if (err)
 			goto out;
 	}
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index ec2b6ef5482352e61a9861a19f0ae4a610985ae9..8fd511d02f3b36a614db5595c3b88afe9fce92a2 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -36,6 +36,7 @@
 struct svc_pool {
 	unsigned int		sp_id;		/* pool id; also node id on NUMA */
 	unsigned int		sp_nrthreads;	/* # of threads currently running in pool */
+	unsigned int		sp_nrthrmin;	/* Min number of threads to run per pool */
 	unsigned int		sp_nrthrmax;	/* Max requested number of threads in pool */
 	struct lwq		sp_xprts;	/* pending transports */
 	struct list_head	sp_all_threads;	/* all server threads */
@@ -72,7 +73,7 @@ struct svc_serv {
 	struct svc_stat *	sv_stats;	/* RPC statistics */
 	spinlock_t		sv_lock;
 	unsigned int		sv_nprogs;	/* Number of sv_programs */
-	unsigned int		sv_nrthreads;	/* # of server threads */
+	unsigned int		sv_nrthreads;	/* # of running server threads */
 	unsigned int		sv_max_payload;	/* datagram payload size */
 	unsigned int		sv_max_mesg;	/* max_payload + 1 page for overheads */
 	unsigned int		sv_xdrsize;	/* XDR buffer size */
@@ -448,8 +449,9 @@ struct svc_serv *  svc_create_pooled(struct svc_program *prog,
 				     unsigned int bufsize,
 				     int (*threadfn)(void *data));
 int		   svc_set_pool_threads(struct svc_serv *serv, struct svc_pool *pool,
-					unsigned int nrservs);
-int		   svc_set_num_threads(struct svc_serv *serv, unsigned int nrservs);
+					unsigned int min_threads, unsigned int max_threads);
+int		   svc_set_num_threads(struct svc_serv *serv, unsigned int min_threads,
+				       unsigned int nrservs);
 int		   svc_pool_stats_open(struct svc_info *si, struct file *file);
 void		   svc_process(struct svc_rqst *rqstp);
 void		   svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 1f6c0da4b7da0acf8db88dc60e790c955d200c96..54b32981a8bcf0538684123f73a81c5fa949b55c 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -820,9 +820,14 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
  * svc_set_pool_threads - adjust number of threads per pool
  * @serv: RPC service to adjust
  * @pool: Specific pool from which to choose threads
- * @nrservs: New number of threads for @serv (0 means kill all threads)
+ * @min_threads: min number of threads to run in @pool
+ * @max_threads: max number of threads in @pool (0 means kill all threads)
+ *
+ * Create or destroy threads in @pool to bring it into an acceptable range
+ * between @min_threads and @max_threads.
  *
- * Create or destroy threads in @pool to bring it to @nrservs.
+ * If @min_threads is 0 or larger than @max_threads, then it is ignored and
+ * the pool will be set to run a static @max_threads number of threads.
  *
  * Caller must ensure mutual exclusion between this and server startup or
  * shutdown.
@@ -832,16 +837,36 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
  */
 int
 svc_set_pool_threads(struct svc_serv *serv, struct svc_pool *pool,
-		     unsigned int nrservs)
+		     unsigned int min_threads, unsigned int max_threads)
 {
-	int delta = nrservs;
+	int delta;
 
 	if (!pool)
 		return -EINVAL;
 
-	pool->sp_nrthrmax = nrservs;
-	delta -= pool->sp_nrthreads;
+	/* clamp min threads to the max */
+	if (min_threads > max_threads)
+		min_threads = max_threads;
+
+	pool->sp_nrthrmin = min_threads;
+	pool->sp_nrthrmax = max_threads;
+
+	/*
+	 * When min_threads is set, then only change the number of
+	 * threads to bring it within an acceptable range.
+	 */
+	if (min_threads) {
+		if (pool->sp_nrthreads > max_threads)
+			delta = max_threads;
+		else if (pool->sp_nrthreads < min_threads)
+			delta = min_threads;
+		else
+			return 0;
+	} else {
+		delta = max_threads;
+	}
 
+	delta -= pool->sp_nrthreads;
 	if (delta > 0)
 		return svc_start_kthreads(serv, pool, delta);
 	if (delta < 0)
@@ -853,6 +878,7 @@ EXPORT_SYMBOL_GPL(svc_set_pool_threads);
 /**
  * svc_set_num_threads - adjust number of threads in serv
  * @serv: RPC service to adjust
+ * @min_threads: min number of threads to run per pool
  * @nrservs: New number of threads for @serv (0 means kill all threads)
  *
  * Create or destroy threads in @serv to bring it to @nrservs. If there
@@ -866,20 +892,23 @@ EXPORT_SYMBOL_GPL(svc_set_pool_threads);
  * starting a thread.
  */
 int
-svc_set_num_threads(struct svc_serv *serv, unsigned int nrservs)
+svc_set_num_threads(struct svc_serv *serv, unsigned int min_threads,
+		    unsigned int nrservs)
 {
 	unsigned int base = nrservs / serv->sv_nrpools;
 	unsigned int remain = nrservs % serv->sv_nrpools;
 	int i, err;
 
 	for (i = 0; i < serv->sv_nrpools; ++i) {
+		struct svc_pool *pool = &serv->sv_pools[i];
 		int threads = base;
 
 		if (remain) {
 			++threads;
 			--remain;
 		}
-		err = svc_set_pool_threads(serv, &serv->sv_pools[i], threads);
+
+		err = svc_set_pool_threads(serv, pool, min_threads, threads);
 		if (err)
 			break;
 	}

-- 
2.52.0


