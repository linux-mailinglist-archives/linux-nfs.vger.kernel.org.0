Return-Path: <linux-nfs+bounces-4419-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 068F891D2B5
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 18:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B675728155D
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641E7155308;
	Sun, 30 Jun 2024 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfSDqvlI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404A8153838
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719765467; cv=none; b=hWzIjBLDA/gALY7NtlEUfDUPbETR/7CNLM6ChVW9FwJRBxueQeZJDmCtc+KiFDZ0KuLvsith+aCVLqQ7x8icwJFZRRro0w19PHaakL4yL/qY5gTZCgiyWauChNwhsYoXbwFOzXSpfHD6uwOiflGQxKZRzzEqCI6wjeE5/JkMHy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719765467; c=relaxed/simple;
	bh=moSgLZwCWchV+6wjIcW6uOKSqyVmn2S2stRVSsUGpRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/2SYuAnvLhJdh2r2O1fqPlidiT0XkffzZLMj5dS2QESXM9GfPKmqKc+qlqlLfr3ExbrnaxbVeakV9OmnMAGWoi5Vs2Dmuem0nlX3lWwYb1GxuBWPlVEV3sTyXaBSvBEIFzKHKQuzDK1VlC1h2WIlPOCDpNPA6kM5Jqtth6LOkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfSDqvlI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF18C2BD10;
	Sun, 30 Jun 2024 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719765467;
	bh=moSgLZwCWchV+6wjIcW6uOKSqyVmn2S2stRVSsUGpRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jfSDqvlIHGF+VHnoRSL+rz1XWciYKo1bkCFxKiI79SvMtRv/n5J2wVrFgSbwOXMwk
	 n/ao+gQbgecYSdw7FDoQLqc5IC+TFsSvXeL9s5T99W4S9EPyEm84TJwVblxk1fUrAJ
	 7/Ua67cU/xLvWAv7rtbmzQL29AchS+hqUBtYjD5br5CV5q80auKeacMSeVTflFX7nR
	 G6juFv/BB3F3wB1EO4cZEY3Yb0RDzWPyxWloJObzoUDKa+qUidmL1tIetiWfRl70F/
	 cGDye3IbKzPdo39KVAm0h41po2HY6imgg2acSZV42vQw62IXN8yagsP6Ni3izClUOl
	 BKg6ouxT06iTg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v10 03/19] nfs_common: add NFS LOCALIO auxiliary protocol enablement
Date: Sun, 30 Jun 2024 12:37:25 -0400
Message-ID: <20240630163741.48753-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240630163741.48753-1-snitzer@kernel.org>
References: <20240630163741.48753-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Localio is used by nfsd to add access to a global nfsd_uuids list in
nfs_common that is used to register and then identify local nfsd
instances.

nfsd_uuids is protected by nfsd_mutex or RCU read lock.  List is
composed of nfsd_uuid_t instances that are managed as nfsd creates
them (per network namespace).

nfsd_uuid_is_local() will be used to search all local nfsd for the
client specified nfsd uuid.

This commit also adds all the nfs_client members required to implement
the entire localio feature (which depends on the LOCALIO protocol).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/client.c            |  8 +++++
 fs/nfs_common/Makefile     |  3 ++
 fs/nfs_common/nfslocalio.c | 74 ++++++++++++++++++++++++++++++++++++++
 fs/nfsd/netns.h            |  4 +++
 fs/nfsd/nfssvc.c           | 12 ++++++-
 include/linux/nfs_fs_sb.h  |  9 +++++
 include/linux/nfslocalio.h | 40 +++++++++++++++++++++
 7 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 fs/nfs_common/nfslocalio.c
 create mode 100644 include/linux/nfslocalio.h

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index de77848ae654..bcdf8d42cbc7 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -178,6 +178,14 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_max_connect = cl_init->max_connect ? cl_init->max_connect : 1;
 	clp->cl_net = get_net(cl_init->net);
 
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	seqlock_init(&clp->cl_boot_lock);
+	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
+	clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
+	clp->nfsd_open_local_fh = NULL;
+	clp->cl_nfssvc_net = NULL;
+#endif /* CONFIG_NFS_LOCALIO */
+
 	clp->cl_principal = "*";
 	clp->cl_xprtsec = cl_init->xprtsec;
 	return clp;
diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
index 119c75ab9fd0..d81623b76aba 100644
--- a/fs/nfs_common/Makefile
+++ b/fs/nfs_common/Makefile
@@ -6,5 +6,8 @@
 obj-$(CONFIG_NFS_ACL_SUPPORT) += nfs_acl.o
 nfs_acl-objs := nfsacl.o
 
+obj-$(CONFIG_NFS_COMMON_LOCALIO_SUPPORT) += nfs_localio.o
+nfs_localio-objs := nfslocalio.o
+
 obj-$(CONFIG_GRACE_PERIOD) += grace.o
 obj-$(CONFIG_NFS_V4_2_SSC_HELPER) += nfs_ssc.o
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
new file mode 100644
index 000000000000..a234aa92950f
--- /dev/null
+++ b/fs/nfs_common/nfslocalio.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ */
+
+#include <linux/module.h>
+#include <linux/rculist.h>
+#include <linux/nfslocalio.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("NFS localio protocol bypass support");
+
+/*
+ * Global list of nfsd_uuid_t instances, add/remove
+ * is protected by fs/nfsd/nfssvc.c:nfsd_mutex.
+ * Reads are protected by RCU read lock (see below).
+ */
+LIST_HEAD(nfsd_uuids);
+EXPORT_SYMBOL(nfsd_uuids);
+
+/* Must be called with RCU read lock held. */
+static const uuid_t * nfsd_uuid_lookup(const uuid_t *uuid,
+				struct net **netp)
+{
+	nfsd_uuid_t *nfsd_uuid;
+
+	list_for_each_entry_rcu(nfsd_uuid, &nfsd_uuids, list)
+		if (uuid_equal(&nfsd_uuid->uuid, uuid)) {
+			*netp = nfsd_uuid->net;
+			return &nfsd_uuid->uuid;
+		}
+
+	return &uuid_null;
+}
+
+bool nfsd_uuid_is_local(const uuid_t *uuid, struct net **netp)
+{
+	bool is_local;
+	const uuid_t *nfsd_uuid;
+
+	rcu_read_lock();
+	nfsd_uuid = nfsd_uuid_lookup(uuid, netp);
+	is_local = !uuid_is_null(nfsd_uuid);
+	rcu_read_unlock();
+
+	return is_local;
+}
+EXPORT_SYMBOL_GPL(nfsd_uuid_is_local);
+
+/*
+ * The nfs localio code needs to call into nfsd to do the filehandle -> struct path
+ * mapping, but cannot be statically linked, because that will make the nfs module
+ * depend on the nfsd module.
+ *
+ * Instead, do dynamic linking to the nfsd module (via nfs_common module). The
+ * nfs_common module will only hold a reference on nfsd when localio is in use.
+ * This allows some sanity checking, like giving up on localio if nfsd isn't loaded.
+ */
+
+extern int nfsd_open_local_fh(struct net *, struct rpc_clnt *rpc_clnt,
+			const struct cred *cred, const struct nfs_fh *nfs_fh,
+			const fmode_t fmode, struct file **pfilp);
+
+nfs_to_nfsd_open_t get_nfsd_open_local_fh(void)
+{
+	return symbol_request(nfsd_open_local_fh);
+}
+EXPORT_SYMBOL_GPL(get_nfsd_open_local_fh);
+
+void put_nfsd_open_local_fh(void)
+{
+	symbol_put(nfsd_open_local_fh);
+}
+EXPORT_SYMBOL_GPL(put_nfsd_open_local_fh);
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 14ec15656320..0c5a1d97e4ac 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -15,6 +15,7 @@
 #include <linux/percpu_counter.h>
 #include <linux/siphash.h>
 #include <linux/sunrpc/stats.h>
