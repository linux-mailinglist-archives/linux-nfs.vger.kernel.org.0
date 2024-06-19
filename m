Return-Path: <linux-nfs+bounces-4101-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F04190F7A5
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 22:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EC8EB20F43
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 20:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1FA15A863;
	Wed, 19 Jun 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UboT0bc3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B830515A846
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829650; cv=none; b=d1L7TJKXWF7ywZfSY/ipWM1ghduT85Rg01j9CLsJKTXaFCpIBAb19bhVBOJ9Ej0TKOPT+fK2nWKb9/KvgYBjtfgirqRmvj9/LU1gM8Ch0jltYvISnlveJ7pptN72qZyeUegAGIWzXpuNZnp+S1goxptF8kfZ875MJSLbQFwVQLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829650; c=relaxed/simple;
	bh=jZSKY6lOQFXzk6qWtEEmIu4pAIl7B3mFEqLj9VSKbv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2GaIpVPlFWG9TPsb2WLVO8nnasKIWg9KnKisLQeMG1eQxXekoS1YimB+gWdGm38XlyOoP66wly3iE3pMDz9yH7LcBMve/xj1M/CsVne5S0SumxEIQBsrlcvH322BffiRYfteircg4XUu1UrVLDEJpFOxf5GtuT9H22WyjGSLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UboT0bc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178C6C4AF07;
	Wed, 19 Jun 2024 20:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718829650;
	bh=jZSKY6lOQFXzk6qWtEEmIu4pAIl7B3mFEqLj9VSKbv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UboT0bc3A+dPCi3Mnk94cdt/cs+n5nJzJqK70obhyjlyFtdL8ny/Oc41MbG43/u4l
	 DoJtREjUx5im3SugW7O972S9aR3Qjml/4f/fVJK3Xip3oRRG5rwgaJHKwH3XWF9OfB
	 11GzqHMZ1GMi3h7i1OAi97UIme4lZKrS2zKYY7npmoG2Wz+OaXty7Zesun1j+a9Gcw
	 Yy6bNCpsYLdIBDgtiAz78c/6epALsvgwksZ1Bp4OQg2REGtKn9H+JGdDstmX98F5f/
	 qEbhlmExRIR9qDOwOo/k5BrqezlaBKrTgC+1Giz8oLWv9ZlYF4HL/AQAGLWdtEMz9q
	 +iVLtHFutcaow==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v6 12/18] nfsd: implement v3 and v4 server support for NFS_LOCALIO_PROGRAM
Date: Wed, 19 Jun 2024 16:40:26 -0400
Message-ID: <20240619204032.93740-13-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240619204032.93740-1-snitzer@kernel.org>
References: <20240619204032.93740-1-snitzer@kernel.org>
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

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/localio.c | 148 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  11 ++++
 fs/nfsd/nfssvc.c  |  80 ++++++++++++++++++++++++-
 fs/nfsd/xdr.h     |   6 ++
 4 files changed, 244 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index f6df66b1d523..46b66e43b81b 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -17,6 +17,9 @@
 #include "vfs.h"
 #include "netns.h"
 #include "filecache.h"
+#include "cache.h"
+#include "xdr3.h"
+#include "xdr4.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_FH
 
@@ -249,3 +252,148 @@ EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
 
 /* Compile time type checking, not used by anything */
 static nfs_to_nfsd_open_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
