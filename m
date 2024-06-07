Return-Path: <linux-nfs+bounces-3612-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF3D900699
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4218F1C20E1F
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E355198E84;
	Fri,  7 Jun 2024 14:27:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9AC19753B
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770453; cv=none; b=YJJBnm66n9PXKOwnlq2O5mGt6Cv+jwE6CcTZ9A+Uj5issvwmXPmu5j5w4m8MlZyNF5zM9BqnF2aVarFyEYfXnIBmYo3r8DafVuvKshHCyxCM3p+L45EvmSIaJ9hzxBU1SEh24A/30zG/+2/zFC0rL+yWk+7aYYwrGoOKeLsESvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770453; c=relaxed/simple;
	bh=T0nMI2X99CSRK9c9VpQk1UoGPb05+40N/7Bpujq+1HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2xWTfdM/brw/aYJ5sw6piZWM3zWDr3HaKKccwd2qPJi/DESoFQrMmKiu+7X63fQjdTVSMK9xhjHfTtIpVdQqAjK0evQgkalrlkk8uKL/oAjG2QOAslBMxrfxvHRvnkH5ZCAlZ+A69Se9E9dFicZrBwU77WwtwQLmPVQfxk806M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-79523244ccfso170349885a.0
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770450; x=1718375250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnieZSoy635CdMu4Lx7fbV0rEn9u66v0s90V0xcAWcc=;
        b=CKHQkrN6xDcnYsIQGmoVh5qlojD+ASWK3jGUcZnWz56hLxMkt4uvwNQLH73rToHZWz
         YvMDPac+P0xR/m/N+WGR+l64oPQy54+nsZya8sO98xq+Z21CvuHQhAzxxBJFINHymZbQ
         5IrA6Rvmcm4b0AXMuL2ok6XD1f1CxXZRfCnKaYUDHKCofcSvTheqgHlm3xF4JwXs81f5
         Kf/Qg/yslMgDbfVhVlWU6UKY9yT+hpZ9x62uez134gqwVr1gBhoAPxTNDTcfujY8ch4e
         qXA/37MW9a9wE7BlyheReGWcUIvTeRpSENP/tRG8lQpGvRmZCWSKiFUr6X90ORsKCiL5
         52jA==
X-Gm-Message-State: AOJu0Yzm2Utn7bEz4EL0iQaBgK/YELOERypgKZ8TuDCNddl/mGacXdGW
	ZuGWP35VKYReubg9sInNf5M2rn6o2D0oAMRymgALPU9tHspYIV0OZOYvmG7joilkIqBvo2wlzyC
	OnEo=
X-Google-Smtp-Source: AGHT+IGF06N+DB1EVcaPbrJ2pyM77NNzFLFMVjnO1l8d+C9wWG17gLCcFa918iObzMCsQ8dBdI3Z6A==
X-Received: by 2002:a05:620a:1916:b0:794:fb8f:5495 with SMTP id af79cd13be357-7953af599demr550598185a.26.1717770450069;
        Fri, 07 Jun 2024 07:27:30 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7953286baabsm169065185a.52.2024.06.07.07.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:29 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 27/29] nfs/nfsd: switch GETUUID to using {encode,decode}_opaque_fixed
Date: Fri,  7 Jun 2024 10:26:44 -0400
Message-ID: <20240607142646.20924-28-snitzer@kernel.org>
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

The uuid is always UUID_SIZE (16) so there is no need to use less
efficient variable sized opaque encode and decode XDR methods.

Also, XDR buffer size requirements were audited and reduced
accordingly.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c        |  6 ++---
 fs/nfs/nfs3xdr.c        | 13 +++++++--
 fs/nfs/nfs4xdr.c        |  5 ++--
 fs/nfsd/localio.c       | 60 +++++++++++++++++------------------------
 include/linux/nfs_xdr.h |  3 +--
 5 files changed, 41 insertions(+), 46 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index ab92c92f04e5..ff28a7315470 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -246,9 +246,9 @@ static bool nfs_local_server_getuuid(struct nfs_client *clp, uuid_t *nfsd_uuid)
 	dprintk("%s: NFS issuing getuuid\n", __func__);
 	msg.rpc_proc = &clp->cl_rpcclient_localio->cl_procinfo[LOCALIOPROC_GETUUID];
 	status = rpc_call_sync(clp->cl_rpcclient_localio, &msg, 0);
