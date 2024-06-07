Return-Path: <linux-nfs+bounces-3597-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A0C900686
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282821C22E09
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E616E196C7B;
	Fri,  7 Jun 2024 14:27:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDDA19751B
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770429; cv=none; b=Y2QSJZpvH2RmaIstyy6WrzKGMIQ6cO8Uq9KoXtQb4hVtKol5X9o3udTMGD7H3XqOdAkd2xZj0xA0ydg8Ir6JW1nNpZZUycr8n9zeMeJlqYC1ij9mjnIROdP2rzy0kGMtO0cfLJeW1Xub6yQ6CAhdcvjKZvzBHM1/OM6bKzUXi6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770429; c=relaxed/simple;
	bh=8ht6aGe6HkORBvTmyM8JszmcxJ98HmMRkU9fpPprb7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drATkxI8u4xGWuDCDURVRpoSBHhvqcwsLps96yj7JoZ9t7ASsDWzoc9lqHj/dznU9c4FSyY+bdDHcu34EWAqNIkBMFiv01lFtV13e6QSMEvqHMorEsqirfHSjU4EFwvKiyzvMQh7FHiQQIyRWZo/VWgGQkwt90XdqORO5eMf1Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44030e79ed4so10108221cf.1
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770424; x=1718375224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UU5yf7x35zuGCxSUeARuMMD1qXmrK41cDN6FrRy3RE=;
        b=bZQx/OCtv4/PWVz9zpK5O9R0bCuVKl0wv0vPYTT6bU94JjUd8+z6ugbRWZ7UlvGFSw
         JDm5PyU6V565iybB2uJECF402sLiAhQrm81demgFyyxBqWzXCMiZ9xNjK+OYmXC93tvP
         A5RfL40i9nMAWy4LmmC2DdjAsmzDmsWbAjOSX8qMlV5PDc6YcjUwZIfxH1vTILVEZINt
         sneb0e+t0JP3INRnUiIKRS5w6qAi7yCYCOy2YL6CssTb6guqGi2OeppR8mPjKO/Bfpzf
         BS7c2f0iy3pPOSUfmb6s0WIWpPYwWOmEgdsw645ItiVncdYF6QEiCHt6wC7I6pUAHfrs
         wDrA==
X-Gm-Message-State: AOJu0YwBqgyDoLqZd/x8bxE8g+v3Ndjy1qCT1sGP5lQq0DIN4cPoQBuk
	JTW1Kuy3Sbyj5orKAbP0ScjXaWjYiV5bAnaZ1JEC9HLw2LXsAlYwwfNMQ1B+7zwopbN1oHBffZe
	BBQEgRQ==
X-Google-Smtp-Source: AGHT+IHQpK43NwRqTFcbBqBjXmPEDPzbN944R+1AlycYoAHiha1RR2QCWbPaW1vv6pFr+GpKVA7ocQ==
X-Received: by 2002:a05:622a:2ca:b0:43b:6fb:8bfd with SMTP id d75a77b69052e-44041c5227bmr32779441cf.20.1717770423751;
        Fri, 07 Jun 2024 07:27:03 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44043351c56sm6218711cf.91.2024.06.07.07.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:03 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 10/29] nfs/nfsd: add "local io" support
Date: Fri,  7 Jun 2024 10:26:27 -0400
Message-ID: <20240607142646.20924-11-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weston Andros Adamson <dros@primarydata.com>

Add client support for bypassing NFS for localhost reads, writes, and commits.

This is only useful when the client and the server are running on the same
host and in the same container.

This has dynamic binding with the nfsd module. Local i/o will only work if
nfsd is already loaded.

[snitm: rebase accounted for commit d8b26071e65e8 ("NFSD: simplify struct nfsfh")
 and commit 7c98f7cb8fda ("remove call_{read,write}_iter() functions")]

Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Peng Tao <tao.peng@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/Makefile                        |   2 +-
 fs/nfs/client.c                        |  12 +
 fs/nfs/filelayout/filelayout.c         |   6 +-
 fs/nfs/flexfilelayout/flexfilelayout.c |   6 +-
 fs/nfs/inode.c                         |   5 +
 fs/nfs/internal.h                      |  32 +-
 fs/nfs/localio.c                       | 933 +++++++++++++++++++++++++
 fs/nfs/nfstrace.h                      |  29 +
 fs/nfs/pagelist.c                      |  12 +-
 fs/nfs/pnfs_nfs.c                      |   2 +-
 fs/nfs/write.c                         |  14 +-
 fs/nfsd/Makefile                       |   2 +-
 fs/nfsd/filecache.c                    |   2 +-
 fs/nfsd/localio.c                      | 179 +++++
 fs/nfsd/trace.h                        |   3 +-
 fs/nfsd/vfs.h                          |   8 +
 include/linux/nfs.h                    |   6 +
 include/linux/nfs_fs.h                 |   2 +
 include/linux/nfs_fs_sb.h              |   2 +
 include/linux/nfs_xdr.h                |   1 +
 20 files changed, 1240 insertions(+), 18 deletions(-)
 create mode 100644 fs/nfs/localio.c
 create mode 100644 fs/nfsd/localio.c

diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index 5f6db37f461e..af64cf5ea420 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -9,7 +9,7 @@ CFLAGS_nfstrace.o += -I$(src)
 nfs-y 			:= client.o dir.o file.o getroot.o inode.o super.o \
 			   io.o direct.o pagelist.o read.o symlink.o unlink.o \
 			   write.o namespace.o mount_clnt.o nfstrace.o \
-			   export.o sysfs.o fs_context.o
+			   export.o sysfs.o fs_context.o localio.o
 nfs-$(CONFIG_ROOT_NFS)	+= nfsroot.o
 nfs-$(CONFIG_SYSCTL)	+= sysctl.o
 nfs-$(CONFIG_NFS_FSCACHE) += fscache.o
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index dd3278dcfca8..288de750fd3b 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -170,6 +170,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	}
 
 	INIT_LIST_HEAD(&clp->cl_superblocks);
+	INIT_LIST_HEAD(&clp->cl_local_addrs);
 	clp->cl_rpcclient = ERR_PTR(-EINVAL);
 
 	clp->cl_flags = cl_init->init_flags;
@@ -183,6 +184,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 
 	clp->cl_principal = "*";
 	clp->cl_xprtsec = cl_init->xprtsec;
+	nfs_probe_local_addr(clp);
 	return clp;
 
 error_cleanup:
@@ -236,10 +238,19 @@ static void pnfs_init_server(struct nfs_server *server)
  */
 void nfs_free_client(struct nfs_client *clp)
 {
+	struct nfs_local_addr *addr, *tmp;
+
+	nfs_local_disable(clp);
+
 	/* -EIO all pending I/O */
 	if (!IS_ERR(clp->cl_rpcclient))
 		rpc_shutdown_client(clp->cl_rpcclient);
 
+	list_for_each_entry_safe(addr, tmp, &clp->cl_local_addrs, cl_addrs) {
+		list_del(&addr->cl_addrs);
+		kfree(addr);
+	}
+
 	put_net(clp->cl_net);
 	put_nfs_version(clp->cl_nfs_mod);
 	kfree(clp->cl_hostname);
@@ -427,6 +438,7 @@ struct nfs_client *nfs_get_client(const struct nfs_client_initdata *cl_init)
 			list_add_tail(&new->cl_share_link,
 					&nn->nfs_client_list);
 			spin_unlock(&nn->nfs_client_lock);
+			nfs_local_probe(new);
 			return rpc_ops->init_client(new, cl_init);
 		}
 
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index d66f2efbd92f..bd8c717c31d2 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -489,7 +489,7 @@ filelayout_read_pagelist(struct nfs_pageio_descriptor *desc,
 	/* Perform an asynchronous read to ds */
 	nfs_initiate_pgio(desc, ds->ds_clp, ds_clnt, hdr, hdr->cred,
 			  NFS_PROTO(hdr->inode), &filelayout_read_call_ops,
-			  0, RPC_TASK_SOFTCONN);
+			  0, RPC_TASK_SOFTCONN, NULL);
 	return PNFS_ATTEMPTED;
 }
 
