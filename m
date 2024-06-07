Return-Path: <linux-nfs+bounces-3610-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB15900696
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3140A1C21940
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2172F198A24;
	Fri,  7 Jun 2024 14:27:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84303199398
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770450; cv=none; b=NgGolrELJaL/vNOvPdxRTVmj+o9K5/ZK/SnlqtcxFjHl2qHE1FFy8xlGnIRFJd2bEWEj+rXj+2g2PWPsimax0wnHs++UBdr6jq1IhEFWsHmJjjoHQ59Hf+J/SRowwHPa6sXMQ50HJzti8FhHO8Y3pmQ33dzBBfAMVawOAba6Kiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770450; c=relaxed/simple;
	bh=1aCEkTG+fJD3qQXos6HhlwQMvQVGyucOAUdh37b3RPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+gjcxmm2jYkTtBCY//NGagvaEYc7CVW7ZTd3H60vdqvij5EJfHWWlTEhgNSdaxiwlvmPY1p/qkcggIvk/5++LQwOtgkYZbnMeLxsVih3eXmVjrtk4bVDdMbkiiZvCbCfylsdocTZFezleWCxdyiuq4H2DXFDglimEcQVswjA38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-440482bfdd9so2823221cf.2
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770447; x=1718375247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaFoga4BCF669tVO0iDvtbQA0xft6rztlHfYEqgoqyw=;
        b=nlGDJJBILgZDAbN0V6W7w//Z+arDDrPaEd20FIM1nNkMpGXGsMl2L6ozZV2hoMwuDF
         MiD6Uaq4HLQZPpjrCY7Qi8Ca4ZQzsnV9DmujKQd6IwLm4drJOQS84yqvSJdt2cwdlJhv
         UNr7Qst3WB8JWFOabSw5nhqcCxsxM+tzZ+fMFH/d7Kt23pYR0BayBStkjfVepzS5ZVG+
         Sccz0KPUViLh/Pxx+WkOss/6+muvoEYAmXfb0AbVHwmDgqrE5e7UBk6ywmpJDeKuM4rq
         EjHHHH7pzCyJW/htTl3APBSVH48297QEY6vWhYb2+X2vMk8URAV3nQ5hV+v8scbEiLMA
         kZww==
X-Gm-Message-State: AOJu0Yzi9lj3S4iTVD1QZ1o8d3in/MXpoqnT8Tnw2g7aBMpofll61Uii
	IRTtnWNklLKMjdmiq6mJ+zh31vF9tXGki7rt29AWrQQPK+T65V834Go+nodJDjiYJb26jqg7HFe
	0eos=
X-Google-Smtp-Source: AGHT+IEWGMBaSD1HXfNgNa9/fFPontDVS1CxYvKqf59hMINbOl+C1kAIk4/GhOHiqgwddPpYfDI2cw==
X-Received: by 2002:ac8:7d4f:0:b0:43a:f58b:2e71 with SMTP id d75a77b69052e-44041b99a34mr34067061cf.10.1717770447109;
        Fri, 07 Jun 2024 07:27:27 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038a7145asm12902711cf.28.2024.06.07.07.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:27:26 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 25/29] nfs: implement v4 client support for NFS_LOCALIO_PROGRAM
Date: Fri,  7 Jun 2024 10:26:42 -0400
Message-ID: <20240607142646.20924-26-snitzer@kernel.org>
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

While doing so, factor out nfs_init_localioclient() so it is used by
both nfs3client.c and nfs4client.c

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/internal.h       | 28 ++++++++++++++++++++--
 fs/nfs/localio.c        |  2 +-
 fs/nfs/nfs3client.c     | 19 +--------------
 fs/nfs/nfs4_fs.h        |  2 ++
 fs/nfs/nfs4client.c     | 23 ++++++++++++++++++
 fs/nfs/nfs4proc.c       |  3 +++
 fs/nfs/nfs4xdr.c        | 53 +++++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_xdr.h |  2 ++
 8 files changed, 111 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 9f81a94e798c..1b2adca930fa 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -452,7 +452,31 @@ extern void nfs_set_cache_invalid(struct inode *inode, unsigned long flags);
 extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
 extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 
