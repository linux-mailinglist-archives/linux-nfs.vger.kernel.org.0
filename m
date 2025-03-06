Return-Path: <linux-nfs+bounces-10507-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0058BA54AED
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 13:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8435E189201C
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE66720E33E;
	Thu,  6 Mar 2025 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEDKBhqG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939E620E335;
	Thu,  6 Mar 2025 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264716; cv=none; b=nSimPHGbZxgCz4k0WMEWlvLGOSFn8c32z4A/q7xqESr/Gnhwl1Kv6k0umGvBcjv4yDmVGEtpqzWB5kYv3S6gKFhEdyS/GewPcVFJSob7u8Joo+m36KtEO7OsbVJ3P0pzO90PDdlZiZtp7CT1uRwgk6veXZZVxVJCkkOXXJZniKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264716; c=relaxed/simple;
	bh=P5cmtorr5cXrsFKmHnbpELmGLQ2FPiPZFr7M/Uw6dhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lgqZBf6vXyYlKs8qI3Hd/+H4MOjiR4DJlaIw4l2mUgkLi/g4YdTEahFTrSNGUpU2VYL1z27hauqigpiu9hyPE1hYScuzVuVDzc1COyRiOm1Z2Lay3Z+5BePME4WbIvFg/X+SgM4xieccAJjIOUeFxMWHPlxXQComZclcNCnVw5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEDKBhqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C21C4CEEB;
	Thu,  6 Mar 2025 12:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741264716;
	bh=P5cmtorr5cXrsFKmHnbpELmGLQ2FPiPZFr7M/Uw6dhM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PEDKBhqGO7mMJfsRuF0wKfZVtfUBrQqRMrRdyVpXHght67b6NmsLjostMnegeCsAu
	 UtBGK925gitKEmpA4as2D0HNd+MsVW0h9EM33iJVTPAbpI6fdiEV+4eRxx109hoPfb
	 eKJYOzUE1LdAEThgThnntacMgplzowI+2JVH94kFGhZRPPlsEmOsMWZUtvEAiRc4dt
	 nNYYsb3if2ozHXokwxUcJrVWzQBOuNcQlmNoH5x50FxUFlXmk2jRyPX9KpCeSgw2GO
	 hqe+Q82kvZCBJuZYT3yK/yLkxOJ20KuUqz1qLYhTB2+Gr0+C6bidwF2nPUGrMtf31b
	 n0m94STEMyhNw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 06 Mar 2025 07:38:15 -0500
Subject: [PATCH 3/4] nfsd: add some stub tracepoints around key vfs
 functions
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-nfsd-tracepoints-v1-3-4405bf41b95f@kernel.org>
References: <20250306-nfsd-tracepoints-v1-0-4405bf41b95f@kernel.org>
In-Reply-To: <20250306-nfsd-tracepoints-v1-0-4405bf41b95f@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Sargun Dillon <sargun@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7290; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=P5cmtorr5cXrsFKmHnbpELmGLQ2FPiPZFr7M/Uw6dhM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnyZdFA4872ZaQ4Gpa8va7ieWuQ96bO1fYNLLZD
 efId0NkSgmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ8mXRQAKCRAADmhBGVaC
 FQDUEAC8HLAvBmiG2ZSGcMG5wpJIn/AWa0mZMYW/DS8ak+OFUThHiY5t3InyPaEVM15W7wHNXYU
 9Z/Rfu5M8lV/V3i87w9k9ZmjcgHLlMNFHk7+6tUmamp2ZOlcuxRgleKcatMpnmAGhMoZX8Lsy0r
 WXE5tiFzOOKzS4uSI6hRz85niDX/zvHkItaT9+2XbRGdIsdphACCVEQQeFSkXR4jeP/QUhA8Fru
 7IBNC1cia/tBNlmgAzziAlTygqVAEWzFRxaM1hOwo5V2juTjUG4kJTLGlK1f4k/WRKO9kZl9HuD
 2AJIoyV3AmWUnCrN32HYJUVN8ldFdefyFKQPGsb0wV9Y8ahdMApipxIQG2ViVbiop2S48M2jJrb
 DWcUh+uEWf5jy6WjmsYiFN2rkQYohqdTCMQK6ZifKNANLVJymlMPLcihD6e2v7odxEgozTBf5ZJ
 wI4rmpZKHIYjExPBSbQrNZG20y7gIG/jcldd5eM9g7+DPq3xO8FFbdW4SAdQdndGc/MSuXdNI6O
 /1pjsbabOhdVlOgvRfG1AlHoSpJVMUEB/YhbueDeESGEXRDyB2V62JEv+seeESP7R+CbeqLOyuh
 JfASdby/5ZxgfqtifD+BismLMqj9MW9Z1pWrb+flKKaFpM1/bVMBJgs4zXWTSAv/eoMtT3zQy/S
 jRpunDCaG3GqJmA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Sargun set up kprobes to add some of these tracepoints. Convert them to
