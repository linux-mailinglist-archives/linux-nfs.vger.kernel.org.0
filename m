Return-Path: <linux-nfs+bounces-11364-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57000AA419E
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 06:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B591B67734
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Apr 2025 04:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1C21D86D6;
	Wed, 30 Apr 2025 04:05:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C668078F40
	for <linux-nfs@vger.kernel.org>; Wed, 30 Apr 2025 04:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745985904; cv=none; b=ec2s0LKT9bbvCQjV4bggOwetT7HfsF7/6S+1CjEsk/IHmE73yLEpoQqIUokL9qnEXqZcmjaDCa+Pr1pzYpfKSvXO3Vv4iTLf0usjbhXd1MRn+LBV0w/bAT6n8C8NeKNFyxaOn0pBOX57TkcrSOR9zNDxCUsULkiAf3Fzh8KZ1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745985904; c=relaxed/simple;
	bh=X7iAjS1QsYxoMalfXCnzaHzQkeeuFn+vqrnC23lxc/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLJVGtbwZ+6SA2ftREu7fEPDjYM+9QH4Oh4RY/yeTJJutCQi7FKVKKGLOWmL7D1pRfvJkx9BvUSL8luEEq9wUrDv6z0pnzh+ZIeGbn+I+nFXD+EPsljLtpLyOxaMEWHIMf2sZp/ibfwPhXRhYzrjDCazMAIs0sQxiLRp5eAlrms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1u9ygn-005EYW-Of;
	Wed, 30 Apr 2025 04:04:53 +0000
From: NeilBrown <neil@brown.name>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/6] nfs_localio: always hold nfsd net ref with nfsd_file ref
Date: Wed, 30 Apr 2025 14:01:12 +1000
Message-ID: <20250430040429.2743921-3-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430040429.2743921-1-neil@brown.name>
References: <20250430040429.2743921-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having separate nfsd_file_put and nfsd_file_put_local in struct
nfsd_localio_operations doesn't make much sense.  The difference is that
nfsd_file_put doesn't drop a reference to the nfs_net which is what
keeps nfsd from shutting down.

Currently, if nfsd tries to shutdown it will invalidate the files stored
in the list from the nfs_uuid and this will drop all references to the
nfsd net that the client holds.  But the client could still hold some
references to nfsd_files for active IO.  So nfsd might think is has
completely shut down local IO, but hasn't and has no way to wait for
those active IO requests to complete.

So this patch changes nfsd_file_get to nfsd_file_get_local and has it
increase the ref count on the nfsd net and it replaces all calls to
->nfsd_put_file to ->nfsd_put_file_local.

It also changes ->nfsd_open_local_fh to return with the refcount on the
net elevated precisely when a valid nfsd_file is returned.

This means that whenever the client holds a valid nfsd_file, there will
be an associated count on the nfsd net, and so the count can only reach
zero when all nfsd_files have been returned.

nfs_local_file_put() is changed to call nfs_to_nfsd_file_put_local()
instead of replacing calls to one with calls to the other because this
will help a later patch which changes nfs_to_nfsd_file_put_local() to
take an __rcu pointer while nfs_local_file_put() doesn't.

Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/localio.c           |  4 ++--
 fs/nfs_common/nfslocalio.c |  5 ++---
 fs/nfsd/filecache.c        | 21 +++++++++++++++++++++
 fs/nfsd/filecache.h        |  1 +
 fs/nfsd/localio.c          |  9 +++++++--
 include/linux/nfslocalio.h |  3 +--
 6 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 3674dd86f095..27d5fff9747b 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -209,12 +209,12 @@ EXPORT_SYMBOL_GPL(nfs_local_probe_async);
 
 static inline struct nfsd_file *nfs_local_file_get(struct nfsd_file *nf)
 {
-	return nfs_to->nfsd_file_get(nf);
+	return nfs_to->nfsd_file_get_local(nf);
 }
 
 static inline void nfs_local_file_put(struct nfsd_file *nf)
 {
-	nfs_to->nfsd_file_put(nf);
+	nfs_to_nfsd_file_put_local(nf);
 }
 
 /*
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index d72eecb85ea9..7e73bbf593b9 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -262,9 +262,8 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 	/* We have an implied reference to net thanks to nfsd_net_try_get */
 	localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
 					     cred, nfs_fh, fmode);
-	if (IS_ERR(localio))
-		nfs_to_nfsd_net_put(net);
-	else
+	nfs_to_nfsd_net_put(net);
+	if (!IS_ERR(localio))
 		nfs_uuid_add_file(uuid, nfl);
 
 	return localio;
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ab85e6a2454f..473697278d8f 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -386,6 +386,27 @@ nfsd_file_put_local(struct nfsd_file *nf)
 	return net;
 }
 
+/**
+ * nfsd_file_get_local - get nfsd_file reference and reference to net
+ * @nf: nfsd_file of which to put the reference
+ *
+ * Get reference to both
+ */
+struct nfsd_file *
+nfsd_file_get_local(struct nfsd_file *nf)
+{
+	struct net *net = nf->nf_net;
+
+	if (nfsd_net_try_get(net)) {
+		nf = nfsd_file_get(nf);
+		if (!nf)
+			nfsd_net_put(net);
+	} else {
+		nf = NULL;
+	}
+	return nf;
+}
+
 /**
  * nfsd_file_file - get the backing file of an nfsd_file
  * @nf: nfsd_file of which to access the backing file.
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 5865f9c72712..cd02f91aaef1 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -63,6 +63,7 @@ int nfsd_file_cache_start_net(struct net *net);
 void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
 struct net *nfsd_file_put_local(struct nfsd_file *nf);
+struct nfsd_file *nfsd_file_get_local(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 struct file *nfsd_file_file(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 238647fa379e..2c0afd1067ea 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -29,8 +29,7 @@ static const struct nfsd_localio_operations nfsd_localio_ops = {
 	.nfsd_net_put  = nfsd_net_put,
 	.nfsd_open_local_fh = nfsd_open_local_fh,
 	.nfsd_file_put_local = nfsd_file_put_local,
-	.nfsd_file_get = nfsd_file_get,
-	.nfsd_file_put = nfsd_file_put,
+	.nfsd_file_get_local = nfsd_file_get_local,
 	.nfsd_file_file = nfsd_file_file,
 };
 
@@ -71,6 +70,9 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 	if (nfs_fh->size > NFS4_FHSIZE)
 		return ERR_PTR(-EINVAL);
 
+	if (!nfsd_net_try_get(net))
+		return ERR_PTR(-ENXIO);
+
 	/* nfs_fh -> svc_fh */
 	fh_init(&fh, NFS4_FHSIZE);
 	fh.fh_handle.fh_size = nfs_fh->size;
@@ -92,6 +94,9 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 	if (rq_cred.cr_group_info)
 		put_group_info(rq_cred.cr_group_info);
 
+	if (IS_ERR(localio))
+		nfsd_net_put(net);
+
 	return localio;
 }
 EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 9aa8a43843d7..c3f34bae60e1 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -66,8 +66,7 @@ struct nfsd_localio_operations {
 						const struct nfs_fh *,
 						const fmode_t);
 	struct net *(*nfsd_file_put_local)(struct nfsd_file *);
-	struct nfsd_file *(*nfsd_file_get)(struct nfsd_file *);
-	void (*nfsd_file_put)(struct nfsd_file *);
+	struct nfsd_file *(*nfsd_file_get_local)(struct nfsd_file *);
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
 } ____cacheline_aligned;
 
-- 
2.49.0


