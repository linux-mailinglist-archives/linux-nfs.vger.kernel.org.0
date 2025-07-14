Return-Path: <linux-nfs+bounces-13016-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BD8B034DA
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 05:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 517B67A232E
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 03:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0684B1D7E5C;
	Mon, 14 Jul 2025 03:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYrFUkYt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D690918C332
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 03:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752462848; cv=none; b=mAriA7OFcEeJ0op2Ol+Q3QK0NFFXk1qi+d6rNt/pVryEwy+akTXJ7NU4OTT9hJvBi2PtcFm/LnE9NEKuk5zJP61TJXMLHbFP97qePZURFebxMVGQusBtUu1c1jbZTmTXfhZwu932D9LhUKSWycV8te1xjv2nhJs51/9xKC9jSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752462848; c=relaxed/simple;
	bh=y+XwH84RE2DzrNoGMOy+M8eVT9uG6Uwj/so2zni0lRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHuIcPEJE4P+zUoooLMAB7IM+mD/24kswqFYJsSVD06YCRpMahPS8gg5L8AVsXLM1ZyCnY8LtqMpFd6n+i/Vjc166MC+Y8zf/Ibu7FmF4xMVKhtoEPeWDaVPdHYN2xwDoShG03iKgvx6rdXFkdtlS674CdF1pjca9750T2suOt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYrFUkYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82099C4CEE3;
	Mon, 14 Jul 2025 03:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752462848;
	bh=y+XwH84RE2DzrNoGMOy+M8eVT9uG6Uwj/so2zni0lRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WYrFUkYtITGGbrcQlMANDiWDsoDspjakHMDSMdz5o5Y0UpkFlkwkUDJxBKPuJBDeh
	 Ov3oV1JxT9WkK93MGDyanUG6np0iivu6ZTgE2b8w54zjGTBDHxKZQwV8+NPfyNFswu
	 xXawedRyuStdpaAkmLE9CatQsR/0dcOr83f165LXUCCkWKSq/PnWa3DW6fzmZ/3W7f
	 n0TiS2B/RC3o/1/YsxGTNy8eOhQn+Va8zyuj3eVLdaIJ4DME9vhcXIjEpLW1GyYyeH
	 E6pBOwZId5uOxJdHk3jFrG4qfyCwSSzuxNN0pzfstBoUJ+p2t/3sIFlWMmbkYRe5SC
	 et5Iz9VIJdexQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org
Subject: [for-6.16-final PATCH 5/9] Revert "nfs_localio: simplify interface to nfsd for getting nfsd_file"
Date: Sun, 13 Jul 2025 23:13:55 -0400
Message-ID: <20250714031359.10192-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250714031359.10192-1-snitzer@kernel.org>
References: <20250714031359.10192-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit aa79c438fda263372c63df2170bc4e4030bb68de.

Really nasty revert due to original series not being bisect safe.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c           | 31 +++++++++++++++++++++++++------
 fs/nfs_common/nfslocalio.c |  3 +--
 fs/nfsd/localio.c          | 37 ++++---------------------------------
 include/linux/nfslocalio.h |  6 ++++--
 4 files changed, 34 insertions(+), 43 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index ef12dd279539..86df8d2cd22e 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -209,6 +209,11 @@ void nfs_local_probe_async(struct nfs_client *clp)
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe_async);
 
+static inline struct nfsd_file *nfs_local_file_get(struct nfsd_file *nf)
+{
+	return nfs_to->nfsd_file_get_local(nf);
+}
+
 static inline void nfs_local_file_put(struct nfsd_file *nf)
 {
 	nfs_to_nfsd_file_put_local(nf);
@@ -223,13 +228,12 @@ static inline void nfs_local_file_put(struct nfsd_file *nf)
 static struct nfsd_file *
 __nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		    struct nfs_fh *fh, struct nfs_file_localio *nfl,
-		    struct nfsd_file __rcu **pnf,
 		    const fmode_t mode)
 {
 	struct nfsd_file *localio;
 
 	localio = nfs_open_local_fh(&clp->cl_uuid, clp->cl_rpcclient,
-				    cred, fh, nfl, pnf, mode);
+				    cred, fh, nfl, mode);
 	if (IS_ERR(localio)) {
 		int status = PTR_ERR(localio);
 		trace_nfs_local_open_fh(fh, mode, status);
@@ -256,7 +260,7 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		  struct nfs_fh *fh, struct nfs_file_localio *nfl,
 		  const fmode_t mode)
 {
-	struct nfsd_file *nf, __rcu **pnf;
+	struct nfsd_file *nf, *new, __rcu **pnf;
 
 	if (!nfs_server_is_local(clp))
 		return NULL;
@@ -268,9 +272,24 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 	else
 		pnf = &nfl->ro_file;
 
-	nf = __nfs_local_open_fh(clp, cred, fh, nfl, pnf, mode);
-	if (IS_ERR(nf))
-		return NULL;
+	new = NULL;
+	rcu_read_lock();
+	nf = rcu_dereference(*pnf);
+	if (!nf) {
+		rcu_read_unlock();
+		new = __nfs_local_open_fh(clp, cred, fh, nfl, mode);
+		if (IS_ERR(new))
+			return NULL;
+		rcu_read_lock();
+		/* try to swap in the pointer */
+		nf = unrcu_pointer(cmpxchg(pnf, NULL, RCU_INITIALIZER(new)));
+		if (!nf)
+			swap(nf, new);
+	}
+	nf = nfs_local_file_get(nf);
+	rcu_read_unlock();
+	if (new)
+		nfs_to_nfsd_file_put_local(new);
 	return nf;
 }
 EXPORT_SYMBOL_GPL(nfs_local_open_fh);
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 503f85f64b76..f6821b2c87a2 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -237,7 +237,6 @@ static void nfs_uuid_add_file(nfs_uuid_t *nfs_uuid, struct nfs_file_localio *nfl
 struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
 		   const struct nfs_fh *nfs_fh, struct nfs_file_localio *nfl,
-		   struct nfsd_file __rcu **pnf,
 		   const fmode_t fmode)
 {
 	struct net *net;
@@ -262,7 +261,7 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 	rcu_read_unlock();
 	/* We have an implied reference to net thanks to nfsd_net_try_get */
 	localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
-					     cred, nfs_fh, pnf, fmode);
+					     cred, nfs_fh, fmode);
 	nfs_to_nfsd_net_put(net);
 	if (!IS_ERR(localio))
 		nfs_uuid_add_file(uuid, nfl);
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 80d9ff6608a7..40998283b858 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -32,7 +32,6 @@
  * @rpc_clnt: rpc_clnt that the client established
  * @cred: cred that the client established
  * @nfs_fh: filehandle to lookup
