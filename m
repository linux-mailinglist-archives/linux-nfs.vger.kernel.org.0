Return-Path: <linux-nfs+bounces-4396-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4367191C7E0
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 23:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC066287231
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 21:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA2B7FBC8;
	Fri, 28 Jun 2024 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXHKcohK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D737FBBF
	for <linux-nfs@vger.kernel.org>; Fri, 28 Jun 2024 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609086; cv=none; b=qcBa0YFm0P1iamKGBE2GK1HKeEVXX+LcC4OinZOhT4m3CY1iGg6Pab52dlql0xxNWOhqd7Z71/PzU7HKcu3lgOg580JQuPwj+xt09TELVNAMh6Ddoqo3eYcOEPosqFvfI/eBbsbMiIa3cYxrwECshyEcSkq8iGzvgewNPBWTWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609086; c=relaxed/simple;
	bh=jJSAG7ZExihBWUgvIjI2HnptniJEKt0lY57PMhLdXgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCivJSyH1BOCqRQP0l/Z11BwqAdmoj6xwglpktr+CYGcgenlKSZhJD2oSNwuQ+tv1xeHNbO0eGQrNwEhbhXsQ4Z0pG938Xq9aM567rXFZmwNf47Y0mVleXy5sgH57JmBPvBQPvgnOdmeGALNxuqge94bh5Q3yJWHY2YHRBxypR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXHKcohK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56990C116B1;
	Fri, 28 Jun 2024 21:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719609085;
	bh=jJSAG7ZExihBWUgvIjI2HnptniJEKt0lY57PMhLdXgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXHKcohKijQDmvLOtAwFp3Vx88i6/hi29VCUrX2QeLVXpVnaObKBGFLtdx6peL1/0
	 wL3AX4tKb7ILBgHOMrJz4qmmVd8AhK034mEJyrNbBirbDHk1xX1Y53QVnQUZP7hyBT
	 cLT8nJ+4RzjbpiWt+ispctSqQfRLt7I1G+BrFIYk9NDlAj7V4rRptnif7HL1LCHXBr
	 0ACmUkKurTooR5Vp01AceoN4Hguw2ccY5Ulr1SVNT3ew+D4MC3gVlYDOsvWzCcUOBm
	 VqZFkdx0pvm7/n/u28OXsY8r+xPqa9Wz1Urrxfu9DEhcsF+hUer6UtwqNhZ6YUZ1GQ
	 Zsv8QO7ikllqQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v9 13/19] nfsd: add "localio" support
Date: Fri, 28 Jun 2024 17:10:59 -0400
Message-ID: <20240628211105.54736-14-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240628211105.54736-1-snitzer@kernel.org>
References: <20240628211105.54736-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the stored cl_nfssvc_net from the client to the server as
first argument to nfsd_open_local_fh() to ensure the proper network
namespace is used for localio.

Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Peng Tao <tao.peng@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/Makefile    |   1 +
 fs/nfsd/filecache.c |   2 +-
 fs/nfsd/localio.c   | 239 ++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfssvc.c    |   1 +
 fs/nfsd/trace.h     |   3 +-
 fs/nfsd/vfs.h       |   9 ++
 6 files changed, 253 insertions(+), 2 deletions(-)
 create mode 100644 fs/nfsd/localio.c

diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index b8736a82e57c..78b421778a79 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
 nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
 nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