+
+/*
+ * GETUUID XDR encode functions
+ */
+
+static __be32 nfsd_proc_null(struct svc_rqst *rqstp)
+{
+	return rpc_success;
+}
+
+static __be32 nfsd_proc_getuuid(struct svc_rqst *rqstp)
+{
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct nfsd_getuuidres *resp = rqstp->rq_resp;
+
+	uuid_copy(&resp->uuid, &nn->nfsd_uuid.uuid);
+	resp->status = nfs_ok;
+
+	return rpc_success;
+}
+
+#define NFS_getuuid_sz XDR_QUADLEN(UUID_SIZE)
+
+static inline void encode_opaque_fixed(struct xdr_stream *xdr, const void *buf, size_t len)
+{
+	WARN_ON_ONCE(xdr_stream_encode_opaque_fixed(xdr, buf, len) < 0);
+}
+
+static void encode_uuid(struct xdr_stream *xdr, uuid_t *src_uuid)
+{
+	u8 uuid[UUID_SIZE];
+
+	export_uuid(uuid, src_uuid);
+	encode_opaque_fixed(xdr, uuid, UUID_SIZE);
+	dprintk("%s: uuid=%pU\n", __func__, uuid);
+}
+
+#if defined(CONFIG_NFSD_V3_LOCALIO)
+static bool nfs3svc_encode_getuuidres(struct svc_rqst *rqstp,
+				      struct xdr_stream *xdr)
+{
+	struct nfsd_getuuidres *resp = rqstp->rq_resp;
+
+	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
+		return false;
+	if (resp->status == nfs_ok)
+		encode_uuid(xdr, &resp->uuid);
+
+	return true;
+}
+
+#define ST 1		/* status */
+#define NFS3_filename_sz	(1+(NFS3_MAXNAMLEN>>2))
+
+static const struct svc_procedure nfsd_localio_procedures3[2] = {
+	[LOCALIOPROC_NULL] = {
+		.pc_func = nfsd_proc_null,
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = 1,
+		.pc_name = "NULL",
+	},
+	[LOCALIOPROC_GETUUID] = {
+		.pc_func = nfsd_proc_getuuid,
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfs3svc_encode_getuuidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_getuuidres),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = 1+NFS_getuuid_sz,
+		.pc_name = "GETUUID",
+	},
+};
+
+static DEFINE_PER_CPU_ALIGNED(unsigned long,
+			      nfsd_localio_count3[ARRAY_SIZE(nfsd_localio_procedures3)]);
+const struct svc_version nfsd_localio_version3 = {
+	.vs_vers	= 3,
+	.vs_nproc	= 2,
+	.vs_proc	= nfsd_localio_procedures3,
+	.vs_dispatch	= nfsd_dispatch,
+	.vs_count	= nfsd_localio_count3,
+	.vs_xdrsize	= NFS3_SVC_XDRSIZE,
+};
+#endif /* CONFIG_NFSD_V3_LOCALIO */
+
+#if defined(CONFIG_NFSD_V4_LOCALIO)
+static bool nfs4svc_encode_getuuidres(struct svc_rqst *rqstp,
+				      struct xdr_stream *xdr)
+{
+	struct nfsd_getuuidres *resp = rqstp->rq_resp;
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, 8);
+	if (!p)
+		return 0;
+	*p++ = cpu_to_be32(LOCALIOPROC_GETUUID);
+	*p++ = resp->status;
+
+	if (resp->status == nfs_ok)
+		encode_uuid(xdr, &resp->uuid);
+
+	return 1;
+}
+
+static const struct svc_procedure nfsd_localio_procedures4[2] = {
+	[LOCALIOPROC_NULL] = {
+		.pc_func = nfsd_proc_null,
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = 1,
+		.pc_name = "NULL",
+	},
+	[LOCALIOPROC_GETUUID] = {
+		.pc_func = nfsd_proc_getuuid,
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfs4svc_encode_getuuidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_getuuidres),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = 2+NFS_getuuid_sz,
+		.pc_name = "GETUUID",
+	},
+};
+
+static DEFINE_PER_CPU_ALIGNED(unsigned long,
+			      nfsd_localio_count4[ARRAY_SIZE(nfsd_localio_procedures4)]);
+const struct svc_version nfsd_localio_version4 = {
+	.vs_vers	        = 4,
+	.vs_nproc	        = 2,
+	.vs_proc	        = nfsd_localio_procedures4,
+	.vs_dispatch	        = nfsd_dispatch,
+	.vs_count	        = nfsd_localio_count4,
+	.vs_xdrsize	        = NFS4_SVC_XDRSIZE,
+	.vs_rpcb_optnl		= true,
+	.vs_need_cong_ctrl	= true,
+
+};
+#endif /* CONFIG_NFSD_V4_LOCALIO */
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index cec8697b1cd6..4f51f95df294 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -143,6 +143,17 @@ extern const struct svc_version nfsd_acl_version3;
 #endif
 #endif
 
