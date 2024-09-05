Return-Path: <linux-nfs+bounces-6274-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF9C96E2D4
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 21:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5686528924C
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 19:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5FF18D63F;
	Thu,  5 Sep 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/d/gG3n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6372C43AD7
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563433; cv=none; b=LBi2/XFoDTZxlLeMfUf1TjA2chwfXi2ZozZhHkf+M0dVJBIr1T3PkOGqwgU8xMalVQ9xQJT1QpW664su8M0Bi55uTap8hmafmT0ronofWlvXQDUhXfTx/R/eYBMYdntOeFcMnonxSuIKdYr9CCldYJt5nan0pwdQVGeSnC5RkxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563433; c=relaxed/simple;
	bh=wZMFGHD12kGTkaN7pUa3ZyZobSUMWx6Xt7YWV338DDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nErGFnJaaQ7EDHJnSHTvW94F/tm/kps9yInGqkK04wLOUHs6vysbksbHVAgRsmoLuDbRkl2Ytu6lYIb7XlwyRxkcoZPJCP+A/HDSpY9rB4K9xHR0W6VjfjerD6t3gawpYwV62MZM//wxIV02fbwS3+Q8VL+4bOQdgehkiSwEo3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/d/gG3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCEAC4CEC3;
	Thu,  5 Sep 2024 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725563433;
	bh=wZMFGHD12kGTkaN7pUa3ZyZobSUMWx6Xt7YWV338DDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/d/gG3nYwzCFZBNHPJC9yp2X+YnqyLy3keCF2T1TVnYL+lsjh2dmWiZuFdXiCBu1
	 FlAIR4/DjAdJmkmayjZKPg9kj9F+0nkK9TpjJH20V28pflaRP1REJi6qukrBck0joT
	 dgJj0z1fH6T65iP2D+FmmIdgZnwACk99RYo8fTd3VfBWIkCSlf9UkOglEvuluwhpU5
	 /jmOFZRTC6lUrrRuGAQISopBHiA4jI24UBnXlhNxBzX3hdsS8UXuE8Axysqgsk/Jf6
	 +QWRbxGRlZgvGBV6jfT0p6S4T9Oa379kssMx5+i2RApvAaTgS8jvgWlqOpbaKqBA8q
	 SURPEFZ9vcxwg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH v16 15/26] nfs_common: prepare for the NFS client to use nfsd_file for LOCALIO
Date: Thu,  5 Sep 2024 15:09:49 -0400
Message-ID: <20240905191011.41650-16-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240905191011.41650-1-snitzer@kernel.org>
References: <20240905191011.41650-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next commit will introduce nfsd_open_local_fh() which returns an
nfsd_file structure.  This commit exposes LOCALIO's required NFSD
symbols to the NFS client:

- Make nfsd_open_local_fh() symbol and other required NFSD symbols
  available to NFS in a global 'nfs_to' nfsd_localio_operations
  struct (global access suggested by Trond, nfsd_localio_operations
  suggested by NeilBrown).  The next commit will also introduce
  nfsd_localio_ops_init() that init_nfsd() will call to initialize
  'nfs_to'.

- Introduce nfsd_file_file() that provides access to nfsd_file's
  backing file.  Keeps nfsd_file structure opaque to NFS client (as
  suggested by Jeff Layton).

- Introduce nfsd_file_put_local() that will put the reference to the
  nfsd_file's associated nn->nfsd_serv and then put the reference to
  the nfsd_file (as suggested by NeilBrown).

Suggested-by: Trond Myklebust <trond.myklebust@hammerspace.com> # nfs_to
Suggested-by: NeilBrown <neilb@suse.de> # nfsd_localio_operations
Suggested-by: Jeff Layton <jlayton@kernel.org> # nfsd_file_file
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs_common/nfslocalio.c | 25 ++++++++++++++++++++++++-
 fs/nfsd/filecache.c        | 28 ++++++++++++++++++++++++++++
 fs/nfsd/filecache.h        |  2 ++
 fs/nfsd/nfssvc.c           |  1 +
 include/linux/nfslocalio.h | 27 ++++++++++++++++++++++++++-
 5 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index f0bff023bb5e..f61761ad19b1 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -72,7 +72,7 @@ void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
 		 * invalidated.
 		 */
 		list_move(&nfs_uuid->list, list);
-		nfs_uuid->net = net;
+		rcu_assign_pointer(nfs_uuid->net, net);
 
 		__module_get(mod);
 		nfsd_mod = mod;