+nfsd-$(CONFIG_NFSD_LOCALIO) += localio.o
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
index 000000000000..759a5cb79652
--- /dev/null
+++ b/fs/nfsd/localio.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NFS server support for local clients to bypass network stack
+ *
+ * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
+ * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
+ * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
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
+/*
+ * We need to translate between nfs status return values and
+ * the local errno values which may not be the same.
+ * - duplicated from fs/nfs/nfs2xdr.c to avoid needless bloat of
+ *   all compiled nfs objects if it were in include/linux/nfs.h
+ */
+static const struct {
+	int stat;
+	int errno;
+} nfs_common_errtbl[] = {
+	{ NFS_OK,		0		},
+	{ NFSERR_PERM,		-EPERM		},
+	{ NFSERR_NOENT,		-ENOENT		},
+	{ NFSERR_IO,		-EIO		},
+	{ NFSERR_NXIO,		-ENXIO		},
+/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
+	{ NFSERR_ACCES,		-EACCES		},
+	{ NFSERR_EXIST,		-EEXIST		},
+	{ NFSERR_XDEV,		-EXDEV		},
+	{ NFSERR_NODEV,		-ENODEV		},
+	{ NFSERR_NOTDIR,	-ENOTDIR	},
+	{ NFSERR_ISDIR,		-EISDIR		},
+	{ NFSERR_INVAL,		-EINVAL		},
+	{ NFSERR_FBIG,		-EFBIG		},
+	{ NFSERR_NOSPC,		-ENOSPC		},
+	{ NFSERR_ROFS,		-EROFS		},
+	{ NFSERR_MLINK,		-EMLINK		},
+	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
+	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
+	{ NFSERR_DQUOT,		-EDQUOT		},
+	{ NFSERR_STALE,		-ESTALE		},
+	{ NFSERR_REMOTE,	-EREMOTE	},
+#ifdef EWFLUSH
+	{ NFSERR_WFLUSH,	-EWFLUSH	},
+#endif
+	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
+	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
+	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
+	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
+	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
+	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
+	{ NFSERR_BADTYPE,	-EBADTYPE	},
+	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
+	{ -1,			-EIO		}
+};
+
+/**
+ * nfs_stat_to_errno - convert an NFS status code to a local errno
+ * @status: NFS status code to convert
+ *
+ * Returns a local errno value, or -EIO if the NFS status code is
+ * not recognized.  nfsd_file_acquire() returns an nfsstat that
+ * needs to be translated to an errno before being returned to a
+ * local client application.
+ */
+static int nfs_stat_to_errno(enum nfs_stat status)
+{
+	int i;
+
+	for (i = 0; nfs_common_errtbl[i].stat != -1; i++) {
+		if (nfs_common_errtbl[i].stat == (int)status)
+			return nfs_common_errtbl[i].errno;
+	}
+	return nfs_common_errtbl[i].errno;
+}
+
+static void
+nfsd_local_fakerqst_destroy(struct svc_rqst *rqstp)
+{
+	if (rqstp->rq_client)
+		auth_domain_put(rqstp->rq_client);
+	if (rqstp->rq_cred.cr_group_info)
+		put_group_info(rqstp->rq_cred.cr_group_info);
+	/* rpcauth_map_to_svc_cred_local() clears cr_principal */
+	WARN_ON_ONCE(rqstp->rq_cred.cr_principal != NULL);
+	kfree(rqstp->rq_xprt);
+	kfree(rqstp);
+}
+
+static struct svc_rqst *
+nfsd_local_fakerqst_create(struct net *net, struct rpc_clnt *rpc_clnt,
+			const struct cred *cred)
+{
+	struct svc_rqst *rqstp;
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	int status;
+
+	/* FIXME: not running in nfsd context, must get reference on nfsd_serv */
+	if (unlikely(!READ_ONCE(nn->nfsd_serv)))
+		return ERR_PTR(-ENXIO);
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
+	rpcauth_map_to_svc_cred_local(rpc_clnt->cl_auth, cred, &rqstp->rq_cred);
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
+		goto out_err;
+	default:
+		status = -ETIMEDOUT;
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
+int nfsd_open_local_fh(struct net *net,
+			 struct rpc_clnt *rpc_clnt,
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
+	rqstp = nfsd_local_fakerqst_create(net, rpc_clnt, cred);
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
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 1222a0a33fe1..a477d2c5088a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -431,6 +431,7 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 #endif
 #if IS_ENABLED(CONFIG_NFSD_LOCALIO)
 	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
+	nn->nfsd_uuid.net = net;
 	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
 #endif
 	nn->nfsd_net_up = true;
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
index 57cd70062048..5146f0c81752 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -33,6 +33,8 @@
 
 #define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for >= NFSv3 */
 
+#define NFSD_MAY_LOCALIO		0x2000
+
 #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
 #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
 
@@ -158,6 +160,13 @@ __be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
 
 void		nfsd_filp_close(struct file *fp);
 
+int		nfsd_open_local_fh(struct net *net,
+				   struct rpc_clnt *rpc_clnt,
+				   const struct cred *cred,
+				   const struct nfs_fh *nfs_fh,
+				   const fmode_t fmode,
+				   struct file **pfilp);
+
 static inline int fh_want_write(struct svc_fh *fh)
 {
 	int ret;
-- 
2.44.0


