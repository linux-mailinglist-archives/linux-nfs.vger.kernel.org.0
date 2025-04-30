Return-Path: <linux-nfs+bounces-11366-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BBDAA41A0
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 06:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDBDA1B677A3
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 04:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDF412CDAE;
	Wed, 30 Apr 2025 04:05:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81D616EB42
	for <linux-nfs@vger.kernel.org>; Wed, 30 Apr 2025 04:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745985904; cv=none; b=shdoN9CydDq0B7lri+/8QE+bB6kIZ24sWKKXvpP6zem5z/kFQKOAfqNu81Ql7m6iO+tDgthbb9OVSX8GIpuWLlFHfHn6QFnOfvwpShg4TzLQMMYkaSos8ACjcSxbbFeX9dVhXCDpmIVjqaT2GVhfFrmJeLB0BiAPjriBO2rIfCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745985904; c=relaxed/simple;
	bh=Z6AANxn+Ge0Stjb6WFDXQ/7D5jx0tQdXOrxc/UdZPvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjCYyDVkuYn7TrSt8InTUD8tDntz7Hk7z1H9DbImsp1+92jDFWMUrYuAWceg/djrtrDRx2pFo2c5+ClPW77ZWrHP9Wf1enrCFRlXAPVvT/F7r4Zrtkilr+AozsTrXnsoN7pBoFOPwIJRtiA8ANKLbVxJBqQpY0FHqV5SBD8yQhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1u9ygo-005EYj-D3;
	Wed, 30 Apr 2025 04:04:54 +0000
From: NeilBrown <neil@brown.name>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 3/6] nfs_localio: simplify interface to nfsd for getting nfsd_file
Date: Wed, 30 Apr 2025 14:01:13 +1000
Message-ID: <20250430040429.2743921-4-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430040429.2743921-1-neil@brown.name>
References: <20250430040429.2743921-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The nfsd_localio_operations structure contains nfsd_file_get() to get a
reference to an nfsd_file.  This is only used in one place, where
nfsd_open_local_fh() is also used.

This patch combines the two, calling nfsd_open_local_fh() passing a
pointer to where the nfsd_file pointer might be stored.  If there is a
pointer there an nfsd_file_get() can get a reference, that reference is
returned.  If not a new nfsd_file is acquired, stored at the pointer,
and returned.

We now get an extra reference *before* storing the new nfsd_file at the
given location.  This avoids possible races with the nfsd_file being
freed before the final reference can be taken.

This patch moves the rcu_dereference() needed after fetching from
ro_file or rw_file into the nfsd code where the 'struct nfs_file' is
fully defined.  This avoids an error reported by older versions of gcc
such as gcc-8 which complain about rcu_dereference() use in contexts
where the structure (which will supposedly be accessed) is not fully
defined.

Reported-by: Pali Rohár <pali@kernel.org>
Reported-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/localio.c           | 31 ++++----------------
 fs/nfs_common/nfslocalio.c |  3 +-
 fs/nfsd/localio.c          | 59 +++++++++++++++++++++++++++-----------
 include/linux/nfslocalio.h |  6 ++--
 4 files changed, 52 insertions(+), 47 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 27d5fff9747b..030a54c8c9d8 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -207,11 +207,6 @@ void nfs_local_probe_async(struct nfs_client *clp)
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe_async);
 