@@ -114,3 +114,26 @@ void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid)
 	}
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
+
+/*
+ * The NFS LOCALIO code needs to call into NFSD using various symbols,
+ * but cannot be statically linked, because that will make the NFS
+ * module always depend on the NFSD module.
+ *
+ * 'nfs_to' provides NFS access to NFSD functions needed for LOCALIO,
+ * its lifetime is tightly coupled to the NFSD module and will always
+ * be available to NFS LOCALIO because any successful client<->server
+ * LOCALIO handshake results in a reference on the NFSD module (above),
+ * so NFS implicitly holds a reference to the NFSD module and its
+ * functions in the 'nfs_to' nfsd_localio_operations cannot disappear.
+ *
+ * If the last NFS client using LOCALIO disconnects (and its reference
+ * on NFSD dropped) then NFSD could be unloaded, resulting in 'nfs_to'
+ * functions being invalid pointers. But if NFSD isn't loaded then NFS
+ * will not be able to handshake with NFSD and will have no cause to
+ * try to call 'nfs_to' function pointers. If/when NFSD is reloaded it
+ * will reinitialize the 'nfs_to' function pointers and make LOCALIO
+ * possible.
+ */
+const struct nfsd_localio_operations *nfs_to;
+EXPORT_SYMBOL_GPL(nfs_to);
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2dc72de31f61..8253e437acb7 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -390,6 +390,34 @@ nfsd_file_put(struct nfsd_file *nf)
 		nfsd_file_free(nf);
 }
 
+/**
+ * nfsd_file_put_local - put the reference to nfsd_file and local nfsd_serv
+ * @nf: nfsd_file of which to put the references
+ *
+ * First put the reference of the nfsd_file and then put the
+ * reference to the associated nn->nfsd_serv.
+ */
+void
+nfsd_file_put_local(struct nfsd_file *nf)
+{
+	struct net *net = nf->nf_net;
+
+	nfsd_file_put(nf);
+	nfsd_serv_put(net);
+}
+
+/**
+ * nfsd_file_file - get the backing file of an nfsd_file
+ * @nf: nfsd_file of which to access the backing file.
+ *
+ * Return backing file for @nf.
+ */
+struct file *
+nfsd_file_file(struct nfsd_file *nf)
+{
+	return nf->nf_file;
+}
+
 static void
 nfsd_file_dispose_list(struct list_head *dispose)
 {
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 26ada78b8c1e..cadf3c2689c4 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -55,7 +55,9 @@ void nfsd_file_cache_shutdown(void);
 int nfsd_file_cache_start_net(struct net *net);
 void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
+void nfsd_file_put_local(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
+struct file *nfsd_file_file(struct nfsd_file *nf);
 void nfsd_file_close_inode_sync(struct inode *inode);
 void nfsd_file_net_dispose(struct nfsd_net *nn);
 bool nfsd_file_is_cached(struct inode *inode);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index fa34de5e59bd..f9a6d888ac9d 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -19,6 +19,7 @@
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/lockd/bind.h>
 #include <linux/nfsacl.h>
+#include <linux/nfslocalio.h>
 #include <linux/seq_file.h>
 #include <linux/inetdevice.h>
 #include <net/addrconf.h>
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 4165ff8390c1..1a39d7d727bd 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/list.h>
 #include <linux/uuid.h>
+#include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/svcauth.h>
 #include <linux/nfs.h>
 #include <net/net_namespace.h>
@@ -22,7 +23,7 @@
 typedef struct {
 	uuid_t uuid;
 	struct list_head list;
-	struct net *net; /* nfsd's network namespace */
+	struct net __rcu *net; /* nfsd's network namespace */
 	struct auth_domain *dom; /* auth_domain for localio */
 } nfs_uuid_t;
 
@@ -33,4 +34,28 @@ void nfs_uuid_is_local(const uuid_t *, struct list_head *,
 void nfs_uuid_invalidate_clients(struct list_head *list);
 void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
 
+struct nfsd_file;
+
+/* localio needs to map filehandle -> struct nfsd_file */
+extern struct nfsd_file *
+nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *,
+		   const struct cred *, const struct nfs_fh *,
+		   const fmode_t) __must_hold(rcu);
+
+struct nfsd_localio_operations {
+	bool (*nfsd_serv_try_get)(struct net *);
+	void (*nfsd_serv_put)(struct net *);
+	struct nfsd_file *(*nfsd_open_local_fh)(struct net *,
+						struct auth_domain *,
+						struct rpc_clnt *,
+						const struct cred *,
+						const struct nfs_fh *,
+						const fmode_t);
+	void (*nfsd_file_put_local)(struct nfsd_file *);
+	struct file *(*nfsd_file_file)(struct nfsd_file *);
+} ____cacheline_aligned;
+
+extern void nfsd_localio_ops_init(void);
+extern const struct nfsd_localio_operations *nfs_to;
+
 #endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0


