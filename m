Return-Path: <linux-nfs+bounces-18064-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DB0D38905
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 22:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB7D6310FA26
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jan 2026 21:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1306B30BB89;
	Fri, 16 Jan 2026 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKl2jBvQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146C2EB873
	for <linux-nfs@vger.kernel.org>; Fri, 16 Jan 2026 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768600303; cv=none; b=kWT1jXDJcu7taUqOLst6GojwlZ2toGpptNGk43fXT41RglJReEQGrz2MoeEmHHxq/O66OqVpfOa3RAkPBlFxYIfsTZufrPutT5MGKwjPeBEeiZlWrrGef4llcPWf7E5lxlSfz+hzY7sZN6NzR7UUMFf464H/F/SuPUxupds9+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768600303; c=relaxed/simple;
	bh=6VAfNyZ5bachwZyVZqGT1zxBIJKUNYMrjHj0gxjy1no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxvOLluOZL5q9EdaDCxjF3CnvNaijjLQHlEW6zC6rLv294YAebGKjwAAZry/6H9d4z+HG8e7F0TCoJZ0g5yKszADi9hnO8S8jgVTKNepqy0KRkhotjlKD3PywRRQeAdtaE48lvhCIuNiszwh0KY0R+3RkEXH0CLClTqS74IaF/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKl2jBvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DE7C19423;
	Fri, 16 Jan 2026 21:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768600303;
	bh=6VAfNyZ5bachwZyVZqGT1zxBIJKUNYMrjHj0gxjy1no=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKl2jBvQWfcbvyDi9N4hdbr+mejB/aL0mGGtrwzMf2vwDtMPMl6e29zME/xyv+rkI
	 LOBhexlSInMsVXZ8aAtYpS0ICi7rK1OZXK0Kx42AtD2hyGHxC4cX7UwkqHpKrjt+sv
	 n7WUPUVsVX6P2xf9PC/A4GWI9/PABNFYcPtzMIC1BtnETnyXZqDSi5Odvw0tFh+BFU
	 lS8Ln/pUF3QHWfLpnEwpYn/2k7nzjiDIqdElkbj37jBG2tE3Z00WnYG0U9LVYb1TyN
	 tqXkLyO9FIA70TwjBkCzKO4HAxh6C+C5l+dl8eoXB9PHoTfYuDG+6IlnJ6tC3jge+h
	 ZG5UhXlywHLoQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 14/14] NFS: Merge CONFIG_NFS_V4_1 with CONFIG_NFS_V4
Date: Fri, 16 Jan 2026 16:51:35 -0500
Message-ID: <20260116215135.846062-15-anna@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116215135.846062-1-anna@kernel.org>
References: <20260116215135.846062-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

Compiling the NFSv4 module without any minorversion support doesn't make
much sense, so this patch sets NFS v4.1 as the default, always enabled
NFS version allowing us to replace all the CONFIG_NFS_V4_1s scattered
throughout the code with CONFIG_NFS_V4.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/Kconfig            | 27 ++++--------
 fs/nfs/Makefile           |  3 +-
 fs/nfs/callback.c         | 13 +-----
 fs/nfs/callback.h         |  3 --
 fs/nfs/callback_proc.c    |  3 --
 fs/nfs/callback_xdr.c     | 21 ----------
 fs/nfs/client.c           |  8 ++--
 fs/nfs/internal.h         | 12 ++----
 fs/nfs/netns.h            |  4 +-
 fs/nfs/nfs4_fs.h          | 36 +---------------
 fs/nfs/nfs4client.c       | 23 -----------
 fs/nfs/nfs4proc.c         | 55 -------------------------
 fs/nfs/nfs4session.c      |  4 --
 fs/nfs/nfs4session.h      | 23 -----------
 fs/nfs/nfs4state.c        | 17 --------
 fs/nfs/nfs4trace.c        |  2 -
 fs/nfs/nfs4trace.h        | 16 -------
 fs/nfs/nfs4xdr.c          | 87 ---------------------------------------
 fs/nfs/pnfs.h             |  6 +--
 fs/nfs/read.c             |  4 +-
 fs/nfs/super.c            | 16 ++-----
 fs/nfs/sysfs.c            | 10 ++---
 fs/nfs/write.c            |  2 +-
 include/linux/nfs_fs_sb.h |  2 -
 include/linux/nfs_xdr.h   |  6 +--
 25 files changed, 35 insertions(+), 368 deletions(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 058ed67b98cc..12cb0ca738af 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -78,9 +78,10 @@ config NFS_V4
 	tristate "NFS client support for NFS version 4"
 	depends on NFS_FS
 	select KEYS
+	select SUNRPC_BACKCHANNEL
 	help
-	  This option enables support for version 4 of the NFS protocol
-	  (RFC 3530) in the kernel's NFS client.
+	  This option enables support for version 4.1 of the NFS protocol
+	  (RFC 5661) in the kernel's NFS client.
 
 	  To mount NFS servers using NFSv4, you also need to install user
 	  space programs which can be found in the Linux nfs-utils package,
@@ -105,19 +106,9 @@ config NFS_V4_0
 
 	  If unsure, say N.
 
-config NFS_V4_1
-	bool "NFS client support for NFSv4.1"
-	depends on NFS_V4
-	select SUNRPC_BACKCHANNEL
-	help
-	  This option enables support for minor version 1 of the NFSv4 protocol
-	  (RFC 5661) in the kernel's NFS client.
-
-	  If unsure, say N.
-
 config NFS_V4_2
 	bool "NFS client support for NFSv4.2"
-	depends on NFS_V4_1
+	depends on NFS_V4
 	help
 	  This option enables support for minor version 2 of the NFSv4 protocol
 	  in the kernel's NFS client.
@@ -126,22 +117,22 @@ config NFS_V4_2
 
 config PNFS_FILE_LAYOUT
 	tristate
-	depends on NFS_V4_1
+	depends on NFS_V4
 	default NFS_V4
 
 config PNFS_BLOCK
 	tristate
-	depends on NFS_V4_1 && BLK_DEV_DM
+	depends on NFS_V4 && BLK_DEV_DM
 	default NFS_V4
 
 config PNFS_FLEXFILE_LAYOUT
 	tristate
-	depends on NFS_V4_1
+	depends on NFS_V4
 	default NFS_V4
 
 config NFS_V4_1_IMPLEMENTATION_ID_DOMAIN
 	string "NFSv4.1 Implementation ID Domain"
-	depends on NFS_V4_1
+	depends on NFS_V4
 	default "kernel.org"
 	help
 	  This option defines the domain portion of the implementation ID that
@@ -153,7 +144,7 @@ config NFS_V4_1_IMPLEMENTATION_ID_DOMAIN
 
 config NFS_V4_1_MIGRATION
 	bool "NFSv4.1 client support for migration"
-	depends on NFS_V4_1
+	depends on NFS_V4
 	default n
 	help
 	  This option makes the NFS client advertise to NFSv4.1 servers that
diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index 6a9aaf2f913b..c895521f27f3 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -27,11 +27,10 @@ CFLAGS_nfs4trace.o += -I$(src)
 nfsv4-y := nfs4proc.o nfs4xdr.o nfs4state.o nfs4renewd.o nfs4super.o nfs4file.o \
 	  delegation.o nfs4idmap.o callback.o callback_xdr.o callback_proc.o \
 	  nfs4namespace.o nfs4getroot.o nfs4client.o nfs4session.o \
-	  dns_resolve.o nfs4trace.o
+	  dns_resolve.o nfs4trace.o pnfs.o pnfs_dev.o pnfs_nfs.o
 nfsv4-$(CONFIG_NFS_USE_LEGACY_DNS) += cache_lib.o
 nfsv4-$(CONFIG_SYSCTL)	+= nfs4sysctl.o
 nfsv4-$(CONFIG_NFS_V4_0)	+= nfs40client.o nfs40proc.o
-nfsv4-$(CONFIG_NFS_V4_1)	+= pnfs.o pnfs_dev.o pnfs_nfs.o
 nfsv4-$(CONFIG_NFS_V4_2)	+= nfs42proc.o nfs42xattr.o
 
 obj-$(CONFIG_PNFS_FILE_LAYOUT) += filelayout/
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index fabda0f6ec1a..6af67bdf0e40 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -87,7 +87,6 @@ nfs4_callback_svc(void *vrqstp)
 	return 0;
 }
 
