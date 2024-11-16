Return-Path: <linux-nfs+bounces-8021-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC979CFC3E
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 02:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F172888BC
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 01:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C854C8F;
	Sat, 16 Nov 2024 01:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeOMdm08"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139AB161
	for <linux-nfs@vger.kernel.org>; Sat, 16 Nov 2024 01:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731721274; cv=none; b=Hfw22cvmx7hO2wqO4qWXUVTuJMoQ59pkYGWMHsx9pFxlfxuzPCdMcQbqeWBY9e0bLThzyZpHmX7BMso/VtKrmfCtDqfDW3tilUFfaSt1iKPMFEpMO5+ONUMTNqyk0qNUMqSyx9O7KZg1rgL+vU3JnoIL+ZpG3nRlCfoQBbNtdnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731721274; c=relaxed/simple;
	bh=8CoGL0Akh/2Q+GcWUxSQuMGv1n/TpBiS2QLvSRFCq8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrQEyNO95JWzGYDgIOsji2lur7SVcoeDka0Gr+lERkajb4hwp05kH36AME5VTpUvWeDnLvFZ/0PqxLjs6p5VkSByqRoY96pcfLjIm75CAM6ifbaMk1d+DIdRAHaEo/t+nKqrW46ou2WuzsIto8Joyp/de71wZ6qXsjZHdXitopM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeOMdm08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA57C4CED5;
	Sat, 16 Nov 2024 01:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731721273;
	bh=8CoGL0Akh/2Q+GcWUxSQuMGv1n/TpBiS2QLvSRFCq8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KeOMdm08DL+hd/0kSgWTy/4EHFPBheANBOaJ6G4Jxjc6Uvfqir53zln5NNjno3g34
	 NBOGL7LSjvz22S8sRKwYCh154CTUpdgmjgw6YPbooeYBMATgHFF+LOb/nncZJk/OpZ
	 O70tI34j4YUhZZRpHPdrf7tVJL8EniKwlaPl+Gsx3RnMy4F/UEPAWkQLzKvqtrU9C/
	 RRwSnygbUwghUfpYWMYjxLWFODsILQSorvd1k40I+lIQYodpcqKOxDssxP2ePm+nf1
	 8Q3pRp2A+Z0GvFs+xOUn1QJpY6PwVzVXM9cpsFLvSXWKSMP1aOVYZrQ+wKlSzUTO0z
	 Bno0RgbHb6U8Q==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v3 04/14] nfs_common: move localio_lock to new lock member of nfs_uuid_t
Date: Fri, 15 Nov 2024 20:40:56 -0500
Message-ID: <20241116014106.25456-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241116014106.25456-1-snitzer@kernel.org>
References: <20241116014106.25456-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove cl_localio_lock from 'struct nfs_client' in favor of adding a
lock to the nfs_uuid_t struct (which is embedded in each nfs_client).

Push nfs_local_{enable,disable} implementation down to nfs_common.
Those methods now call nfs_localio_{enable,disable}_client.

This allows implementing nfs_localio_invalidate_clients in terms of
nfs_localio_disable_client.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/client.c            |  1 -
 fs/nfs/localio.c           | 14 +++-------
 fs/nfs_common/nfslocalio.c | 57 ++++++++++++++++++++++++++------------
 include/linux/nfs_fs_sb.h  |  1 -
 include/linux/nfslocalio.h |  8 +++++-
 5 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 550ca934c9cfc..e83e1ce046130 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -186,7 +186,6 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	seqlock_init(&clp->cl_boot_lock);
 	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
 	nfs_uuid_init(&clp->cl_uuid);
-	spin_lock_init(&clp->cl_localio_lock);
 #endif /* CONFIG_NFS_LOCALIO */
 
 	clp->cl_principal = "*";
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 94af5d89bb996..7191135b47a42 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -126,10 +126,8 @@ const struct rpc_program nfslocalio_program = {
  */
 static void nfs_local_enable(struct nfs_client *clp)
 {
-	spin_lock(&clp->cl_localio_lock);
-	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
 	trace_nfs_local_enable(clp);
-	spin_unlock(&clp->cl_localio_lock);
+	nfs_localio_enable_client(clp);
 }
 
 /*
@@ -137,12 +135,8 @@ static void nfs_local_enable(struct nfs_client *clp)
  */
 void nfs_local_disable(struct nfs_client *clp)
 {
-	spin_lock(&clp->cl_localio_lock);
-	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
-		trace_nfs_local_disable(clp);
-		nfs_localio_disable_client(&clp->cl_uuid);
-	}
-	spin_unlock(&clp->cl_localio_lock);
+	trace_nfs_local_disable(clp);
+	nfs_localio_disable_client(clp);
 }
 
 /*
@@ -184,7 +178,7 @@ static bool nfs_server_uuid_is_local(struct nfs_client *clp)
 	rpc_shutdown_client(rpcclient_localio);
 
 	/* Server is only local if it initialized required struct members */
-	if (status || !clp->cl_uuid.net || !clp->cl_uuid.dom)
+	if (status || !rcu_access_pointer(clp->cl_uuid.net) || !clp->cl_uuid.dom)
 		return false;
 
 	return true;
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 904439e4bb859..abc132166742e 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -7,6 +7,9 @@
 #include <linux/module.h>
 #include <linux/list.h>
 #include <linux/nfslocalio.h>
