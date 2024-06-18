Return-Path: <linux-nfs+bounces-4021-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35FF90DD35
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 22:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC8A1C226AE
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 20:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52B71741C9;
	Tue, 18 Jun 2024 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWypdc1+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14661741E9
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718742007; cv=none; b=oOt0tUt/78LHEOEBja3wqEZRTDxAxKYYpvF+eRZ9CqEGBgaVZazFCNZQv3EfTKEaUTGsQDYt85TnyB03qnBWXh008dMLAihEw8yWZzRaescnG0STQoCzRh6g1n2VZ0XXt2bpAftyNbWElHTkVzQJo5/CrpnX24yv6x+PrzICDDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718742007; c=relaxed/simple;
	bh=ISfF6yLyKuEC2+AOz/FvvHNXll1yAEsjf4tp25w1Hp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlc8ZmxAWwLDUPfT/nqw97s9ENULguB45SP2zzUT4rJ7oXfG9WEKD2UWMjjfwaMtCsMhr8OWPCIiRshDoQp3RML3fM6LNCwCR97BGxvGWpIxOJNPgPClDokYARMVglfaH2pviRkUw04WgXg9bIOIcYJAMCscVBxy2MbmM+YzU4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWypdc1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE1EC32786;
	Tue, 18 Jun 2024 20:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718742007;
	bh=ISfF6yLyKuEC2+AOz/FvvHNXll1yAEsjf4tp25w1Hp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MWypdc1+cQIX3a0ypjjz8oWjlEvnycSe6abs5yA9iOleBPH10qxtvc+1qKh4bYS7Y
	 BBrTUayurl4K505CZotCWqQWGCOCIb+enXUlQnMpmuiUHZg+Nt9+H2NugrUbFWQyBU
	 jFfF5cR7bctjt2FwitfF0/8nqNz9arIxY+HLmOiFnz8plL9MQwx66sIsOZTc4zvgX3
	 KxDkM08nLTonIXtO9c6+CpqhNc6/o/IFBQt5HpFyMWAQdY6u6veTiMrayHYV3pMgiK
	 AcH6jKM+PvJ3v4QZ5RP3mWJHJXKCHCOgpqK+jprs8nnS1G/w2WbzFNTsRiy9LATKl6
	 nkckf4V+Vth3Q==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v5 13/19] nfs/nfsd: ensure localio server always uses its network namespace
Date: Tue, 18 Jun 2024 16:19:43 -0400
Message-ID: <20240618201949.81977-14-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240618201949.81977-1-snitzer@kernel.org>
References: <20240618201949.81977-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the stored cl_nfssvc_net from the client to the server as first
argument to nfsd_open_local_fh() to ensure the proper network
namespace is used for localio.

Otherwise, before this commit, the nfs_client's network namespace was
used (as extracted from the client's cl_rpcclient). This is clearly
not going to allow proper functionality if the client and server
happen to have disjoint network namespaces.

Elected to not rename the nfsd_uuid_t structure despite it growing a
non-uuid member. Can revisit later.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/client.c            |  1 +
 fs/nfs/localio.c           | 12 ++++++++----
 fs/nfs_common/nfslocalio.c | 15 +++++++++------
 fs/nfsd/localio.c          |  9 +++++----
 fs/nfsd/nfssvc.c           |  1 +
 fs/nfsd/vfs.h              |  3 ++-
 include/linux/nfs_fs_sb.h  |  1 +
 include/linux/nfslocalio.h | 10 ++++++----
 8 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index cbabcdf3d785..40077ad08ccb 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -171,6 +171,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 
 	INIT_LIST_HEAD(&clp->cl_superblocks);
 	clp->cl_rpcclient = clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
+	clp->cl_nfssvc_net = NULL;
 	clp->nfsd_open_local_fh = NULL;
 
 	clp->cl_flags = cl_init->init_flags;
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index ddd17549812e..d41130f5a84d 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -132,10 +132,11 @@ EXPORT_SYMBOL_GPL(nfs_server_is_local);
 /*
  * nfs_local_enable - attempt to enable local i/o for an nfs_client
  */
-static void nfs_local_enable(struct nfs_client *clp)
+static void nfs_local_enable(struct nfs_client *clp, struct net *net)
 {
 	if (READ_ONCE(clp->nfsd_open_local_fh)) {
 		set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
+		clp->cl_nfssvc_net = net;
 		trace_nfs_local_enable(clp);
 	}
 }
@@ -153,6 +154,7 @@ void nfs_local_disable(struct nfs_client *clp)
 			rpc_shutdown_client(clp->cl_rpcclient_localio);
 			clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
 		}
