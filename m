Return-Path: <linux-nfs+bounces-4274-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 898389153C6
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 18:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C331F2101F
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B3019DF91;
	Mon, 24 Jun 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/GVjo/x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1185813C3DD
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246485; cv=none; b=AP3t4iWVGPBFlEIfbx954kL5cRLasWxReP6SbjIrjODiPnoGi4ttV9qQ3/nVmxOJ+gHoBhUIAhLVbQ9HAKjdaWr457QCxzrX0RPegokRdv4SZqEE1Wg6lStlxYeeecerDz8+wZixFEuSL3YvLa/XITtQ5VqRQRGkun2473Yb4wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246485; c=relaxed/simple;
	bh=RJ2GnsIukQdBlP1QK3lVe5vpkJJ29N4nydMbM/zAUys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiMbzINOPJzxpVlrZolxBgYSmP/f5p+bAU2VlLM3Bx58mnGDSe9YgwPoW5SdSTryn9UjIUPzvacUckNSRXi+kkRdncBYzoP5k71lJOL8j1jt0MtXYXAzmX613bI06SCUhld2zJoRHlo/VlsG2n8SCG8cNT7w5PLfxndUtKTUnZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/GVjo/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C5DC2BBFC;
	Mon, 24 Jun 2024 16:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719246484;
	bh=RJ2GnsIukQdBlP1QK3lVe5vpkJJ29N4nydMbM/zAUys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O/GVjo/xHnLBIg9tUcNdSzpMGdqXZv5ubS7K6MG4bF3RmNfIbp3oRR3LmYh70P8hq
	 4K3B0ZTptukrUBBq14CoxFPyRvYI6E1YeuIxNMu+JIkjzvLV1uP7KceckhY0uhmCWN
	 zNKVcPLYMghjeV0yDWG+gmVQxhE93p8pkoKQ5KiAHJtE1eouysdaHq94KNDgIPJ+b9
	 iHjSjz+jSo2U3N5nZ3cI1m+IB78F8BzxMz3Dw21tex//BlQMmAcS45KgPJ882hGOtJ
	 4JBr2S6/pHoZp73e61xxXD1OgqNLpxPw/TKuRDqzYq4JO1C8CyUHC5qY+yOiYVuXSu
	 K483o5GabMEtg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v7 16/20] nfsd: prepare to use SRCU to dereference nn->nfsd_serv
Date: Mon, 24 Jun 2024 12:27:37 -0400
Message-ID: <20240624162741.68216-17-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240624162741.68216-1-snitzer@kernel.org>
References: <20240624162741.68216-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next commit switches the nfsd_serv member for struct nfsd_net over
to a void pointer (void __rcu *).  Prepare for this by assigning
nn->nfsd_serv to an struct svc_serv pointer that is then happily
dereferenced.  This eliminates what would otherwise be numerous void
pointer dereferences after the next commit.

