Return-Path: <linux-nfs+bounces-4424-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F8591D2BB
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 18:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FDA1C209D6
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 16:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779321552E0;
	Sun, 30 Jun 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh7TUHYW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543282576F
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719765474; cv=none; b=Ywm+E3gjHO6WHv4ljNPvsHiktUEJdCgLJYxV4Za3XZJpczGvKSh3mn0CTEy1kckyT6aYxvPf2icWVnQWSq8crcAG5cqEjD1PZQVAlVJkvKpQ6Qsf4+xWHcU8yekByIehrdE/7lEcmS0hFJ0MPTWHIdFH2H2Cr8FogyzGusFdIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719765474; c=relaxed/simple;
	bh=eG0ryC1KpjtUzvjQzhMFgNrYRQJh8bVfCk0ey5Jh58w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/Mf6OkegDvAaTAMhNdS+qZ0fHGBrZogLrmSCwhXN0sUK30Zu9chSG9+GST77TXsPLIYDg60KaLNAv6ke0JSaNLGQP9pBx/IzIvMRdpZ9d5g1pd/PKe/txHMvvEasPXT7ubgKosWW2pLM6cNEq7IMvtXfHFPd5pP8zDZFUNgirw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh7TUHYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C13C2BD10;
	Sun, 30 Jun 2024 16:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719765473;
	bh=eG0ryC1KpjtUzvjQzhMFgNrYRQJh8bVfCk0ey5Jh58w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vh7TUHYWFRgHuThdDDQCiv52wyPFVNJAZqjguLXBa6HG/j7m51jy7TDFCAZhFnnNr
	 JCRP8yplj3+kicRmiAsVUyxWFStS/Egf/0axKi5lFSCd4YXzWliUzPfekzFcCaPtD9
	 NUQgwgCIMcTIoxDuuSXVNd5cjdJBnEGJaR8h2cxqmWfwd8KV9JJBnlGr4U6p8Zxrcs
	 m2CEUtNGp5VbJC6688M82R2JpficD/oC/ypu4FH/+8Yj9npbfPgXcLBsEC0sdCMlhi
	 uj2qO1EvU1bSxQhv748hFxDGNMVjcHeYZkkUrkLdKH89Ko160u48VgW6PNacLLDGLE
	 7rp0qKTsyK5kA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v10 08/19] nfsd: implement server support for NFS_LOCALIO_PROGRAM
Date: Sun, 30 Jun 2024 12:37:30 -0400
Message-ID: <20240630163741.48753-9-snitzer@kernel.org>
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

LOCALIOPROC_GETUUID encodes the server's uuid_t in terms of the fixed
UUID_SIZE (16). The fixed size opaque encode and decode XDR methods
are used instead of the less efficient variable sized methods.

Aside from a bit of code in nfssvc.c, all the knowledge of the LOCALIO
RPC protocol is in fs/nfsd/localio.c which implements just a single
version (1) that is used independently of what NFS version is used.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
[neilb: factored out and simplified single localio protocol]
Co-developed-by: NeilBrown <neil@brown.name>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/localio.c   | 74 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfssvc.c    | 29 +++++++++++++++++-
 include/linux/nfs.h |  7 +++++
 3 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 2e609ada7e19..1d6508aa931e 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -11,12 +11,15 @@
 #include <linux/sunrpc/svcauth_gss.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/nfs.h>
+#include <linux/nfs_fs.h>
+#include <linux/nfs_xdr.h>
 #include <linux/string.h>
 
 #include "nfsd.h"
 #include "vfs.h"
 #include "netns.h"
 #include "filecache.h"
+#include "cache.h"
 
 /*
  * We need to translate between nfs status return values and
@@ -253,3 +256,74 @@ EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
 
 /* Compile time type checking, not used by anything */
 static nfs_to_nfsd_open_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
