Return-Path: <linux-nfs+bounces-7959-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E039C819D
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 05:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7B58B240D6
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 04:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033751E7C35;
	Thu, 14 Nov 2024 04:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rp6fF+ei"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D368C13D53E
	for <linux-nfs@vger.kernel.org>; Thu, 14 Nov 2024 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556804; cv=none; b=D7PqaCvj6EAVRcXJKmbnY5Ek7SaBWZ9I8aPVis6LI4cW+r5uKYE5UuWeWD6elxGHREDuW5h2n3gjjR43ZgNGcMM1Lo6wjihtWF2cjmbkxFU2Xnvz/Ud5xn2D2Ir2Ga2vIAJT6VwYmkMYEIm/N4TNreQrC/qDqxOUkfnR0u4Qlks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556804; c=relaxed/simple;
	bh=aUMSVApUmE4rxegSXSw9pqFLSppGiFwhNmHm0+PsQGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyXboJ5w33JiwKqsAQfokZ2f9Wu9Xz4Q0aBwpOz1nYNrzjxYDcZjs6vxHNtfP508Zu/BfiYrZO/7CGs7UvzDjehD8I6F5P/lD4ImqalI4aDTLxO1/mYqnMjmjHUzkOpl0/lOI6bu16dMKN/M82CdMRxqtb7c1374mCxND9qZRcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rp6fF+ei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BBFC4CED0;
	Thu, 14 Nov 2024 04:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731556804;
	bh=aUMSVApUmE4rxegSXSw9pqFLSppGiFwhNmHm0+PsQGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rp6fF+eiAoQ33RmPLza57J3NuPEPrry0uP8e9AN2B5ZHTYTgzTm3x7VECWDT/3QMY
	 X9lPhatBIPP4pDGAYIZx2/o5HAZJ+R5FosAILfKsNwiap96n3SeN6IinUxLGnjdPp0
	 3QwOGBZmNMDnfdVDqL9znSrVOzFczf0CgSzc3xMjE4zgi5E+ef4E5/A5qa4ff7gExK
	 Z+GawIhgdqtfjasKGNDZSi9UK43C+QtZOkh/B8wJr4JO6dxCoh1QwmaXAnBKCe/KEW
	 9bJch6/pdwN7ZQmlgRjYSzGIoNU0fk8DeigEi6ZbTLeEYQ9ct1hOJO8M+jHUh0ksdt
	 MaMMrJyqZ0ZDQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v2 08/15] nfsd: rename nfsd_serv_ prefixed methods and variables with nfsd_net_
Date: Wed, 13 Nov 2024 22:59:45 -0500
Message-ID: <20241114035952.13889-9-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241114035952.13889-1-snitzer@kernel.org>
References: <20241114035952.13889-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also update Documentation/filesystems/nfs/localio.rst accordingly
and reduce the technical documentation debt that was previously
captured in that document.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 Documentation/filesystems/nfs/localio.rst | 81 +++++++----------------
 fs/nfs_common/nfslocalio.c                | 10 ++-
 fs/nfsd/filecache.c                       |  2 +-
 fs/nfsd/localio.c                         |  4 +-
 fs/nfsd/netns.h                           | 11 +--
 fs/nfsd/nfssvc.c                          | 34 +++++-----
 include/linux/nfslocalio.h                | 12 ++--
 7 files changed, 64 insertions(+), 90 deletions(-)

diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
index eb3dc764cfce8..9d991a958c81c 100644
--- a/Documentation/filesystems/nfs/localio.rst
+++ b/Documentation/filesystems/nfs/localio.rst
@@ -218,64 +218,30 @@ NFS Client and Server Interlock
 ===============================
 
 LOCALIO provides the nfs_uuid_t object and associated interfaces to
-allow proper network namespace (net-ns) and NFSD object refcounting:
+allow proper network namespace (net-ns) and NFSD object refcounting.
 
