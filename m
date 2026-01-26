Return-Path: <linux-nfs+bounces-18524-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFKcOYHRd2mFlwEAu9opvQ
	(envelope-from <linux-nfs+bounces-18524-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:41:37 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED78D30E
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBC623055C89
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87632D73AD;
	Mon, 26 Jan 2026 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LptxWSww"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B672D73B4
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459986; cv=none; b=sI50aHAN69xhJI4jMQ6oQ1QuPGU0CJTwxmQ4qbpFHIrVHPbZNTaGaPrD/46pRiJDRi753XURUTZ9c/I7o9gDbuESKbQkv5kQhSk8fr/iAjaWArKSkbp7a6jGGz2YGO659AmTVEtKt2Zgb4lzlrOYFSZWR1C0EmSSm0EWKvLo/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459986; c=relaxed/simple;
	bh=GXLBQ+kjPkM9c05H2HyoZrwfuMGuMBXTEWc6WG0AAKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLtE+vRRKGm/wK95Cq9UD2lUT8ZqSnHATKpHRuZKFlsfkn7m//wYXSX2PPnv+tCCbRStPPQFaKcYvl976S7CR1HPeZ5AWSMleM5+NfMHrjSXJ0QgeaN8dvcQ/XBoFRdH4R0Z9KVa2240fX+4A8xA4AxFcf/Z/hUB2oDCFKm0o00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LptxWSww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F326CC2BCB5;
	Mon, 26 Jan 2026 20:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769459986;
	bh=GXLBQ+kjPkM9c05H2HyoZrwfuMGuMBXTEWc6WG0AAKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LptxWSwwZate4BtWygpszDdP0oSF+mrdJ0ojQ0yIcsXWIPb1adD+lfmfEWap3clPT
	 O/+x1nv27ocMP3wXt5lXC3KK1gFwUWxkLvOL3bVci29+XDFiFylpiLbzm37gorbNn+
	 uimX1r9wV71gDgNK0EEpeSkEytQXpBlE34zc8TEahnTvWmpBgM8SuvdAwsysSHPVRR
	 FdP3h9snQw/wJaZML5iJoqOf77Jlg9mwR6dpYM1eE6WqLFqOj3xyfy6bN8xddn987I
	 YmQ+xX5hmAQhZOdDs1j4ijqJLwa4pxahUGFreEi2SIiyVds2CgK2SeNcKwshP4/6tW
	 FU8H3UOjOCqkA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 13/14] NFS: Add a way to disable NFS v4.0 via KConfig
Date: Mon, 26 Jan 2026 15:39:37 -0500
Message-ID: <20260126203938.450304-14-anna@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126203938.450304-1-anna@kernel.org>
References: <20260126203938.450304-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18524-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EED78D30E
X-Rspamd-Action: no action

From: Anna Schumaker <anna.schumaker@oracle.com>

I introduce NFS4_MIN_MINOR_VERSION as a parallel to
NFS4_MAX_MINOR_VERSION to check if NFS v4.0 has been compiled in and
return an appropriate error if not.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/Kconfig      |  9 +++++++++
 fs/nfs/Makefile     |  3 ++-
 fs/nfs/fs_context.c |  3 ++-
 fs/nfs/nfs4_fs.h    |  6 ++++++
 fs/nfs/nfs4client.c |  3 ++-
 fs/nfs/nfs4proc.c   |  2 ++
 fs/nfs/nfs4state.c  |  2 ++
 fs/nfs/nfs4xdr.c    | 27 +++++++++++++++++++++++++--
 8 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 07932ce9246c..058ed67b98cc 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -96,6 +96,15 @@ config NFS_SWAP
 	help
 	  This option enables swapon to work on files located on NFS mounts.
 
+config NFS_V4_0
+	bool "NFS client support for NFSv4.0"
+	depends on NFS_V4
+	help
+	  This option enables support for minor version 0 of the NFSv4 protocol
+	  (RFC 3530) in the kernel's NFS client.
+
+	  If unsure, say N.
+
 config NFS_V4_1
 	bool "NFS client support for NFSv4.1"
 	depends on NFS_V4
diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
index d05e69c00fe1..6a9aaf2f913b 100644
--- a/fs/nfs/Makefile
+++ b/fs/nfs/Makefile
@@ -27,9 +27,10 @@ CFLAGS_nfs4trace.o += -I$(src)
 nfsv4-y := nfs4proc.o nfs4xdr.o nfs4state.o nfs4renewd.o nfs4super.o nfs4file.o \
 	  delegation.o nfs4idmap.o callback.o callback_xdr.o callback_proc.o \
 	  nfs4namespace.o nfs4getroot.o nfs4client.o nfs4session.o \