+
+/*
+ * GETUUID XDR encode functions
+ */
+
+static __be32 localio_proc_null(struct svc_rqst *rqstp)
+{
+	return rpc_success;
+}
+
+struct localio_getuuidres {
+	uuid_t			uuid;
+};
+
+static __be32 localio_proc_getuuid(struct svc_rqst *rqstp)
+{
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct localio_getuuidres *resp = rqstp->rq_resp;
+
+	uuid_copy(&resp->uuid, &nn->nfsd_uuid.uuid);
+
+	return rpc_success;
+}
+
+static bool localio_encode_getuuidres(struct svc_rqst *rqstp,
+				      struct xdr_stream *xdr)
+{
+	struct localio_getuuidres *resp = rqstp->rq_resp;
+	u8 uuid[UUID_SIZE];
+
+	export_uuid(uuid, &resp->uuid);
+	encode_opaque_fixed(xdr, uuid, UUID_SIZE);
+
+	return true;
+}
+
+static const struct svc_procedure localio_procedures1[] = {
+	[LOCALIOPROC_NULL] = {
+		.pc_func = localio_proc_null,
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = 0,
+		.pc_name = "NULL",
+	},
+	[LOCALIOPROC_GETUUID] = {
+		.pc_func = localio_proc_getuuid,
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = localio_encode_getuuidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct localio_getuuidres),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = XDR_QUADLEN(UUID_SIZE),
+		.pc_name = "GETUUID",
+	},
+};
+
+#define LOCALIO_NR_PROCEDURES ARRAY_SIZE(localio_procedures1)
+static DEFINE_PER_CPU_ALIGNED(unsigned long,
+			      localio_count[LOCALIO_NR_PROCEDURES]);
+const struct svc_version localio_version1 = {
+	.vs_vers	= 1,
+	.vs_nproc	= LOCALIO_NR_PROCEDURES,
+	.vs_proc	= localio_procedures1,
+	.vs_dispatch	= nfsd_dispatch,
+	.vs_count	= localio_count,
+	.vs_xdrsize	= XDR_QUADLEN(UUID_SIZE),
+	.vs_hidden	= true,
+};
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 90922c0586d5..3e528d242966 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -81,6 +81,26 @@ DEFINE_SPINLOCK(nfsd_drc_lock);
 unsigned long	nfsd_drc_max_mem;
 unsigned long	nfsd_drc_mem_used;
 
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+extern const struct svc_version localio_version1;
+static const struct svc_version *localio_versions[] = {
+	[1] = &localio_version1,
+};
+
+#define NFSD_LOCALIO_NRVERS		ARRAY_SIZE(localio_versions)
+
+static struct svc_program	nfsd_localio_program = {
+	.pg_prog		= NFS_LOCALIO_PROGRAM,
+	.pg_nvers		= NFSD_LOCALIO_NRVERS,
+	.pg_vers		= localio_versions,
+	.pg_name		= "nfslocalio",
+	.pg_class		= "nfsd",
+	.pg_authenticate	= &svc_set_client,
+	.pg_init_request	= svc_generic_init_request,
+	.pg_rpcbind_set		= svc_generic_rpcbind_set,
+};
+#endif /* CONFIG_NFSD_LOCALIO */
+
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static const struct svc_version *nfsd_acl_version[] = {
 # if defined(CONFIG_NFSD_V2_ACL)
@@ -95,6 +115,9 @@ static const struct svc_version *nfsd_acl_version[] = {
 #define NFSD_ACL_NRVERS		ARRAY_SIZE(nfsd_acl_version)
 
 static struct svc_program	nfsd_acl_program = {
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+	.pg_next		= &nfsd_localio_program,
+#endif /* CONFIG_NFSD_LOCALIO */
 	.pg_prog		= NFS_ACL_PROGRAM,
 	.pg_nvers		= NFSD_ACL_NRVERS,
 	.pg_vers		= nfsd_acl_version,
@@ -123,6 +146,10 @@ static const struct svc_version *nfsd_version[] = {
 struct svc_program		nfsd_program = {
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 	.pg_next		= &nfsd_acl_program,
+#else
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+	.pg_next		= &nfsd_localio_program,
+#endif /* CONFIG_NFSD_LOCALIO */
 #endif
 	.pg_prog		= NFS_PROGRAM,		/* program number */
 	.pg_nvers		= NFSD_NRVERS,		/* nr of entries in nfsd_version */
@@ -1020,7 +1047,7 @@ nfsd(void *vrqstp)
 }
 
 /**
- * nfsd_dispatch - Process an NFS or NFSACL Request
+ * nfsd_dispatch - Process an NFS or NFSACL or LOCALIO Request
  * @rqstp: incoming request
  *
  * This RPC dispatcher integrates the NFS server's duplicate reply cache.
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index ceb70a926b95..b1e00349f3ed 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -13,6 +13,13 @@
 #include <linux/crc32.h>
 #include <uapi/linux/nfs.h>
 
+/* The localio program is entirely private to Linux and is
+ * NOT part of the uapi.
+ */
+#define NFS_LOCALIO_PROGRAM	400122
+#define LOCALIOPROC_NULL	0
+#define LOCALIOPROC_GETUUID	1
+
 /*
  * This is the kernel NFS client file handle representation
  */
-- 
2.44.0