+#if defined(CONFIG_NFSD_V3_LOCALIO)
+extern const struct svc_version nfsd_localio_version3;
+#else
+#define nfsd_localio_version3 NULL
+#endif
+#if defined(CONFIG_NFSD_V4_LOCALIO)
+extern const struct svc_version nfsd_localio_version4;
+#else
+#define nfsd_localio_version4 NULL
+#endif
+
 struct nfsd_net;
 
 enum vers_op {NFSD_SET, NFSD_CLEAR, NFSD_TEST, NFSD_AVAIL };
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index a477d2c5088a..48bfd3c6d619 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -38,6 +38,16 @@
 atomic_t			nfsd_th_cnt = ATOMIC_INIT(0);
 extern struct svc_program	nfsd_program;
 static int			nfsd(void *vrqstp);
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+static int			nfsd_localio_rpcbind_set(struct net *,
+						     const struct svc_program *,
+						     u32, int,
+						     unsigned short,
+						     unsigned short);
+static __be32			nfsd_localio_init_request(struct svc_rqst *,
+						const struct svc_program *,
+						struct svc_process_info *);
+#endif /* CONFIG_NFSD_LOCALIO */
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static int			nfsd_acl_rpcbind_set(struct net *,
 						     const struct svc_program *,
@@ -81,6 +91,31 @@ DEFINE_SPINLOCK(nfsd_drc_lock);
 unsigned long	nfsd_drc_max_mem;
 unsigned long	nfsd_drc_mem_used;
 
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+static const struct svc_version *nfsd_localio_version[] = {
+#if defined(CONFIG_NFSD_V3_LOCALIO)
+	[3] = &nfsd_localio_version3,
+#endif
+#if defined(CONFIG_NFSD_V4_LOCALIO)
+	[4] = &nfsd_localio_version4,
+#endif
+};
+
+#define NFSD_LOCALIO_MINVERS            3
+#define NFSD_LOCALIO_NRVERS		ARRAY_SIZE(nfsd_localio_version)
+
+static struct svc_program	nfsd_localio_program = {
+	.pg_prog		= NFS_LOCALIO_PROGRAM,
+	.pg_nvers		= NFSD_LOCALIO_NRVERS,
+	.pg_vers		= nfsd_localio_version,
+	.pg_name		= "nfslocalio",
+	.pg_class		= "nfsd",
+	.pg_authenticate	= &svc_set_client,
+	.pg_init_request	= nfsd_localio_init_request,
+	.pg_rpcbind_set		= nfsd_localio_rpcbind_set,
+};
+#endif /* CONFIG_NFSD_LOCALIO */
+
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static const struct svc_version *nfsd_acl_version[] = {
 # if defined(CONFIG_NFSD_V2_ACL)
@@ -95,6 +130,9 @@ static const struct svc_version *nfsd_acl_version[] = {
 #define NFSD_ACL_NRVERS		ARRAY_SIZE(nfsd_acl_version)
 
 static struct svc_program	nfsd_acl_program = {
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+	.pg_next		= &nfsd_localio_program,
+#endif /* CONFIG_NFSD_LOCALIO */
 	.pg_prog		= NFS_ACL_PROGRAM,
 	.pg_nvers		= NFSD_ACL_NRVERS,
 	.pg_vers		= nfsd_acl_version,
@@ -123,6 +161,10 @@ static const struct svc_version *nfsd_version[] = {
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
@@ -833,6 +875,42 @@ nfsd_svc(int n, int *nthreads, struct net *net, const struct cred *cred, const c
 	return error;
 }
 
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+static bool
+nfsd_support_localio_version(int vers)
+{
+	if (vers >= NFSD_LOCALIO_MINVERS && vers < NFSD_LOCALIO_NRVERS)
+		return nfsd_localio_version[vers] != NULL;
+	return false;
+}
+
+static int
+nfsd_localio_rpcbind_set(struct net *net, const struct svc_program *progp,
+			u32 version, int family, unsigned short proto,
+			unsigned short port)
+{
+	if (!nfsd_support_localio_version(version) ||
+	    !nfsd_vers(net_generic(net, nfsd_net_id), version, NFSD_TEST))
+		return 0;
+	return svc_generic_rpcbind_set(net, progp, version, family,
+			proto, port);
+}
+
+static __be32
+nfsd_localio_init_request(struct svc_rqst *rqstp,
+			const struct svc_program *progp,
+			struct svc_process_info *ret)
+{
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+
+	if (likely(nfsd_support_localio_version(rqstp->rq_vers) &&
+	    nfsd_vers(nn, rqstp->rq_vers, NFSD_TEST)))
+		return svc_generic_init_request(rqstp, progp, ret);
+
+	return rpc_prog_unavail;
+}
+#endif /* CONFIG_NFSD_LOCALIO */
+
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static bool
 nfsd_support_acl_version(int vers)
@@ -975,7 +1053,7 @@ nfsd(void *vrqstp)
 }
 
 /**
- * nfsd_dispatch - Process an NFS or NFSACL Request
+ * nfsd_dispatch - Process an NFS or NFSACL or NFSLOCALIO Request
  * @rqstp: incoming request
  *
  * This RPC dispatcher integrates the NFS server's duplicate reply cache.
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 852f71580bd0..5714469af597 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -5,6 +5,7 @@
 #define LINUX_NFSD_H
 
 #include <linux/vfs.h>
+#include <linux/uuid.h>
 #include "nfsd.h"
 #include "nfsfh.h"
 
@@ -123,6 +124,11 @@ struct nfsd_statfsres {
 	struct kstatfs		stats;
 };
 
+struct nfsd_getuuidres {
+	__be32			status;
+	uuid_t			uuid;
+};
+
 /*
  * Storage requirements for XDR arguments and results.
  */
-- 
2.44.0


