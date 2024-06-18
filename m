Return-Path: <linux-nfs+bounces-3966-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB02790C109
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 03:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C6B282584
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 01:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776391CA80;
	Tue, 18 Jun 2024 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AV2edQ3a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515031CA89
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718672978; cv=none; b=GZ4W+j9aU3KSxvyscF9Xuexe0z3TqR1AI7woKI1bMjypYvuo3eokxc0O1jZCr5SeZEcrUG7kn/1csrEEyD9QgGXTz7QngN7AZDI1W7QdMO9OxSEfuShF1ZLyyGKwVuvFyHplqpiyctyyq/k8KOSndQOo+wiy4oAo1eRQaK5Tzxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718672978; c=relaxed/simple;
	bh=JX6aw9YqdgNHM0+6VWobAInAGs2FApn8yzlRP5hTm4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keHk88DHa9OcKOVr/HWtV/SU0/xAblBlGn+e8YYZMXt1vDJXqcWz6X93Hw4E/2Ci6L/TeJYCs+oo8QQ6TVZS8iybbaL0z+t9E2o5czt/QMM24cXOnDHMtcCBLo/9YrwrRl3OJLE2MnJvgogdlhDhekXXpP5jJtO2gpMI1pshn9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AV2edQ3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DF3C2BD10;
	Tue, 18 Jun 2024 01:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718672978;
	bh=JX6aw9YqdgNHM0+6VWobAInAGs2FApn8yzlRP5hTm4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AV2edQ3a7kdpCBFFqIYrzxNpuOHNt/xdiS95fglddnMY2pVWfMhxyltu9BA5s82NC
	 TnhhUtl9WQgUWSyl7LWXDa9J8MUWqpXRmfVQNkkNtkUAu34uIUmv6P2eUpwHRMtqjw
	 +qLeEsTIqEXrdBYuK0Mcg1FBErYmIj0YX7HLLsoakQgCPV6StIvjLkCxgcPEix2yOt
	 NQPD52ryI6Ky8c8jWBSmWGZYLm1K2MQe5/Kw6SbuKRcNYLG52ScoZAQnPI8TQvdClX
	 MwFCTaLHXfzlQz7leBbY8Rk+Qd2GfbvB8dN1Q+XjRkEg9WtX9GiBsgeJ3p59Loo4hx
	 siWE1ABshxOWw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com,
	axboe@kernel.dk
Subject: [PATCH v4 15/18] nfsd: prepare to use SRCU to dereference nn->nfsd_serv
Date: Mon, 17 Jun 2024 21:09:14 -0400
Message-ID: <20240618010917.23385-16-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240618010917.23385-1-snitzer@kernel.org>
References: <20240618010917.23385-1-snitzer@kernel.org>
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
 fs/nfsd/nfssvc.c | 28 ++++++++++++++++------------
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 202140df8f82..e26b1bc7ad33 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -679,10 +679,11 @@ static ssize_t write_versions(struct file *file, char *buf, size_t size)
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
@@ -709,7 +710,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 	serv = nn->nfsd_serv;
 	err = svc_addsock(serv, net, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
 
-	if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsocks))
+	if (!serv->sv_nrthreads && list_empty(&serv->sv_permsocks))
 		nfsd_destroy_serv(net);
 
 	return err;
@@ -757,7 +758,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct net *net, const struct cr
 		svc_xprt_put(xprt);
 	}
 out_err:
-	if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsocks))
+	if (!serv->sv_nrthreads && list_empty(&serv->sv_permsocks))
 		nfsd_destroy_serv(net);
 
 	return err;
@@ -1666,6 +1667,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 	int nthreads = 0, count = 0, nrpools, ret = -EOPNOTSUPP, rem;
 	struct net *net = genl_info_net(info);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 	const struct nlattr *attr;
 	const char *scope = NULL;
 
@@ -1693,7 +1695,8 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
 	    info->attrs[NFSD_A_SERVER_SCOPE]) {
 		ret = -EBUSY;
-		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
+		serv = nn->nfsd_serv;
+		if (serv && serv->sv_nrthreads)
 			goto out_unlock;
 
 		ret = -EINVAL;
@@ -1741,6 +1744,7 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net *net = genl_info_net(info);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 	void *hdr;
 	int err;
 
@@ -1765,11 +1769,12 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -2087,7 +2092,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 			err = ret;
 	}
 
-	if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsocks))
+	if (!serv->sv_nrthreads && list_empty(&serv->sv_permsocks))
 		nfsd_destroy_serv(net);
 
 out_unlock_mtx:
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 8f4b8c341c7c..d6e9d346e84a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -309,10 +309,12 @@ int nfsd_nrthreads(struct net *net)
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
@@ -321,16 +323,17 @@ static int nfsd_init_socks(struct net *net, const struct cred *cred)
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
@@ -742,11 +745,12 @@ int nfsd_create_serv(struct net *net)
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
@@ -767,14 +771,15 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 	int tot = 0;
 	int err = 0;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv = nn->nfsd_serv;
 
 	WARN_ON(!mutex_is_locked(&nfsd_mutex));
 
-	if (nn->nfsd_serv == NULL || n <= 0)
+	if (serv == NULL || n <= 0)
 		return 0;
 
-	if (n > nn->nfsd_serv->sv_nrpools)
-		n = nn->nfsd_serv->sv_nrpools;
+	if (n > serv->sv_nrpools)
+		n = serv->sv_nrpools;
 
 	/* enforce a global maximum number of threads */
 	tot = 0;
@@ -804,8 +809,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 
 	/* apply the new numbers */
 	for (i = 0; i < n; i++) {
-		err = svc_set_num_threads(nn->nfsd_serv,
-					  &nn->nfsd_serv->sv_pools[i],
+		err = svc_set_num_threads(serv, &serv->sv_pools[i],
 					  nthreads[i]);
 		if (err)
 			break;
-- 
2.44.0