-	dprintk("%s: NFS reply getuuid: status=%d uuid=%pU uuid_len=%u\n",
-		__func__, status, res.uuid, res.len);
-	if (status || res.len != UUID_SIZE)
+	dprintk("%s: NFS reply getuuid: status=%d uuid=%pU\n",
+		__func__, status, res.uuid);
+	if (status)
 		return false;
 
 	import_uuid(nfsd_uuid, res.uuid);
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 49689a9a2111..d2a17ecd12b8 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -2582,7 +2582,7 @@ const struct rpc_version nfsacl_version3 = {
 
 #if defined(CONFIG_NFS_V3_LOCALIO)
 
-#define LOCALIO3_getuuidres_sz	(1+NFS3_filename_sz)
+#define LOCALIO3_getuuidres_sz	(1+XDR_QUADLEN(UUID_SIZE))
 
 static void nfs3_xdr_enc_getuuidargs(struct rpc_rqst *req,
 				struct xdr_stream *xdr,
@@ -2591,10 +2591,19 @@ static void nfs3_xdr_enc_getuuidargs(struct rpc_rqst *req,
 	/* void function */
 }
 
+// FIXME: factor out from fs/nfs/nfs4xdr.c
+static int decode_opaque_fixed(struct xdr_stream *xdr, void *buf, size_t len)
+{
+	ssize_t ret = xdr_stream_decode_opaque_fixed(xdr, buf, len);
+	if (unlikely(ret < 0))
+		return -EIO;
+	return 0;
+}
+
 static inline int nfs3_decode_getuuidresok(struct xdr_stream *xdr,
 					struct nfs_getuuidres *result)
 {
-	return decode_inline_filename3(xdr, &result->uuid, &result->len);
+	return decode_opaque_fixed(xdr, result->uuid, UUID_SIZE);
 }
 
 static int nfs3_xdr_dec_getuuidres(struct rpc_rqst *req,
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index e6f3556a320e..d3b4fa3245f0 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7731,8 +7731,7 @@ const struct rpc_version nfs_version4 = {
 
 #if defined(CONFIG_NFS_V4_LOCALIO)
 
-#define NFS4_filename_sz	(1+(NFS4_MAXNAMLEN>>2))
-#define LOCALIO4_getuuidres_sz	(1+NFS4_filename_sz)
+#define LOCALIO4_getuuidres_sz	(op_decode_hdr_maxsz+XDR_QUADLEN(UUID_SIZE))
 
 static void nfs4_xdr_enc_getuuidargs(struct rpc_rqst *req,
 				struct xdr_stream *xdr,
@@ -7744,7 +7743,7 @@ static void nfs4_xdr_enc_getuuidargs(struct rpc_rqst *req,
 static inline int nfs4_decode_getuuidresok(struct xdr_stream *xdr,
 					struct nfs_getuuidres *result)
 {
-	return decode_opaque_inline(xdr, &result->len, (char **)&result->uuid);
+	return decode_opaque_fixed(xdr, result->uuid, UUID_SIZE);
 }
 
 static int nfs4_xdr_dec_getuuidres(struct rpc_rqst *req,
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index e4d2adf9531f..ace99f371c13 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -201,17 +201,23 @@ static __be32 nfsd_proc_getuuid(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
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
 #if defined(CONFIG_NFSD_V3_LOCALIO)
-
-static void encode_uuid(struct xdr_stream *xdr,
-			const char *name, u32 length)
-{
-	__be32 *p;
-
-	p = xdr_reserve_space(xdr, 4 + length);
-	xdr_encode_opaque(p, name, length);
-}
-
 static bool nfs3svc_encode_getuuidres(struct svc_rqst *rqstp,
 				      struct xdr_stream *xdr)
 {
@@ -219,14 +225,8 @@ static bool nfs3svc_encode_getuuidres(struct svc_rqst *rqstp,
 
 	if (!svcxdr_encode_nfsstat3(xdr, resp->status))
 		return false;
-	if (resp->status == nfs_ok) {
-		u8 uuid[UUID_SIZE];
-
-		export_uuid(uuid, &resp->uuid);
-		encode_uuid(xdr, uuid, UUID_SIZE);
-		dprintk("%s: nfs_ok uuid=%pU uuid_len=%lu\n",
-			__func__, uuid, sizeof(uuid));
-	}
+	if (resp->status == nfs_ok)
+		encode_uuid(xdr, &resp->uuid);
 
 	return true;
 }
@@ -242,7 +242,7 @@ static const struct svc_procedure nfsd_localio_procedures3[2] = {
 		.pc_argsize = sizeof(struct nfsd_voidargs),
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
-		.pc_xdrressize = ST,
+		.pc_xdrressize = 1,
 		.pc_name = "NULL",
 	},
 	[LOCALIOPROC_GETUUID] = {
@@ -252,7 +252,7 @@ static const struct svc_procedure nfsd_localio_procedures3[2] = {
 		.pc_argsize = sizeof(struct nfsd_voidargs),
 		.pc_ressize = sizeof(struct nfsd_getuuidres),
 		.pc_cachetype = RC_NOCACHE,
-		.pc_xdrressize = ST+NFS3_filename_sz,
+		.pc_xdrressize = 1+NFS_getuuid_sz,
 		.pc_name = "GETUUID",
 	},
 };
@@ -282,24 +282,12 @@ static bool nfs4svc_encode_getuuidres(struct svc_rqst *rqstp,
 	*p++ = cpu_to_be32(LOCALIOPROC_GETUUID);
 	*p++ = resp->status;
 
-	if (resp->status == nfs_ok) {
-		u8 uuid[UUID_SIZE];
-
-		export_uuid(uuid, &resp->uuid);
-		p = xdr_reserve_space(xdr, 4 + UUID_SIZE);
-		if (!p)
-			return 0;
-		xdr_encode_opaque(p, uuid, UUID_SIZE);
-		dprintk("%s: nfs_ok uuid=%pU uuid_len=%lu\n",
-			__func__, uuid, sizeof(uuid));
-	}
+	if (resp->status == nfs_ok)
+		encode_uuid(xdr, &resp->uuid);
 
 	return 1;
 }
 
-#define ST 1		/* status */
-#define NFS4_filename_sz	(1+(NFS4_MAXNAMLEN>>2))
-
 static const struct svc_procedure nfsd_localio_procedures4[2] = {
 	[LOCALIOPROC_NULL] = {
 		.pc_func = nfsd_proc_null,
@@ -308,7 +296,7 @@ static const struct svc_procedure nfsd_localio_procedures4[2] = {
 		.pc_argsize = sizeof(struct nfsd_voidargs),
 		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
-		.pc_xdrressize = ST,
+		.pc_xdrressize = 1,
 		.pc_name = "NULL",
 	},
 	[LOCALIOPROC_GETUUID] = {
@@ -318,7 +306,7 @@ static const struct svc_procedure nfsd_localio_procedures4[2] = {
 		.pc_argsize = sizeof(struct nfsd_voidargs),
 		.pc_ressize = sizeof(struct nfsd_getuuidres),
 		.pc_cachetype = RC_NOCACHE,
-		.pc_xdrressize = ST+NFS4_filename_sz,
+		.pc_xdrressize = 2+NFS_getuuid_sz,
 		.pc_name = "GETUUID",
 	},
 };
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index b6a16eca4664..2a438f4c2d6d 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1003,8 +1003,7 @@ struct nfs3_getaclres {
 };
 
 struct nfs_getuuidres {
-	const char *		uuid;
-	unsigned int		len;
+	__u8 *			uuid;
 };
 
 #if IS_ENABLED(CONFIG_NFS_V4)
-- 
2.44.0