-#if defined(CONFIG_NFS_V4_1)
 static inline void nfs_callback_bc_serv(u32 minorversion, struct rpc_xprt *xprt,
 		struct svc_serv *serv)
 {
@@ -98,12 +97,6 @@ static inline void nfs_callback_bc_serv(u32 minorversion, struct rpc_xprt *xprt,
 		 */
 		xprt->bc_serv = serv;
 }
-#else
-static inline void nfs_callback_bc_serv(u32 minorversion, struct rpc_xprt *xprt,
-		struct svc_serv *serv)
-{
-}
-#endif /* CONFIG_NFS_V4_1 */
 
 static int nfs_callback_start_svc(int minorversion, struct rpc_xprt *xprt,
 				  struct svc_serv *serv)
@@ -157,7 +150,7 @@ static int nfs_callback_up_net(int minorversion, struct svc_serv *serv,
 	}
 
 	ret = 0;
-	if (!IS_ENABLED(CONFIG_NFS_V4_1) || minorversion == 0)
+	if (minorversion == 0)
 		ret = nfs4_callback_up_net(serv, net);
 	else if (xprt->ops->bc_setup)
 		set_bc_enabled(serv);
@@ -198,10 +191,6 @@ static struct svc_serv *nfs_callback_create_svc(int minorversion)
 			cb_info->users);
 
 	threadfn = nfs4_callback_svc;