-static inline struct nfsd_file *nfs_local_file_get(struct nfsd_file *nf)
-{
-	return nfs_to->nfsd_file_get_local(nf);
-}
-
 static inline void nfs_local_file_put(struct nfsd_file *nf)
 {
 	nfs_to_nfsd_file_put_local(nf);
@@ -226,12 +221,13 @@ static inline void nfs_local_file_put(struct nfsd_file *nf)
 static struct nfsd_file *
 __nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		    struct nfs_fh *fh, struct nfs_file_localio *nfl,
+		    struct nfsd_file __rcu **pnf,
 		    const fmode_t mode)
 {
 	struct nfsd_file *localio;
 
 	localio = nfs_open_local_fh(&clp->cl_uuid, clp->cl_rpcclient,
-				    cred, fh, nfl, mode);
+				    cred, fh, nfl, pnf, mode);
 	if (IS_ERR(localio)) {
 		int status = PTR_ERR(localio);
 		trace_nfs_local_open_fh(fh, mode, status);
@@ -258,7 +254,7 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		  struct nfs_fh *fh, struct nfs_file_localio *nfl,
 		  const fmode_t mode)
 {
-	struct nfsd_file *nf, *new, __rcu **pnf;
+	struct nfsd_file *nf, __rcu **pnf;
 
 	if (!nfs_server_is_local(clp))
 		return NULL;
@@ -270,24 +266,9 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 	else
 		pnf = &nfl->ro_file;
 
-	new = NULL;
-	rcu_read_lock();
-	nf = rcu_dereference(*pnf);
-	if (!nf) {
-		rcu_read_unlock();
-		new = __nfs_local_open_fh(clp, cred, fh, nfl, mode);
-		if (IS_ERR(new))
-			return NULL;
-		/* try to swap in the pointer */
-		nf = unrcu_pointer(cmpxchg(pnf, NULL, RCU_INITIALIZER(new)));
-		if (!nf)
-			swap(nf, new);
-		rcu_read_lock();
-	}
-	nf = nfs_local_file_get(nf);
-	rcu_read_unlock();
-	if (new)
-		nfs_to_nfsd_file_put_local(new);
+	nf = __nfs_local_open_fh(clp, cred, fh, nfl, pnf, mode);
+	if (IS_ERR(nf))
+		return NULL;
 	return nf;
 }
 EXPORT_SYMBOL_GPL(nfs_local_open_fh);
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 7e73bbf593b9..d9e2f65912ef 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -237,6 +237,7 @@ static void nfs_uuid_add_file(nfs_uuid_t *nfs_uuid, struct nfs_file_localio *nfl
 struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
 		   const struct nfs_fh *nfs_fh, struct nfs_file_localio *nfl,
+		   struct nfsd_file __rcu **pnf,
 		   const fmode_t fmode)
 {
 	struct net *net;
@@ -261,7 +262,7 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 	rcu_read_unlock();
 	/* We have an implied reference to net thanks to nfsd_net_try_get */
 	localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
-					     cred, nfs_fh, fmode);
+					     cred, nfs_fh, pnf, fmode);
 	nfs_to_nfsd_net_put(net);
 	if (!IS_ERR(localio))
 		nfs_uuid_add_file(uuid, nfl);
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 2c0afd1067ea..cb9042761eaf 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -24,20 +24,6 @@
 #include "filecache.h"
 #include "cache.h"
 
-static const struct nfsd_localio_operations nfsd_localio_ops = {
-	.nfsd_net_try_get  = nfsd_net_try_get,
-	.nfsd_net_put  = nfsd_net_put,
-	.nfsd_open_local_fh = nfsd_open_local_fh,
-	.nfsd_file_put_local = nfsd_file_put_local,
-	.nfsd_file_get_local = nfsd_file_get_local,
-	.nfsd_file_file = nfsd_file_file,
-};
-
-void nfsd_localio_ops_init(void)
-{
-	nfs_to = &nfsd_localio_ops;
-}
-
 /**
  * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to nfsd_file
  *
@@ -46,6 +32,7 @@ void nfsd_localio_ops_init(void)
  * @rpc_clnt: rpc_clnt that the client established
  * @cred: cred that the client established
  * @nfs_fh: filehandle to lookup
+ * @nfp: place to find the nfsd_file, or store it if it was non-NULL
  * @fmode: fmode_t to use for open
  *
  * This function maps a local fh to a path on a local filesystem.
@@ -56,10 +43,11 @@ void nfsd_localio_ops_init(void)
  * set. Caller (NFS client) is responsible for calling nfsd_net_put and
  * nfsd_file_put (via nfs_to_nfsd_file_put_local).
  */