@@ -532,7 +532,7 @@ filelayout_write_pagelist(struct nfs_pageio_descriptor *desc,
 	/* Perform an asynchronous write */
 	nfs_initiate_pgio(desc, ds->ds_clp, ds_clnt, hdr, hdr->cred,
 			  NFS_PROTO(hdr->inode), &filelayout_write_call_ops,
-			  sync, RPC_TASK_SOFTCONN);
+			  sync, RPC_TASK_SOFTCONN, NULL);
 	return PNFS_ATTEMPTED;
 }
 
@@ -1014,7 +1014,7 @@ static int filelayout_initiate_commit(struct nfs_commit_data *data, int how)
 	return nfs_initiate_commit(ds->ds_clp, ds_clnt, data,
 				   NFS_PROTO(data->inode),
 				   &filelayout_commit_call_ops, how,
-				   RPC_TASK_SOFTCONN);
+				   RPC_TASK_SOFTCONN, NULL);
 out_err:
 	pnfs_generic_prepare_to_resend_writes(data);
 	pnfs_generic_commit_release(data);
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index d7e9e5ef4085..ce6cb5d82427 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1808,7 +1808,7 @@ ff_layout_read_pagelist(struct nfs_pageio_descriptor *desc,
 			  ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_read_call_ops_v3 :
 				      &ff_layout_read_call_ops_v4,
-			  0, RPC_TASK_SOFTCONN);
+			  0, RPC_TASK_SOFTCONN, NULL);
 	put_cred(ds_cred);
 	return PNFS_ATTEMPTED;
 
@@ -1878,7 +1878,7 @@ ff_layout_write_pagelist(struct nfs_pageio_descriptor *desc,
 			  ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_write_call_ops_v3 :
 				      &ff_layout_write_call_ops_v4,
-			  sync, RPC_TASK_SOFTCONN);
+			  sync, RPC_TASK_SOFTCONN, NULL);
 	put_cred(ds_cred);
 	return PNFS_ATTEMPTED;
 
@@ -1953,7 +1953,7 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	ret = nfs_initiate_commit(ds->ds_clp, ds_clnt, data, ds->ds_clp->rpc_ops,
 				   vers == 3 ? &ff_layout_commit_call_ops_v3 :
 					       &ff_layout_commit_call_ops_v4,
-				   how, RPC_TASK_SOFTCONN);
+				   how, RPC_TASK_SOFTCONN, NULL);
 	put_cred(ds_cred);
 	return ret;
 out_err:
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index acef52ecb1bb..4f88b860494f 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -39,6 +39,7 @@
 #include <linux/slab.h>
 #include <linux/compat.h>
 #include <linux/freezer.h>
+#include <linux/file.h>
 #include <linux/uaccess.h>
 #include <linux/iversion.h>
 
@@ -1053,6 +1054,7 @@ struct nfs_open_context *alloc_nfs_open_context(struct dentry *dentry,
 	ctx->lock_context.open_context = ctx;
 	INIT_LIST_HEAD(&ctx->list);
 	ctx->mdsthreshold = NULL;
+	ctx->local_filp = NULL;
 	return ctx;
 }
 EXPORT_SYMBOL_GPL(alloc_nfs_open_context);
@@ -1084,6 +1086,8 @@ static void __put_nfs_open_context(struct nfs_open_context *ctx, int is_sync)
 	nfs_sb_deactive(sb);
 	put_rpccred(rcu_dereference_protected(ctx->ll_cred, 1));
 	kfree(ctx->mdsthreshold);
+	if (!IS_ERR_OR_NULL(ctx->local_filp))
+		fput(ctx->local_filp);
 	kfree_rcu(ctx, rcu_head);
 }
 
@@ -2495,6 +2499,7 @@ static int __init init_nfs_fs(void)
 	if (err)
 		goto out1;
 
+	nfs_local_init();
 	err = register_nfs_fs();
 	if (err)
 		goto out0;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 873c2339b78a..67b348447a40 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -204,6 +204,12 @@ struct nfs_mount_request {
 	struct net		*net;
 };
 
+struct nfs_local_addr {
+	struct list_head	cl_addrs;
+	struct sockaddr_storage	address;
+	size_t			addrlen;
+};
+
 extern int nfs_mount(struct nfs_mount_request *info, int timeo, int retrans);
 extern void nfs_umount(const struct nfs_mount_request *info);
 
@@ -309,7 +315,8 @@ int nfs_generic_pgio(struct nfs_pageio_descriptor *, struct nfs_pgio_header *);
 int nfs_initiate_pgio(struct nfs_pageio_descriptor *, struct nfs_client *clp,
 		      struct rpc_clnt *rpc_clnt, struct nfs_pgio_header *hdr,
 		      const struct cred *cred, const struct nfs_rpc_ops *rpc_ops,
-		      const struct rpc_call_ops *call_ops, int how, int flags);
+		      const struct rpc_call_ops *call_ops, int how, int flags,
+		      struct file *localio);
 void nfs_free_request(struct nfs_page *req);
 struct nfs_pgio_mirror *
 nfs_pgio_current_mirror(struct nfs_pageio_descriptor *desc);
@@ -450,6 +457,26 @@ extern void nfs_set_cache_invalid(struct inode *inode, unsigned long flags);
 extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
 extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 
+/* localio.c */
+extern void nfs_local_init(void);
+extern void nfs_local_enable(struct nfs_client *);
+extern void nfs_local_disable(struct nfs_client *);
+extern void nfs_local_probe(struct nfs_client *);
+extern struct file *nfs_local_open_fh(struct nfs_client *, const struct cred *,
+				      struct nfs_fh *, const fmode_t);
+extern struct file *nfs_local_file_open(struct nfs_client *clp,
+					const struct cred *cred,
+					struct nfs_fh *fh,
+					struct nfs_open_context *ctx);
+extern int nfs_local_doio(struct nfs_client *, struct file *,
+			  struct nfs_pgio_header *,
+			  const struct rpc_call_ops *);
+extern int nfs_local_commit(struct nfs_client *, struct file *,
+			    struct nfs_commit_data *,
+			    const struct rpc_call_ops *, int);
+extern void nfs_probe_local_addr(struct nfs_client *clnt);
+extern bool nfs_server_is_local(const struct nfs_client *clp);
+
 /* super.c */
 extern const struct super_operations nfs_sops;
 bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
