Return-Path: <linux-nfs+bounces-3608-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBF0900695
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E941C21B4E
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD5E19753E;
	Fri,  7 Jun 2024 14:27:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9629196C85
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770447; cv=none; b=bscAi96rH8HA83l6p2jEX242fZgSOWHWPjO3eBgOAKL5qDk1IzkH658FYj7T/+A7zlSebKl0aL/X1ASn1CAdHPHBOe2ZGnTFQvEmkWTSCgMsqJ/nVA0jIPQzO4TGwMNkqyb9oX8PbSsJx3zQvsyj9pPAdVw/96OdOhK7smGa7HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770447; c=relaxed/simple;
	bh=Ew1t96eWao4LmRTo7eOtrWOOfkQp2LQfXFvtCP8dJmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRhvHV/mtmZcCucuseZAq70cmEXA90G3iZIdsjr1jbRJlj5lBiYVEEdboBLydwoGZU4zitTvaTj79oRM/mNW4nPiPLIx+WYro4RUznfR0c2syr3J2ZNY0WiU6thi6g5WMSNIIVRuw4U1UJd4YRw22QlVQBeDZgq07SAqLOtLIDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b063047958so2276466d6.3
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770444; x=1718375244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5va2WMsYGSYMVOxWFOdnrx6gENMQTK3zuw1rVO709c8=;
        b=MbKLQB59KithdVaJ0vvD1ixXKkmG8mnn+0SpaaXSlnuu+depDGnVgSNGiGBi8MEwYv
         UZgzxdyicDclCbxVlf85q0aX7HsbrZFV7FhY0tUtTBwBI4mAyXwWFLamlzyQjP9bAo08
         Y9YDkfvAHE43ec6K0KGz7FcvWTCMxRVxgdZgRBwUUe1hG3xI0iqNXX9LjoYGgAhRVP7U
         w0AaMgt8GphjtMV2gKeeNIpZqLkymVvrELFFayZNwJnhzpTVBVPstzsYai/hywwvMAaT
         3E7sqlx8pJpuAYUHzOpn7be8RH2rqsczQ+n6Xlpo9Ts82eDjbCdSSyS52/2pVrkdFVUY
         BFQw==
X-Gm-Message-State: AOJu0YzrcPfVz+IqHxi+tti/zc1MBbLwUrw+UxaoTOPGGMnpHmTRbGvK
	YSwuovivtJpS691lUZPkt0bAZzpM+8Bi3K3r2IPeP1QgVHuP3FqIeq3ivUbZBlZHrrESmLEjbWb
	/fgg=
X-Google-Smtp-Source: AGHT+IFoWJfeFhmGncYfv7HkfPX7M2Au8J0TL1+VrIFVOOFozVExPJrzPKBs5PPhaNk/dRnmT+aQLA==
X-Received: by 2002:a05:6214:4a91:b0:6ab:8949:4743 with SMTP id 6a1803df08f44-6b059f281b0mr32777166d6.59.1717770444259;
        Fri, 07 Jun 2024 07:27:24 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b0601f3174sm6214486d6.93.2024.06.07.07.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:23 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 23/29] nfsd: implement v3 server support for NFS_LOCALIO_PROGRAM
Date: Fri,  7 Jun 2024 10:26:40 -0400
Message-ID: <20240607142646.20924-24-snitzer@kernel.org>
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

LOCALIOPROC_GETUUID encodes the server's uuid_t in terms of smaller
UUID_SIZE (16), rather than larger UUID_STRING_LEN + 1 (37).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/localio.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  6 ++++
 fs/nfsd/nfssvc.c  | 75 ++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/xdr.h     |  6 ++++
 4 files changed, 176 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index ff68454a4017..eda4fa49b316 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -14,6 +14,8 @@
 #include "vfs.h"
 #include "netns.h"
 #include "filecache.h"
+#include "cache.h"
+#include "xdr3.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_FH
 