+		clp->cl_nfssvc_net = NULL;
 	}
 }
 
@@ -192,6 +194,7 @@ static bool nfs_local_server_getuuid(struct nfs_client *clp, uuid_t *nfsd_uuid)
 void nfs_local_probe(struct nfs_client *clp)
 {
 	uuid_t uuid;
+	struct net *net = NULL;
 
 	if (!localio_enabled)
 		goto unsupported;
@@ -211,7 +214,7 @@ void nfs_local_probe(struct nfs_client *clp)
 		 * by verifying client's nfsd, with specified uuid, is local.
 		 */
 		if (!nfs_local_server_getuuid(clp, &uuid) ||
-		    !nfsd_uuid_is_local(&uuid))
+		    !nfsd_uuid_is_local(&uuid, &net))
 			goto unsupported;
 		break;
 	default:
@@ -219,7 +222,7 @@ void nfs_local_probe(struct nfs_client *clp)
 	}
 
 	dprintk("%s: detected local server.\n", __func__);
-	nfs_local_enable(clp);
+	nfs_local_enable(clp, net);
 	return;
 
 unsupported:
@@ -243,7 +246,8 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 	if (mode & ~(FMODE_READ | FMODE_WRITE))
 		return ERR_PTR(-EINVAL);
 
-	status = clp->nfsd_open_local_fh(clp->cl_rpcclient, cred, fh, mode, &filp);
+	status = clp->nfsd_open_local_fh(clp->cl_nfssvc_net, clp->cl_rpcclient,
+					cred, fh, mode, &filp);
 	if (status < 0) {
 		dprintk("%s: open local file failed error=%d\n",
 				__func__, status);
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index c454c4100976..086e09b3ec38 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -12,29 +12,32 @@ MODULE_LICENSE("GPL");
 /*
  * Global list of nfsd_uuid_t instances, add/remove
  * is protected by fs/nfsd/nfssvc.c:nfsd_mutex.
- * Reads are protected RCU read lock (see below).
+ * Reads are protected by RCU read lock (see below).
  */
 LIST_HEAD(nfsd_uuids);
 EXPORT_SYMBOL(nfsd_uuids);
 
 /* Must be called with RCU read lock held. */
-static const uuid_t * nfsd_uuid_lookup(const uuid_t *uuid)
+static const uuid_t * nfsd_uuid_lookup(const uuid_t *uuid,
+				struct net **netp)
 {
 	nfsd_uuid_t *nfsd_uuid;
 
 	list_for_each_entry_rcu(nfsd_uuid, &nfsd_uuids, list)
-		if (uuid_equal(&nfsd_uuid->uuid, uuid))
+		if (uuid_equal(&nfsd_uuid->uuid, uuid)) {
+			*netp = nfsd_uuid->net;
 			return &nfsd_uuid->uuid;
+		}
 
 	return &uuid_null;
 }
 
-bool nfsd_uuid_is_local(const uuid_t *uuid)
+bool nfsd_uuid_is_local(const uuid_t *uuid, struct net **netp)
 {
 	const uuid_t *nfsd_uuid;
 
 	rcu_read_lock();
-	nfsd_uuid = nfsd_uuid_lookup(uuid);
+	nfsd_uuid = nfsd_uuid_lookup(uuid, netp);
 	rcu_read_unlock();
 
 	return !uuid_is_null(nfsd_uuid);
@@ -51,7 +54,7 @@ EXPORT_SYMBOL_GPL(nfsd_uuid_is_local);
  * This allows some sanity checking, like giving up on localio if nfsd isn't loaded.
  */
 
-extern int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
+extern int nfsd_open_local_fh(struct net *, struct rpc_clnt *rpc_clnt,
 			const struct cred *cred, const struct nfs_fh *nfs_fh,
 			const fmode_t fmode, struct file **pfilp);
 
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 7ecd72406dc0..34678bfed579 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -103,10 +103,10 @@ nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
 }
 
 static struct svc_rqst *
-nfsd_local_fakerqst_create(struct rpc_clnt *rpc_clnt, const struct cred *cred)
+nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
+			const struct cred *cred)
 {
 	struct svc_rqst *rqstp;
-	struct net *net = rpc_net_ns(rpc_clnt);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	int status;
 
@@ -186,7 +186,8 @@ nfsd_local_fakerqst_create(struct rpc_clnt *rpc_clnt, const struct cred *cred)
  * dependency on knfsd. So, there is no forward declaration in a header file
  * for it.
  */
-int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
+int nfsd_open_local_fh(struct net *net,
+			 struct rpc_clnt *rpc_clnt,
 			 const struct cred *cred,
 			 const struct nfs_fh *nfs_fh,
 			 const fmode_t fmode,
@@ -203,7 +204,7 @@ int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
 	/* Save creds before calling into nfsd */
 	save_cred = get_current_cred();
 
-	rqstp = nfsd_local_fakerqst_create(rpc_clnt, cred);
+	rqstp = nfsd_local_fakerqst_create(net, rpc_clnt, cred);
 	if (IS_ERR(rqstp)) {
 		status = PTR_ERR(rqstp);
 		goto out_revertcred;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index a81be9b39399..48bfd3c6d619 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -473,6 +473,7 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 #endif
 #if IS_ENABLED(CONFIG_NFSD_LOCALIO)
 	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
+	nn->nfsd_uuid.net = net;
 	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
 #endif
 	nn->nfsd_net_up = true;
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 91c50649a8c7..af07bb146e81 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -160,7 +160,8 @@ __be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
 
 void		nfsd_filp_close(struct file *fp);
 
-int		nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
+int		nfsd_open_local_fh(struct net *net,
+				   struct rpc_clnt *rpc_clnt,
 				   const struct cred *cred,
 				   const struct nfs_fh *nfs_fh,
 				   const fmode_t fmode,
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index f5760b05ec87..f47ea512eb0a 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -132,6 +132,7 @@ struct nfs_client {
 	struct timespec64	cl_nfssvc_boot;
 	seqlock_t		cl_boot_lock;
 	struct rpc_clnt *	cl_rpcclient_localio;	/* localio RPC client handle */
+	struct net *	        cl_nfssvc_net;
 	nfs_to_nfsd_open_t	nfsd_open_local_fh;
 };
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index b8df1b9f248d..c9592ad0afe2 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -8,6 +8,7 @@
 #include <linux/list.h>
 #include <linux/uuid.h>
 #include <linux/nfs.h>
+#include <net/net_namespace.h>
 
 /*
  * Global list of nfsd_uuid_t instances, add/remove
@@ -23,13 +24,14 @@ extern struct list_head nfsd_uuids;
 typedef struct {
 	uuid_t uuid;
 	struct list_head list;
+	struct net *net; /* nfsd's network namespace */
 } nfsd_uuid_t;
 
-bool nfsd_uuid_is_local(const uuid_t *uuid);
+bool nfsd_uuid_is_local(const uuid_t *uuid, struct net **netp);
 
-typedef int (*nfs_to_nfsd_open_t)(struct rpc_clnt *, const struct cred *,
-				  const struct nfs_fh *, const fmode_t,
-				  struct file **);
+typedef int (*nfs_to_nfsd_open_t)(struct net *, struct rpc_clnt *,
+				const struct cred *, const struct nfs_fh *,
+				const fmode_t, struct file **);
 
 nfs_to_nfsd_open_t get_nfsd_open_local_fh(void);
 void put_nfsd_open_local_fh(void);
-- 
2.44.0