@@ -530,7 +557,8 @@ extern int nfs_initiate_commit(struct nfs_client *clp,
 			       struct nfs_commit_data *data,
 			       const struct nfs_rpc_ops *nfs_ops,
 			       const struct rpc_call_ops *call_ops,
-			       int how, int flags);
+			       int how, int flags,
+			       struct file *localio);
 extern void nfs_init_commit(struct nfs_commit_data *data,
 			    struct list_head *head,
 			    struct pnfs_layout_segment *lseg,
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
new file mode 100644
index 000000000000..5c69eb0fe7b6
--- /dev/null
+++ b/fs/nfs/localio.c
@@ -0,0 +1,933 @@
+/*
+ *  linux/fs/nfs/localio.c
+ *
+ *  Copyright (C) 2014  Weston Andros Adamson <dros@primarydata.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/vfs.h>
+#include <linux/file.h>
+#include <linux/inet.h>
+#include <linux/sunrpc/addr.h>
+#include <linux/inetdevice.h>
+#include <net/addrconf.h>
+#include <linux/module.h>
+#include <linux/bvec.h>
+
+#include <linux/nfs.h>
+#include <linux/nfs_fs.h>
+#include <linux/nfs_xdr.h>
+
+#include <uapi/linux/if_arp.h>
+
+#include "internal.h"
+#include "pnfs.h"
+#include "nfstrace.h"
+
+#define NFSDBG_FACILITY		NFSDBG_VFS
+
+extern int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
+			      const struct cred *cred,
+			      const struct nfs_fh *nfs_fh, const fmode_t fmode,
+			      struct file **pfilp);
+/*
+ * The localio code needs to call into nfsd to do the filehandle -> struct path
+ * mapping, but cannot be statically linked, because that will make the nfs
+ * module depend on the nfsd module.
+ *
+ * Instead, do dynamic linking to the nfsd module. This way the nfs module
+ * will only hold a reference on nfsd when it's actually in use. This also
+ * allows some sanity checking, like giving up on localio if nfsd isn't loaded.
+ */
+
+struct nfs_local_open_ctx {
+	spinlock_t lock;
+	nfs_to_nfsd_open_t open_f;
+	atomic_t refcount;
+};
+
+struct nfs_local_kiocb {
+	struct kiocb		kiocb;
+	struct bio_vec		*bvec;
+	struct nfs_pgio_header	*hdr;
+	struct work_struct	work;
+};
+
+struct nfs_local_fsync_ctx {
+	struct file		*filp;
+	struct nfs_commit_data	*data;
+	struct work_struct	work;
+	struct kref		kref;
+};
+static void nfs_local_fsync_work(struct work_struct *work);
+
+/*
+ * We need to translate between nfs status return values and
+ * the local errno values which may not be the same.
+ */
+static struct {
+	__u32 stat;
+	int errno;
+} nfs_errtbl[] = {
+	{ NFS4_OK,		0		},
+	{ NFS4ERR_PERM,		-EPERM		},
+	{ NFS4ERR_NOENT,	-ENOENT		},
+	{ NFS4ERR_IO,		-EIO		},
+	{ NFS4ERR_NXIO,		-ENXIO		},
+	{ NFS4ERR_FBIG,		-E2BIG		},
+	{ NFS4ERR_STALE,	-EBADF		},
+	{ NFS4ERR_ACCESS,	-EACCES		},
+	{ NFS4ERR_EXIST,	-EEXIST		},
+	{ NFS4ERR_XDEV,		-EXDEV		},
+	{ NFS4ERR_MLINK,	-EMLINK		},
+	{ NFS4ERR_NOTDIR,	-ENOTDIR	},
+	{ NFS4ERR_ISDIR,	-EISDIR		},
+	{ NFS4ERR_INVAL,	-EINVAL		},
+	{ NFS4ERR_FBIG,		-EFBIG		},
+	{ NFS4ERR_NOSPC,	-ENOSPC		},
+	{ NFS4ERR_ROFS,		-EROFS		},
+	{ NFS4ERR_NAMETOOLONG,	-ENAMETOOLONG	},
+	{ NFS4ERR_NOTEMPTY,	-ENOTEMPTY	},
+	{ NFS4ERR_DQUOT,	-EDQUOT		},
+	{ NFS4ERR_STALE,	-ESTALE		},
+	{ NFS4ERR_STALE,	-EOPENSTALE	},
+	{ NFS4ERR_DELAY,	-ETIMEDOUT	},
+	{ NFS4ERR_DELAY,	-ERESTARTSYS	},
+	{ NFS4ERR_DELAY,	-EAGAIN		},
+	{ NFS4ERR_DELAY,	-ENOMEM		},
+	{ NFS4ERR_IO,		-ETXTBSY	},
+	{ NFS4ERR_IO,		-EBUSY		},
+	{ NFS4ERR_BADHANDLE,	-EBADHANDLE	},
+	{ NFS4ERR_BAD_COOKIE,	-EBADCOOKIE	},
+	{ NFS4ERR_NOTSUPP,	-EOPNOTSUPP	},
+	{ NFS4ERR_TOOSMALL,	-ETOOSMALL	},
+	{ NFS4ERR_SERVERFAULT,	-ESERVERFAULT	},
+	{ NFS4ERR_SERVERFAULT,	-ENFILE		},
+	{ NFS4ERR_IO,		-EREMOTEIO	},
+	{ NFS4ERR_IO,		-EUCLEAN	},
+	{ NFS4ERR_PERM,		-ENOKEY		},
+	{ NFS4ERR_BADTYPE,	-EBADTYPE	},
+	{ NFS4ERR_SYMLINK,	-ELOOP		},
+	{ NFS4ERR_DEADLOCK,	-EDEADLK	},
+};
+
+/*
+ * Convert an NFS error code to a local one.
+ * This one is used jointly by NFSv2 and NFSv3.
+ */
+static __u32
+nfs4errno(int errno)
+{
+	unsigned int i;
+	for (i = 0; i < ARRAY_SIZE(nfs_errtbl); i++) {
+		if (nfs_errtbl[i].errno == errno)
+			return nfs_errtbl[i].stat;
+	}
+	/* If we cannot translate the error, the recovery routines should
+	 * handle it.
+	 * Note: remaining NFSv4 error codes have values > 10000, so should
+	 * not conflict with native Linux error codes.
+	 */
+	return NFS4ERR_SERVERFAULT;
+}
+
+static struct nfs_local_open_ctx __local_open_ctx __read_mostly;
+
+static bool localio_enabled __read_mostly = true;
+module_param(localio_enabled, bool, 0644);
+
+bool nfs_server_is_local(const struct nfs_client *clp)
+{
+	return test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags) != 0 &&
+		localio_enabled;
+}
+EXPORT_SYMBOL_GPL(nfs_server_is_local);
+
+void
+nfs_local_init(void)
+{
+	struct nfs_local_open_ctx *ctx = &__local_open_ctx;
+
+	ctx->open_f = NULL;
+	spin_lock_init(&ctx->lock);
+	atomic_set(&ctx->refcount, 0);
+}
+
+static bool
+nfs_local_get_lookup_ctx(void)
+{
+	struct nfs_local_open_ctx *ctx = &__local_open_ctx;
+	nfs_to_nfsd_open_t fn = NULL;
+
+	spin_lock(&ctx->lock);
+	if (ctx->open_f == NULL) {
+		spin_unlock(&ctx->lock);
+
+		fn = symbol_request(nfsd_open_local_fh);
+		if (!fn)
+			return false;
+
+		spin_lock(&ctx->lock);
+		/* catch race */
+		if (ctx->open_f == NULL) {
+			ctx->open_f = fn;
+			fn = NULL;
+		}
+	}
+	atomic_inc(&ctx->refcount);
+	spin_unlock(&ctx->lock);
+	if (fn)
+		symbol_put(nfsd_open_local_fh);
+	return true;
+}
+
+static void
+nfs_local_put_lookup_ctx(void)
+{
+	struct nfs_local_open_ctx *ctx = &__local_open_ctx;
+	nfs_to_nfsd_open_t fn;
+
+	if (atomic_dec_and_lock(&ctx->refcount, &ctx->lock)) {
+		fn = ctx->open_f;
+		ctx->open_f = NULL;
+		spin_unlock(&ctx->lock);
+		if (fn)
+			symbol_put(nfsd_open_local_fh);
+		dprintk("destroy lookup context\n");
+	}
+}
+
+/*
+ * nfs_local_enable - attempt to enable local i/o for an nfs_client
+ */
+void
+nfs_local_enable(struct nfs_client *clp)
+{
+	if (nfs_local_get_lookup_ctx()) {
+		dprintk("enabled local i/o\n");
+		set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
+	}
+}
+EXPORT_SYMBOL_GPL(nfs_local_enable);
+
+/*
+ * nfs_local_disable - disable local i/o for an nfs_client
+ */
+void
+nfs_local_disable(struct nfs_client *clp)
+{
+	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
+		dprintk("disabled local i/o\n");
+		nfs_local_put_lookup_ctx();
+	}
+}
+
+/*
+ * nfs_local_probe - probe local i/o support for an nfs_client
+ */
+void
+nfs_local_probe(struct nfs_client *clp)
+{
+	struct sockaddr_in *sin;
+	struct sockaddr_in6 *sin6;
+	struct nfs_local_addr *addr;
+	struct sockaddr *sap;
+	bool enable = false;
+
+	switch (clp->cl_addr.ss_family) {
+	case AF_INET:
+		sin = (struct sockaddr_in *)&clp->cl_addr;
+		if (ipv4_is_loopback(sin->sin_addr.s_addr)) {
+			dprintk("%s: detected IPv4 loopback address\n",
+				__func__);
+			enable = true;
+		}
+		break;
+	case AF_INET6:
+		sin6 = (struct sockaddr_in6 *)&clp->cl_addr;
+		if (memcmp(&sin6->sin6_addr, &in6addr_loopback,
+		    sizeof(struct in6_addr)) == 0) {
+			dprintk("%s: detected IPv6 loopback address\n",
+				__func__);
+			enable = true;
+		}
+		break;
+	default:
+		break;
+	}
+
+	if (enable)
+		goto out;
+
+	list_for_each_entry(addr, &clp->cl_local_addrs, cl_addrs) {
+		sap = (struct sockaddr *)&addr->address;
+		if (rpc_cmp_addr((struct sockaddr *)&clp->cl_addr, sap)) {
+			dprintk("%s: detected local server.\n", __func__);
+			enable = true;
+			break;
+		}
+	}
+
+out:
+	if (enable)
+		nfs_local_enable(clp);
+}
+
+/*
+ * nfs_local_open_fh - open a local filehandle
+ *
+ * Returns a pointer to a struct file or an ERR_PTR
+ */
+struct file *
+nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
+		  struct nfs_fh *fh, const fmode_t mode)
+{
+	struct nfs_local_open_ctx *ctx = &__local_open_ctx;
+	struct file *filp;
+	int status;
+
+	if (mode & ~(FMODE_READ | FMODE_WRITE))
+		return ERR_PTR(-EINVAL);
+
+	status = ctx->open_f(clp->cl_rpcclient, cred, fh, mode, &filp);
+	if (status < 0) {
+		dprintk("%s: open local file failed error=%d\n",
+				__func__, status);
+		trace_nfs_local_open_fh(fh, mode, status);
+		switch (status) {
+		case -ENXIO:
+			nfs_local_disable(clp);
+			fallthrough;
+		case -ETIMEDOUT:
+			status = -EAGAIN;
+		}
+		filp = ERR_PTR(status);
+	}
+	return filp;
+}
+EXPORT_SYMBOL_GPL(nfs_local_open_fh);
+
+static struct bio_vec *
+nfs_bvec_alloc_and_import_pagevec(struct page **pagevec,
+		unsigned int npages, gfp_t flags)
+{
+	struct bio_vec *bvec, *p;
+
+	bvec = kmalloc_array(npages, sizeof(*bvec), flags);
+	if (bvec != NULL) {
+		for (p = bvec; npages > 0; p++, pagevec++, npages--) {
+			p->bv_page = *pagevec;
+			p->bv_len = PAGE_SIZE;
+			p->bv_offset = 0;
+		}
+	}
+	return bvec;
+}
+
+static void
+nfs_local_iocb_free(struct nfs_local_kiocb *iocb)
+{
+	kfree(iocb->bvec);
+	kfree(iocb);
+}
+
+static struct nfs_local_kiocb *
+nfs_local_iocb_alloc(struct nfs_pgio_header *hdr, struct file *filp,
+		gfp_t flags)
+{
+	struct nfs_local_kiocb *iocb;
+
+	iocb = kmalloc(sizeof(*iocb), flags);
+	if (iocb == NULL)
+		return NULL;
+	iocb->bvec = nfs_bvec_alloc_and_import_pagevec(hdr->page_array.pagevec,
+			hdr->page_array.npages, flags);
+	if (iocb->bvec == NULL) {
+		kfree(iocb);
+		return NULL;
+	}
+	init_sync_kiocb(&iocb->kiocb, filp);
+	iocb->kiocb.ki_pos = hdr->args.offset;
+	iocb->hdr = hdr;
+	/* FIXME: NFS_IOHDR_ODIRECT isn't ever set */
+	if (test_bit(NFS_IOHDR_ODIRECT, &hdr->flags))
+		iocb->kiocb.ki_flags |= IOCB_DIRECT|IOCB_DSYNC;
+	iocb->kiocb.ki_flags &= ~IOCB_APPEND;
+	return iocb;
+}
+
+static void
+nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
+{
+	struct nfs_pgio_header *hdr = iocb->hdr;
+
+	if (hdr->args.pgbase != 0) {
+		iov_iter_bvec(i, dir, iocb->bvec,
+				hdr->page_array.npages,
+				hdr->args.count + hdr->args.pgbase);
+		iov_iter_advance(i, hdr->args.pgbase);
+	} else
+		iov_iter_bvec(i, dir, iocb->bvec,
+				hdr->page_array.npages, hdr->args.count);
+}
+
+static void
+nfs_local_hdr_release(struct nfs_pgio_header *hdr,
+		const struct rpc_call_ops *call_ops)
+{
+	call_ops->rpc_call_done(&hdr->task, hdr);
+	call_ops->rpc_release(hdr);
+}
+
+static void
+nfs_local_pgio_init(struct nfs_pgio_header *hdr,
+		const struct rpc_call_ops *call_ops)
+{
+	hdr->task.tk_ops = call_ops;
+	if (!hdr->task.tk_start)
+		hdr->task.tk_start = ktime_get();
+}
+
+static void
+nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
+{
+	if (status >= 0) {
+		hdr->res.count = status;
+		hdr->res.op_status = NFS4_OK;
+		hdr->task.tk_status = 0;
+	} else {
+		hdr->res.op_status = nfs4errno(status);
+		hdr->task.tk_status = status;
+	}
+}
+
+static void
+nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
+{
+	struct nfs_pgio_header *hdr = iocb->hdr;
+
+	fput(iocb->kiocb.ki_filp);
+	nfs_local_iocb_free(iocb);
+	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
+}
+
+static void
+nfs_local_read_aio_complete_work(struct work_struct *work)
+{
+	struct nfs_local_kiocb *iocb = container_of(work,
+			struct nfs_local_kiocb, work);
+
+	nfs_local_pgio_release(iocb);
+}
+
+/*
+ * Complete the I/O from iocb->kiocb.ki_complete()
+ *
+ * Note that this function can be called from a bottom half context,
+ * hence we need to queue the fput() etc to a workqueue
+ */
+static void
+nfs_local_pgio_complete(struct nfs_local_kiocb *iocb)
+{
+	queue_work(nfsiod_workqueue, &iocb->work);
+}
+
+static void
+nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
+{
+	struct nfs_pgio_header *hdr = iocb->hdr;
+	struct file *filp = iocb->kiocb.ki_filp;
+
+	nfs_local_pgio_done(hdr, status);
+
+	if (hdr->res.count != hdr->args.count ||
+	    hdr->args.offset + hdr->res.count >= i_size_read(file_inode(filp)))
+		hdr->res.eof = true;
+
+	dprintk("%s: read %ld bytes eof %d.\n", __func__,
+			status > 0 ? status : 0, hdr->res.eof);
+}
+
+static void
+nfs_local_read_aio_complete(struct kiocb *kiocb, long ret)
+{
+	struct nfs_local_kiocb *iocb = container_of(kiocb,
+			struct nfs_local_kiocb, kiocb);
+
+	nfs_local_read_done(iocb, ret);
+	nfs_local_pgio_complete(iocb);
+}
+
+static int
+nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
+		const struct rpc_call_ops *call_ops)
+{
+	struct nfs_local_kiocb *iocb;
+	struct iov_iter iter;
+	ssize_t status;
+
+	dprintk("%s: vfs_read count=%u pos=%llu\n",
+		__func__, hdr->args.count, hdr->args.offset);
+
+	iocb = nfs_local_iocb_alloc(hdr, filp, GFP_KERNEL);
+	if (iocb == NULL)
+		return -ENOMEM;
+	nfs_local_iter_init(&iter, iocb, READ);
+
+	nfs_local_pgio_init(hdr, call_ops);
+	hdr->res.eof = false;
+
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		INIT_WORK(&iocb->work, nfs_local_read_aio_complete_work);
+		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
+	}
+
+	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
+	if (status != -EIOCBQUEUED) {
+		nfs_local_read_done(iocb, status);
+		nfs_local_pgio_release(iocb);
+	}
+	return 0;
+}
+
+static void
+nfs_copy_boot_verifier(struct nfs_write_verifier *verifier, struct inode *inode)
+{
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
+	u32 *verf = (u32 *)verifier->data;
+	int seq = 0;
+
+	do {
+		read_seqbegin_or_lock(&clp->cl_boot_lock, &seq);
+		verf[0] = (u32)clp->cl_nfssvc_boot.tv_sec;
+		verf[1] = (u32)clp->cl_nfssvc_boot.tv_nsec;
+	} while (need_seqretry(&clp->cl_boot_lock, seq));
+	done_seqretry(&clp->cl_boot_lock, seq);
+}
+
+static void
+nfs_reset_boot_verifier(struct inode *inode)
+{
+	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
+
+	write_seqlock(&clp->cl_boot_lock);
+	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
+	write_sequnlock(&clp->cl_boot_lock);
+}
+
+static void
+nfs_set_local_verifier(struct inode *inode,
+		struct nfs_writeverf *verf,
+		enum nfs3_stable_how how)
+{
+
+	nfs_copy_boot_verifier(&verf->verifier, inode);
+	verf->committed = how;
+}
+
+static void
+nfs_get_vfs_attr(struct file *filp, struct nfs_fattr *fattr)
+{
+	struct kstat stat;
+
+	if (fattr != NULL && vfs_getattr(&filp->f_path, &stat,
+					 STATX_INO |
+					 STATX_ATIME |
+					 STATX_MTIME |
+					 STATX_CTIME |
+					 STATX_SIZE |
+					 STATX_BLOCKS,
+					 AT_STATX_SYNC_AS_STAT) == 0) {
+		fattr->valid = NFS_ATTR_FATTR_FILEID |
+			NFS_ATTR_FATTR_CHANGE |
+			NFS_ATTR_FATTR_SIZE |
+			NFS_ATTR_FATTR_ATIME |
+			NFS_ATTR_FATTR_MTIME |
+			NFS_ATTR_FATTR_CTIME |
+			NFS_ATTR_FATTR_SPACE_USED;
+		fattr->fileid = stat.ino;
+		fattr->size = stat.size;
+		fattr->atime = stat.atime;
+		fattr->mtime = stat.mtime;
+		fattr->ctime = stat.ctime;
+		fattr->change_attr = nfs_timespec_to_change_attr(&fattr->ctime);
+		fattr->du.nfs3.used = stat.blocks << 9;
+	}
+}
+
+static void
+nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
+{
+	struct nfs_pgio_header *hdr = iocb->hdr;
+
+	dprintk("%s: wrote %ld bytes.\n", __func__, status > 0 ? status : 0);
+
+	/* Handle short writes as if they are ENOSPC */
+	if (status > 0 && status < hdr->args.count) {
+		hdr->mds_offset += status;
+		hdr->args.offset += status;
+		hdr->args.pgbase += status;
+		hdr->args.count -= status;
+		nfs_set_pgio_error(hdr, -ENOSPC, hdr->args.offset);
+		status = -ENOSPC;
+	}
+	if (status < 0)
+		nfs_reset_boot_verifier(hdr->inode);
+	nfs_local_pgio_done(hdr, status);
+}
+
+static void
+nfs_local_write_aio_complete_work(struct work_struct *work)
+{
+	struct nfs_local_kiocb *iocb = container_of(work,
+			struct nfs_local_kiocb, work);
+
+	nfs_get_vfs_attr(iocb->kiocb.ki_filp, iocb->hdr->res.fattr);
+	nfs_local_pgio_release(iocb);
+}
+
+static void
+nfs_local_write_aio_complete(struct kiocb *kiocb, long ret)
+{
+	struct nfs_local_kiocb *iocb = container_of(kiocb,
+			struct nfs_local_kiocb, kiocb);
+
+	nfs_local_write_done(iocb, ret);
+	nfs_local_pgio_complete(iocb);
+}
+
+static int
+nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
+		const struct rpc_call_ops *call_ops)
+{
+	struct nfs_local_kiocb *iocb;
+	struct iov_iter iter;
+	ssize_t status;
+
+	dprintk("%s: vfs_write count=%u pos=%llu %s\n",
+		__func__, hdr->args.count, hdr->args.offset,
+		(hdr->args.stable == NFS_UNSTABLE) ?  "unstable" : "stable");
+
+	iocb = nfs_local_iocb_alloc(hdr, filp, GFP_NOIO);
+	if (iocb == NULL)
+		return -ENOMEM;
+	nfs_local_iter_init(&iter, iocb, WRITE);
+
+	switch (hdr->args.stable) {
+	default:
+		break;
+	case NFS_DATA_SYNC:
+		iocb->kiocb.ki_flags |= IOCB_DSYNC;
+		break;
+	case NFS_FILE_SYNC:
+		iocb->kiocb.ki_flags |= IOCB_DSYNC|IOCB_SYNC;
+	}
+	nfs_local_pgio_init(hdr, call_ops);
+
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		INIT_WORK(&iocb->work, nfs_local_write_aio_complete_work);
+		iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
+	}
+
+	nfs_set_local_verifier(hdr->inode, hdr->res.verf, hdr->args.stable);
+
+	file_start_write(filp);
+	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
+	file_end_write(filp);
+	if (status != -EIOCBQUEUED) {
+		nfs_local_write_done(iocb, status);
+		nfs_get_vfs_attr(filp, hdr->res.fattr);
+		nfs_local_pgio_release(iocb);
+	}
+	return 0;
+}
+
+static struct file *
+nfs_local_file_open_cached(struct nfs_client *clp, const struct cred *cred,
+			   struct nfs_fh *fh, struct nfs_open_context *ctx)
+{
+	struct file *filp = ctx->local_filp;
+
+	if (!filp) {
+		struct file *new = nfs_local_open_fh(clp, cred, fh, ctx->mode);
+		if (IS_ERR_OR_NULL(new))
+			return NULL;
+		/* try to put this one in the slot */
+		filp = cmpxchg(&ctx->local_filp, NULL, new);
+		if (filp != NULL)
+			fput(new);
+		else
+			filp = new;
+	}
+	return get_file(filp);
+}
+
+struct file *
+nfs_local_file_open(struct nfs_client *clp, const struct cred *cred,
+		    struct nfs_fh *fh, struct nfs_open_context *ctx)
+{
+	if (!nfs_server_is_local(clp))
+		return NULL;
+	return nfs_local_file_open_cached(clp, cred, fh, ctx);
+}
+
+int
+nfs_local_doio(struct nfs_client *clp, struct file *filp,
+	       struct nfs_pgio_header *hdr,
+	       const struct rpc_call_ops *call_ops)
+{
+	int status = 0;
+
+	if (!hdr->args.count)
+		goto out_fput;
+	/* Don't support filesystems without read_iter/write_iter */
+	if (!filp->f_op->read_iter || !filp->f_op->write_iter) {
+		nfs_local_disable(clp);
+		status = -EAGAIN;
+		goto out_fput;
+	}
+
+	switch (hdr->rw_mode) {
+	case FMODE_READ:
+		status = nfs_do_local_read(hdr, filp, call_ops);
+		break;
+	case FMODE_WRITE:
+		status = nfs_do_local_write(hdr, filp, call_ops);
+		break;
+	default:
+		dprintk("%s: invalid mode: %d\n", __func__,
+			hdr->rw_mode);
+		status = -EINVAL;
+	}
+out_fput:
+	if (status != 0) {
+		fput(filp);
+		hdr->task.tk_status = status;
+		nfs_local_hdr_release(hdr, call_ops);
+	}
+	return status;
+}
+
+static void
+nfs_local_init_commit(struct nfs_commit_data *data,
+		const struct rpc_call_ops *call_ops)
+{
+	data->task.tk_ops = call_ops;
+}
+
+static int
+nfs_local_run_commit(struct file *filp, struct nfs_commit_data *data)
+{
+	loff_t start = data->args.offset;
+	loff_t end = LLONG_MAX;
+
+	if (data->args.count > 0) {
+		end = start + data->args.count - 1;
+		if (end < start)
+			end = LLONG_MAX;
+	}
+
+	dprintk("%s: commit %llu - %llu\n", __func__, start, end);
+	return vfs_fsync_range(filp, start, end, 0);
+}
+
+static void
+nfs_local_commit_done(struct nfs_commit_data *data, int status)
+{
+	if (status >= 0) {
+		nfs_set_local_verifier(data->inode,
+				data->res.verf,
+				NFS_FILE_SYNC);
+		data->res.op_status = NFS4_OK;
+		data->task.tk_status = 0;
+	} else {
+		nfs_reset_boot_verifier(data->inode);
+		data->res.op_status = nfs4errno(status);
+		data->task.tk_status = status;
+	}
+}
+
+static void
+nfs_local_release_commit_data(struct file *filp,
+		struct nfs_commit_data *data,
+		const struct rpc_call_ops *call_ops)
+{
+	fput(filp);
+	call_ops->rpc_call_done(&data->task, data);
+	call_ops->rpc_release(data);
+}
+
+static struct nfs_local_fsync_ctx *
+nfs_local_fsync_ctx_alloc(struct nfs_commit_data *data, struct file *filp,
+		gfp_t flags)
+{
+	struct nfs_local_fsync_ctx *ctx = kmalloc(sizeof(*ctx), flags);
+
+	if (ctx != NULL) {
+		ctx->filp = filp;
+		ctx->data = data;
+		INIT_WORK(&ctx->work, nfs_local_fsync_work);
+		kref_init(&ctx->kref);
+	}
+	return ctx;
+}
+
+static void
+nfs_local_fsync_ctx_kref_free(struct kref *kref)
+{
+	kfree(container_of(kref, struct nfs_local_fsync_ctx, kref));
+}
+
+static void
+nfs_local_fsync_ctx_put(struct nfs_local_fsync_ctx *ctx)
+{
+	kref_put(&ctx->kref, nfs_local_fsync_ctx_kref_free);
+}
+
+static void
+nfs_local_fsync_ctx_free(struct nfs_local_fsync_ctx *ctx)
+{
+	nfs_local_release_commit_data(ctx->filp, ctx->data,
+			ctx->data->task.tk_ops);
+	nfs_local_fsync_ctx_put(ctx);
+}
+
+static void
+nfs_local_fsync_work(struct work_struct *work)
+{
+	struct nfs_local_fsync_ctx *ctx;
+	int status;
+
+	ctx = container_of(work, struct nfs_local_fsync_ctx, work);
+
+	status = nfs_local_run_commit(ctx->filp, ctx->data);
+	nfs_local_commit_done(ctx->data, status);
+	nfs_local_fsync_ctx_free(ctx);
+}
+
+int
+nfs_local_commit(struct nfs_client *clp, struct file *filp,
+		 struct nfs_commit_data *data,
+		 const struct rpc_call_ops *call_ops, int how)
+{
+	struct nfs_local_fsync_ctx *ctx;
+
+	ctx = nfs_local_fsync_ctx_alloc(data, filp, GFP_KERNEL);
+	if (!ctx) {
+		nfs_local_commit_done(data, -ENOMEM);
+		nfs_local_release_commit_data(filp, data, call_ops);
+		return -ENOMEM;
+	}
+
+	nfs_local_init_commit(data, call_ops);
+	kref_get(&ctx->kref);
+	queue_work(nfsiod_workqueue, &ctx->work);
+	if (how & FLUSH_SYNC)
+		flush_work(&ctx->work);
+	nfs_local_fsync_ctx_put(ctx);
+	return 0;
+}
+
+static int
+nfs_client_add_addr(struct nfs_client *clnt, char *buf, gfp_t flags)
+{
+	struct nfs_local_addr *addr;
+	struct sockaddr *sap;
+
+	dprintk("%s: adding new local IP %s\n", __func__, buf);
+	addr = kmalloc(sizeof(*addr), flags);
+	if (!addr) {
+		printk(KERN_WARNING "NFS: cannot alloc new addr\n");
+		return -ENOMEM;
+	}
+	sap = (struct sockaddr *)&addr->address;
+	addr->addrlen = rpc_pton(clnt->cl_net, buf, strlen(buf),
+				sap, sizeof(addr->address));
+	if (!addr->addrlen) {
+		printk(KERN_WARNING "NFS: cannot parse new addr %s\n",
+				buf);
+		kfree(addr);
+		return -EINVAL;
+	}
+	list_add(&addr->cl_addrs, &clnt->cl_local_addrs);
+
+	return 0;
+}
+
+static int
+nfs_client_add_v4_addr(struct nfs_client *clnt, struct in_device *indev,
+		       char *buf, size_t buflen)
+{
+	struct in_ifaddr *ifa;
+	int ret;
+
+	in_dev_for_each_ifa_rtnl(ifa, indev) {
+		snprintf(buf, buflen, "%pI4", &ifa->ifa_local);
+		ret = nfs_client_add_addr(clnt, buf, GFP_KERNEL);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_IPV6)
+static int
+nfs_client_add_v6_addr(struct nfs_client *clnt, struct inet6_dev *in6dev,
+		       char *buf, size_t buflen)
+{
+	struct inet6_ifaddr *ifp;
+	int ret = 0;
+
+	read_lock_bh(&in6dev->lock);
+	list_for_each_entry(ifp, &in6dev->addr_list, if_list) {
+		rpc_ntop6_addr_noscopeid(&ifp->addr, buf, buflen);
+		ret = nfs_client_add_addr(clnt, buf, GFP_ATOMIC);
+		if (ret < 0)
+			goto out;
+	}
+out:
+	read_unlock_bh(&in6dev->lock);
+	return ret;
+}
+#else /* CONFIG_IPV6 */
+static int
+nfs_client_add_v6_addr(struct nfs_client *clnt, struct inet6_dev *in6dev,
+		       char *buf, size_t buflen)
+{
+	return 0;
+}
+#endif
+
+/* Find out all local IP addresses. Ignore errors
+ * because local IO can be optional.
+ */
+void
+nfs_probe_local_addr(struct nfs_client *clnt)
+{
+	struct net_device *dev;
+	struct in_device *indev;
+	struct inet6_dev *in6dev;
+	char buf[INET6_ADDRSTRLEN + IPV6_SCOPE_ID_LEN];
+	size_t buflen = sizeof(buf);
+
+	rtnl_lock();
+
+	for_each_netdev(clnt->cl_net, dev) {
+		if (dev->type == ARPHRD_LOOPBACK ||
+		    !(dev->flags & IFF_UP))
+			continue;
+		indev = __in_dev_get_rtnl(dev);
+		if (indev &&
+		    nfs_client_add_v4_addr(clnt, indev, buf, buflen) < 0)
+			break;
+		in6dev = __in6_dev_get(dev);
+		if (in6dev &&
+		    nfs_client_add_v6_addr(clnt, in6dev, buf, buflen) < 0)
+			break;
+	}
+
+	rtnl_unlock();
+}
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 1e710654af11..45d4086cdeb1 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1681,6 +1681,35 @@ TRACE_EVENT(nfs_mount_path,
 	TP_printk("path='%s'", __get_str(path))
 );
 
+TRACE_EVENT(nfs_local_open_fh,
+		TP_PROTO(
+			const struct nfs_fh *fh,
+			fmode_t fmode,
+			int error
+		),
+
+		TP_ARGS(fh, fmode, error),
+
+		TP_STRUCT__entry(
+			__field(int, error)
+			__field(u32, fhandle)
+			__field(unsigned int, fmode)
+		),
+
+		TP_fast_assign(
+			__entry->error = error;
+			__entry->fhandle = nfs_fhandle_hash(fh);
+			__entry->fmode = (__force unsigned int)fmode;
+		),
+
+		TP_printk(
+			"error=%d fhandle=0x%08x mode=%s",
+			__entry->error,
+			__entry->fhandle,
+			show_fs_fmode_flags(__entry->fmode)
+		)
+);
+
 DECLARE_EVENT_CLASS(nfs_xdr_event,
 		TP_PROTO(
 			const struct xdr_stream *xdr,
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 3786d767e2ff..9210a1821ec9 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -848,7 +848,8 @@ int nfs_initiate_pgio(struct nfs_pageio_descriptor *desc,
 		      struct nfs_client *clp, struct rpc_clnt *rpc_clnt,
 		      struct nfs_pgio_header *hdr, const struct cred *cred,
 		      const struct nfs_rpc_ops *rpc_ops,
-		      const struct rpc_call_ops *call_ops, int how, int flags)
+		      const struct rpc_call_ops *call_ops, int how, int flags,
+		      struct file *localio)
 {
 	struct rpc_task *task;
 	struct rpc_message msg = {
@@ -878,10 +879,16 @@ int nfs_initiate_pgio(struct nfs_pageio_descriptor *desc,
 		hdr->args.count,
 		(unsigned long long)hdr->args.offset);
 
+	if (localio) {
+		nfs_local_doio(clp, localio, hdr, call_ops);
+		goto out;
+	}
+
 	task = rpc_run_task(&task_setup_data);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
 	rpc_put_task(task);
+out:
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nfs_initiate_pgio);
@@ -1080,7 +1087,8 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 					NFS_PROTO(hdr->inode),
 					desc->pg_rpc_callops,
 					desc->pg_ioflags,
-					RPC_TASK_CRED_NOREF | task_flags);
+					RPC_TASK_CRED_NOREF | task_flags,
+					NULL);
 	}
 	return ret;
 }
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index b29b50c2c933..ac3c5e6d4c5e 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -538,7 +538,7 @@ pnfs_generic_commit_pagelist(struct inode *inode, struct list_head *mds_pages,
 					    NFS_CLIENT(inode), data,
 					    NFS_PROTO(data->inode),
 					    data->mds_ops, how,
-					    RPC_TASK_CRED_NOREF);
+					    RPC_TASK_CRED_NOREF, NULL);
 		} else {
 			nfs_init_commit(data, NULL, data->lseg, cinfo);
 			initiate_commit(data, how);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index c9cfa1308264..ba0b36b15bc1 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1672,7 +1672,8 @@ int nfs_initiate_commit(struct nfs_client *clp,
 			struct nfs_commit_data *data,
 			const struct nfs_rpc_ops *nfs_ops,
 			const struct rpc_call_ops *call_ops,
-			int how, int flags)
+			int how, int flags,
+			struct file *localio)
 {
 	struct rpc_task *task;
 	int priority = flush_task_priority(how);
@@ -1691,6 +1692,7 @@ int nfs_initiate_commit(struct nfs_client *clp,
 		.flags = RPC_TASK_ASYNC | flags,
 		.priority = priority,
 	};
+	int status = 0;
 
 	if (nfs_server_capable(data->inode, NFS_CAP_MOVEABLE))
 		task_setup_data.flags |= RPC_TASK_MOVEABLE;
@@ -1701,13 +1703,19 @@ int nfs_initiate_commit(struct nfs_client *clp,
 
 	dprintk("NFS: initiated commit call\n");
 
+	if (localio) {
+		nfs_local_commit(clp, localio, data, call_ops, how);
+		goto out;
+	}
+
 	task = rpc_run_task(&task_setup_data);
 	if (IS_ERR(task))
 		return PTR_ERR(task);
 	if (how & FLUSH_SYNC)
 		rpc_wait_for_completion_task(task);
 	rpc_put_task(task);
-	return 0;
+out:
+	return status;
 }
 EXPORT_SYMBOL_GPL(nfs_initiate_commit);
 
@@ -1819,7 +1827,7 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 	return nfs_initiate_commit(NFS_SERVER(inode)->nfs_client,
 				   NFS_CLIENT(inode), data, NFS_PROTO(inode),
 				   data->mds_ops, how,
-				   RPC_TASK_CRED_NOREF | task_flags);
+				   RPC_TASK_CRED_NOREF | task_flags, NULL);
 }
 
 /*
diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index b8736a82e57c..702f277394f1 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -13,7 +13,7 @@ nfsd-y			+= trace.o
 nfsd-y 			+= nfssvc.o nfsctl.o nfsfh.o vfs.o \
 			   export.o auth.o lockd.o nfscache.o \
 			   stats.o filecache.o nfs3proc.o nfs3xdr.o \
-			   netlink.o
+			   netlink.o localio.o
 nfsd-$(CONFIG_NFSD_V2) += nfsproc.o nfsxdr.o
 nfsd-$(CONFIG_NFSD_V2_ACL) += nfs2acl.o
 nfsd-$(CONFIG_NFSD_V3_ACL) += nfs3acl.o
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ad9083ca144b..99631fa56662 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -52,7 +52,7 @@
 #define NFSD_FILE_CACHE_UP		     (0)
 
 /* We only care about NFSD_MAY_READ/WRITE for this cache */
