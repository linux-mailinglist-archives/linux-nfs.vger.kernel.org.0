Return-Path: <linux-nfs+bounces-4272-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF949153C4
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 18:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF3D1C23579
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 16:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30F319DF7E;
	Mon, 24 Jun 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIxcKj4C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6E119DF65
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246482; cv=none; b=dPKBaJw88ugn/YgBpQTT5d+KmqLTzGZavvvzHB8sNmNUqN7PNdpS858EN4dL87F1U5gXv1bCF1vOMSfJarAkdggtVyW6CJUPvf0yzws5wJQJOv+Hzci3NLdsCbOA7jm796L5xq/BW26KY4eQnSTYC6Da6GguMmxQWKjdt4e8nJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246482; c=relaxed/simple;
	bh=LBdPr3qI3GhGCc1FwuUoqShpegoUMior0a45hXCH32Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJIIuGJLVMM1I4AhJtr5dbUFTHdhN5xXtj1KNbG++3p2kNGALwpAv7KeUlv0vuAm6hImMFgEX1YmoY1Wt454AocfVVpv9s7T3CZzFG8nwrSylYXrLbLnoMQYb102l+NTjUffjBdvoQLJWN63xySWpidYgCxlbR9a4sTE3mcSeWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIxcKj4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E720C2BBFC;
	Mon, 24 Jun 2024 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719246482;
	bh=LBdPr3qI3GhGCc1FwuUoqShpegoUMior0a45hXCH32Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uIxcKj4CuXAI4t/faqPG4GzpgQGiql/fGK5VNvzGXmgg1PqVACMb4DzVqmxDgDqyJ
	 cHuUulyzKxoiJW4O0oMz5jZZzGNY0evHriMnO0bdVKo5RMOyVEKPUN8cpFDfGzScbs
	 se6CZzLXFIkRcSnrSYhPsN5jjKsArvPyWjJD0CHoHyuKUq0ow1lm1IZhVk52tzoqL6
	 KcBH26IfVtVl5mbtEh+3loC6cXQQWBzm3XzfyAgWTp1z1mHhqLJxNMbPzrKf1sx5gG
	 LcI2aA7k3oV4QRDOzUTHURRN6FzN1HxHRzq7q5egFCP/bYiZGuP/x7sF8d1oR5A2zw
	 AGJmm0/sObOFg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v7 14/20] nfsd: implement server support for NFS_LOCALIO_PROGRAM
Date: Mon, 24 Jun 2024 12:27:35 -0400
Message-ID: <20240624162741.68216-15-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240624162741.68216-1-snitzer@kernel.org>
References: <20240624162741.68216-1-snitzer@kernel.org>
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
Co-developed-by: NeilBrown <neilb@suse.de>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/localio.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfssvc.c  | 29 ++++++++++++++++++-
 2 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index f6df66b1d523..aaa5293eb352 100644
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
 
 #define NFSDDBG_FACILITY		NFSDDBG_FH
 
@@ -249,3 +252,74 @@ EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
 
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
+struct nfsd_getuuidres {
+	uuid_t			uuid;
+};
+
+static __be32 nfsd_proc_getuuid(struct svc_rqst *rqstp)
+{
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct nfsd_getuuidres *resp = rqstp->rq_resp;
+
+	uuid_copy(&resp->uuid, &nn->nfsd_uuid.uuid);
+
+	return rpc_success;
+}
+
+static bool nfslocalio_encode_getuuidres(struct svc_rqst *rqstp,
+					 struct xdr_stream *xdr)
+{
+	struct nfsd_getuuidres *resp = rqstp->rq_resp;
+	u8 uuid[UUID_SIZE];
+
+	export_uuid(uuid, &resp->uuid);
+	encode_opaque_fixed(xdr, uuid, UUID_SIZE);
+	dprintk("%s: uuid=%pU\n", __func__, uuid);
+
+	return true;
+}
+
+static const struct svc_procedure nfsd_localio_procedures[2] = {
+	[LOCALIOPROC_NULL] = {
+		.pc_func = nfsd_proc_null,
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = 0,
+		.pc_name = "NULL",
+	},
+	[LOCALIOPROC_GETUUID] = {
+		.pc_func = nfsd_proc_getuuid,
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfslocalio_encode_getuuidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_getuuidres),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = XDR_QUADLEN(UUID_SIZE),
+		.pc_name = "GETUUID",
+	},
+};
+
+static DEFINE_PER_CPU_ALIGNED(unsigned long,
+			      nfsd_localio_count[ARRAY_SIZE(nfsd_localio_procedures)]);
+const struct svc_version nfsd_localio_version1 = {
+	.vs_vers	= 1,
+	.vs_nproc	= 2,
+	.vs_proc	= nfsd_localio_procedures,
+	.vs_dispatch	= nfsd_dispatch,
+	.vs_count	= nfsd_localio_count,
+	.vs_xdrsize	= XDR_QUADLEN(UUID_SIZE),
+	.vs_hidden	= true,
+};
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index a477d2c5088a..bc69a2c90077 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -81,6 +81,26 @@ DEFINE_SPINLOCK(nfsd_drc_lock);
 unsigned long	nfsd_drc_max_mem;
 unsigned long	nfsd_drc_mem_used;
 
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+extern const struct svc_version nfsd_localio_version1;
+static const struct svc_version *nfsd_localio_version[] = {
+	[1] = &nfsd_localio_version1,
+};
+
+#define NFSD_LOCALIO_NRVERS		ARRAY_SIZE(nfsd_localio_version)
+
+static struct svc_program	nfsd_localio_program = {
+	.pg_prog		= NFS_LOCALIO_PROGRAM,
+	.pg_nvers		= NFSD_LOCALIO_NRVERS,
+	.pg_vers		= nfsd_localio_version,
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
@@ -975,7 +1002,7 @@ nfsd(void *vrqstp)
 }
 
 /**
- * nfsd_dispatch - Process an NFS or NFSACL Request
+ * nfsd_dispatch - Process an NFS or NFSACL or NFSLOCALIO Request
  * @rqstp: incoming request
  *
  * This RPC dispatcher integrates the NFS server's duplicate reply cache.
-- 
2.44.0