-	  dns_resolve.o nfs4trace.o nfs40proc.o nfs40client.o
+	  dns_resolve.o nfs4trace.o
 nfsv4-$(CONFIG_NFS_USE_LEGACY_DNS) += cache_lib.o
 nfsv4-$(CONFIG_SYSCTL)	+= nfs4sysctl.o
+nfsv4-$(CONFIG_NFS_V4_0)	+= nfs40client.o nfs40proc.o
 nfsv4-$(CONFIG_NFS_V4_1)	+= pnfs.o pnfs_dev.o pnfs_nfs.o
 nfsv4-$(CONFIG_NFS_V4_2)	+= nfs42proc.o nfs42xattr.o
 
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index b4679b7161b0..86750f110053 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -806,7 +806,8 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
 		ctx->mount_server.version = result.uint_32;
 		break;
 	case Opt_minorversion:
-		if (result.uint_32 > NFS4_MAX_MINOR_VERSION)
+		if (result.uint_32 < NFS4_MIN_MINOR_VERSION ||
+		    result.uint_32 > NFS4_MAX_MINOR_VERSION)
 			goto out_of_bounds;
 		ctx->minorversion = result.uint_32;
 		break;
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 6cb2c1d9d691..1f233411578c 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -10,6 +10,12 @@
 #ifndef __LINUX_FS_NFS_NFS4_FS_H
 #define __LINUX_FS_NFS_NFS4_FS_H
 
+#if defined(CONFIG_NFS_V4_0)
+#define NFS4_MIN_MINOR_VERSION 0
+#else
+#define NFS4_MIN_MINOR_VERSION 1
+#endif
+
 #if defined(CONFIG_NFS_V4_2)
 #define NFS4_MAX_MINOR_VERSION 2
 #elif defined(CONFIG_NFS_V4_1)
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index c376b2420b6c..00b57e55aba8 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -203,7 +203,8 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 	if (err)
 		goto error;
 
