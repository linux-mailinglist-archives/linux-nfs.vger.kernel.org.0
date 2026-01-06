Return-Path: <linux-nfs+bounces-17508-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CC6CFA6AB
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 20:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B19BD304C0E4
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 19:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13811338596;
	Tue,  6 Jan 2026 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k20O+1Ik"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3AF3358B6;
	Tue,  6 Jan 2026 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767726008; cv=none; b=lbg0HnWq4empMx12pW/etGhX+yUJywjwwwM6uGRKAIqdzz/c38sVHby3KHNtesOowfmmLwLAKPollHLhrarp4dxZjKxDfzAUXyFnI2MmMMMXDz3pUE64fimt0UfYM/pBBXNbCYnwOuenO+8l1h619rQR+5OZ+tANe0xzA+JzHKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767726008; c=relaxed/simple;
	bh=BjmCbwf5nSufQSQSM0eEa4iHkF8TwmxBc4IniJ5Y3TQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mggppFyJ69I9wZn2zaOoqk5/0u1CoAB1y77ZmK5JCp61i6x2EbrsHl91LhiN/wwPfelitovxwdKvanpXlX7y9mMekLWIXv3JwjmAc5+QCTp4vGzCZ85cFXDbt3iymueH2f9Rw2gNEjuQYXNqeYUglthGEjqWLlSxleUdsmGaMXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k20O+1Ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7821FC19422;
	Tue,  6 Jan 2026 19:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767726007;
	bh=BjmCbwf5nSufQSQSM0eEa4iHkF8TwmxBc4IniJ5Y3TQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k20O+1IkAhADpjEs2g8x9gFABj8PYBINA095ReuOK1sUxDmfJgp5tKkhLjQwsSdK1
	 jnrb3vIn5YQfZi3kWHTJbha4fGAY0Y3hNRVoaYHI5poqjMrydEobt43V3ug52hFFF4
	 elZe9nY3UITX/NldKWfRsQnsHdH+cd3W3iRcBkj5Bgen76W/4wLwVuwqrmFBxPYxhB
	 NOHI3UAkIKtDPxJFCcbVXu41wwi0GuNrYy/i284hgOb3j42YDnlgpr2mCaMRtc/pzl
	 HXHziC8aN49w82XwBg7avmUk3U7x/0M8HnB+5o9tG4TB4OtMJ14VHs9IdelLl3x9YK
	 jsuSPgQWk3hDg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 06 Jan 2026 13:59:43 -0500
Subject: [PATCH v2 1/8] sunrpc: split svc_set_num_threads() into two
 functions
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-nfsd-dynathread-v2-1-416e5f27b2b6@kernel.org>
References: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
In-Reply-To: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8671; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=BjmCbwf5nSufQSQSM0eEa4iHkF8TwmxBc4IniJ5Y3TQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpXVuzgNU3vAnOVcgKeRWZssFJAqWj1odTPBEru
 XbvNZMKKuOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV1bswAKCRAADmhBGVaC
 FQ/+D/9oBjU3z4KIXwYpxbswAz2ZJBE+StDVwfbB870zuSy1JZ0IQBMBbwMdUa31UgQw8Xw+nBM
 xzI+7Rv3Wcl+GTP4QWlEMnc3N1Asdv6GdTx62E0ks7soabbLAN8QfSgDAi2rRKDMZ6KofZqsZ6r
 IracHqPcyuGvngp2EIbr0jOuLSFmf0KpHMxkBPNORDpnkkYv7JuZSm8ac7Jxt+//M5sUQ9e1nmU
 fCoyJD5IexDQQ/UAf33ILTNcPMkOysGO1ycyT/bEgVcNPbW+Dojtbql2AcSJn+do4Itag5r5vcs
 jzM2DfGIE62jnlZMi/qGEFkA25u/R9hP+Gm1l6CwzpzInVDtfQpuRHtPslG8sL6nDbyL9fWsb8U
 SKHlA7Wt2Ar+Qxlup6N7ONDxa1YDp3IN+7QgfE+Dn5vuulMs4xpu/Vojbf7cZgx4a9WjturLoev
 UnlPAs4It3brybeKyKLMTtIP5Zsz2V/n7+JKIy3PM5DHZlfirPH7+Hb6lFQ5+CHqopr/Y42ev20
 T1Mmu3lyc3VxRwb3RSwaIXUYc0Te3xi2vo6EKOuL/AjHliAEVoYSUxxfOvcaRrTLdm0uqNM0tXr
 Rwy0Z1szony8iM+UQe+6UWtxzYOf5aweyrfDEpg6wspKZuumUvjrn9ug1+47QbLa4Ft65tyi9RE
 VElPe2wGMwtVRJA==
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
 fs/lockd/svc.c             |  4 +--
 fs/nfs/callback.c          |  8 +++---
 fs/nfsd/nfssvc.c           | 21 +++++++--------
 include/linux/sunrpc/svc.h |  4 ++-
 net/sunrpc/svc.c           | 67 +++++++++++++++++++++++++++++++++++-----------
 5 files changed, 70 insertions(+), 34 deletions(-)

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
index fabda0f6ec1a8ab1017553b755693a4a371f578d..d01de143927bfeab2b44e60928512a03183e7244 100644
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
@@ -268,7 +268,7 @@ void nfs_callback_down(int minorversion, struct net *net, struct rpc_xprt *xprt)
 	nfs_callback_down_net(minorversion, serv, net);
 	cb_info->users--;
 	if (cb_info->users == 0) {
-		svc_set_num_threads(serv, NULL, 0);
+		svc_set_num_threads(serv, 0);
 		dprintk("nfs_callback_down: service destroyed\n");
 		xprt_svc_destroy_nullify_bc(xprt, &cb_info->serv);
 	}
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index f1cc223ecee2f6ea5bd1d88abf1b0569bc430238..049165ee26afca9f3d6d4ba471823597c93262a5 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -580,7 +580,7 @@ void nfsd_shutdown_threads(struct net *net)
 	}
 
 	/* Kill outstanding nfsd threads */
