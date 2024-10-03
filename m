Return-Path: <linux-nfs+bounces-6843-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5DF98F712
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 21:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A6C1C22690
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C82D1AC44C;
	Thu,  3 Oct 2024 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpjtDnhW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693261A727F
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984107; cv=none; b=unIQaEJ1l6fsACK6LDOYSgt7mtvBnBcwKkxWEbh2UFEcQtMyzfeXY4uMPw7dFPsQiyTxlYMVLdUeQk+4l7o0ujtfWvKzhIf8DbkV4gTy0YdRiExSiAXGI5NB+GZc24W7XkGRGBSm71JvfjGa2EYvIiLNAsjKjYzGowX2lp6xs7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984107; c=relaxed/simple;
	bh=Zb7197YfQ1LtCHlCEuSs83CLgWL9vDqTe3kpj30t1aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6wOaXyYBhyaOgZ8MgBP/hAdbl45rfGqUoihkY7rxU1ArIKRtuWSe9ZLTTUKkzsogm4L/oyKVqjJegZDz2jP8rNXcJuqQYlZ85ua3sX/PqvnKIyT1ts0hbmX7QLtqszRYJGtLCEiewXYd1wRgvS1vY+JEmsTSwBTJdVxBTwIF6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpjtDnhW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BABC4CEC5;
	Thu,  3 Oct 2024 19:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727984107;
	bh=Zb7197YfQ1LtCHlCEuSs83CLgWL9vDqTe3kpj30t1aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fpjtDnhWwYB1aO1vbi5sp3u9+kUtTC3R294aPV6drXdu8FELMWa56XqK9iG1j8Kl5
	 97+iUosgRwVCI8FfZ5VRvZRksk2hJJ4QFOTtI+5QNA1h6qmlr2+deLoSqtXpzVVCbv
	 AASgcYDfUgLyLHV/axdNpwfU99x+bHvP2LHJ3U+dvqt2FK3Z3z99ZOCJPTro02SDq4
	 /kGOsyOPAC5JN1hkLWZZEnXrSQhjTxM2GwVBGqnm9GilinYL5xEzatK+Of7mvIEB3F
	 dOKqhwRYKxmAS8M9Gqaorx1kkFoaVpT3Oor/vPWtgCN+OsHhQA1KxA/bnaDEW0yNz/
	 LuKSRGA3TJQyw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [6.12-rc2 v2 PATCH 1/7] nfs_common: fix race in NFS calls to nfsd_file_put_local() and nfsd_serv_put()
Date: Thu,  3 Oct 2024 15:34:58 -0400
Message-ID: <20241003193504.34640-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241003193504.34640-1-snitzer@kernel.org>
References: <20241003193504.34640-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nfs_to_nfsd_file_put_local() interface to fix race with nfsd
module unload.  Similarly, use RCU around nfs_open_local_fh()'s error
path call to nfs_to->nfsd_serv_put().  Holding RCU ensures that NFS
will safely _call and return_ from its nfs_to calls into the NFSD
functions nfsd_file_put_local() and nfsd_serv_put().

Otherwise, if RCU isn't used then there is a narrow window when NFS's
reference for the nfsd_file and nfsd_serv are dropped and the NFSD
module could be unloaded, which could result in a crash from the
return instruction for either nfs_to->nfsd_file_put_local() or
nfs_to->nfsd_serv_put().

Reported-by: NeilBrown <neilb@suse.de>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c           |  6 +++---
 fs/nfs_common/nfslocalio.c |  5 ++++-
 fs/nfsd/filecache.c        |  2 +-
 fs/nfsd/localio.c          |  2 +-
 fs/nfsd/nfssvc.c           |  4 ++--
 include/linux/nfslocalio.h | 15 +++++++++++++++
 6 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index c29cdf51c458..d124c265b8fd 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -341,7 +341,7 @@ nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
 
-	nfs_to->nfsd_file_put_local(iocb->localio);
+	nfs_to_nfsd_file_put_local(iocb->localio);
 	nfs_local_iocb_free(iocb);
 	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
 }
@@ -622,7 +622,7 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
 	}
 out:
 	if (status != 0) {
-		nfs_to->nfsd_file_put_local(localio);
+		nfs_to_nfsd_file_put_local(localio);
 		hdr->task.tk_status = status;
 		nfs_local_hdr_release(hdr, call_ops);
 	}
@@ -673,7 +673,7 @@ nfs_local_release_commit_data(struct nfsd_file *localio,
 		struct nfs_commit_data *data,
 		const struct rpc_call_ops *call_ops)
 {
-	nfs_to->nfsd_file_put_local(localio);
+	nfs_to_nfsd_file_put_local(localio);
 	call_ops->rpc_call_done(&data->task, data);
 	call_ops->rpc_release(data);
 }
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 42b479b9191f..5c8ce5066c16 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -142,8 +142,11 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 	/* We have an implied reference to net thanks to nfsd_serv_try_get */
 	localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
 					     cred, nfs_fh, fmode);
-	if (IS_ERR(localio))
+	if (IS_ERR(localio)) {
+		rcu_read_lock();
 		nfs_to->nfsd_serv_put(net);
+		rcu_read_unlock();
+	}
 	return localio;
 }
 EXPORT_SYMBOL_GPL(nfs_open_local_fh);
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 19bb88c7eebd..53070e1de3d9 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -398,7 +398,7 @@ nfsd_file_put(struct nfsd_file *nf)
  * reference to the associated nn->nfsd_serv.
  */
 void
-nfsd_file_put_local(struct nfsd_file *nf)
+nfsd_file_put_local(struct nfsd_file *nf) __must_hold(rcu)
 {
 	struct net *net = nf->nf_net;
 
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 291e9c69cae4..f441cb9f74d5 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -53,7 +53,7 @@ void nfsd_localio_ops_init(void)
  *
  * On successful return, returned nfsd_file will have its nf_net member
  * set. Caller (NFS client) is responsible for calling nfsd_serv_put and
- * nfsd_file_put (via nfs_to->nfsd_file_put_local).
+ * nfsd_file_put (via nfs_to_nfsd_file_put_local).
  */
 struct nfsd_file *
 nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index e236135ddc63..47172b407be8 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -214,14 +214,14 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
 	return 0;
 }
 
-bool nfsd_serv_try_get(struct net *net)
+bool nfsd_serv_try_get(struct net *net) __must_hold(rcu)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	return (nn && percpu_ref_tryget_live(&nn->nfsd_serv_ref));
 }
 
-void nfsd_serv_put(struct net *net)
+void nfsd_serv_put(struct net *net) __must_hold(rcu)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index b353abe00357..b0dd9b1eef4f 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -65,10 +65,25 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *,
 		   struct rpc_clnt *, const struct cred *,
 		   const struct nfs_fh *, const fmode_t);
 
+static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
+{
+	/*
+	 * Once reference to nfsd_serv is dropped, NFSD could be
+	 * unloaded, so ensure safe return from nfsd_file_put_local()
+	 * by always taking RCU.
+	 */
+	rcu_read_lock();
+	nfs_to->nfsd_file_put_local(localio);
+	rcu_read_unlock();
+}
+
 #else   /* CONFIG_NFS_LOCALIO */
 static inline void nfsd_localio_ops_init(void)
 {
 }
+static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
+{
+}
 #endif  /* CONFIG_NFS_LOCALIO */
 
 #endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0