-#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
+#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
 
 static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
 static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
new file mode 100644
index 000000000000..ff68454a4017
--- /dev/null
+++ b/fs/nfsd/localio.c
@@ -0,0 +1,179 @@
+/*
+ * NFS server support for local clients to bypass network stack
+ *
+ * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
+ */
+
+#include <linux/exportfs.h>
+#include <linux/sunrpc/svcauth_gss.h>
+#include <linux/sunrpc/clnt.h>
+#include <linux/nfs.h>
+#include <linux/string.h>
+
+#include "nfsd.h"
+#include "vfs.h"
+#include "netns.h"
+#include "filecache.h"
+
+#define NFSDDBG_FACILITY		NFSDDBG_FH
+
+static void
+nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
+{
+	if (rqstp->rq_client)
+		auth_domain_put(rqstp->rq_client);
+	if (rqstp->rq_cred.cr_group_info)
+		put_group_info(rqstp->rq_cred.cr_group_info);
+	kfree(rqstp->rq_cred.cr_principal);
+	kfree(rqstp->rq_xprt);
+	kfree(rqstp);
+}
+
+static struct svc_rqst *
+nfsd_local_fakerqst_create(struct rpc_clnt *rpc_clnt, const struct cred *cred)
+{
+	struct svc_rqst *rqstp;
+	struct net *net = rpc_net_ns(rpc_clnt);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	int status;
+
+	if (!nn->nfsd_serv) {
+		dprintk("%s: localio denied. Server not running\n", __func__);
+		return ERR_PTR(-ENXIO);
+	}
+
+	rqstp = kzalloc(sizeof(*rqstp), GFP_KERNEL);
+	if (!rqstp)
+		return ERR_PTR(-ENOMEM);
+
+	rqstp->rq_xprt = kzalloc(sizeof(*rqstp->rq_xprt), GFP_KERNEL);
+	if (!rqstp->rq_xprt) {
+		status = -ENOMEM;
+		goto out_err;
+	}
+
+	rqstp->rq_xprt->xpt_net = net;
+	__set_bit(RQ_SECURE, &rqstp->rq_flags);
+	rqstp->rq_proc = 1;
+	rqstp->rq_vers = 3;
+	rqstp->rq_prot = IPPROTO_TCP;
+	rqstp->rq_server = nn->nfsd_serv;
+
+	/* Note: we're connecting to ourself, so source addr == peer addr */
+	rqstp->rq_addrlen = rpc_peeraddr(rpc_clnt,
+			(struct sockaddr *)&rqstp->rq_addr,
+			sizeof(rqstp->rq_addr));
+
+	if (!rpcauth_map_to_svc_cred(rpc_clnt->cl_auth, cred,
+				     &rqstp->rq_cred)) {
+		dprintk("%s :map cred failed\n", __func__);
+		status = -EINVAL;
+		goto out_err;
+	}
+
+	/*
+	 * set up enough for svcauth_unix_set_client to be able to wait
+	 * for the cache downcall. Note that we do _not_ want to allow the
+	 * request to be deferred for later revisit since this rqst and xprt
+	 * are not set up to run inside of the normal svc_rqst engine.
+	 */
+	INIT_LIST_HEAD(&rqstp->rq_xprt->xpt_deferred);
+	kref_init(&rqstp->rq_xprt->xpt_ref);
+	spin_lock_init(&rqstp->rq_xprt->xpt_lock);
+	rqstp->rq_chandle.thread_wait = 5 * HZ;
+
+	status = svcauth_unix_set_client(rqstp);
+	switch (status) {
+	case SVC_OK:
+		break;
+	case SVC_DENIED:
+		status = -ENXIO;
+		dprintk("%s: client %pISpc denied localio access\n",
+				__func__, (struct sockaddr *)&rqstp->rq_addr);
+		goto out_err;
+	default:
+		status = -ETIMEDOUT;
+		dprintk("%s: client %pISpc temporarily denied localio access\n",
+				__func__, (struct sockaddr *)&rqstp->rq_addr);
+		goto out_err;
+	}
+
+	return rqstp;
+
+out_err:
+	nfsd_local_fakerqst_destroy(rqstp);
+	return ERR_PTR(status);
+}
+
+/*
+ * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to @file
+ *
+ * This function maps a local fh to a path on a local filesystem.
+ * This is useful when the nfs client has the local server mounted - it can
+ * avoid all the NFS overhead with reads, writes and commits.
+ *
+ * on successful return, caller is responsible for calling path_put. Also
+ * note that this is called from nfs.ko via find_symbol() to avoid an explicit
+ * dependency on knfsd. So, there is no forward declaration in a header file
+ * for it.
+ */
+int nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
+			 const struct cred *cred,
+			 const struct nfs_fh *nfs_fh,
+			 const fmode_t fmode,
+			 struct file **pfilp)
+{
+	const struct cred *save_cred;
+	struct svc_rqst *rqstp;
+	struct svc_fh fh;
+	struct nfsd_file *nf;
+	int status = 0;
+	int mayflags = NFSD_MAY_LOCALIO;
+	__be32 beres;
+
+	/* Save creds before calling into nfsd */
+	save_cred = get_current_cred();
+
+	rqstp = nfsd_local_fakerqst_create(rpc_clnt, cred);
+	if (IS_ERR(rqstp)) {
+		status = PTR_ERR(rqstp);
+		goto out_revertcred;
+	}
+
+	/* nfs_fh -> svc_fh */
+	if (nfs_fh->size > NFS4_FHSIZE) {
+		status = -EINVAL;
+		goto out;
+	}
+	fh_init(&fh, NFS4_FHSIZE);
+	fh.fh_handle.fh_size = nfs_fh->size;
+	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
+
+	if (fmode & FMODE_READ)
+		mayflags |= NFSD_MAY_READ;
+	if (fmode & FMODE_WRITE)
+		mayflags |= NFSD_MAY_WRITE;
+
+	beres = nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
+	if (beres) {
+		status = nfs_stat_to_errno(be32_to_cpu(beres));
+		dprintk("%s: fh_verify failed %d\n", __func__, status);
+		goto out_fh_put;
+	}
+
+	*pfilp = get_file(nf->nf_file);
+
+	nfsd_file_put(nf);
+out_fh_put:
+	fh_put(&fh);
+
+out:
+	nfsd_local_fakerqst_destroy(rqstp);
+out_revertcred:
+	revert_creds(save_cred);
+	return status;
+}
+EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
+
+/* Compile time type checking, not used by anything */
+static nfs_to_nfsd_open_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 77bbd23aa150..9c0610fdd11c 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -86,7 +86,8 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
 		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
 		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
 		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