+#include <linux/nfs3.h>
+#include <linux/nfs4.h>
+#include <linux/nfs_fs_sb.h>
 #include <net/netns/generic.h>
 
 MODULE_LICENSE("GPL");
@@ -25,6 +28,7 @@ void nfs_uuid_init(nfs_uuid_t *nfs_uuid)
 	nfs_uuid->net = NULL;
 	nfs_uuid->dom = NULL;
 	INIT_LIST_HEAD(&nfs_uuid->list);
+	spin_lock_init(&nfs_uuid->lock);
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_init);
 
@@ -94,12 +98,23 @@ void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
 }
 EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
 
+void nfs_localio_enable_client(struct nfs_client *clp)
+{
+	nfs_uuid_t *nfs_uuid = &clp->cl_uuid;
+
+	spin_lock(&nfs_uuid->lock);
+	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
+	spin_unlock(&nfs_uuid->lock);
+}
+EXPORT_SYMBOL_GPL(nfs_localio_enable_client);
+
 static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
 {
-	if (nfs_uuid->net) {
-		module_put(nfsd_mod);
-		nfs_uuid->net = NULL;
-	}
+	if (!nfs_uuid->net)
+		return;
+	module_put(nfsd_mod);
+	RCU_INIT_POINTER(nfs_uuid->net, NULL);
+
 	if (nfs_uuid->dom) {
 		auth_domain_put(nfs_uuid->dom);
 		nfs_uuid->dom = NULL;
@@ -107,27 +122,35 @@ static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
 	list_del_init(&nfs_uuid->list);
 }
 
-void nfs_localio_invalidate_clients(struct list_head *list)
+void nfs_localio_disable_client(struct nfs_client *clp)
+{
+	nfs_uuid_t *nfs_uuid = &clp->cl_uuid;
+
+	spin_lock(&nfs_uuid->lock);
+	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
+		spin_lock(&nfs_uuid_lock);
+		nfs_uuid_put_locked(nfs_uuid);
+		spin_unlock(&nfs_uuid_lock);
+	}
+	spin_unlock(&nfs_uuid->lock);
+}
+EXPORT_SYMBOL_GPL(nfs_localio_disable_client);
+
+void nfs_localio_invalidate_clients(struct list_head *cl_uuid_list)
 {
 	nfs_uuid_t *nfs_uuid, *tmp;
 
 	spin_lock(&nfs_uuid_lock);
-	list_for_each_entry_safe(nfs_uuid, tmp, list, list)
-		nfs_uuid_put_locked(nfs_uuid);
+	list_for_each_entry_safe(nfs_uuid, tmp, cl_uuid_list, list) {
+		struct nfs_client *clp =
+			container_of(nfs_uuid, struct nfs_client, cl_uuid);
+
+		nfs_localio_disable_client(clp);
+	}
 	spin_unlock(&nfs_uuid_lock);
 }
 EXPORT_SYMBOL_GPL(nfs_localio_invalidate_clients);
 
-void nfs_localio_disable_client(nfs_uuid_t *nfs_uuid)
-{
-	if (nfs_uuid->net) {
-		spin_lock(&nfs_uuid_lock);
-		nfs_uuid_put_locked(nfs_uuid);
-		spin_unlock(&nfs_uuid_lock);
-	}
-}
-EXPORT_SYMBOL_GPL(nfs_localio_disable_client);
-
 struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
 		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index b804346a97419..239d86ef166c0 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -132,7 +132,6 @@ struct nfs_client {
 	struct timespec64	cl_nfssvc_boot;
 	seqlock_t		cl_boot_lock;
 	nfs_uuid_t		cl_uuid;
-	spinlock_t		cl_localio_lock;
 #endif /* CONFIG_NFS_LOCALIO */
 };
 
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index a05d1043f2b07..4d5583873f418 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -6,6 +6,7 @@
 #ifndef __LINUX_NFSLOCALIO_H
 #define __LINUX_NFSLOCALIO_H
 
+
 /* nfsd_file structure is purposely kept opaque to NFS client */
 struct nfsd_file;
 
@@ -19,6 +20,8 @@ struct nfsd_file;
 #include <linux/nfs.h>
 #include <net/net_namespace.h>
 
+struct nfs_client;
+
 /*
  * Useful to allow a client to negotiate if localio
  * possible with its server.
@@ -27,6 +30,8 @@ struct nfsd_file;
  */
 typedef struct {
 	uuid_t uuid;
+	/* sadly this struct is just over a cacheline, avoid bouncing */
+	spinlock_t ____cacheline_aligned lock;
 	struct list_head list;
 	struct net __rcu *net; /* nfsd's network namespace */
 	struct auth_domain *dom; /* auth_domain for localio */
@@ -38,7 +43,8 @@ void nfs_uuid_end(nfs_uuid_t *);
 void nfs_uuid_is_local(const uuid_t *, struct list_head *,
 		       struct net *, struct auth_domain *, struct module *);
 
-void nfs_localio_disable_client(nfs_uuid_t *nfs_uuid);
+void nfs_localio_enable_client(struct nfs_client *clp);
+void nfs_localio_disable_client(struct nfs_client *clp);
 void nfs_localio_invalidate_clients(struct list_head *list);
 
 /* localio needs to map filehandle -> struct nfsd_file */
-- 
2.44.0