-#if defined(CONFIG_NFS_V3_LOCALIO)
+#if defined(CONFIG_NFS_V3_LOCALIO) || defined(CONFIG_NFS_V4_LOCALIO)
+/*
+ * Initialise an NFS localio client connection.
+ * Inlined here to allow nfs[34]client.c to share this code.
+ */
+static __always_inline void
+nfs_init_localioclient(struct nfs_client *clp,
+		       const struct rpc_program *program, u32 vers)
+{
+	bool supported = false;
+
+	if (unlikely(!IS_ERR(clp->cl_rpcclient_localio)))
+		goto out;
+	clp->cl_rpcclient_localio = rpc_bind_new_program(clp->cl_rpcclient,
+							program, vers);
+	if (IS_ERR(clp->cl_rpcclient_localio))
+		goto out;
+	/* No errors! Assume that localio is supported */
+	supported = true;
+out:
+	dfprintk_rcu(CLIENT, "%s: server (%s) %s NFS v%u LOCALIO\n", __func__,
+		rpc_peeraddr2str(clp->cl_rpcclient_localio, RPC_DISPLAY_ADDR),
+		(supported ? "supports" : "does not support"), vers);
+}
+
 /* localio.c */
 extern void nfs_local_init(void);
 extern void nfs_local_enable(struct nfs_client *);
@@ -507,7 +531,7 @@ static inline bool nfs_server_is_local(const struct nfs_client *clp)
 {
 	return false;
 }
-#endif /* CONFIG_NFS_V3_LOCALIO */
+#endif /* CONFIG_NFS_V3_LOCALIO || CONFIG_NFS_V4_LOCALIO */
 
 /* super.c */
 extern const struct super_operations nfs_sops;
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 145708444998..ab92c92f04e5 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -269,6 +269,7 @@ void nfs_local_probe(struct nfs_client *clp)
 
 	switch (clp->cl_rpcclient->cl_vers) {
 	case 3:
+	case 4:
 		/*
 		 * Retrieve server's uuid via LOCALIO protocol and verify the
 		 * server with that uuid it is known to be local. This ensures
@@ -280,7 +281,6 @@ void nfs_local_probe(struct nfs_client *clp)
 		if (!nfsd_uuid_is_local(&uuid))
 			return;
 		break;
-	case 4:
 	default:
 		return; /* localio not supported */
 	}
diff --git a/fs/nfs/nfs3client.c b/fs/nfs/nfs3client.c
index c41122ee808c..123e7c1fd339 100644
--- a/fs/nfs/nfs3client.c
+++ b/fs/nfs/nfs3client.c
@@ -152,23 +152,6 @@ const struct rpc_program nfslocalio_program3 = {
  */
 void nfs3_init_localioclient(struct nfs_client *clp)
 {
-	if (unlikely(!IS_ERR(clp->cl_rpcclient_localio)))
-		goto out;
-
-	clp->cl_rpcclient_localio = rpc_bind_new_program(clp->cl_rpcclient,
-							&nfslocalio_program3, 3);
-	if (IS_ERR(clp->cl_rpcclient_localio)) {
-		dprintk_rcu("%s: server (%s) does not support NFS v3 LOCALIO\n", __func__,
-			rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_ADDR));
-		return;
-	}
-out:
-	/* No errors! Assume that localio is supported */
-	dprintk_rcu("%s: server (%s) supports NFS v3 LOCALIO\n", __func__,
-		rpc_peeraddr2str(clp->cl_rpcclient_localio, RPC_DISPLAY_ADDR));
-}
-#else
-void nfs3_init_localioclient(struct nfs_client *clp)
-{
+	nfs_init_localioclient(clp, &nfslocalio_program3, 3);
 }
 #endif /* CONFIG_NFS_V3_LOCALIO */
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 7024230f0d1d..a0a41917dec2 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -538,6 +538,8 @@ extern int nfs4_proc_commit(struct file *dst, __u64 offset, __u32 count, struct
 extern const nfs4_stateid zero_stateid;
 extern const nfs4_stateid invalid_stateid;
 
+extern void nfs4_init_localioclient(struct nfs_client *);
+
 /* nfs4super.c */
 struct nfs_mount_info;
 extern struct nfs_subversion nfs_v4;
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 84573df5cf5a..d2f634aa1e1b 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1384,3 +1384,26 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
 
 	return nfs_probe_server(server, NFS_FH(d_inode(server->super->s_root)));
 }