-    We don't want to keep a long-term counted reference on each NFSD's
-    net-ns in the client because that prevents a server container from
-    completely shutting down.
-
-    So we avoid taking a reference at all and rely on the per-cpu
-    reference to the server (detailed below) being sufficient to keep
-    the net-ns active. This involves allowing the NFSD's net-ns exit
-    code to iterate all active clients and clear their ->net pointers
-    (which are needed to find the per-cpu-refcount for the nfsd_serv).
-
-    Details:
-
-     - Embed nfs_uuid_t in nfs_client. nfs_uuid_t provides a list_head
-       that can be used to find the client. It does add the 16-byte
-       uuid_t to nfs_client so it is bigger than needed (given that
-       uuid_t is only used during the initial NFS client and server
-       LOCALIO handshake to determine if they are local to each other).
-       If that is really a problem we can find a fix.
-
-     - When the nfs server confirms that the uuid_t is local, it moves
-       the nfs_uuid_t onto a per-net-ns list in NFSD's nfsd_net.
-
-     - When each server's net-ns is shutting down - in a "pre_exit"
-       handler, all these nfs_uuid_t have their ->net cleared. There is
-       an rcu_synchronize() call between pre_exit() handlers and exit()
-       handlers so any caller that sees nfs_uuid_t ->net as not NULL can
-       safely manage the per-cpu-refcount for nfsd_serv.
-
-     - The client's nfs_uuid_t is passed to nfsd_open_local_fh() so it
-       can safely dereference ->net in a private rcu_read_lock() section
-       to allow safe access to the associated nfsd_net and nfsd_serv.
-
-So LOCALIO required the introduction and use of NFSD's percpu_ref to
-interlock nfsd_destroy_serv() and nfsd_open_local_fh(), to ensure each
-nn->nfsd_serv is not destroyed while in use by nfsd_open_local_fh(), and
+LOCALIO required the introduction and use of NFSD's percpu nfsd_net_ref
+to interlock nfsd_shutdown_net() and nfsd_open_local_fh(), to ensure
+each net-ns is not destroyed while in use by nfsd_open_local_fh(), and
 warrants a more detailed explanation:
 
-    nfsd_open_local_fh() uses nfsd_serv_try_get() before opening its
+    nfsd_open_local_fh() uses nfsd_net_try_get() before opening its
     nfsd_file handle and then the caller (NFS client) must drop the
-    reference for the nfsd_file and associated nn->nfsd_serv using
-    nfs_file_put_local() once it has completed its IO.
+    reference for the nfsd_file and associated net-ns using
+    nfsd_file_put_local() once it has completed its IO.
 
     This interlock working relies heavily on nfsd_open_local_fh() being
     afforded the ability to safely deal with the possibility that the
     NFSD's net-ns (and nfsd_net by association) may have been destroyed
-    by nfsd_destroy_serv() via nfsd_shutdown_net() -- which is only
-    possible given the nfs_uuid_t ->net pointer managemenet detailed
-    above.
+    by nfsd_destroy_serv() via nfsd_shutdown_net().
 
-All told, this elaborate interlock of the NFS client and server has been
-verified to fix an easy to hit crash that would occur if an NFSD
-instance running in a container, with a LOCALIO client mounted, is
-shutdown. Upon restart of the container and associated NFSD the client
-would go on to crash due to NULL pointer dereference that occurred due
-to the LOCALIO client's attempting to nfsd_open_local_fh(), using
-nn->nfsd_serv, without having a proper reference on nn->nfsd_serv.
+This interlock of the NFS client and server has been verified to fix an
+easy to hit crash that would occur if an NFSD instance running in a
+container, with a LOCALIO client mounted, is shutdown. Upon restart of
+the container and associated NFSD, the client would go on to crash due
+to NULL pointer dereference that occurred due to the LOCALIO client's
+attempting to nfsd_open_local_fh() without having a proper reference on
+NFSD's net-ns.
 
 NFS Client issues IO instead of Server
 ======================================
@@ -308,14 +274,17 @@ fs/nfs/localio.c:nfs_local_commit().
 
 With normal NFS that makes use of RPC to issue IO to the server, if an
 application uses O_DIRECT the NFS client will bypass the pagecache but
-the NFS server will not. Because the NFS server's use of buffered IO
-affords applications to be less precise with their alignment when
-issuing IO to the NFS client. LOCALIO can be configured to use O_DIRECT
-semantics by setting the 'localio_O_DIRECT_semantics' nfs module
+the NFS server will not. The NFS server's use of buffered IO affords
+applications to be less precise with their alignment when issuing IO to
+the NFS client. But if all applications properly align their IO, LOCALIO
+can be configured to use end-to-end O_DIRECT semantics from the NFS
+client to the underlying local filesystem, that it is sharing with
+the NFS server, by setting the 'localio_O_DIRECT_semantics' nfs module
 parameter to Y, e.g.:
-  echo Y > /sys/module/nfs/parameters/localio_O_DIRECT_semantics
-Once enabled, it will cause LOCALIO to use O_DIRECT semantics (this may
-cause IO to fail if applications do not properly align their IO).
+    echo Y > /sys/module/nfs/parameters/localio_O_DIRECT_semantics
+Once enabled, it will cause LOCALIO to use end-to-end O_DIRECT semantics
+(but again, this may cause IO to fail if applications do not properly
+align their IO).
 
 Security
 ========
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 35a2e48731df6..e75cd21f4c8bc 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -159,6 +159,10 @@ static void nfs_uuid_add_file(nfs_uuid_t *nfs_uuid, struct nfs_file_localio *nfl
 	spin_unlock(&nfs_uuid_lock);
 }
 
+/*
+ * Caller is responsible for calling nfsd_net_put and
+ * nfsd_file_put (via nfs_to_nfsd_file_put_local).
+ */
 struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
 		   const struct nfs_fh *nfs_fh, struct nfs_file_localio *nfl,
@@ -171,7 +175,7 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 	 * Not running in nfsd context, so must safely get reference on nfsd_serv.
 	 * But the server may already be shutting down, if so disallow new localio.
 	 * uuid->net is NOT a counted reference, but rcu_read_lock() ensures that
-	 * if uuid->net is not NULL, then calling nfsd_serv_try_get() is safe
+	 * if uuid->net is not NULL, then calling nfsd_net_try_get() is safe
 	 * and if it succeeds we will have an implied reference to the net.
 	 *
 	 * Otherwise NFS may not have ref on NFSD and therefore cannot safely
@@ -179,12 +183,12 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 	 */
 	rcu_read_lock();
 	net = rcu_dereference(uuid->net);