-struct nfsd_file *
+static struct nfsd_file *
 nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
-		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
+		   const struct nfs_fh *nfs_fh, struct nfsd_file __rcu **pnf,
+		   const fmode_t fmode)
 {
 	int mayflags = NFSD_MAY_LOCALIO;
 	struct svc_cred rq_cred;
@@ -73,6 +61,12 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 	if (!nfsd_net_try_get(net))
 		return ERR_PTR(-ENXIO);
 
+	rcu_read_lock();
+	localio = nfsd_file_get(rcu_dereference(*pnf));
+	rcu_read_unlock();
+	if (localio)
+		return localio;
+
 	/* nfs_fh -> svc_fh */
 	fh_init(&fh, NFS4_FHSIZE);
 	fh.fh_handle.fh_size = nfs_fh->size;
@@ -94,12 +88,43 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 	if (rq_cred.cr_group_info)
 		put_group_info(rq_cred.cr_group_info);
 
+	if (!IS_ERR(localio)) {
+		struct nfsd_file *new;
+		nfsd_file_get(localio);
+	again:
+		new = unrcu_pointer(cmpxchg(pnf, NULL, RCU_INITIALIZER(localio)));
+		if (new) {
+			/* Some other thread installed an nfsd_file */
+			if (nfsd_file_get(new) == NULL)
+				goto again;
+			/*
+			 * Drop the ref we were going to install and the
+			 * one we were going to return.
+			 */
+			nfsd_file_put(localio);
+			nfsd_file_put(localio);
+			localio = new;
+		}
+	}
 	if (IS_ERR(localio))
 		nfsd_net_put(net);
 
 	return localio;
 }
-EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
+
+static const struct nfsd_localio_operations nfsd_localio_ops = {
+	.nfsd_net_try_get  = nfsd_net_try_get,
+	.nfsd_net_put  = nfsd_net_put,
+	.nfsd_open_local_fh = nfsd_open_local_fh,
+	.nfsd_file_put_local = nfsd_file_put_local,
+	.nfsd_file_get_local = nfsd_file_get_local,
+	.nfsd_file_file = nfsd_file_file,
+};
+
+void nfsd_localio_ops_init(void)
+{
+	nfs_to = &nfsd_localio_ops;
+}
 
 /*
  * UUID_IS_LOCAL XDR functions
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index c3f34bae60e1..e6cd6ec447f5 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -50,10 +50,6 @@ void nfs_localio_invalidate_clients(struct list_head *nn_local_clients,
 				    spinlock_t *nn_local_clients_lock);
 
 /* localio needs to map filehandle -> struct nfsd_file */
-extern struct nfsd_file *
-nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *,
-		   const struct cred *, const struct nfs_fh *,
-		   const fmode_t) __must_hold(rcu);
 void nfs_close_local_fh(struct nfs_file_localio *);
 
 struct nfsd_localio_operations {
@@ -64,6 +60,7 @@ struct nfsd_localio_operations {
 						struct rpc_clnt *,
 						const struct cred *,
 						const struct nfs_fh *,
+						struct nfsd_file __rcu **pnf,
 						const fmode_t);
 	struct net *(*nfsd_file_put_local)(struct nfsd_file *);
 	struct nfsd_file *(*nfsd_file_get_local)(struct nfsd_file *);
@@ -76,6 +73,7 @@ extern const struct nfsd_localio_operations *nfs_to;
 struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *,
 		   struct rpc_clnt *, const struct cred *,
 		   const struct nfs_fh *, struct nfs_file_localio *,
+		   struct nfsd_file __rcu **pnf,
 		   const fmode_t);
 
 static inline void nfs_to_nfsd_net_put(struct net *net)
-- 
2.49.0


