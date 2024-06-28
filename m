Return-Path: <linux-nfs+bounces-4400-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B688C91C7E4
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 23:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9AC41C21357
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 21:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0CF8062A;
	Fri, 28 Jun 2024 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CriF8pIU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8F280624
	for <linux-nfs@vger.kernel.org>; Fri, 28 Jun 2024 21:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609091; cv=none; b=UD0gDPPuXHbwv1PMo8lPOXR4VYa6qluszZwc7qXI/2fmX778dhH9FDxvz8/IvdEWj7/Jl05lE7ijQq/2pGqmFB6yF4SoYjZ4yyO0YPTAXbhQ9kWbPAE/1iOeFRlYYGfF4BR1weB+pOG/NdR5bTPH7cp+8qDecG6H4gGubs0jWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609091; c=relaxed/simple;
	bh=hSwr3m5UbOOOg1vbOJ66bCLcnPlCiqpfyq+pjs28L0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TW5zy1QhADQdYMfRUoPPt63OkEzMcRK5zPRHF2/xs8uJc/XpkZ88ZkfX0/YrHfEaWRCoJO18tGxlmv8DP3yexXW3ydAnGYz6OdTVjkMttozPucE2aOxelpOtdXIGdzarUnJc+AvlRJiHWJ74U9YxF4wdsh+8bfxQCbRZogCcFuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CriF8pIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2E7C116B1;
	Fri, 28 Jun 2024 21:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719609090;
	bh=hSwr3m5UbOOOg1vbOJ66bCLcnPlCiqpfyq+pjs28L0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CriF8pIUyNOaRrFYdTyP1arjohLP+AVzjGBMnPZUAZ2h5eJfEsGKyiQMlPWuSn0Ea
	 PFIZTU3Ogq2vUe3ACDlCxVXDVYotrvK2GJ+zFf0VeCw7Zi30Mn74AxbLetSSM4FjL1
	 kWjab8AzdZOTLIPUbh7n2RajDGrffbuPmrBVjWDuAlS1ntYhEsGdwP/mEcTHTWHH/W
	 AavVcYjR3UONxo9kWffX1kLL7ajoHnsCymCON8xYhLDmRVnRh1pQKV08hcBCj3gYrH
	 puASww/XaPlkoct3iHGF7SRQ71JK8ymOgQDSFKJ2Wk7atYSovpTOnS8uE6ex0l2r5s
	 wX57iRppsuYKg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v9 17/19] nfsd: implement server support for NFS_LOCALIO_PROGRAM
Date: Fri, 28 Jun 2024 17:11:03 -0400
Message-ID: <20240628211105.54736-18-snitzer@kernel.org>
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
 fs/nfsd/localio.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfssvc.c  | 29 ++++++++++++++++++-
 2 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index ef8467056827..3b52391a7bde 100644
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
 
@@ -243,3 +246,74 @@ EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
 
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
index 11fb209b46bf..6cc6a1971e21 100644
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
@@ -1014,7 +1041,7 @@ nfsd(void *vrqstp)
 }
 
 /**
- * nfsd_dispatch - Process an NFS or NFSACL Request
+ * nfsd_dispatch - Process an NFS or NFSACL or LOCALIO Request
  * @rqstp: incoming request
  *
  * This RPC dispatcher integrates the NFS server's duplicate reply cache.
-- 
2.44.0


