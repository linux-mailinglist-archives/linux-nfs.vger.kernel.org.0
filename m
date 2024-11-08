Return-Path: <linux-nfs+bounces-7802-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5739C282E
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60131B22B26
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6122C1F26E0;
	Fri,  8 Nov 2024 23:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2JkHtPk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B4610D
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109218; cv=none; b=i7qXrDnfE9HrbsdVVEfQ5DbONg+EgahQbeBA8EzhqfyrxYvf+AiCQ3qYZPk2z9vRwQC8PvcTzlcwI94R8UzfTK4jcV8JSDuKBrZrae9WOHLvQ/3XOgjunPe8iUennhqlo3KUZ+2mPMNFIdtpGKucwx+KnNGA/Iyv+OglCOFd4ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109218; c=relaxed/simple;
	bh=4M0Eys7VcHvPWAGYLi5wd5QcD99fOfKAkg5m2yCcTvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEXS7FBJBwp6I/dkIdURTJiysD+rNgosSzzCYVK3USkC8vX2Fm9R0sM3JhQ+teDZAwZS0z++J/I/2b8NucEOSAy0hNjX7aj3zAsE/DjWujxBWmx/gI6qa/6jsGY9seN9hdBcvu6cPbeSuTpHgo7hrEmjdHqWdfj1TUh8xiGQv0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2JkHtPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC61C4CECE;
	Fri,  8 Nov 2024 23:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109217;
	bh=4M0Eys7VcHvPWAGYLi5wd5QcD99fOfKAkg5m2yCcTvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2JkHtPkiSq8xtVVvFyf6guQBuz7aKzJJTsGknKZki6pv/DHHXPAggrBqbHMgq6eW
	 rUoGI2Z2MLBD2RuGCcsMaFXyi/aSNNAuYQ1fYvK4k9v+nymSOK7tg1VpdEbKuXvU+k
	 enTApImVLxHRl3BW5kkCxx11dP5ctGLA8VEZAqmTL+CbiBmK6It2krLrH1o81jsoFi
	 1raAjfE9ZQAbqEWz804I/5QqthzNSlMqK7xiOZMSZHyn/7ayi4Nfoh8SjjXIanIYHv
	 AvsiDFuyWoje4I15Id3YLDG5of/uoFmATi4sMhasmiUS1KTM1roebzA9JeJg+m7shk
	 ClsVDZxRVR/gA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 10/19] nfs_common: move localio_lock to new lock member of nfs_uuid_t
Date: Fri,  8 Nov 2024 18:39:53 -0500
Message-ID: <20241108234002.16392-11-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241108234002.16392-1-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>
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
 fs/nfs/localio.c           | 18 ++++++------
 fs/nfs_common/nfslocalio.c | 57 ++++++++++++++++++++++++++------------
 include/linux/nfs_fs_sb.h  |  1 -
 include/linux/nfslocalio.h |  8 +++++-
 5 files changed, 55 insertions(+), 30 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 03ecc7765615..124232054807 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -182,7 +182,6 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	seqlock_init(&clp->cl_boot_lock);
 	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
 	nfs_uuid_init(&clp->cl_uuid);
-	spin_lock_init(&clp->cl_localio_lock);
 #endif /* CONFIG_NFS_LOCALIO */
 
 	clp->cl_principal = "*";
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index cab2a8819259..4c75ffc5efa2 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -125,10 +125,8 @@ const struct rpc_program nfslocalio_program = {
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
@@ -136,12 +134,8 @@ static void nfs_local_enable(struct nfs_client *clp)
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
@@ -183,8 +177,12 @@ static bool nfs_server_uuid_is_local(struct nfs_client *clp)
 	rpc_shutdown_client(rpcclient_localio);
 
 	/* Server is only local if it initialized required struct members */
-	if (status || !clp->cl_uuid.net || !clp->cl_uuid.dom)
+	rcu_read_lock();
+	if (status || !rcu_access_pointer(clp->cl_uuid.net) || !clp->cl_uuid.dom) {
+		rcu_read_unlock();
 		return false;
+	}
+	rcu_read_unlock();
 
 	return true;
 }
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 904439e4bb85..cf2f47ea4f8d 100644
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
+	rcu_assign_pointer(nfs_uuid->net, NULL);
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
index b804346a9741..239d86ef166c 100644
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
index a05d1043f2b0..4d5583873f41 100644
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