-		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
+		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
+		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
 
 TRACE_EVENT(nfsd_compound,
 	TP_PROTO(
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 57cd70062048..91c50649a8c7 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -36,6 +36,8 @@
 #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
 #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
 
+#define NFSD_MAY_LOCALIO		0x800000
+
 struct nfsd_file;
 
 /*
@@ -158,6 +160,12 @@ __be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
 
 void		nfsd_filp_close(struct file *fp);
 
+int		nfsd_open_local_fh(struct rpc_clnt *rpc_clnt,
+				   const struct cred *cred,
+				   const struct nfs_fh *nfs_fh,
+				   const fmode_t fmode,
+				   struct file **pfilp);
+
 static inline int fh_want_write(struct svc_fh *fh)
 {
 	int ret;
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index b94f51d17bc5..80843764fad3 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -8,6 +8,8 @@
 #ifndef _LINUX_NFS_H
 #define _LINUX_NFS_H
 
+#include <linux/cred.h>
+#include <linux/sunrpc/auth.h>
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/string.h>
 #include <linux/errno.h>
@@ -109,6 +111,10 @@ static inline int nfs_stat_to_errno(enum nfs_stat status)
 	return nfs_common_errtbl[i].errno;
 }
 
+typedef int (*nfs_to_nfsd_open_t)(struct rpc_clnt *, const struct cred *,
+				  const struct nfs_fh *, const fmode_t,
+				  struct file **);
+
 #ifdef CONFIG_CRC32
 /**
  * nfs_fhandle_hash - calculate the crc32 hash for the filehandle
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 039898d70954..a0bb947fdd1d 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -96,6 +96,8 @@ struct nfs_open_context {
 	struct list_head list;
 	struct nfs4_threshold	*mdsthreshold;
 	struct rcu_head	rcu_head;
+
+	struct file *local_filp;
 };
 
 struct nfs_open_dir_context {
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 82a6f66fe1d0..6b603b0247f1 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -49,12 +49,14 @@ struct nfs_client {
 #define NFS_CS_DS		7		/* - Server is a DS */
 #define NFS_CS_REUSEPORT	8		/* - reuse src port on reconnect */
 #define NFS_CS_PNFS		9		/* - Server used for pnfs */
+#define NFS_CS_LOCAL_IO		10		/* - client is local */
 	struct sockaddr_storage	cl_addr;	/* server identifier */
 	size_t			cl_addrlen;
 	char *			cl_hostname;	/* hostname of server */
 	char *			cl_acceptor;	/* GSSAPI acceptor name */
 	struct list_head	cl_share_link;	/* link in global client list */
 	struct list_head	cl_superblocks;	/* List of nfs_server structs */
+	struct list_head	cl_local_addrs;	/* List of local addresses */
 
 	struct rpc_clnt *	cl_rpcclient;
 	const struct nfs_rpc_ops *rpc_ops;	/* NFS protocol vector */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index d09b9773b20c..764513a61601 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1605,6 +1605,7 @@ enum {
 	NFS_IOHDR_RESEND_PNFS,
 	NFS_IOHDR_RESEND_MDS,
 	NFS_IOHDR_UNSTABLE_WRITES,
+	NFS_IOHDR_ODIRECT,
 };
 
 struct nfs_io_completion;
-- 
2.44.0