-#if !defined(CONFIG_NFS_V4_1)
-	if (minorversion)
-		return ERR_PTR(-ENOTSUPP);
-#endif
 	serv = svc_create(&nfs4_callback_program, NFS4_CALLBACK_BUFSIZE,
 			  threadfn);
 	if (!serv) {
diff --git a/fs/nfs/callback.h b/fs/nfs/callback.h
index 8809f93d82c0..2a721c422d48 100644
--- a/fs/nfs/callback.h
+++ b/fs/nfs/callback.h
@@ -65,8 +65,6 @@ struct cb_recallargs {
 	uint32_t truncate;
 };
 
-#if defined(CONFIG_NFS_V4_1)
-
 struct referring_call {
 	uint32_t			rc_sequenceid;
 	uint32_t			rc_slotid;
@@ -168,7 +166,6 @@ struct cb_notify_lock_args {
 
 extern __be32 nfs4_callback_notify_lock(void *argp, void *resp,
 					 struct cb_process_state *cps);
-#endif /* CONFIG_NFS_V4_1 */
 #ifdef CONFIG_NFS_V4_2
 struct cb_offloadargs {
 	struct nfs_fh		coa_fh;
diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 8397c43358bd..a63b97aabcbc 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -121,8 +121,6 @@ __be32 nfs4_callback_recall(void *argp, void *resp,
 	return res;
 }
 
-#if defined(CONFIG_NFS_V4_1)
-
 /*
  * Lookup a layout inode by stateid
  *
@@ -693,7 +691,6 @@ __be32 nfs4_callback_notify_lock(void *argp, void *resp,
 
 	return htonl(NFS4_OK);
 }
-#endif /* CONFIG_NFS_V4_1 */
 #ifdef CONFIG_NFS_V4_2
 static void nfs4_copy_cb_args(struct nfs4_copy_state *cp_state,
 				struct cb_offloadargs *args)
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 4254ba3ee7c5..c2fa4a91db26 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -30,7 +30,6 @@
 					 (2 + 2 + 3 + 3 + 3 + 3 + 3) * 4)
 #define CB_OP_RECALL_RES_MAXSZ		(CB_OP_HDR_RES_MAXSZ)
 
-#if defined(CONFIG_NFS_V4_1)
 #define CB_OP_LAYOUTRECALL_RES_MAXSZ	(CB_OP_HDR_RES_MAXSZ)
 #define CB_OP_DEVICENOTIFY_RES_MAXSZ	(CB_OP_HDR_RES_MAXSZ)
 #define CB_OP_SEQUENCE_RES_MAXSZ	(CB_OP_HDR_RES_MAXSZ + \
@@ -39,7 +38,6 @@
 #define CB_OP_RECALLANY_RES_MAXSZ	(CB_OP_HDR_RES_MAXSZ)
 #define CB_OP_RECALLSLOT_RES_MAXSZ	(CB_OP_HDR_RES_MAXSZ)
 #define CB_OP_NOTIFY_LOCK_RES_MAXSZ	(CB_OP_HDR_RES_MAXSZ)
-#endif /* CONFIG_NFS_V4_1 */
 #ifdef CONFIG_NFS_V4_2
 #define CB_OP_OFFLOAD_RES_MAXSZ		(CB_OP_HDR_RES_MAXSZ)
 #endif /* CONFIG_NFS_V4_2 */
@@ -205,7 +203,6 @@ static __be32 decode_recall_args(struct svc_rqst *rqstp,
 	return decode_fh(xdr, &args->fh);
 }
 
-#if defined(CONFIG_NFS_V4_1)
 static __be32 decode_layout_stateid(struct xdr_stream *xdr, nfs4_stateid *stateid)
 {
 	stateid->type = NFS4_LAYOUT_STATEID_TYPE;
@@ -521,7 +518,6 @@ static __be32 decode_notify_lock_args(struct svc_rqst *rqstp,
 	return decode_lockowner(xdr, args);
 }
 
-#endif /* CONFIG_NFS_V4_1 */
 #ifdef CONFIG_NFS_V4_2
 static __be32 decode_write_response(struct xdr_stream *xdr,
 					struct cb_offloadargs *args)
@@ -747,8 +743,6 @@ static __be32 encode_getattr_res(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	return status;
 }
 
-#if defined(CONFIG_NFS_V4_1)
-
 static __be32 encode_sessionid(struct xdr_stream *xdr,
 				 const struct nfs4_sessionid *sid)
 {
@@ -846,19 +840,6 @@ static void nfs4_cb_free_slot(struct cb_process_state *cps)
 	}
 }
 
-#else /* CONFIG_NFS_V4_1 */
-
-static __be32
-preprocess_nfs41_op(int nop, unsigned int op_nr, struct callback_op **op)
-{
-	return htonl(NFS4ERR_MINOR_VERS_MISMATCH);
-}
-
-static void nfs4_cb_free_slot(struct cb_process_state *cps)
-{
-}
-#endif /* CONFIG_NFS_V4_1 */
-
 #ifdef CONFIG_NFS_V4_2
 static __be32
 preprocess_nfs42_op(int nop, unsigned int op_nr, struct callback_op **op)
@@ -1051,7 +1032,6 @@ static struct callback_op callback_ops[] = {
 		.decode_args = decode_recall_args,
 		.res_maxsize = CB_OP_RECALL_RES_MAXSZ,
 	},
-#if defined(CONFIG_NFS_V4_1)
 	[OP_CB_LAYOUTRECALL] = {
 		.process_op = nfs4_callback_layoutrecall,
 		.decode_args = decode_layoutrecall_args,
@@ -1083,7 +1063,6 @@ static struct callback_op callback_ops[] = {
 		.decode_args = decode_notify_lock_args,
 		.res_maxsize = CB_OP_NOTIFY_LOCK_RES_MAXSZ,
 	},
-#endif /* CONFIG_NFS_V4_1 */
 #ifdef CONFIG_NFS_V4_2
 	[OP_CB_OFFLOAD] = {
 		.process_op = nfs4_callback_offload,
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 2aaea9c98c2c..4ed25285c8c4 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1263,11 +1263,9 @@ void nfs_clients_init(struct net *net)
 	INIT_LIST_HEAD(&nn->nfs_volume_list);
 #if IS_ENABLED(CONFIG_NFS_V4)
 	idr_init(&nn->cb_ident_idr);
-#endif
-#if IS_ENABLED(CONFIG_NFS_V4_1)
 	INIT_LIST_HEAD(&nn->nfs4_data_server_cache);
 	spin_lock_init(&nn->nfs4_data_server_lock);
-#endif
+#endif /* CONFIG_NFS_V4 */
 	spin_lock_init(&nn->nfs_client_lock);
 	nn->boot_time = ktime_get_real();
 	memset(&nn->rpcstats, 0, sizeof(nn->rpcstats));
@@ -1284,9 +1282,9 @@ void nfs_clients_exit(struct net *net)
 	nfs_cleanup_cb_ident_idr(net);
 	WARN_ON_ONCE(!list_empty(&nn->nfs_client_list));
 	WARN_ON_ONCE(!list_empty(&nn->nfs_volume_list));
-#if IS_ENABLED(CONFIG_NFS_V4_1)
+#if IS_ENABLED(CONFIG_NFS_V4)
 	WARN_ON_ONCE(!list_empty(&nn->nfs4_data_server_cache));
-#endif
+#endif /* CONFIG_NFS_V4 */
 }
 
 #ifdef CONFIG_PROC_FS
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index e99998e515c0..63e09dfc27a8 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -334,17 +334,13 @@ extern int nfs3_decode_dirent(struct xdr_stream *,
 #if IS_ENABLED(CONFIG_NFS_V4)
 extern int nfs4_decode_dirent(struct xdr_stream *,
 				struct nfs_entry *, bool);
-#endif
-#ifdef CONFIG_NFS_V4_1
 extern const u32 nfs41_maxread_overhead;
 extern const u32 nfs41_maxwrite_overhead;
 extern const u32 nfs41_maxgetdevinfo_overhead;
-#endif
 
 /* nfs4proc.c */
-#if IS_ENABLED(CONFIG_NFS_V4)
 extern const struct rpc_procinfo nfs4_procedures[];
-#endif
+#endif /* CONFIG_NFS_V4 */
 
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 extern struct nfs4_label *nfs4_label_alloc(struct nfs_server *server, gfp_t flags);
@@ -639,7 +635,7 @@ void nfs_pageio_stop_mirroring(struct nfs_pageio_descriptor *pgio);
 int nfs_filemap_write_and_wait_range(struct address_space *mapping,
 		loff_t lstart, loff_t lend);
 
-#ifdef CONFIG_NFS_V4_1
+#ifdef CONFIG_NFS_V4
 static inline void
 pnfs_bucket_clear_pnfs_ds_commit_verifiers(struct pnfs_commit_bucket *buckets,
 		unsigned int nbuckets)
@@ -660,12 +656,12 @@ void nfs_clear_pnfs_ds_commit_verifiers(struct pnfs_ds_commit_info *cinfo)
 				array->nbuckets);
 	rcu_read_unlock();
 }
-#else
+#else /* CONFIG_NFS_V4 */
 static inline
 void nfs_clear_pnfs_ds_commit_verifiers(struct pnfs_ds_commit_info *cinfo)
 {
 }
-#endif
+#endif /* CONFIG_NFS_V4 */
 
 #ifdef CONFIG_MIGRATION
 int nfs_migrate_folio(struct address_space *, struct folio *dst,
diff --git a/fs/nfs/netns.h b/fs/nfs/netns.h
index 6ba3ea39e928..36658579100d 100644
--- a/fs/nfs/netns.h
+++ b/fs/nfs/netns.h
@@ -31,11 +31,9 @@ struct nfs_net {
 	unsigned short nfs_callback_tcpport;
 	unsigned short nfs_callback_tcpport6;
 	int cb_users[NFS4_MAX_MINOR_VERSION + 1];
-#endif /* CONFIG_NFS_V4 */
-#if IS_ENABLED(CONFIG_NFS_V4_1)
 	struct list_head nfs4_data_server_cache;
 	spinlock_t nfs4_data_server_lock;
-#endif /* CONFIG_NFS_V4_1 */
+#endif /* CONFIG_NFS_V4 */
 	struct nfs_netns_client *nfs_client;
 	spinlock_t nfs_client_lock;
 	ktime_t boot_time;
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 5a6728acb589..783df6901b84 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -18,10 +18,8 @@
 
 #if defined(CONFIG_NFS_V4_2)
 #define NFS4_MAX_MINOR_VERSION 2
-#elif defined(CONFIG_NFS_V4_1)
+#else
 #define NFS4_MAX_MINOR_VERSION 1
-#else
-#define NFS4_MAX_MINOR_VERSION 0
 #endif
 
 #if IS_ENABLED(CONFIG_NFS_V4)
@@ -383,7 +381,6 @@ extern bool nfs4_match_stateid(const nfs4_stateid *s1, const nfs4_stateid *s2);
 extern int nfs4_find_root_sec(struct nfs_server *server, struct nfs_fh *fhandle,
 			      struct nfs_fattr *fattr);
 
-#if defined(CONFIG_NFS_V4_1)
 extern int nfs41_sequence_done(struct rpc_task *, struct nfs4_sequence_res *);
 extern int nfs4_proc_create_session(struct nfs_client *, const struct cred *);
 extern int nfs4_proc_destroy_session(struct nfs4_session *, const struct cred *);
@@ -461,31 +458,6 @@ nfs4_state_protect_write(struct nfs_client *clp, struct rpc_clnt **clntp,
 	    !test_bit(NFS_SP4_MACH_CRED_COMMIT, &clp->cl_sp4_flags))
 		hdr->args.stable = NFS_FILE_SYNC;
 }
-#else /* CONFIG_NFS_v4_1 */
-static inline bool
-is_ds_only_client(struct nfs_client *clp)
-{
-	return false;
-}
-
-static inline bool
-is_ds_client(struct nfs_client *clp)
-{
-	return false;
-}
-
-static inline void
-nfs4_state_protect(struct nfs_client *clp, unsigned long sp4_flags,
-		   struct rpc_clnt **clntp, struct rpc_message *msg)
-{
-}
-
-static inline void
-nfs4_state_protect_write(struct nfs_client *clp, struct rpc_clnt **clntp,
-			 struct rpc_message *msg, struct nfs_pgio_header *hdr)
-{
-}
-#endif /* CONFIG_NFS_V4_1 */
 
 extern const struct nfs4_minor_version_ops *nfs_v4_minor_ops[];
 
@@ -518,18 +490,12 @@ int nfs4_discover_server_trunking(struct nfs_client *clp,
 			struct nfs_client **);
 int nfs40_discover_server_trunking(struct nfs_client *clp,
 			struct nfs_client **, const struct cred *);
-#if defined(CONFIG_NFS_V4_1)
 int nfs41_discover_server_trunking(struct nfs_client *clp,
 			struct nfs_client **, const struct cred *);
 extern void nfs4_schedule_session_recovery(struct nfs4_session *, int);
 extern void nfs41_notify_server(struct nfs_client *);
 bool nfs4_check_serverowner_major_id(struct nfs41_server_owner *o1,
 			struct nfs41_server_owner *o2);
-#else
-static inline void nfs4_schedule_session_recovery(struct nfs4_session *session, int err)
-{
-}
-#endif /* CONFIG_NFS_V4_1 */
 
 extern struct nfs4_state_owner *nfs4_get_state_owner(struct nfs_server *, const struct cred *, gfp_t);
 extern void nfs4_put_state_owner(struct nfs4_state_owner *);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 00b57e55aba8..51cf4a37d652 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -44,7 +44,6 @@ static int nfs_get_cb_ident_idr(struct nfs_client *clp, int minorversion)
 	return ret < 0 ? ret : 0;
 }
 
-#ifdef CONFIG_NFS_V4_1
 /*
  * Per auth flavor data server rpc clients
  */
@@ -187,7 +186,6 @@ void nfs41_shutdown_client(struct nfs_client *clp)
 	}
 
 }
-#endif	/* CONFIG_NFS_V4_1 */
 
 struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 {
@@ -217,9 +215,7 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 	clp->cl_mvops = nfs_v4_minor_ops[cl_init->minorversion];
 	clp->cl_mig_gen = 1;
 	clp->cl_last_renewal = jiffies;
-#if IS_ENABLED(CONFIG_NFS_V4_1)
 	init_waitqueue_head(&clp->cl_lock_waitq);
-#endif
 	INIT_LIST_HEAD(&clp->pending_cb_stateids);
 
 	if (cl_init->minorversion != 0)
@@ -332,8 +328,6 @@ static int nfs4_init_callback(struct nfs_client *clp)
 	return 0;
 }
 
-#if defined(CONFIG_NFS_V4_1)
-
 /**
  * nfs41_init_client - nfs_client initialization tasks for NFSv4.1+
  * @clp: nfs_client to initialize
@@ -365,8 +359,6 @@ int nfs41_init_client(struct nfs_client *clp)
 	return 0;
 }
 
-#endif	/* CONFIG_NFS_V4_1 */
-
 /*
  * Initialize the minor version specific parts of an NFS4 client record
  */
@@ -508,7 +500,6 @@ int nfs4_match_client(struct nfs_client  *pos,  struct nfs_client *new,
 	return 0;
 }
 
-#ifdef CONFIG_NFS_V4_1
 /*
  * Returns true if the server major ids match
  */
@@ -637,7 +628,6 @@ int nfs41_walk_client_list(struct nfs_client *new,
 	nfs_put_client(prev);
 	return status;
 }
-#endif	/* CONFIG_NFS_V4_1 */
 
 static void nfs4_destroy_server(struct nfs_server *server)
 {
@@ -669,7 +659,6 @@ nfs4_find_client_ident(struct net *net, int cb_ident)
 	return clp;
 }
 
-#if defined(CONFIG_NFS_V4_1)
 /* Common match routine for v4.0 and v4.1 callback services */
 static bool nfs4_cb_match_client(const struct sockaddr *addr,
 		struct nfs_client *clp, u32 minorversion)
@@ -727,16 +716,6 @@ nfs4_find_client_sessionid(struct net *net, const struct sockaddr *addr,
 	return NULL;
 }
 
-#else /* CONFIG_NFS_V4_1 */
-
-struct nfs_client *
-nfs4_find_client_sessionid(struct net *net, const struct sockaddr *addr,
-			   struct nfs4_sessionid *sid, u32 minorversion)
-{
-	return NULL;
-}
-#endif /* CONFIG_NFS_V4_1 */
-
 /*
  * Set up an NFS4 client
  */
@@ -878,7 +857,6 @@ EXPORT_SYMBOL_GPL(nfs4_set_ds_client);
  */
 static void nfs4_session_limit_rwsize(struct nfs_server *server)
 {
-#ifdef CONFIG_NFS_V4_1
 	struct nfs4_session *sess;
 	u32 server_resp_sz;
 	u32 server_rqst_sz;
@@ -895,7 +873,6 @@ static void nfs4_session_limit_rwsize(struct nfs_server *server)
 		server->rsize = server_resp_sz;
 	if (server->wsize > server_rqst_sz)
 		server->wsize = server_rqst_sz;
-#endif /* CONFIG_NFS_V4_1 */
 }
 
 /*
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7ff036afb0e3..ed79f5fe451a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -99,7 +99,6 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 static int nfs4_do_setattr(struct inode *inode, const struct cred *cred,
 			    struct nfs_fattr *fattr, struct iattr *sattr,
 			    struct nfs_open_context *ctx, struct nfs4_label *ilabel);
-#ifdef CONFIG_NFS_V4_1
 static struct rpc_task *_nfs41_proc_sequence(struct nfs_client *clp,
 		const struct cred *cred,
 		struct nfs4_slot *slot,
@@ -108,7 +107,6 @@ static int nfs41_test_stateid(struct nfs_server *, const nfs4_stateid *,
 			      const struct cred *);
 static int nfs41_free_stateid(struct nfs_server *, nfs4_stateid *,
 			      const struct cred *, bool);
-#endif
 
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 static inline struct nfs4_label *
@@ -569,7 +567,6 @@ static int nfs4_do_handle_exception(struct nfs_server *server,
 		case -NFS4ERR_LEASE_MOVED:
 			nfs4_schedule_lease_moved_recovery(clp);
 			goto wait_on_recovery;
-#if defined(CONFIG_NFS_V4_1)
 		case -NFS4ERR_BADSESSION:
 		case -NFS4ERR_BADSLOT:
 		case -NFS4ERR_BAD_HIGH_SLOT:
@@ -579,7 +576,6 @@ static int nfs4_do_handle_exception(struct nfs_server *server,
 		case -NFS4ERR_SEQ_MISORDERED:
 			/* Handled in nfs41_sequence_process() */
 			goto wait_on_recovery;
-#endif /* defined(CONFIG_NFS_V4_1) */
 		case -NFS4ERR_FILE_OPEN:
 			if (exception->timeout > HZ) {
 				/* We have retried a decent amount, time to
@@ -783,8 +779,6 @@ void nfs4_init_sequence(struct nfs_client *clp,
 	res->sr_slot_ops = clp->cl_mvops->sequence_slot_ops;
 }
 
-#if defined(CONFIG_NFS_V4_1)
-
 static void nfs41_release_slot(struct nfs4_slot *slot)
 {
 	struct nfs4_session *session;
@@ -1022,8 +1016,6 @@ static const struct rpc_call_ops nfs41_call_sync_ops = {
 };
 
 
-#endif	/* !CONFIG_NFS_V4_1 */
-
 static void nfs41_sequence_res_init(struct nfs4_sequence_res *res)
 {
 	res->sr_timestamp = jiffies;
@@ -1577,7 +1569,6 @@ static void update_open_stateflags(struct nfs4_state *state, fmode_t fmode)
 	nfs4_state_set_mode_locked(state, state->state | fmode);
 }
 
-#ifdef CONFIG_NFS_V4_1
 static bool nfs_open_stateid_recover_openmode(struct nfs4_state *state)
 {
 	if (state->n_rdonly && !test_bit(NFS_O_RDONLY_STATE, &state->flags))
@@ -1588,7 +1579,6 @@ static bool nfs_open_stateid_recover_openmode(struct nfs4_state *state)
 		return true;
 	return false;
 }
-#endif /* CONFIG_NFS_V4_1 */
 
 static void nfs_state_log_update_open_stateid(struct nfs4_state *state)
 {
@@ -2837,7 +2827,6 @@ void nfs_finish_clear_delegation_stateid(struct nfs4_state *state,
 	nfs_state_clear_delegation(state);
 }
 
-#if defined(CONFIG_NFS_V4_1)
 static int nfs41_test_and_free_expired_stateid(struct nfs_server *server,
 					       nfs4_stateid *stateid, const struct cred *cred)
 {
@@ -3022,7 +3011,6 @@ static int nfs41_open_expired(struct nfs4_state_owner *sp, struct nfs4_state *st
 		status = nfs4_open_expired(sp, state);
 	return status;
 }
-#endif
 
 /*
  * on an EXCLUSIVE create, the server should send back a bitmask with FATTR4-*
@@ -4384,7 +4372,6 @@ static int nfs4_get_referral(struct rpc_clnt *client, struct inode *dir,
 	return status;
 }
 
-#if IS_ENABLED(CONFIG_NFS_V4_1)
 static bool should_request_dir_deleg(struct inode *inode)
 {
 	if (!directory_delegations)
@@ -4401,12 +4388,6 @@ static bool should_request_dir_deleg(struct inode *inode)
 		return false;
 	return true;
 }
-#else
-static bool should_request_dir_deleg(struct inode *inode)
-{
-	return false;
-}
-#endif /* CONFIG_NFS_V4_1 */
 
 static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 				struct nfs_fattr *fattr, struct inode *inode)
@@ -7521,7 +7502,6 @@ int nfs4_lock_expired(struct nfs4_state *state, struct file_lock *request)
 	return err;
 }
 
-#if defined(CONFIG_NFS_V4_1)
 static int nfs41_lock_expired(struct nfs4_state *state, struct file_lock *request)
 {
 	struct nfs4_lock_state *lsp;
@@ -7536,7 +7516,6 @@ static int nfs41_lock_expired(struct nfs4_state *state, struct file_lock *reques
 		return 0;
 	return nfs4_lock_expired(state, request);
 }
-#endif
 
 static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock *request)
 {
@@ -7610,7 +7589,6 @@ nfs4_retry_setlk_simple(struct nfs4_state *state, int cmd,
 	return status;
 }
 
-#ifdef CONFIG_NFS_V4_1
 struct nfs4_lock_waiter {
 	struct inode		*inode;
 	struct nfs_lowner	owner;
@@ -7678,13 +7656,6 @@ nfs4_retry_setlk(struct nfs4_state *state, int cmd, struct file_lock *request)
 
 	return status;
 }
-#else /* !CONFIG_NFS_V4_1 */
-static inline int
-nfs4_retry_setlk(struct nfs4_state *state, int cmd, struct file_lock *request)
-{
-	return nfs4_retry_setlk_simple(state, cmd, request);
-}
-#endif
 
 static int
 nfs4_proc_lock(struct file *filp, int cmd, struct file_lock *request)
@@ -7817,7 +7788,6 @@ static bool nfs4_xattr_list_nfs4_acl(struct dentry *dentry)
 	return nfs4_server_supports_acls(NFS_SB(dentry->d_sb), NFS4ACL_ACL);
 }
 
-#if defined(CONFIG_NFS_V4_1)
 #define XATTR_NAME_NFSV4_DACL "system.nfs4_dacl"
 
 static int nfs4_xattr_set_nfs4_dacl(const struct xattr_handler *handler,
@@ -7864,8 +7834,6 @@ static bool nfs4_xattr_list_nfs4_sacl(struct dentry *dentry)
 	return nfs4_server_supports_acls(NFS_SB(dentry->d_sb), NFS4ACL_SACL);
 }
 
-#endif
-
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 
 static int nfs4_xattr_set_nfs4_label(const struct xattr_handler *handler,
@@ -8125,8 +8093,6 @@ int nfs4_proc_fs_locations(struct rpc_clnt *client, struct inode *dir,
 	return err;
 }
 
-#ifdef CONFIG_NFS_V4_1
-
 /*
  * This operation also signals the server that this client is
  * performing migration recovery.  The server can stop asserting
@@ -8189,8 +8155,6 @@ static int _nfs41_proc_get_locations(struct nfs_server *server,
 	return status;
 }
 
-#endif	/* CONFIG_NFS_V4_1 */
-
 /**
  * nfs4_proc_get_locations - discover locations for a migrated FSID
  * @server: pointer to nfs_server to process
@@ -8238,8 +8202,6 @@ int nfs4_proc_get_locations(struct nfs_server *server,
 	return status;
 }
 
-#ifdef CONFIG_NFS_V4_1
-
 /*
  * This operation also signals the server that this client is
  * performing "lease moved" recovery.  The server can stop asserting
@@ -8278,8 +8240,6 @@ static int _nfs41_proc_fsid_present(struct inode *inode, const struct cred *cred
 	return status;
 }
 
-#endif	/* CONFIG_NFS_V4_1 */
-
 /**
  * nfs4_proc_fsid_present - Is this FSID present or absent on server?
  * @inode: inode on FSID to check
@@ -8408,7 +8368,6 @@ int nfs4_proc_secinfo(struct inode *dir, const struct qstr *name,
 	return err;
 }
 
-#ifdef CONFIG_NFS_V4_1
 /*
  * Check the exchange flags returned by the server for invalid flags, having
  * both PNFS and NON_PNFS flags set, and not having one of NON_PNFS, PNFS, or
@@ -9021,8 +8980,6 @@ int nfs4_destroy_clientid(struct nfs_client *clp)
 	return ret;
 }
 
-#endif /* CONFIG_NFS_V4_1 */
-
 struct nfs4_get_lease_time_data {
 	struct nfs4_get_lease_time_args *args;
 	struct nfs4_get_lease_time_res *res;
@@ -9099,8 +9056,6 @@ int nfs4_proc_get_lease_time(struct nfs_client *clp, struct nfs_fsinfo *fsinfo)
 	return nfs4_call_sync_custom(&task_setup);
 }
 
-#ifdef CONFIG_NFS_V4_1
-
 /*
  * Initialize the values to be used by the client in CREATE_SESSION
  * If nfs4_init_session set the fore channel request and response sizes,
@@ -10439,8 +10394,6 @@ static bool nfs41_match_stateid(const nfs4_stateid *s1,
 	return s1->seqid == 0 || s2->seqid == 0;
 }
 
-#endif /* CONFIG_NFS_V4_1 */
-
 bool nfs4_match_stateid(const nfs4_stateid *s1,
 		const nfs4_stateid *s2)
 {
@@ -10450,7 +10403,6 @@ bool nfs4_match_stateid(const nfs4_stateid *s1,
 }
 
 
-#if defined(CONFIG_NFS_V4_1)
 static const struct nfs4_sequence_slot_ops nfs41_sequence_slot_ops = {
 	.process = nfs41_sequence_process,
 	.done = nfs41_sequence_done,
@@ -10517,7 +10469,6 @@ static const struct nfs4_minor_version_ops nfs_v4_1_minor_ops = {
 	.state_renewal_ops = &nfs41_state_renewal_ops,
 	.mig_recovery_ops = &nfs41_mig_recovery_ops,
 };
-#endif
 
 #if defined(CONFIG_NFS_V4_2)
 static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
@@ -10563,9 +10514,7 @@ const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
 #if defined(CONFIG_NFS_V4_0)
 	[0] = &nfs_v4_0_minor_ops,
 #endif /* CONFIG_NFS_V4_0 */
-#if defined(CONFIG_NFS_V4_1)
 	[1] = &nfs_v4_1_minor_ops,
-#endif
 #if defined(CONFIG_NFS_V4_2)
 	[2] = &nfs_v4_2_minor_ops,
 #endif
@@ -10744,7 +10693,6 @@ static const struct xattr_handler nfs4_xattr_nfs4_acl_handler = {
 	.set	= nfs4_xattr_set_nfs4_acl,
 };
 
-#if defined(CONFIG_NFS_V4_1)
 static const struct xattr_handler nfs4_xattr_nfs4_dacl_handler = {
 	.name	= XATTR_NAME_NFSV4_DACL,
 	.list	= nfs4_xattr_list_nfs4_dacl,
@@ -10758,7 +10706,6 @@ static const struct xattr_handler nfs4_xattr_nfs4_sacl_handler = {
 	.get	= nfs4_xattr_get_nfs4_sacl,
 	.set	= nfs4_xattr_set_nfs4_sacl,
 };
-#endif
 
 #ifdef CONFIG_NFS_V4_2
 static const struct xattr_handler nfs4_xattr_nfs4_user_handler = {
@@ -10770,10 +10717,8 @@ static const struct xattr_handler nfs4_xattr_nfs4_user_handler = {
 
 const struct xattr_handler * const nfs4_xattr_handlers[] = {
 	&nfs4_xattr_nfs4_acl_handler,
-#if defined(CONFIG_NFS_V4_1)
 	&nfs4_xattr_nfs4_dacl_handler,
 	&nfs4_xattr_nfs4_sacl_handler,
-#endif
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 	&nfs4_xattr_nfs4_label_handler,
 #endif
diff --git a/fs/nfs/nfs4session.c b/fs/nfs/nfs4session.c
index 5db460476bf2..a2fdd4b80dc4 100644
--- a/fs/nfs/nfs4session.c
+++ b/fs/nfs/nfs4session.c
@@ -408,8 +408,6 @@ void nfs41_wake_slot_table(struct nfs4_slot_table *tbl)
 	}
 }
 
-#if defined(CONFIG_NFS_V4_1)
-
 static void nfs41_set_max_slotid_locked(struct nfs4_slot_table *tbl,
 		u32 target_highest_slotid)
 {
@@ -653,5 +651,3 @@ int nfs4_init_ds_session(struct nfs_client *clp, unsigned long lease_time)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nfs4_init_ds_session);
-
-#endif	/* defined(CONFIG_NFS_V4_1) */
diff --git a/fs/nfs/nfs4session.h b/fs/nfs/nfs4session.h
index f9c291e2165c..d2569f599977 100644
--- a/fs/nfs/nfs4session.h
+++ b/fs/nfs/nfs4session.h
@@ -111,7 +111,6 @@ static inline struct nfs4_session *nfs4_get_session(const struct nfs_client *clp
 	return clp->cl_session;
 }
 
-#if defined(CONFIG_NFS_V4_1)
 extern void nfs41_set_target_slotid(struct nfs4_slot_table *tbl,
 		u32 target_highest_slotid);
 extern void nfs41_update_target_slotid(struct nfs4_slot_table *tbl,
@@ -154,28 +153,6 @@ static inline void nfs4_copy_sessionid(struct nfs4_sessionid *dst,
  */
 #define nfs_session_id_hash(sess_id) \
 	(~crc32_le(0xFFFFFFFF, &(sess_id)->data[0], sizeof((sess_id)->data)))
-#else /* defined(CONFIG_NFS_V4_1) */
 
-static inline int nfs4_init_session(struct nfs_client *clp)
-{
-	return 0;
-}
-
-/*
- * Determine if sessions are in use.
- */
-static inline int nfs4_has_session(const struct nfs_client *clp)
-{
-	return 0;
-}
-
-static inline int nfs4_has_persistent_session(const struct nfs_client *clp)
-{
-	return 0;
-}
-
-#define nfs_session_id_hash(session) (0)
-
-#endif /* defined(CONFIG_NFS_V4_1) */
 #endif /* IS_ENABLED(CONFIG_NFS_V4) */
 #endif /* __LINUX_FS_NFS_NFS4SESSION_H */
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index fe7c0d7cdace..2e8f6a8cac50 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -259,8 +259,6 @@ static int nfs4_begin_drain_session(struct nfs_client *clp)
 	return nfs4_drain_slot_tbl(&ses->fc_slot_table);
 }
 
-#if defined(CONFIG_NFS_V4_1)
-
 static void nfs41_finish_session_reset(struct nfs_client *clp)
 {
 	clear_bit(NFS4CLNT_LEASE_CONFIRM, &clp->cl_state);
@@ -339,8 +337,6 @@ int nfs41_discover_server_trunking(struct nfs_client *clp,
 	return status;
 }
 
-#endif /* CONFIG_NFS_V4_1 */
-
 /**
  * nfs4_get_clid_cred - Acquire credential for a setclientid operation
  * @clp: client state handle
@@ -2306,7 +2302,6 @@ int nfs4_discover_server_trunking(struct nfs_client *clp,
 	return status;
 }
 
-#ifdef CONFIG_NFS_V4_1
 void nfs4_schedule_session_recovery(struct nfs4_session *session, int err)
 {
 	struct nfs_client *clp = session->clp;
@@ -2513,18 +2508,6 @@ static void nfs4_layoutreturn_any_run(struct nfs_client *clp)
 		set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
 	}
 }
-#else /* CONFIG_NFS_V4_1 */
-static int nfs4_reset_session(struct nfs_client *clp) { return 0; }
-
-static int nfs4_bind_conn_to_session(struct nfs_client *clp)
-{
-	return 0;
-}
-
-static void nfs4_layoutreturn_any_run(struct nfs_client *clp)
-{
-}
-#endif /* CONFIG_NFS_V4_1 */
 
 static void nfs4_state_manager(struct nfs_client *clp)
 {
diff --git a/fs/nfs/nfs4trace.c b/fs/nfs/nfs4trace.c
index 987c92d6364b..3fdc013f56d8 100644
--- a/fs/nfs/nfs4trace.c
+++ b/fs/nfs/nfs4trace.c
@@ -14,7 +14,6 @@
 #define CREATE_TRACE_POINTS
 #include "nfs4trace.h"
 
-#ifdef CONFIG_NFS_V4_1
 EXPORT_TRACEPOINT_SYMBOL_GPL(nfs4_pnfs_read);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nfs4_pnfs_write);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nfs4_pnfs_commit_ds);
@@ -39,4 +38,3 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_unreg);
 EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_unreg_err);
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(fl_getdevinfo);
-#endif
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 6285128e631a..71df432931d3 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -71,7 +71,6 @@ DEFINE_NFS4_CLIENTID_EVENT(nfs4_setclientid);
 DEFINE_NFS4_CLIENTID_EVENT(nfs4_setclientid_confirm);
 DEFINE_NFS4_CLIENTID_EVENT(nfs4_renew);
 DEFINE_NFS4_CLIENTID_EVENT(nfs4_renew_async);
-#ifdef CONFIG_NFS_V4_1
 DEFINE_NFS4_CLIENTID_EVENT(nfs4_exchange_id);
 DEFINE_NFS4_CLIENTID_EVENT(nfs4_create_session);
 DEFINE_NFS4_CLIENTID_EVENT(nfs4_destroy_session);
@@ -302,8 +301,6 @@ TRACE_EVENT(pnfs_ds_connect,
                 )
 );
 
-#endif /* CONFIG_NFS_V4_1 */
-
 TRACE_EVENT(nfs4_setup_sequence,
 		TP_PROTO(
 			const struct nfs4_session *session,
@@ -1070,7 +1067,6 @@ TRACE_EVENT(nfs4_delegreturn_exit,
 		)
 );
 
-#ifdef CONFIG_NFS_V4_1
 DECLARE_EVENT_CLASS(nfs4_test_stateid_event,
 		TP_PROTO(
 			const struct nfs4_state *state,
@@ -1125,7 +1121,6 @@ DECLARE_EVENT_CLASS(nfs4_test_stateid_event,
 DEFINE_NFS4_TEST_STATEID_EVENT(nfs4_test_delegation_stateid);
 DEFINE_NFS4_TEST_STATEID_EVENT(nfs4_test_open_stateid);
 DEFINE_NFS4_TEST_STATEID_EVENT(nfs4_test_lock_stateid);
-#endif /* CONFIG_NFS_V4_1 */
 
 DECLARE_EVENT_CLASS(nfs4_lookup_event,
 		TP_PROTO(
@@ -1628,12 +1623,8 @@ DEFINE_NFS4_IDMAP_EVENT(nfs4_map_group_to_gid);
 DEFINE_NFS4_IDMAP_EVENT(nfs4_map_uid_to_name);
 DEFINE_NFS4_IDMAP_EVENT(nfs4_map_gid_to_group);
 
-#ifdef CONFIG_NFS_V4_1
 #define NFS4_LSEG_LAYOUT_STATEID_HASH(lseg) \
 	(lseg ? nfs_stateid_hash(&lseg->pls_layout->plh_stateid) : 0)
-#else
-#define NFS4_LSEG_LAYOUT_STATEID_HASH(lseg) (0)
-#endif
 
 DECLARE_EVENT_CLASS(nfs4_read_event,
 		TP_PROTO(
@@ -1705,9 +1696,7 @@ DECLARE_EVENT_CLASS(nfs4_read_event,
 			), \
 			TP_ARGS(hdr, error))
 DEFINE_NFS4_READ_EVENT(nfs4_read);
-#ifdef CONFIG_NFS_V4_1
 DEFINE_NFS4_READ_EVENT(nfs4_pnfs_read);
-#endif /* CONFIG_NFS_V4_1 */
 
 DECLARE_EVENT_CLASS(nfs4_write_event,
 		TP_PROTO(
@@ -1780,9 +1769,7 @@ DECLARE_EVENT_CLASS(nfs4_write_event,
 			), \
 			TP_ARGS(hdr, error))
 DEFINE_NFS4_WRITE_EVENT(nfs4_write);
-#ifdef CONFIG_NFS_V4_1
 DEFINE_NFS4_WRITE_EVENT(nfs4_pnfs_write);
-#endif /* CONFIG_NFS_V4_1 */
 
 DECLARE_EVENT_CLASS(nfs4_commit_event,
 		TP_PROTO(
@@ -1842,7 +1829,6 @@ DECLARE_EVENT_CLASS(nfs4_commit_event,
 			), \
 			TP_ARGS(data, error))
 DEFINE_NFS4_COMMIT_EVENT(nfs4_commit);
-#ifdef CONFIG_NFS_V4_1
 DEFINE_NFS4_COMMIT_EVENT(nfs4_pnfs_commit_ds);
 
 TRACE_EVENT(nfs4_layoutget,
@@ -2876,8 +2862,6 @@ DEFINE_NFS4_XATTR_EVENT(nfs4_removexattr);
 DEFINE_NFS4_INODE_EVENT(nfs4_listxattr);
 #endif /* CONFIG_NFS_V4_2 */
 
-#endif /* CONFIG_NFS_V4_1 */
-
 #endif /* _TRACE_NFS4_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index b6fe30577fab..bb91f083f69e 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -308,7 +308,6 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 #define encode_secinfo_maxsz	(op_encode_hdr_maxsz + nfs4_name_maxsz)
 #define decode_secinfo_maxsz	(op_decode_hdr_maxsz + 1 + ((NFS_MAX_SECFLAVORS * (16 + GSS_OID_MAX_LEN)) / 4))
 
-#if defined(CONFIG_NFS_V4_1)
 #define NFS4_MAX_MACHINE_NAME_LEN (64)
 #define IMPL_NAME_LIMIT (sizeof(utsname()->sysname) + sizeof(utsname()->release) + \
 			 sizeof(utsname()->version) + sizeof(utsname()->machine) + 8)
@@ -455,16 +454,6 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 #define encode_free_stateid_maxsz	(op_encode_hdr_maxsz + 1 + \
 					 XDR_QUADLEN(NFS4_STATEID_SIZE))
 #define decode_free_stateid_maxsz	(op_decode_hdr_maxsz)
-#else /* CONFIG_NFS_V4_1 */
-#define encode_sequence_maxsz	0
-#define decode_sequence_maxsz	0
-#define encode_get_dir_deleg_maxsz 0
-#define decode_get_dir_deleg_maxsz 0
-#define encode_layoutreturn_maxsz 0
-#define decode_layoutreturn_maxsz 0
-#define encode_layoutget_maxsz	0
-#define decode_layoutget_maxsz	0
-#endif /* CONFIG_NFS_V4_1 */
 
 #define NFS4_enc_compound_sz	(1024)  /* XXX: large enough? */
 #define NFS4_dec_compound_sz	(1024)  /* XXX: large enough? */
@@ -838,7 +827,6 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 				 decode_putfh_maxsz + \
 				 decode_getfh_maxsz + \
 				 decode_renew_maxsz)
-#if defined(CONFIG_NFS_V4_1)
 #define NFS4_enc_bind_conn_to_session_sz \
 				(compound_encode_hdr_maxsz + \
 				 encode_bind_conn_to_session_maxsz)
@@ -871,7 +859,6 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 #define NFS4_dec_sequence_sz \
 				(compound_decode_hdr_maxsz + \
 				 decode_sequence_maxsz)
-#endif
 #define NFS4_enc_get_lease_time_sz	(compound_encode_hdr_maxsz + \
 					 encode_sequence_maxsz + \
 					 encode_putrootfh_maxsz + \
@@ -880,7 +867,6 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 					 decode_sequence_maxsz + \
 					 decode_putrootfh_maxsz + \
 					 decode_fsinfo_maxsz)
-#if defined(CONFIG_NFS_V4_1)
 #define NFS4_enc_reclaim_complete_sz	(compound_encode_hdr_maxsz + \
 					 encode_sequence_maxsz + \
 					 encode_reclaim_complete_maxsz)
@@ -958,7 +944,6 @@ const u32 nfs41_maxgetdevinfo_overhead = ((RPC_MAX_REPHEADER_WITH_AUTH +
 					   decode_sequence_maxsz) *
 					  XDR_UNIT);
 EXPORT_SYMBOL_GPL(nfs41_maxgetdevinfo_overhead);
-#endif /* CONFIG_NFS_V4_1 */
 
 static const umode_t nfs_type2fmt[] = {
 	[NF4BAD] = 0,
@@ -1832,7 +1817,6 @@ static void encode_secinfo(struct xdr_stream *xdr, const struct qstr *name, stru
 	encode_string(xdr, name->len, name->name);
 }
 
-#if defined(CONFIG_NFS_V4_1)
 /* NFSv4.1 operations */
 static void encode_bind_conn_to_session(struct xdr_stream *xdr,
 				   const struct nfs41_bind_conn_to_session_args *args,
@@ -1984,13 +1968,11 @@ static void encode_reclaim_complete(struct xdr_stream *xdr,
 	encode_op_hdr(xdr, OP_RECLAIM_COMPLETE, decode_reclaim_complete_maxsz, hdr);
 	encode_uint32(xdr, args->one_fs);
 }
-#endif /* CONFIG_NFS_V4_1 */
 
 static void encode_sequence(struct xdr_stream *xdr,
 			    const struct nfs4_sequence_args *args,
 			    struct compound_hdr *hdr)
 {
-#if defined(CONFIG_NFS_V4_1)
 	struct nfs4_session *session;
 	struct nfs4_slot_table *tp;
 	struct nfs4_slot *slot = args->sa_slot;
@@ -2021,10 +2003,8 @@ static void encode_sequence(struct xdr_stream *xdr,
 	*p++ = cpu_to_be32(slot->slot_nr);
 	*p++ = cpu_to_be32(tp->highest_used_slotid);
 	*p = cpu_to_be32(args->sa_cache_this);
-#endif /* CONFIG_NFS_V4_1 */
 }
 
-#ifdef CONFIG_NFS_V4_1
 static void
 encode_get_dir_delegation(struct xdr_stream *xdr, struct compound_hdr *hdr)
 {
@@ -2186,26 +2166,6 @@ static void encode_free_stateid(struct xdr_stream *xdr,
 	encode_op_hdr(xdr, OP_FREE_STATEID, decode_free_stateid_maxsz, hdr);
 	encode_nfs4_stateid(xdr, &args->stateid);
 }
-#else
-static inline void
-encode_get_dir_delegation(struct xdr_stream *xdr, struct compound_hdr *hdr)
-{
-}
-
-static inline void
-encode_layoutreturn(struct xdr_stream *xdr,
-		    const struct nfs4_layoutreturn_args *args,
-		    struct compound_hdr *hdr)
-{
-}
-
-static void
-encode_layoutget(struct xdr_stream *xdr,
-		      const struct nfs4_layoutget_args *args,
-		      struct compound_hdr *hdr)
-{
-}
-#endif /* CONFIG_NFS_V4_1 */
 
 /*
  * END OF "GENERIC" ENCODE ROUTINES.
@@ -2213,11 +2173,9 @@ encode_layoutget(struct xdr_stream *xdr,
 
 static u32 nfs4_xdr_minorversion(const struct nfs4_sequence_args *args)
 {
-#if defined(CONFIG_NFS_V4_1)
 	struct nfs4_session *session = args->sa_slot->table->session;
 	if (session)
 		return session->clp->cl_mvops->minor_version;
-#endif /* CONFIG_NFS_V4_1 */
 	return 0;
 }
 
@@ -2971,7 +2929,6 @@ static void nfs4_xdr_enc_fsid_present(struct rpc_rqst *req,
 	encode_nops(&hdr);
 }
 
-#if defined(CONFIG_NFS_V4_1)
 /*
  * BIND_CONN_TO_SESSION request
  */
@@ -3073,8 +3030,6 @@ static void nfs4_xdr_enc_sequence(struct rpc_rqst *req, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
 
-#endif
-
 /*
  * a GET_LEASE_TIME request
  */
@@ -3095,8 +3050,6 @@ static void nfs4_xdr_enc_get_lease_time(struct rpc_rqst *req,
 	encode_nops(&hdr);
 }
 
-#ifdef CONFIG_NFS_V4_1
-
 /*
  * a RECLAIM_COMPLETE request
  */
@@ -3259,7 +3212,6 @@ static void nfs4_xdr_enc_free_stateid(struct rpc_rqst *req,
 	encode_free_stateid(xdr, args, &hdr);
 	encode_nops(&hdr);
 }
-#endif /* CONFIG_NFS_V4_1 */
 
 static int decode_opaque_inline(struct xdr_stream *xdr, unsigned int *len, char **string)
 {
@@ -5756,7 +5708,6 @@ static int decode_secinfo(struct xdr_stream *xdr, struct nfs4_secinfo_res *res)
 	return decode_secinfo_common(xdr, res);
 }
 
-#if defined(CONFIG_NFS_V4_1)
 static int decode_secinfo_no_name(struct xdr_stream *xdr, struct nfs4_secinfo_res *res)
 {
 	int status = decode_op_hdr(xdr, OP_SECINFO_NO_NAME);
@@ -5968,13 +5919,11 @@ static int decode_reclaim_complete(struct xdr_stream *xdr, void *dummy)
 {
 	return decode_op_hdr(xdr, OP_RECLAIM_COMPLETE);
 }
-#endif /* CONFIG_NFS_V4_1 */
 
 static int decode_sequence(struct xdr_stream *xdr,
 			   struct nfs4_sequence_res *res,
 			   struct rpc_rqst *rqstp)
 {
-#if defined(CONFIG_NFS_V4_1)
 	struct nfs4_session *session;
 	struct nfs4_sessionid id;
 	u32 dummy;
@@ -6034,12 +5983,8 @@ static int decode_sequence(struct xdr_stream *xdr,
 out_overflow:
 	status = -EIO;
 	goto out_err;
-#else  /* CONFIG_NFS_V4_1 */
-	return 0;
-#endif /* CONFIG_NFS_V4_1 */
 }
 
-#if defined(CONFIG_NFS_V4_1)
 static int decode_layout_stateid(struct xdr_stream *xdr, nfs4_stateid *stateid)
 {
 	stateid->type = NFS4_LAYOUT_STATEID_TYPE;
@@ -6302,27 +6247,6 @@ static int decode_free_stateid(struct xdr_stream *xdr,
 	res->status = decode_op_hdr(xdr, OP_FREE_STATEID);
 	return res->status;
 }
-#else
-static int decode_get_dir_delegation(struct xdr_stream *xdr,
-				     struct nfs4_getattr_res *res)
-{
-	return 0;
-}
-
-static inline
-int decode_layoutreturn(struct xdr_stream *xdr,
-			       struct nfs4_layoutreturn_res *res)
-{
-	return 0;
-}
-
-static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
-			    struct nfs4_layoutget_res *res)
-{
-	return 0;
-}
-
-#endif /* CONFIG_NFS_V4_1 */
 
 /*
  * END OF "GENERIC" DECODE ROUTINES.
@@ -7347,7 +7271,6 @@ static int nfs4_xdr_dec_fsid_present(struct rpc_rqst *rqstp,
 	return status;
 }
 
-#if defined(CONFIG_NFS_V4_1)
 /*
  * Decode BIND_CONN_TO_SESSION response
  */
@@ -7444,8 +7367,6 @@ static int nfs4_xdr_dec_sequence(struct rpc_rqst *rqstp,
 	return status;
 }
 
-#endif
-
 /*
  * Decode GET_LEASE_TIME response
  */
@@ -7467,8 +7388,6 @@ static int nfs4_xdr_dec_get_lease_time(struct rpc_rqst *rqstp,
 	return status;
 }
 
-#ifdef CONFIG_NFS_V4_1
-
 /*
  * Decode RECLAIM_COMPLETE response
  */
@@ -7656,7 +7575,6 @@ static int nfs4_xdr_dec_free_stateid(struct rpc_rqst *rqstp,
 out:
 	return status;
 }
-#endif /* CONFIG_NFS_V4_1 */
 
 /**
  * nfs4_decode_dirent - Decode a single NFSv4 directory entry stored in
@@ -7754,13 +7672,8 @@ int nfs4_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	.p_name = #proc,	\
 }
 
-#if defined(CONFIG_NFS_V4_1)
 #define PROC41(proc, argtype, restype)				\
 	PROC(proc, argtype, restype)
-#else
-#define PROC41(proc, argtype, restype)				\
-	STUB(proc)
-#endif
 
 #if defined(CONFIG_NFS_V4_2)
 #define PROC42(proc, argtype, restype)				\
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 91ff877185c8..1e83218de188 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -84,7 +84,7 @@ enum pnfs_try_status {
 	PNFS_TRY_AGAIN     = 2,
 };
 
-#ifdef CONFIG_NFS_V4_1
+#if IS_ENABLED(CONFIG_NFS_V4)
 
 #define LAYOUT_NFSV4_1_MODULE_PREFIX "nfs-layouttype4"
 
@@ -705,7 +705,7 @@ static inline void nfs4_print_deviceid(const struct nfs4_deviceid *dev_id)
 }
 
 #endif /* NFS_DEBUG */
-#else  /* CONFIG_NFS_V4_1 */
+#else  /* CONFIG_NFS_V4 */
 
 static inline bool nfs_have_layout(struct inode *inode)
 {
@@ -916,7 +916,7 @@ static inline bool pnfs_layout_is_valid(const struct pnfs_layout_hdr *lo)
 	return false;
 }
 
-#endif /* CONFIG_NFS_V4_1 */
+#endif /* CONFIG_NFS_V4 */
 
 #if IS_ENABLED(CONFIG_NFS_V4_2)
 int pnfs_report_layoutstat(struct inode *inode, gfp_t gfp_flags);
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 3c1fa320b3f1..e1fe78d7b8d0 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -68,10 +68,10 @@ void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
 	struct nfs_server *server = NFS_SERVER(inode);
 	const struct nfs_pageio_ops *pg_ops = &nfs_pgio_rw_ops;
 
-#ifdef CONFIG_NFS_V4_1
+#if IS_ENABLED(CONFIG_NFS_V4)
 	if (server->pnfs_curr_ld && !force_mds)
 		pg_ops = server->pnfs_curr_ld->pg_read_ops;
-#endif
+#endif /* CONFIG_NFS_V4 */
 	nfs_pageio_init(pgio, inode, pg_ops, compl_ops, &nfs_rw_read_ops,
 			server->rsize, 0);
 }
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 57d372db03b9..8ff69603d594 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -597,18 +597,13 @@ static void show_lease(struct seq_file *m, struct nfs_server *server)
 	seq_printf(m, ",lease_expired=%ld",
 		   time_after(expire, jiffies) ?  0 : (jiffies - expire) / HZ);
 }
-#ifdef CONFIG_NFS_V4_1
+
 static void show_sessions(struct seq_file *m, struct nfs_server *server)
 {
 	if (nfs4_has_session(server->nfs_client))
 		seq_puts(m, ",sessions");
 }
-#else
-static void show_sessions(struct seq_file *m, struct nfs_server *server) {}
-#endif
-#endif
 
-#ifdef CONFIG_NFS_V4_1
 static void show_pnfs(struct seq_file *m, struct nfs_server *server)
 {
 	seq_printf(m, ",pnfs=");
@@ -628,16 +623,11 @@ static void show_implementation_id(struct seq_file *m, struct nfs_server *nfss)
 			   impl_id->date.seconds, impl_id->date.nseconds);
 	}
 }
-#else
-#if IS_ENABLED(CONFIG_NFS_V4)
-static void show_pnfs(struct seq_file *m, struct nfs_server *server)
-{
-}
-#endif
+#else /* CONFIG_NFS_V4 */
 static void show_implementation_id(struct seq_file *m, struct nfs_server *nfss)
 {
 }
-#endif
+#endif /* CONFIG_NFS_V4 */
 
 int nfs_show_devname(struct seq_file *m, struct dentry *root)
 {
diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index ea6e6168092b..7bf650fda1cb 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -293,7 +293,7 @@ shutdown_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static struct kobj_attribute nfs_sysfs_attr_shutdown = __ATTR_RW(shutdown);
 
-#if IS_ENABLED(CONFIG_NFS_V4_1)
+#if IS_ENABLED(CONFIG_NFS_V4)
 static ssize_t
 implid_domain_show(struct kobject *kobj, struct kobj_attribute *attr,
 				char *buf)
@@ -323,7 +323,7 @@ implid_name_show(struct kobject *kobj, struct kobj_attribute *attr,
 
 static struct kobj_attribute nfs_sysfs_attr_implid_name = __ATTR_RO(implid_name);
 
-#endif /* IS_ENABLED(CONFIG_NFS_V4_1) */
+#endif /* IS_ENABLED(CONFIG_NFS_V4) */
 
 #define RPC_CLIENT_NAME_SIZE 64
 
@@ -362,7 +362,7 @@ static struct kobj_type nfs_sb_ktype = {
 	.child_ns_type = nfs_netns_object_child_ns_type,
 };
 
-#if IS_ENABLED(CONFIG_NFS_V4_1)
+#if IS_ENABLED(CONFIG_NFS_V4)
 static void nfs_sysfs_add_nfsv41_server(struct nfs_server *server)
 {
 	int ret;
@@ -382,11 +382,11 @@ static void nfs_sysfs_add_nfsv41_server(struct nfs_server *server)
 		pr_warn("NFS: sysfs_create_file_ns for server-%d failed (%d)\n",
 			server->s_sysfs_id, ret);
 }
-#else /* CONFIG_NFS_V4_1 */
+#else /* CONFIG_NFS_V4 */
 static inline void nfs_sysfs_add_nfsv41_server(struct nfs_server *server)
 {
 }
-#endif /* CONFIG_NFS_V4_1 */
+#endif /* CONFIG_NFS_V4 */
 
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 336c510f3750..33f785086f42 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1402,7 +1402,7 @@ void nfs_pageio_init_write(struct nfs_pageio_descriptor *pgio,
 	struct nfs_server *server = NFS_SERVER(inode);
 	const struct nfs_pageio_ops *pg_ops = &nfs_pgio_rw_ops;
 
-#ifdef CONFIG_NFS_V4_1
+#if IS_ENABLED(CONFIG_NFS_V4)
 	if (server->pnfs_curr_ld && !force_mds)
 		pg_ops = server->pnfs_curr_ld->pg_write_ops;
 #endif
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index c58b870f31ee..a810a42b6495 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -115,9 +115,7 @@ struct nfs_client {
 #define NFS_SP4_MACH_CRED_WRITE    5	/* WRITE */
 #define NFS_SP4_MACH_CRED_COMMIT   6	/* COMMIT */
 #define NFS_SP4_MACH_CRED_PNFS_CLEANUP  7 /* LAYOUTRETURN */
-#if IS_ENABLED(CONFIG_NFS_V4_1)
 	wait_queue_head_t	cl_lock_waitq;
-#endif /* CONFIG_NFS_V4_1 */
 #endif /* CONFIG_NFS_V4 */
 
 	/* Our own IP address, as a null-terminated string.
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 2aa4e38af57a..437e6f4af7e0 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1324,10 +1324,6 @@ struct nfs4_fsid_present_res {
 	unsigned char			renew:1;
 };
 
-#endif /* CONFIG_NFS_V4 */
-
-#ifdef CONFIG_NFS_V4_1
-
 struct pnfs_commit_bucket {
 	struct list_head written;
 	struct list_head committing;
@@ -1467,7 +1463,7 @@ struct nfs41_free_stateid_res {
 struct pnfs_ds_commit_info {
 };
 
-#endif /* CONFIG_NFS_V4_1 */
+#endif /* CONFIG_NFS_V4 */
 
 #ifdef CONFIG_NFS_V4_2
 struct nfs42_falloc_args {
-- 
2.52.0


