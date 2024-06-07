Return-Path: <linux-nfs+bounces-3611-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381AD900698
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419E21C228B8
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BBA196DA5;
	Fri,  7 Jun 2024 14:27:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CD319753B
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770451; cv=none; b=Gk4v2iU/0W3lpZx9xhvntblSxmtjOq2am2YRpv7Lubqu/SG3pHMXeY2qBQHGCpodwy9K2CXriAmhZb4vWf1GUYXN+ix9EV3TG5oBmzahFHHKIJoi0JNztvGkHJNzZNcqHW16SfTO2mVqoRs+tSHeVXj94CDPzYAJxwBP36aJh8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770451; c=relaxed/simple;
	bh=1iVFGGzcjCA8sHQBCaqLmbLk7zYE2/nwHvJVYoxGJJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgUtIry35/ANM9nXbidC4EF92FFtTmunwLOSmfBigywOncatPWq8HcNmPz6D9dIaYOv1tUW6lUikLnVSov4vsRw/GS6KIeauriIG+ZuoHUJS8fdlKcODWmVmoPu6QAcpsiAVEi1ePnn5/TF4yLLUtpb9bo1/sPnr3Q5IgbJnjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79543e08da7so41373085a.1
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770449; x=1718375249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBSe5nbYKHSsRdcV5O1rbDwalSUH6Ll0iUuRomQayHI=;
        b=dZ1qTAD2l0PrUUymNB+xh8tmScazIRxOcvfF5sM7INRo4TQIagn+c0S0mfQ1997cm/
         6cjhOyivx/oUKCko/tQRohjC/sQN9GiTGeJZAlx5j2KrxY6zXpV1f3oLDfr3M2JvjVI7
         afx7xl+BAoVmFlsZTGTfRTLbOCaJv9V5mJHk0vfsw5ekHGCO9NFyInBXfhPNSHtoV3l5
         JLV+cHO9s4oXLbVwN+pmCYD0l8YiWfEYzFBaSux6x2kfK+o6P7h769EaoSXY1VbAAuMg
         xyjnW2Q6BusC9kI1Z/rIDb3w6JeMA0tvB0zTv+2cpTmGBo/zfbo7htX/GjVnauuYQmwT
         8e8g==
X-Gm-Message-State: AOJu0Yy4Gd6mPWaYTkk/5HjVymzda7jH8P6bibkxKBD6774ig514477T
	IMHWCoKYIeAjYyhOI74pziic6gf0UDmwYkhCHhB8uLKGiZIzvBcb0090MuzJhulFfKpCaD/u4iy
	nz6g=
X-Google-Smtp-Source: AGHT+IGSykggp+JvT9nvWSgAKN4bocWUi7BHrll9lwEeAD+mRi5XgQc+WPZcnoaOtiSLzt44uILlSw==
X-Received: by 2002:a05:620a:3636:b0:795:2307:97ef with SMTP id af79cd13be357-7953c2b3438mr227533385a.6.1717770448591;
        Fri, 07 Jun 2024 07:27:28 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795330b7198sm170611885a.90.2024.06.07.07.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:28 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 26/29] nfsd: implement v4 server support for NFS_LOCALIO_PROGRAM
Date: Fri,  7 Jun 2024 10:26:43 -0400
Message-ID: <20240607142646.20924-27-snitzer@kernel.org>
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

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/localio.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  5 ++++
 fs/nfsd/nfssvc.c  | 25 ++++++++++-------
 3 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index eda4fa49b316..e4d2adf9531f 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -16,6 +16,7 @@
 #include "filecache.h"
 #include "cache.h"
 #include "xdr3.h"
+#include "xdr4.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_FH
 
@@ -267,3 +268,72 @@ const struct svc_version nfsd_localio_version3 = {
 	.vs_xdrsize	= NFS3_SVC_XDRSIZE,
 };
 #endif /* CONFIG_NFSD_V3_LOCALIO */
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
+	if (resp->status == nfs_ok) {
+		u8 uuid[UUID_SIZE];
+
+		export_uuid(uuid, &resp->uuid);
+		p = xdr_reserve_space(xdr, 4 + UUID_SIZE);
+		if (!p)
+			return 0;
+		xdr_encode_opaque(p, uuid, UUID_SIZE);
+		dprintk("%s: nfs_ok uuid=%pU uuid_len=%lu\n",
+			__func__, uuid, sizeof(uuid));
+	}
+
+	return 1;
+}
+
+#define ST 1		/* status */
+#define NFS4_filename_sz	(1+(NFS4_MAXNAMLEN>>2))
+
+static const struct svc_procedure nfsd_localio_procedures4[2] = {
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
+		.pc_encode = nfs4svc_encode_getuuidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_getuuidres),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = ST+NFS4_filename_sz,
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
index d6771669531d..dd225330837f 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -147,6 +147,11 @@ extern const struct svc_version nfsd_localio_version3;
 #else
 #define nfsd_localio_version3 NULL
 #endif