+
+#if defined(CONFIG_NFS_V4_LOCALIO)
+static struct rpc_stat		nfslocalio_rpcstat = { &nfslocalio_program4 };
+static const struct rpc_version *nfslocalio_version[] = {
+	[4]			= &nfslocalio_version4,
+};
+
+const struct rpc_program nfslocalio_program4 = {
+	.name			= "nfslocalio",
+	.number			= NFS_LOCALIO_PROGRAM,
+	.nrvers			= ARRAY_SIZE(nfslocalio_version),
+	.version		= nfslocalio_version,
+	.stats			= &nfslocalio_rpcstat,
+};
+
+/*
+ * Initialise an NFSv4 localio client connection
+ */
+void nfs4_init_localioclient(struct nfs_client *clp)
+{
+	nfs_init_localioclient(clp, &nfslocalio_program4, 4);
+}
+#endif /* CONFIG_NFS_V4_LOCALIO */
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c93c12063b3a..060bc8dbee61 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10745,6 +10745,9 @@ const struct nfs_rpc_ops nfs_v4_clientops = {
 	.discover_trunking = nfs4_discover_trunking,
 	.enable_swap	= nfs4_enable_swap,
 	.disable_swap	= nfs4_disable_swap,
+#if defined(CONFIG_NFS_V4_LOCALIO)
+	.init_localioclient = nfs4_init_localioclient,
+#endif
 };
 
 static const struct xattr_handler nfs4_xattr_nfs4_acl_handler = {
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 1416099dfcd1..e6f3556a320e 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7728,3 +7728,56 @@ const struct rpc_version nfs_version4 = {
 	.procs			= nfs4_procedures,
 	.counts			= nfs_version4_counts,
 };
+
+#if defined(CONFIG_NFS_V4_LOCALIO)
+
+#define NFS4_filename_sz	(1+(NFS4_MAXNAMLEN>>2))
+#define LOCALIO4_getuuidres_sz	(1+NFS4_filename_sz)
+
+static void nfs4_xdr_enc_getuuidargs(struct rpc_rqst *req,
+				struct xdr_stream *xdr,
+				const void *data)
+{
+	/* void function */
+}
+
+static inline int nfs4_decode_getuuidresok(struct xdr_stream *xdr,
+					struct nfs_getuuidres *result)
+{
+	return decode_opaque_inline(xdr, &result->len, (char **)&result->uuid);
+}
+
+static int nfs4_xdr_dec_getuuidres(struct rpc_rqst *req,
+				struct xdr_stream *xdr,
+				void *result)
+{
+	// FIXME: need proper handling that isn't abusing nfs_opnum4
+	int error = decode_op_hdr(xdr, LOCALIOPROC_GETUUID);
+	if (unlikely(error))
+		goto out;
+	error = nfs4_decode_getuuidresok(xdr, result);
+out:
+	return error;
+}
+
+static const struct rpc_procinfo nfs4_localio_procedures[] = {
+	[LOCALIOPROC_GETUUID] = {
+		.p_proc = LOCALIOPROC_GETUUID,
+		.p_encode = nfs4_xdr_enc_getuuidargs,
+		.p_decode = nfs4_xdr_dec_getuuidres,
+		.p_arglen = 1,
+		.p_replen = LOCALIO4_getuuidres_sz,
+		.p_statidx = LOCALIOPROC_GETUUID,
+		.p_name = "GETUUID",
+	},
+};
+
+static unsigned int nfs4_localio_counts[ARRAY_SIZE(nfs4_localio_procedures)];
+const struct rpc_version nfslocalio_version4 = {
+	.number			= 4,
+	.nrprocs		= ARRAY_SIZE(nfs4_localio_procedures),
+	.procs			= nfs4_localio_procedures,
+	.counts			= nfs4_localio_counts,
+};
+
+#endif  /* CONFIG_NFS_V4_LOCALIO */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 9a030e9bd9cf..b6a16eca4664 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1842,5 +1842,7 @@ extern const struct rpc_program nfsacl_program;
 
 extern const struct rpc_version nfslocalio_version3;
 extern const struct rpc_program nfslocalio_program3;
+extern const struct rpc_version nfslocalio_version4;
+extern const struct rpc_program nfslocalio_program4;
 
 #endif
-- 
2.44.0