+#include <linux/nfslocalio.h>
 
 /* Hash tables for nfs4_clientid state */
 #define CLIENT_HASH_BITS                 4
@@ -213,6 +214,9 @@ struct nfsd_net {
 	/* last time an admin-revoke happened for NFSv4.0 */
 	time64_t		nfs40_last_revoke;
 
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+	nfsd_uuid_t		nfsd_uuid;
+#endif
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 0bc8eaa5e009..402d436cbd24 100644
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
@@ -427,6 +428,10 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	nfsd4_ssc_init_umount_work(nn);
+#endif
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
+	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
 #endif
 	nn->nfsd_net_up = true;
 	return 0;
@@ -456,6 +461,9 @@ static void nfsd_shutdown_net(struct net *net)
 		lockd_down(net);
 		nn->lockd_up = false;
 	}
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+	list_del_rcu(&nn->nfsd_uuid.list);
+#endif
 	nn->nfsd_net_up = false;
 	nfsd_shutdown_generic();
 }
@@ -808,7 +816,9 @@ nfsd_svc(int n, int *nthreads, struct net *net, const struct cred *cred, const c
 
 	strscpy(nn->nfsd_name, scope ? scope : utsname()->nodename,
 		sizeof(nn->nfsd_name));
-
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+	uuid_gen(&nn->nfsd_uuid.uuid);
+#endif
 	error = nfsd_create_serv(net);
 	if (error)
 		goto out;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 92de074e63b9..e58e706a6503 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -8,6 +8,7 @@
 #include <linux/wait.h>
 #include <linux/nfs_xdr.h>
 #include <linux/sunrpc/xprt.h>
+#include <linux/nfslocalio.h>
 
 #include <linux/atomic.h>
 #include <linux/refcount.h>
@@ -125,6 +126,14 @@ struct nfs_client {
 	struct net		*cl_net;
 	struct list_head	pending_cb_stateids;
 	struct rcu_head		rcu;
+
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	struct timespec64	cl_nfssvc_boot;
+	seqlock_t		cl_boot_lock;
+	struct rpc_clnt *	cl_rpcclient_localio;
+	struct net *	        cl_nfssvc_net;
+	nfs_to_nfsd_open_t	nfsd_open_local_fh;
+#endif /* CONFIG_NFS_LOCALIO */
 };
 
 /*
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
new file mode 100644
index 000000000000..22443d2089eb
--- /dev/null
+++ b/include/linux/nfslocalio.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
+ */
+#ifndef __LINUX_NFSLOCALIO_H
+#define __LINUX_NFSLOCALIO_H
+
+#include <linux/list.h>
+#include <linux/uuid.h>
+#include <linux/sunrpc/clnt.h>
+#include <linux/nfs.h>
+#include <net/net_namespace.h>
+
+/*
+ * Global list of nfsd_uuid_t instances, add/remove
+ * is protected by fs/nfsd/nfssvc.c:nfsd_mutex.
+ */
+extern struct list_head nfsd_uuids;
+
+/*
+ * Each nfsd instance has an nfsd_uuid_t that is accessible through the
+ * global nfsd_uuids list. Useful to allow a client to negotiate if localio
+ * possible with its server.
+ */
+typedef struct {
+	uuid_t uuid;
+	struct list_head list;
+	struct net *net; /* nfsd's network namespace */
+} nfsd_uuid_t;
+
+bool nfsd_uuid_is_local(const uuid_t *uuid, struct net **netp);
+
+typedef int (*nfs_to_nfsd_open_t)(struct net *, struct rpc_clnt *,
+				const struct cred *, const struct nfs_fh *,
+				const fmode_t, struct file **);
+
+nfs_to_nfsd_open_t get_nfsd_open_local_fh(void);
+void put_nfsd_open_local_fh(void);
+
+#endif  /* __LINUX_NFSLOCALIO_H */
-- 
2.44.0