-	if (cl_init->minorversion > NFS4_MAX_MINOR_VERSION) {
+	if (cl_init->minorversion < NFS4_MIN_MINOR_VERSION ||
+	    cl_init->minorversion > NFS4_MAX_MINOR_VERSION) {
 		err = -EINVAL;
 		goto error;
 	}
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index eaf2e5f5cf55..9daba5b7a545 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10570,7 +10570,9 @@ static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
 #endif
 
 const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
+#if defined(CONFIG_NFS_V4_0)
 	[0] = &nfs_v4_0_minor_ops,
+#endif /* CONFIG_NFS_V4_0 */
 #if defined(CONFIG_NFS_V4_1)
 	[1] = &nfs_v4_1_minor_ops,
 #endif
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 1546351e76b2..87c40c207ab6 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1804,9 +1804,11 @@ static int nfs4_recovery_handle_error(struct nfs_client *clp, int error)
 	switch (error) {
 	case 0:
 		break;
+#if IS_ENABLED(CONFIG_NFS_V4_0)
 	case -NFS4ERR_CB_PATH_DOWN:
 		nfs40_handle_cb_pathdown(clp);
 		break;
+#endif /* CONFIG_NFS_V4_0 */
 	case -NFS4ERR_NO_GRACE:
 		nfs4_state_end_reclaim_reboot(clp);
 		break;
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index b6fe30577fab..73f36dd539ec 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1399,11 +1399,13 @@ static void encode_locku(struct xdr_stream *xdr, const struct nfs_locku_args *ar
 	xdr_encode_hyper(p, nfs4_lock_length(args->fl));
 }
 
+#if defined(CONFIG_NFS_V4_0)
 static void encode_release_lockowner(struct xdr_stream *xdr, const struct nfs_lowner *lowner, struct compound_hdr *hdr)
 {
 	encode_op_hdr(xdr, OP_RELEASE_LOCKOWNER, decode_release_lockowner_maxsz, hdr);
 	encode_lockowner(xdr, lowner);
 }
+#endif /* CONFIG_NFS_V4_0 */
 
 static void encode_lookup(struct xdr_stream *xdr, const struct qstr *name, struct compound_hdr *hdr)
 {
@@ -2583,6 +2585,7 @@ static void nfs4_xdr_enc_locku(struct rpc_rqst *req, struct xdr_stream *xdr,
 	encode_nops(&hdr);
 }
 
+#if defined(CONFIG_NFS_V4_0)
 static void nfs4_xdr_enc_release_lockowner(struct rpc_rqst *req,
 					   struct xdr_stream *xdr,
 					   const void *data)
@@ -2596,6 +2599,7 @@ static void nfs4_xdr_enc_release_lockowner(struct rpc_rqst *req,
 	encode_release_lockowner(xdr, &args->lock_owner, &hdr);
 	encode_nops(&hdr);
 }
+#endif /* CONFIG_NFS_V4_0 */
 
 /*
  * Encode a READLINK request
@@ -2825,6 +2829,7 @@ static void nfs4_xdr_enc_server_caps(struct rpc_rqst *req,
 /*
  * a RENEW request
  */
+#if defined(CONFIG_NFS_V4_0)
 static void nfs4_xdr_enc_renew(struct rpc_rqst *req, struct xdr_stream *xdr,
 			       const void *data)
 
@@ -2838,6 +2843,7 @@ static void nfs4_xdr_enc_renew(struct rpc_rqst *req, struct xdr_stream *xdr,
 	encode_renew(xdr, clp->cl_clientid, &hdr);
 	encode_nops(&hdr);
 }
+#endif /* CONFIG_NFS_V4_0 */
 
 /*
  * a SETCLIENTID request
@@ -5224,10 +5230,12 @@ static int decode_locku(struct xdr_stream *xdr, struct nfs_locku_res *res)
 	return status;
 }
 
+#if defined(CONFIG_NFS_V4_0)
 static int decode_release_lockowner(struct xdr_stream *xdr)
 {
 	return decode_op_hdr(xdr, OP_RELEASE_LOCKOWNER);
 }
+#endif /* CONFIG_NFS_V4_0 */
 
 static int decode_lookup(struct xdr_stream *xdr)
 {
@@ -6930,6 +6938,7 @@ static int nfs4_xdr_dec_locku(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	return status;
 }
 
+#if defined(CONFIG_NFS_V4_0)
 static int nfs4_xdr_dec_release_lockowner(struct rpc_rqst *rqstp,
 					  struct xdr_stream *xdr, void *dummy)
 {
@@ -6941,6 +6950,7 @@ static int nfs4_xdr_dec_release_lockowner(struct rpc_rqst *rqstp,
 		status = decode_release_lockowner(xdr);
 	return status;
 }
+#endif /* CONFIG_NFS_V4_0 */
 
 /*
  * Decode READLINK response
@@ -7162,6 +7172,7 @@ static int nfs4_xdr_dec_server_caps(struct rpc_rqst *req,
 /*
  * Decode RENEW response
  */
+#if defined(CONFIG_NFS_V4_0)
 static int nfs4_xdr_dec_renew(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 			      void *__unused)
 {
@@ -7173,6 +7184,7 @@ static int nfs4_xdr_dec_renew(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 		status = decode_renew(xdr);
 	return status;
 }
+#endif /* CONFIG_NFS_V4_0 */
 
 /*
  * Decode SETCLIENTID response
@@ -7754,7 +7766,18 @@ int nfs4_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	.p_name = #proc,	\
 }
 
+<<<<<<< Updated upstream
 #if defined(CONFIG_NFS_V4_1)
+=======
+#if defined(CONFIG_NFS_V4_0)
+#define PROC40(proc, argtype, restype)				\
+	PROC(proc, argtype, restype)
+#else
+#define PROC40(proc, argtype, restype)				\
+	STUB(proc)
+#endif /* CONFIG_NFS_V4_0 */
+
+>>>>>>> Stashed changes
 #define PROC41(proc, argtype, restype)				\
 	PROC(proc, argtype, restype)
 #else
@@ -7781,7 +7804,7 @@ const struct rpc_procinfo nfs4_procedures[] = {
 	PROC(CLOSE,		enc_close,		dec_close),
 	PROC(SETATTR,		enc_setattr,		dec_setattr),
 	PROC(FSINFO,		enc_fsinfo,		dec_fsinfo),
-	PROC(RENEW,		enc_renew,		dec_renew),
+	PROC40(RENEW,		enc_renew,		dec_renew),
 	PROC(SETCLIENTID,	enc_setclientid,	dec_setclientid),
 	PROC(SETCLIENTID_CONFIRM, enc_setclientid_confirm, dec_setclientid_confirm),
 	PROC(LOCK,		enc_lock,		dec_lock),
@@ -7805,7 +7828,7 @@ const struct rpc_procinfo nfs4_procedures[] = {
 	PROC(GETACL,		enc_getacl,		dec_getacl),
 	PROC(SETACL,		enc_setacl,		dec_setacl),
 	PROC(FS_LOCATIONS,	enc_fs_locations,	dec_fs_locations),
-	PROC(RELEASE_LOCKOWNER,	enc_release_lockowner,	dec_release_lockowner),
+	PROC40(RELEASE_LOCKOWNER,	enc_release_lockowner,	dec_release_lockowner),
 	PROC(SECINFO,		enc_secinfo,		dec_secinfo),
 	PROC(FSID_PRESENT,	enc_fsid_present,	dec_fsid_present),
 	PROC41(EXCHANGE_ID,	enc_exchange_id,	dec_exchange_id),
-- 
2.52.0


