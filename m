Return-Path: <linux-nfs+bounces-144-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6327FC8F1
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 23:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB34E2825C3
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 22:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387F142A8B;
	Tue, 28 Nov 2023 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9eBs96y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1625044390;
	Tue, 28 Nov 2023 22:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE1EC433C9;
	Tue, 28 Nov 2023 22:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701208805;
	bh=Ce/gbed0QVHH5TAEENJ0RGD+ZTBWPPsp0UiGFOaQXe0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=s9eBs96yBPrNFBTCvtxTLGeBR+lTL3kbpWqyZzjn8pFpxdHzyhJ8Nw/8hcZtvtWX9
	 P4CoIhM9F7B7IYj38q5QFj5oT6x9Yh9Vielk6qI/nrPkJxCczBTg6sKFVVBQjq8mJ0
	 ws7VC/nqtMi9T7cKD7jKj412epAkqGjj+yyh4bYL5HmMOIDO3GSm02Vp55UUO3ImhC
	 /D2blRuQIq6Ne4AZ7RzDHxv8fsXFwFmNMH6HmNtmmOjSoI+zrClt7U1bB59DAv0ySg
	 okbuDMtcxOlx7KUazRX0EuLt7jJDJ6MabBMhT2/X+c7UlWmD2jCSspm4V0CKmuPwqW
	 5pedSaqZBJK/g==
Subject: [PATCH 5/8] NFSD: Remove svc_rqst::rq_cacherep
From: Chuck Lever <cel@kernel.org>
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org
Date: Tue, 28 Nov 2023 17:00:04 -0500
Message-ID: 
 <170120880443.1515.5927395382345776082.stgit@klimt.1015granger.net>
In-Reply-To: 
 <170120874713.1515.13712791731008720729.stgit@klimt.1015granger.net>
References: 
 <170120874713.1515.13712791731008720729.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit cb18eca4b86768ec79e847795d1043356c9ee3b0 ]

Over time I'd like to see NFS-specific fields moved out of struct
svc_rqst, which is an RPC layer object. These fields are layering
violations.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/cache.h            |    6 ++++--
 fs/nfsd/nfscache.c         |   11 ++++++-----
 fs/nfsd/nfssvc.c           |   10 ++++++----
 include/linux/sunrpc/svc.h |    1 -
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
index 4c9b87850ab1..27610b071880 100644
--- a/fs/nfsd/cache.h
+++ b/fs/nfsd/cache.h
@@ -84,8 +84,10 @@ int	nfsd_net_reply_cache_init(struct nfsd_net *nn);
 void	nfsd_net_reply_cache_destroy(struct nfsd_net *nn);
 int	nfsd_reply_cache_init(struct nfsd_net *);
 void	nfsd_reply_cache_shutdown(struct nfsd_net *);
-int	nfsd_cache_lookup(struct svc_rqst *);
-void	nfsd_cache_update(struct svc_rqst *, int, __be32 *);
+int	nfsd_cache_lookup(struct svc_rqst *rqstp,
+			  struct svc_cacherep **cacherep);
+void	nfsd_cache_update(struct svc_rqst *rqstp, struct svc_cacherep *rp,
+			  int cachetype, __be32 *statp);
 int	nfsd_reply_cache_stats_show(struct seq_file *m, void *v);
 
 #endif /* NFSCACHE_H */
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 8aab82ca798b..de4f2c6f23dc 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -465,6 +465,7 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key,
 /**
  * nfsd_cache_lookup - Find an entry in the duplicate reply cache
  * @rqstp: Incoming Call to find
+ * @cacherep: OUT: DRC entry for this request
  *
  * Try to find an entry matching the current call in the cache. When none
  * is found, we try to grab the oldest expired entry off the LRU list. If
@@ -477,7 +478,7 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key,
  *   %RC_REPLY: Reply from cache
  *   %RC_DROPIT: Do not process the request further
  */
-int nfsd_cache_lookup(struct svc_rqst *rqstp)
+int nfsd_cache_lookup(struct svc_rqst *rqstp, struct svc_cacherep **cacherep)
 {
 	struct nfsd_net		*nn;
 	struct svc_cacherep	*rp, *found;
@@ -488,7 +489,6 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 	LIST_HEAD(dispose);
 	int rtn = RC_DOIT;
 
-	rqstp->rq_cacherep = NULL;
 	if (type == RC_NOCACHE) {
 		nfsd_stats_rc_nocache_inc();
 		goto out;
@@ -510,7 +510,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 	found = nfsd_cache_insert(b, rp, nn);
 	if (found != rp)
 		goto found_entry;
-	rqstp->rq_cacherep = rp;
+	*cacherep = rp;
 	rp->c_state = RC_INPROG;
 	nfsd_prune_bucket_locked(nn, b, 3, &dispose);
 	spin_unlock(&b->cache_lock);
@@ -568,6 +568,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
 /**
  * nfsd_cache_update - Update an entry in the duplicate reply cache.
  * @rqstp: svc_rqst with a finished Reply
+ * @rp: IN: DRC entry for this request
  * @cachetype: which cache to update
  * @statp: pointer to Reply's NFS status code, or NULL
  *
@@ -585,10 +586,10 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp)
  * nfsd failed to encode a reply that otherwise would have been cached.
  * In this case, nfsd_cache_update is called with statp == NULL.
  */
-void nfsd_cache_update(struct svc_rqst *rqstp, int cachetype, __be32 *statp)
+void nfsd_cache_update(struct svc_rqst *rqstp, struct svc_cacherep *rp,
+		       int cachetype, __be32 *statp)
 {
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-	struct svc_cacherep *rp = rqstp->rq_cacherep;
 	struct kvec	*resv = &rqstp->rq_res.head[0], *cachv;
 	struct nfsd_drc_bucket *b;
 	int		len;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 2154fa63c5f2..f91fb343313d 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -1046,6 +1046,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 {
 	const struct svc_procedure *proc = rqstp->rq_procinfo;
 	__be32 *statp = rqstp->rq_accept_statp;
+	struct svc_cacherep *rp;
 
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
@@ -1056,7 +1057,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
 		goto out_decode_err;
 
-	switch (nfsd_cache_lookup(rqstp)) {
+	rp = NULL;
+	switch (nfsd_cache_lookup(rqstp, &rp)) {
 	case RC_DOIT:
 		break;
 	case RC_REPLY:
@@ -1072,7 +1074,7 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
 		goto out_encode_err;
 
-	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
+	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
 out_cached_reply:
 	return 1;
 
@@ -1082,13 +1084,13 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
 	return 1;
 
 out_update_drop:
-	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
+	nfsd_cache_update(rqstp, rp, RC_NOCACHE, NULL);
 out_dropit:
 	return 0;
 
 out_encode_err:
 	trace_nfsd_cant_encode_err(rqstp);
-	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
+	nfsd_cache_update(rqstp, rp, RC_NOCACHE, NULL);
 	*statp = rpc_system_err;
 	return 1;
 }
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index f8751118c122..fe1394cc1371 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -265,7 +265,6 @@ struct svc_rqst {
 	/* Catering to nfsd */
 	struct auth_domain *	rq_client;	/* RPC peer info */
 	struct auth_domain *	rq_gssclient;	/* "gss/"-style peer info */
-	struct svc_cacherep *	rq_cacherep;	/* cache info */
 	struct task_struct	*rq_task;	/* service thread */
 	struct net		*rq_bc_net;	/* pointer to backchannel's
 						 * net namespace