-	if (!net || !nfs_to->nfsd_serv_try_get(net)) {
+	if (!net || !nfs_to->nfsd_net_try_get(net)) {
 		rcu_read_unlock();
 		return ERR_PTR(-ENXIO);
 	}
 	rcu_read_unlock();
-	/* We have an implied reference to net thanks to nfsd_serv_try_get */
+	/* We have an implied reference to net thanks to nfsd_net_try_get */
 	localio = nfs_to->nfsd_open_local_fh(net, uuid->dom, rpc_clnt,
 					     cred, nfs_fh, fmode);
 	if (IS_ERR(localio))
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 9a62b4da89bb7..fac98b2cb463a 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -391,7 +391,7 @@ nfsd_file_put(struct nfsd_file *nf)
 }
 
 /**
- * nfsd_file_put_local - put nfsd_file reference and arm nfsd_serv_put in caller
+ * nfsd_file_put_local - put nfsd_file reference and arm nfsd_net_put in caller
  * @nf: nfsd_file of which to put the reference
  *
  * First save the associated net to return to caller, then put
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 8beda4c851119..f9a91cd3b5ec7 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -25,8 +25,8 @@
 #include "cache.h"
 
 static const struct nfsd_localio_operations nfsd_localio_ops = {
-	.nfsd_serv_try_get  = nfsd_serv_try_get,
-	.nfsd_serv_put  = nfsd_serv_put,
+	.nfsd_net_try_get  = nfsd_net_try_get,
+	.nfsd_net_put  = nfsd_net_put,
 	.nfsd_open_local_fh = nfsd_open_local_fh,
 	.nfsd_file_put_local = nfsd_file_put_local,
 	.nfsd_file_get = nfsd_file_get,
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 26f7b34d1a030..8faef59d71229 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -140,9 +140,10 @@ struct nfsd_net {
 
 	struct svc_info nfsd_info;
 #define nfsd_serv nfsd_info.serv
-	struct percpu_ref nfsd_serv_ref;
-	struct completion nfsd_serv_confirm_done;
-	struct completion nfsd_serv_free_done;
+
+	struct percpu_ref nfsd_net_ref;
+	struct completion nfsd_net_confirm_done;
+	struct completion nfsd_net_free_done;
 
 	/*
 	 * clientid and stateid data for construction of net unique COPY
@@ -229,8 +230,8 @@ struct nfsd_net {
 extern bool nfsd_support_version(int vers);
 extern unsigned int nfsd_net_id;
 
-bool nfsd_serv_try_get(struct net *net);
-void nfsd_serv_put(struct net *net);
+bool nfsd_net_try_get(struct net *net);
+void nfsd_net_put(struct net *net);
 
 void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
 void nfsd_reset_write_verifier(struct nfsd_net *nn);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 6ca5540424266..e937e2d0ce62c 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -214,32 +214,32 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
 	return 0;
 }
 
-bool nfsd_serv_try_get(struct net *net) __must_hold(rcu)
+bool nfsd_net_try_get(struct net *net) __must_hold(rcu)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	return (nn && percpu_ref_tryget_live(&nn->nfsd_serv_ref));
+	return (nn && percpu_ref_tryget_live(&nn->nfsd_net_ref));
 }
 
-void nfsd_serv_put(struct net *net) __must_hold(rcu)
+void nfsd_net_put(struct net *net) __must_hold(rcu)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	percpu_ref_put(&nn->nfsd_serv_ref);
+	percpu_ref_put(&nn->nfsd_net_ref);
 }
 
-static void nfsd_serv_done(struct percpu_ref *ref)
+static void nfsd_net_done(struct percpu_ref *ref)
 {
-	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
+	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_net_ref);
 
-	complete(&nn->nfsd_serv_confirm_done);
+	complete(&nn->nfsd_net_confirm_done);
 }
 
-static void nfsd_serv_free(struct percpu_ref *ref)
+static void nfsd_net_free(struct percpu_ref *ref)
 {
-	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_serv_ref);
+	struct nfsd_net *nn = container_of(ref, struct nfsd_net, nfsd_net_ref);
 
-	complete(&nn->nfsd_serv_free_done);
+	complete(&nn->nfsd_net_free_done);
 }
 
 /*
@@ -437,8 +437,8 @@ static void nfsd_shutdown_net(struct net *net)
 	if (!nn->nfsd_net_up)
 		return;
 
-	percpu_ref_kill_and_confirm(&nn->nfsd_serv_ref, nfsd_serv_done);
-	wait_for_completion(&nn->nfsd_serv_confirm_done);
+	percpu_ref_kill_and_confirm(&nn->nfsd_net_ref, nfsd_net_done);
+	wait_for_completion(&nn->nfsd_net_confirm_done);
 
 	nfsd_export_flush(net);
 	nfs4_state_shutdown_net(net);
@@ -449,8 +449,8 @@ static void nfsd_shutdown_net(struct net *net)
 		nn->lockd_up = false;
 	}
 
-	wait_for_completion(&nn->nfsd_serv_free_done);
-	percpu_ref_exit(&nn->nfsd_serv_ref);
+	wait_for_completion(&nn->nfsd_net_free_done);
+	percpu_ref_exit(&nn->nfsd_net_ref);
 
 	nn->nfsd_net_up = false;
 	nfsd_shutdown_generic();
@@ -654,12 +654,12 @@ int nfsd_create_serv(struct net *net)
 	if (nn->nfsd_serv)
 		return 0;
 
-	error = percpu_ref_init(&nn->nfsd_serv_ref, nfsd_serv_free,
+	error = percpu_ref_init(&nn->nfsd_net_ref, nfsd_net_free,
 				0, GFP_KERNEL);
 	if (error)
 		return error;
-	init_completion(&nn->nfsd_serv_free_done);
-	init_completion(&nn->nfsd_serv_confirm_done);
+	init_completion(&nn->nfsd_net_free_done);
+	init_completion(&nn->nfsd_net_confirm_done);
 
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 7cfc6720ed26d..aa2b5c6561ab0 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -52,8 +52,8 @@ nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *,
 void nfs_close_local_fh(struct nfs_file_localio *);
 
 struct nfsd_localio_operations {
-	bool (*nfsd_serv_try_get)(struct net *);
-	void (*nfsd_serv_put)(struct net *);
+	bool (*nfsd_net_try_get)(struct net *);
+	void (*nfsd_net_put)(struct net *);
 	struct nfsd_file *(*nfsd_open_local_fh)(struct net *,
 						struct auth_domain *,
 						struct rpc_clnt *,
@@ -77,12 +77,12 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *,
 static inline void nfs_to_nfsd_net_put(struct net *net)
 {
 	/*
-	 * Once reference to nfsd_serv is dropped, NFSD could be
-	 * unloaded, so ensure safe return from nfsd_file_put_local()
-	 * by always taking RCU.
+	 * Once reference to net (and associated nfsd_serv) is dropped, NFSD
+	 * could be unloaded, so ensure safe return from nfsd_net_put() by
+	 * always taking RCU.
 	 */
 	rcu_read_lock();
-	nfs_to->nfsd_serv_put(net);
+	nfs_to->nfsd_net_put(net);
 	rcu_read_unlock();
 }
 
-- 
2.44.0