+#if defined(CONFIG_NFSD_V4_LOCALIO)
+extern const struct svc_version nfsd_localio_version4;
+#else
+#define nfsd_localio_version4 NULL
+#endif
 
 struct nfsd_net;
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index fab699699869..72ed4ed11c95 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -38,7 +38,7 @@
 atomic_t			nfsd_th_cnt = ATOMIC_INIT(0);
 extern struct svc_program	nfsd_program;
 static int			nfsd(void *vrqstp);
-#if defined(CONFIG_NFSD_V3_LOCALIO)
+#if defined(CONFIG_NFSD_V3_LOCALIO) || defined(CONFIG_NFSD_V4_LOCALIO)
 static int			nfsd_localio_rpcbind_set(struct net *,
 						     const struct svc_program *,
 						     u32, int,
@@ -47,7 +47,7 @@ static int			nfsd_localio_rpcbind_set(struct net *,
 static __be32			nfsd_localio_init_request(struct svc_rqst *,
 						const struct svc_program *,
 						struct svc_process_info *);
-#endif /* CONFIG_NFSD_V3_LOCALIO */
+#endif /* CONFIG_NFSD_V3_LOCALIO || CONFIG_NFSD_V4_LOCALIO */
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static int			nfsd_acl_rpcbind_set(struct net *,
 						     const struct svc_program *,
@@ -91,9 +91,14 @@ DEFINE_SPINLOCK(nfsd_drc_lock);
 unsigned long	nfsd_drc_max_mem;
 unsigned long	nfsd_drc_mem_used;
 
-#if defined(CONFIG_NFSD_V3_LOCALIO)
+#if defined(CONFIG_NFSD_V3_LOCALIO) || defined(CONFIG_NFSD_V4_LOCALIO)
 static const struct svc_version *nfsd_localio_version[] = {
+#if defined(CONFIG_NFSD_V3_LOCALIO)
 	[3] = &nfsd_localio_version3,
+#endif
+#if defined(CONFIG_NFSD_V4_LOCALIO)
+	[4] = &nfsd_localio_version4,
+#endif
 };
 
 #define NFSD_LOCALIO_MINVERS            3
@@ -109,7 +114,7 @@ static struct svc_program	nfsd_localio_program = {
 	.pg_init_request	= nfsd_localio_init_request,
 	.pg_rpcbind_set		= nfsd_localio_rpcbind_set,
 };
-#endif /* CONFIG_NFSD_V3_LOCALIO */
+#endif /* CONFIG_NFSD_V3_LOCALIO || CONFIG_NFSD_V4_LOCALIO */
 
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static const struct svc_version *nfsd_acl_version[] = {
@@ -125,9 +130,9 @@ static const struct svc_version *nfsd_acl_version[] = {
 #define NFSD_ACL_NRVERS		ARRAY_SIZE(nfsd_acl_version)
 
 static struct svc_program	nfsd_acl_program = {
-#if defined(CONFIG_NFSD_V3_LOCALIO)
+#if defined(CONFIG_NFSD_V3_LOCALIO) || defined(CONFIG_NFSD_V4_LOCALIO)
 	.pg_next		= &nfsd_localio_program,
-#endif /* CONFIG_NFSD_V3_LOCALIO */
+#endif /* CONFIG_NFSD_V3_LOCALIO || CONFIG_NFSD_V4_LOCALIO */
 	.pg_prog		= NFS_ACL_PROGRAM,
 	.pg_nvers		= NFSD_ACL_NRVERS,
 	.pg_vers		= nfsd_acl_version,
@@ -157,9 +162,9 @@ struct svc_program		nfsd_program = {
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 	.pg_next		= &nfsd_acl_program,
 #else
-#if defined(CONFIG_NFSD_V3_LOCALIO)
+#if defined(CONFIG_NFSD_V3_LOCALIO) || defined(CONFIG_NFSD_V4_LOCALIO)
 	.pg_next		= &nfsd_localio_program,
-#endif /* CONFIG_NFSD_V3_LOCALIO */
+#endif /* CONFIG_NFSD_V3_LOCALIO || CONFIG_NFSD_V4_LOCALIO */
 #endif
 	.pg_prog		= NFS_PROGRAM,		/* program number */
 	.pg_nvers		= NFSD_NRVERS,		/* nr of entries in nfsd_version */
@@ -855,7 +860,7 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred, const char *scop
 	return error;
 }
 
-#if defined(CONFIG_NFSD_V3_LOCALIO)
+#if defined(CONFIG_NFSD_V3_LOCALIO) || defined(CONFIG_NFSD_V4_LOCALIO)
 static bool
 nfsd_support_localio_version(int vers)
 {
@@ -889,7 +894,7 @@ nfsd_localio_init_request(struct svc_rqst *rqstp,
 
 	return rpc_prog_unavail;
 }
-#endif /* CONFIG_NFSD_V3_LOCALIO */
+#endif /* CONFIG_NFSD_V3_LOCALIO || CONFIG_NFSD_V4_LOCALIO */
 
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static bool
-- 
2.44.0