- * @nfp: place to find the nfsd_file, or store it if it was non-NULL
  * @fmode: fmode_t to use for open
  *
  * This function maps a local fh to a path on a local filesystem.
@@ -43,11 +42,10 @@
  * set. Caller (NFS client) is responsible for calling nfsd_net_put and
  * nfsd_file_put (via nfs_to_nfsd_file_put_local).
  */
-static struct nfsd_file *
+struct nfsd_file *
 nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
-		   const struct nfs_fh *nfs_fh, struct nfsd_file __rcu **pnf,
-		   const fmode_t fmode)
+		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
 {
 	int mayflags = NFSD_MAY_LOCALIO;
 	struct svc_cred rq_cred;
@@ -61,12 +59,6 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 	if (!nfsd_net_try_get(net))
 		return ERR_PTR(-ENXIO);
 
-	rcu_read_lock();
-	localio = nfsd_file_get(rcu_dereference(*pnf));
-	rcu_read_unlock();
-	if (localio)
-		return localio;
-
 	/* nfs_fh -> svc_fh */
 	fh_init(&fh, NFS4_FHSIZE);
 	fh.fh_handle.fh_size = nfs_fh->size;
@@ -88,33 +80,12 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 	if (rq_cred.cr_group_info)
 		put_group_info(rq_cred.cr_group_info);
 
-	if (!IS_ERR(localio)) {
-		struct nfsd_file *new;
-		if (!nfsd_net_try_get(net)) {
-			nfsd_file_put(localio);
-			nfsd_net_put(net);
-			return ERR_PTR(-ENXIO);
-		}
-		nfsd_file_get(localio);
-	again:
-		new = unrcu_pointer(cmpxchg(pnf, NULL, RCU_INITIALIZER(localio)));
-		if (new) {
-			/* Some other thread installed an nfsd_file */
-			if (nfsd_file_get(new) == NULL)
-				goto again;
-			/*
-			 * Drop the ref we were going to install and the
-			 * one we were going to return.
-			 */
-			nfsd_file_put(localio);
-			nfsd_file_put(localio);
-			localio = new;
-		}
-	} else
+	if (IS_ERR(localio))
 		nfsd_net_put(net);
 
 	return localio;
 }
+EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
 
 static const struct nfsd_localio_operations nfsd_localio_ops = {
 	.nfsd_net_try_get  = nfsd_net_try_get,
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 453d9de3d70b..c3f34bae60e1 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -50,6 +50,10 @@ void nfs_localio_invalidate_clients(struct list_head *nn_local_clients,
 				    spinlock_t *nn_local_clients_lock);
 
 /* localio needs to map filehandle -> struct nfsd_file */
+extern struct nfsd_file *
+nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *,
+		   const struct cred *, const struct nfs_fh *,
+		   const fmode_t) __must_hold(rcu);
 void nfs_close_local_fh(struct nfs_file_localio *);
 
 struct nfsd_localio_operations {
@@ -60,7 +64,6 @@ struct nfsd_localio_operations {
 						struct rpc_clnt *,
 						const struct cred *,
 						const struct nfs_fh *,
-						struct nfsd_file __rcu **,
 						const fmode_t);
 	struct net *(*nfsd_file_put_local)(struct nfsd_file *);
 	struct nfsd_file *(*nfsd_file_get_local)(struct nfsd_file *);
@@ -73,7 +76,6 @@ extern const struct nfsd_localio_operations *nfs_to;
 struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *,
 		   struct rpc_clnt *, const struct cred *,
 		   const struct nfs_fh *, struct nfs_file_localio *,
-		   struct nfsd_file __rcu **pnf,
 		   const fmode_t);
 
 static inline void nfs_to_nfsd_net_put(struct net *net)
-- 
2.44.0