@@ -177,3 +179,91 @@ EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
 
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
+#if defined(CONFIG_NFSD_V3_LOCALIO)
+
+static void encode_uuid(struct xdr_stream *xdr,
+			const char *name, u32 length)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, 4 + length);
+	xdr_encode_opaque(p, name, length);
+}
+
+static bool nfs3svc_encode_getuuidres(struct svc_rqst *rqstp,
+				      struct xdr_stream *xdr)
+{
+	struct nfsd_getuuidres *resp = rqstp->rq_resp;
+
+	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
+		return false;
+	if (resp->status == nfs_ok) {
+		u8 uuid[UUID_SIZE];
+
+		export_uuid(uuid, &resp->uuid);
+		encode_uuid(xdr, uuid, UUID_SIZE);
+		dprintk("%s: nfs_ok uuid=%pU uuid_len=%lu\n",
+			__func__, uuid, sizeof(uuid));
+	}
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
+		.pc_xdrressize = ST,
+		.pc_name = "NULL",
+	},
+	[LOCALIOPROC_GETUUID] = {
+		.pc_func = nfsd_proc_getuuid,
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfs3svc_encode_getuuidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_getuuidres),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = ST+NFS3_filename_sz,
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
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 8f4f239d9f8a..d6771669531d 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -142,6 +142,12 @@ extern const struct svc_version nfsd_acl_version3;
 #endif
 #endif
 
+#if defined(CONFIG_NFSD_V3_LOCALIO)
+extern const struct svc_version nfsd_localio_version3;
+#else
+#define nfsd_localio_version3 NULL
+#endif
+
 struct nfsd_net;
 
 enum vers_op {NFSD_SET, NFSD_CLEAR, NFSD_TEST, NFSD_AVAIL };
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 122cfa184805..c18ee0f56da4 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -38,6 +38,16 @@
 atomic_t			nfsd_th_cnt = ATOMIC_INIT(0);
 extern struct svc_program	nfsd_program;
 static int			nfsd(void *vrqstp);
+#if defined(CONFIG_NFSD_V3_LOCALIO)
+static int			nfsd_localio_rpcbind_set(struct net *,
+						     const struct svc_program *,
+						     u32, int,
+						     unsigned short,
+						     unsigned short);
+static __be32			nfsd_localio_init_request(struct svc_rqst *,
+						const struct svc_program *,
+						struct svc_process_info *);
+#endif /* CONFIG_NFSD_V3_LOCALIO */
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static int			nfsd_acl_rpcbind_set(struct net *,
 						     const struct svc_program *,
@@ -81,6 +91,26 @@ DEFINE_SPINLOCK(nfsd_drc_lock);
 unsigned long	nfsd_drc_max_mem;
 unsigned long	nfsd_drc_mem_used;
 
+#if defined(CONFIG_NFSD_V3_LOCALIO)
+static const struct svc_version *nfsd_localio_version[] = {
+	[3] = &nfsd_localio_version3,
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
+#endif /* CONFIG_NFSD_V3_LOCALIO */
+
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static const struct svc_version *nfsd_acl_version[] = {
 # if defined(CONFIG_NFSD_V2_ACL)
@@ -95,6 +125,9 @@ static const struct svc_version *nfsd_acl_version[] = {
 #define NFSD_ACL_NRVERS		ARRAY_SIZE(nfsd_acl_version)
 
 static struct svc_program	nfsd_acl_program = {
+#if defined(CONFIG_NFSD_V3_LOCALIO)
+	.pg_next		= &nfsd_localio_program,
+#endif /* CONFIG_NFSD_V3_LOCALIO */
 	.pg_prog		= NFS_ACL_PROGRAM,
 	.pg_nvers		= NFSD_ACL_NRVERS,
 	.pg_vers		= nfsd_acl_version,
@@ -123,6 +156,10 @@ static const struct svc_version *nfsd_version[] = {
 struct svc_program		nfsd_program = {
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 	.pg_next		= &nfsd_acl_program,
+#else
+#if defined(CONFIG_NFSD_V3_LOCALIO)
+	.pg_next		= &nfsd_localio_program,
+#endif /* CONFIG_NFSD_V3_LOCALIO */
 #endif
 	.pg_prog		= NFS_PROGRAM,		/* program number */
 	.pg_nvers		= NFSD_NRVERS,		/* nr of entries in nfsd_version */
@@ -818,6 +855,42 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scop
 	return error;
 }
 
+#if defined(CONFIG_NFSD_V3_LOCALIO)
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
+#endif /* CONFIG_NFSD_V3_LOCALIO */
+
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static bool
 nfsd_support_acl_version(int vers)
@@ -960,7 +1033,7 @@ nfsd(void *vrqstp)
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