simple static tracepoints. These are pretty sparse for now, but they
could be expanded in the future as needed.

Cc: Sargun Dillon <sargun@meta.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c |  3 +++
 fs/nfsd/nfs4proc.c |  2 ++
 fs/nfsd/nfsproc.c  |  2 ++
 fs/nfsd/trace.h    | 35 +++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c      | 26 ++++++++++++++++++++++++++
 5 files changed, 68 insertions(+)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 372bdcf5e07a5c835da240ecebb02e3576eb2ca6..2a56cae4c78a7ca66d569637e9f0e7c0fdcfb826 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -14,6 +14,7 @@
 #include "xdr3.h"
 #include "vfs.h"
 #include "filecache.h"
+#include "trace.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
@@ -69,6 +70,8 @@ nfsd3_proc_getattr(struct svc_rqst *rqstp)
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
+	trace_nfsd_getattr(rqstp, &argp->fh);
+
 	dprintk("nfsd: GETATTR(3)  %s\n",
 		SVCFH_fmt(&argp->fh));
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index c20f1abcb94f131b1ec898860ba2c394b22e61e1..87d241ff91920317e0122a58bf0cf71c5b28d264 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -876,6 +876,8 @@ nfsd4_getattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_getattr *getattr = &u->getattr;
 	__be32 status;
 