-	svc_set_num_threads(serv, NULL, 0);
+	svc_set_num_threads(serv, 0);
 	nfsd_destroy_serv(net);
 	mutex_unlock(&nfsd_mutex);
 }
@@ -688,12 +688,9 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
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
@@ -719,18 +716,18 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 
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
index 5506d20857c318774cd223272d4b0022cc19ffb8..2676bf276d6ba43772ecee65b94207b438168679 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -446,7 +446,9 @@ struct svc_serv *  svc_create_pooled(struct svc_program *prog,
 				     struct svc_stat *stats,
 				     unsigned int bufsize,
 				     int (*threadfn)(void *data));
-int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
+int		   svc_set_pool_threads(struct svc_serv *serv, struct svc_pool *pool,
+					unsigned int nrservs);
+int		   svc_set_num_threads(struct svc_serv *serv, unsigned int nrservs);
 int		   svc_pool_stats_open(struct svc_info *si, struct file *file);
 void		   svc_process(struct svc_rqst *rqstp);
 void		   svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 4704dce7284eccc9e2bc64cf22947666facfa86a..cd9d4f8b75aeb6ffa08ce84a0b82da7fd37e6fbf 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -856,15 +856,12 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 }
 
 /**
- * svc_set_num_threads - adjust number of threads per RPC service
+ * svc_set_pool_threads - adjust number of threads per pool
  * @serv: RPC service to adjust
- * @pool: Specific pool from which to choose threads, or NULL
- * @nrservs: New number of threads for @serv (0 or less means kill all threads)
+ * @pool: Specific pool from which to choose threads
+ * @nrservs: New number of threads for @serv (0 means kill all threads)
  *
- * Create or destroy threads to make the number of threads for @serv the
- * given number. If @pool is non-NULL, change only threads in that pool;
- * otherwise, round-robin between all pools for @serv. @serv's
- * sv_nrthreads is adjusted for each thread created or destroyed.
+ * Create or destroy threads in @pool to bring it to @nrservs.
  *
  * Caller must ensure mutual exclusion between this and server startup or
  * shutdown.
@@ -873,19 +870,59 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
  * starting a thread.
  */
 int
-svc_set_num_threads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
+svc_set_pool_threads(struct svc_serv *serv, struct svc_pool *pool,
+		     unsigned int nrservs)
 {
+	int delta = nrservs;
+
 	if (!pool)
-		nrservs -= serv->sv_nrthreads;
-	else
-		nrservs -= pool->sp_nrthreads;
+		return -EINVAL;
 
-	if (nrservs > 0)
-		return svc_start_kthreads(serv, pool, nrservs);
-	if (nrservs < 0)
-		return svc_stop_kthreads(serv, pool, nrservs);
+	delta -= pool->sp_nrthreads;
+
+	if (delta > 0)
+		return svc_start_kthreads(serv, pool, delta);
+	if (delta < 0)
+		return svc_stop_kthreads(serv, pool, delta);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(svc_set_pool_threads);
+
+/**
+ * svc_set_num_threads - adjust number of threads in serv
+ * @serv: RPC service to adjust
+ * @nrservs: New number of threads for @serv (0 means kill all threads)
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
+svc_set_num_threads(struct svc_serv *serv, unsigned int nrservs)
+{
+	unsigned int base = nrservs / serv->sv_nrpools;
+	unsigned int remain = nrservs % serv->sv_nrpools;
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