All nfsd code what audited so that methods that hold nfsd_mutex will
continue to directly dereference nn->nfsd_serv.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/nfsctl.c | 21 +++++++++++++--------
 fs/nfsd/nfssvc.c | 34 ++++++++++++++++++----------------
 2 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 6fb92bb61c6d..075ada559e18 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -687,10 +687,11 @@ static ssize_t write_versions(struct file *file, char *buf, size_t size)
 static ssize_t __write_ports_names(char *buf, struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv = nn->nfsd_serv;
 
-	if (nn->nfsd_serv == NULL)
+	if (serv == NULL)
 		return 0;
-	return svc_xprt_names(nn->nfsd_serv, buf, SIMPLE_TRANSACTION_LIMIT);
+	return svc_xprt_names(serv, buf, SIMPLE_TRANSACTION_LIMIT);
 }
 
 /*
@@ -717,7 +718,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 	serv = nn->nfsd_serv;
 	err = svc_addsock(serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
 
-	if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsocks))
+	if (!serv->sv_nrthreads && list_empty(&serv->sv_permsocks))
 		nfsd_destroy_serv(net);
 
 	return err;
@@ -765,7 +766,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 		svc_xprt_put(xprt);
 	}
 out_err:
-	if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsocks))
+	if (!serv->sv_nrthreads && list_empty(&serv->sv_permsocks))
 		nfsd_destroy_serv(net);
 
 	return err;
@@ -1674,6 +1675,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 	int *nthreads, count = 0, nrpools, i, ret = -EOPNOTSUPP, rem;
 	struct net *net = genl_info_net(info);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 	const struct nlattr *attr;
 	const char *scope = NULL;
 
@@ -1708,7 +1710,8 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
 	    info->attrs[NFSD_A_SERVER_SCOPE]) {
 		ret = -EBUSY;
-		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
+		serv = nn->nfsd_serv;
+		if (serv && serv->sv_nrthreads)
 			goto out_unlock;
 
 		ret = -EINVAL;
@@ -1757,6 +1760,7 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net *net = genl_info_net(info);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 	void *hdr;
 	int err;
 
@@ -1781,11 +1785,12 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto err_unlock;
 
-	if (nn->nfsd_serv) {
+	serv = nn->nfsd_serv;
+	if (serv) {
 		int i;
 
 		for (i = 0; i < nfsd_nrpools(net); ++i) {
-			struct svc_pool *sp = &nn->nfsd_serv->sv_pools[i];
+			struct svc_pool *sp = &serv->sv_pools[i];
 
 			err = nla_put_u32(skb, NFSD_A_SERVER_THREADS,
 					  atomic_read(&sp->sp_nrthreads));
@@ -2103,7 +2108,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 			err = ret;
 	}
 
-	if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsocks))
+	if (!serv->sv_nrthreads && list_empty(&serv->sv_permsocks))
 		nfsd_destroy_serv(net);
 
 out_unlock_mtx:
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 1df9e18c510b..c16c7d630859 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -288,10 +288,12 @@ int nfsd_nrthreads(struct net *net)
 {
 	int rv = 0;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 
 	mutex_lock(&nfsd_mutex);
-	if (nn->nfsd_serv)
-		rv = nn->nfsd_serv->sv_nrthreads;
+	serv = nn->nfsd_serv;
+	if (serv)
+		rv = serv->sv_nrthreads;
 	mutex_unlock(&nfsd_mutex);
 	return rv;
 }
@@ -300,16 +302,17 @@ static int nfsd_init_socks(struct net *net, const struct cred *cred)
 {
 	int error;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv = nn->nfsd_serv;
 
-	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
+	if (!list_empty(&serv->sv_permsocks))
 		return 0;
 
-	error = svc_xprt_create(nn->nfsd_serv, "udp", net, PF_INET, NFS_PORT,
+	error = svc_xprt_create(serv, "udp", net, PF_INET, NFS_PORT,
 				SVC_SOCK_DEFAULTS, cred);
 	if (error < 0)
 		return error;
 
-	error = svc_xprt_create(nn->nfsd_serv, "tcp", net, PF_INET, NFS_PORT,
+	error = svc_xprt_create(serv, "tcp", net, PF_INET, NFS_PORT,
 				SVC_SOCK_DEFAULTS, cred);
 	if (error < 0)
 		return error;
@@ -722,11 +725,12 @@ int nfsd_create_serv(struct net *net)
 int nfsd_nrpools(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv = nn->nfsd_serv;
 
-	if (nn->nfsd_serv == NULL)
+	if (serv == NULL)
 		return 0;
 	else
-		return nn->nfsd_serv->sv_nrpools;
+		return serv->sv_nrpools;
 }
 
 int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
@@ -760,14 +764,15 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 	int tot = 0;
 	int err = 0;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv = nn->nfsd_serv;
 
 	lockdep_assert_held(&nfsd_mutex);
 
-	if (nn->nfsd_serv == NULL || n <= 0)
+	if (serv == NULL || n <= 0)
 		return 0;
 
-	if (n > nn->nfsd_serv->sv_nrpools)
-		n = nn->nfsd_serv->sv_nrpools;
+	if (n > serv->sv_nrpools)
+		n = serv->sv_nrpools;
 
 	/* enforce a global maximum number of threads */
 	tot = 0;
@@ -790,18 +795,15 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 
 	/* apply the new numbers */
 	for (i = 0; i < n; i++) {
-		err = svc_set_num_threads(nn->nfsd_serv,
-					  &nn->nfsd_serv->sv_pools[i],
+		err = svc_set_num_threads(serv, &serv->sv_pools[i],
 					  nthreads[i]);
 		if (err)
 			goto out;
 	}
 
 	/* Anything undefined in array is considered to be 0 */
-	for (i = n; i < nn->nfsd_serv->sv_nrpools; ++i) {
-		err = svc_set_num_threads(nn->nfsd_serv,
-					  &nn->nfsd_serv->sv_pools[i],
-					  0);
+	for (i = n; i < serv->sv_nrpools; ++i) {
+		err = svc_set_num_threads(serv, &serv->sv_pools[i], 0);
 		if (err)
 			goto out;
 	}
-- 
2.44.0