+	trace_nfsd_getattr(rqstp, &cstate->current_fh);
+
 	status = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_NOP);
 	if (status)
 		return status;
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 6dda081eb24c00b834ab0965c3a35a12115bceb7..9563372f0826b9580299144069f57664dbd2a079 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -54,6 +54,8 @@ nfsd_proc_getattr(struct svc_rqst *rqstp)
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 
+	trace_nfsd_getattr(rqstp, &argp->fh);
+
 	dprintk("nfsd: GETATTR  %s\n", SVCFH_fmt(&argp->fh));
 
 	fh_copy(&resp->fh, &argp->fh);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 117f7e1fd66a4838a048cc44bd5bf4dd8c6db958..d4a78fe1bab24b594b96cca8611c439da9ed6926 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2337,6 +2337,41 @@ DEFINE_EVENT(nfsd_copy_async_done_class,		\
 DEFINE_COPY_ASYNC_DONE_EVENT(done);
 DEFINE_COPY_ASYNC_DONE_EVENT(cancel);
 
+DECLARE_EVENT_CLASS(nfsd_vfs_class,
+	TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp),
+	TP_ARGS(rqstp, fhp),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, fh_hash)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x",
+		  __entry->xid, __entry->fh_hash)
+);
+
+#define DEFINE_NFSD_VFS_EVENT(name)                                        \
+	DEFINE_EVENT(nfsd_vfs_class, nfsd_##name,                           \
+		     TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp), \
+		     TP_ARGS(rqstp, fhp))
+
+DEFINE_NFSD_VFS_EVENT(lookup);
+DEFINE_NFSD_VFS_EVENT(lookup_dentry);
+DEFINE_NFSD_VFS_EVENT(create_locked);
+DEFINE_NFSD_VFS_EVENT(create);
+DEFINE_NFSD_VFS_EVENT(access);
+DEFINE_NFSD_VFS_EVENT(create_setattr);
+DEFINE_NFSD_VFS_EVENT(readlink);
+DEFINE_NFSD_VFS_EVENT(symlink);
+DEFINE_NFSD_VFS_EVENT(link);
+DEFINE_NFSD_VFS_EVENT(rename);
+DEFINE_NFSD_VFS_EVENT(unlink);
+DEFINE_NFSD_VFS_EVENT(readdir);
+DEFINE_NFSD_VFS_EVENT(statfs);
+DEFINE_NFSD_VFS_EVENT(getattr);
+
 #define show_ia_valid_flags(x)					\
 	__print_flags(x, "|",					\
 			{ ATTR_MODE, "MODE" },			\
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index d755cc87a8670c491e55194de266d999ba1b337d..772a4d32b09a4bd217a9258ec803c06618cf13c8 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -244,6 +244,8 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct dentry		*dentry;
 	int			host_err;
 
+	trace_nfsd_lookup(rqstp, fhp);
+
 	dprintk("nfsd: nfsd_lookup(fh %s, %.*s)\n", SVCFH_fmt(fhp), len,name);
 
 	dparent = fhp->fh_dentry;
@@ -313,6 +315,8 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
 	struct dentry		*dentry;
 	__be32 err;
 
+	trace_nfsd_lookup(rqstp, fhp);
+
 	err = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
 	if (err)
 		return err;
@@ -794,6 +798,8 @@ nfsd_access(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *access, u32 *suppor
 	u32			query, result = 0, sresult = 0;
 	__be32			error;
 
+	trace_nfsd_create(rqstp, fhp);
+
 	error = fh_verify(rqstp, fhp, 0, NFSD_MAY_NOP);
 	if (error)
 		goto out;
@@ -1401,6 +1407,8 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct iattr *iap = attrs->na_iattr;
 	__be32 status;
 
+	trace_nfsd_create_setattr(rqstp, fhp);
+
 	/*
 	 * Mode has already been set by file creation.
 	 */
@@ -1467,6 +1475,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32		err;
 	int		host_err;
 
+	trace_nfsd_create_locked(rqstp, fhp);
+
 	dentry = fhp->fh_dentry;
 	dirp = d_inode(dentry);
 
@@ -1557,6 +1567,8 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32		err;
 	int		host_err;
 
+	trace_nfsd_create(rqstp, fhp);
+
 	if (isdotent(fname, flen))
 		return nfserr_exist;
 
@@ -1609,6 +1621,8 @@ nfsd_readlink(struct svc_rqst *rqstp, struct svc_fh *fhp, char *buf, int *lenp)
 	DEFINE_DELAYED_CALL(done);
 	int len;
 
+	trace_nfsd_readlink(rqstp, fhp);
+
 	err = fh_verify(rqstp, fhp, S_IFLNK, NFSD_MAY_NOP);
 	if (unlikely(err))
 		return err;
@@ -1657,6 +1671,8 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32		err, cerr;
 	int		host_err;
 
+	trace_nfsd_symlink(rqstp, fhp);
+
 	err = nfserr_noent;
 	if (!flen || path[0] == '\0')
 		goto out;
@@ -1725,6 +1741,8 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	__be32		err;
 	int		host_err;
 
+	trace_nfsd_link(rqstp, ffhp);
+
 	err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_CREATE);
 	if (err)
 		goto out;
@@ -1842,6 +1860,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	int		host_err;
 	bool		close_cached = false;
 
+	trace_nfsd_rename(rqstp, ffhp);
+
 	err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_REMOVE);
 	if (err)
 		goto out;
@@ -2000,6 +2020,8 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	__be32		err;
 	int		host_err;
 
+	trace_nfsd_unlink(rqstp, fhp);
+
 	err = nfserr_acces;
 	if (!flen || isdotent(fname, flen))
 		goto out;
@@ -2222,6 +2244,8 @@ nfsd_readdir(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t *offsetp,
 	loff_t		offset = *offsetp;
 	int             may_flags = NFSD_MAY_READ;
 
+	trace_nfsd_readdir(rqstp, fhp);
+
 	err = nfsd_open(rqstp, fhp, S_IFDIR, may_flags, &file);
 	if (err)
 		goto out;
@@ -2288,6 +2312,8 @@ nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *fhp, struct kstatfs *stat, in
 {
 	__be32 err;
 
+	trace_nfsd_statfs(rqstp, fhp);
+
 	err = fh_verify(rqstp, fhp, 0, NFSD_MAY_NOP | access);
 	if (!err) {
 		struct path path = {

-- 
2.48.1


