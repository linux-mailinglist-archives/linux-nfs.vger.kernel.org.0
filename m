Return-Path: <linux-nfs+bounces-11419-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4F1AA8281
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 22:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D5C18972D8
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 20:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96592281519;
	Sat,  3 May 2025 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5Bmxx3V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E128150F;
	Sat,  3 May 2025 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302392; cv=none; b=rK1rze82t4rI6OnCgBgB94eiJFwxPGmQS7mhKcFeqxLMXaNcEe7VAPQl1OdejgS61nyOQe2bmLXhHOn9f8QAxfEnI0D09EjKQ2+3oAwK8lKVH0eIOhBF7w8s3ybZOODEWifUwKtXKoM9lNtoXQzDBNEEQ4s+VMBquPooL+2aoYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302392; c=relaxed/simple;
	bh=ZKs0bRbmtNComB3idWcyiEEWtYkgrA5qtpbBITjrpuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpYcpcwMn/pQIK2RsHxUlwrnX6Mq3DSP9mx5azeR2I7LwyvIHQUnsnBQPT+PUufYg7JnxRiuaREkGR998KkiPX9n1QZThIDyfrE/mDhu11W/jduW/CsfQ9I6HSbA211jPQS094o+qiwNowS28T1wL8MAcUhG9qMri6K6SBtoSDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5Bmxx3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51F4C4CEF1;
	Sat,  3 May 2025 19:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302391;
	bh=ZKs0bRbmtNComB3idWcyiEEWtYkgrA5qtpbBITjrpuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l5Bmxx3VSgNxEdpLmMUkQqE8BNzTN1GL4eCRr8wmjhohbuliOnbVEymzbDXT2U64J
	 +IoWds50gO+J1oVaarNg7FX3+Og7iWFRwaRTstGBf3HLr9+iIHbPWhxqV8XTzTo3XU
	 zBg5KnVYEyMl6L2tD1Va+kVSnhUQq28aIajN3pFXxjuEePx2/7VWuORUoa3KHBZSGB
	 01LQjUScTOlRQOip9NS5Kebv4BY/mi23EMilofmmhlbhurVOw0L73ajF/DPEhhaeeB
	 qjWt76NyTrLPjqXFZFJHmSNg866vPFgKbfvwJw/gol2Tn3vgiqXN7mSonPLvza17/o
	 xJahD0wGloSLg==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: sargun@sargun.me,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 11/18] nfsd: add tracepoint for getattr and statfs events
Date: Sat,  3 May 2025 15:59:29 -0400
Message-ID: <20250503195936.5083-12-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503195936.5083-1-cel@kernel.org>
References: <20250503195936.5083-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

There isn't a common helper for getattrs, so add these into the
protocol-specific helpers.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |  2 ++
 fs/nfsd/nfs4proc.c |  2 ++
 fs/nfsd/nfsproc.c  |  2 ++
 fs/nfsd/trace.h    | 30 ++++++++++++++++++++++++++++++
 fs/nfsd/vfs.c      |  2 ++
 5 files changed, 38 insertions(+)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 80096a5c4865..f6eb8331dc4b 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -70,6 +70,8 @@ nfsd3_proc_getattr(struct svc_rqst *rqstp)
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
+	trace_nfsd_vfs_getattr(rqstp, &argp->fh);
+
 	dprintk("nfsd: GETATTR(3)  %s\n",
 		SVCFH_fmt(&argp->fh));
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 483fd8b26f9d..2b16ee1ae461 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -876,6 +876,8 @@ nfsd4_getattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_getattr *getattr = &u->getattr;
 	__be32 status;
 
+	trace_nfsd_vfs_getattr(rqstp, &cstate->current_fh);
+
 	status = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_NOP);
 	if (status)
 		return status;
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index c561af30c37a..8816cc565c0c 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -55,6 +55,8 @@ nfsd_proc_getattr(struct svc_rqst *rqstp)
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 
+	trace_nfsd_vfs_getattr(rqstp, &argp->fh);
+
 	dprintk("nfsd: GETATTR  %s\n", SVCFH_fmt(&argp->fh));
 
 	fh_copy(&resp->fh, &argp->fh);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index bed58cf55c10..3c5505ef5e3a 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2579,6 +2579,36 @@ TRACE_EVENT(nfsd_vfs_readdir,
 	)
 );
 
+DECLARE_EVENT_CLASS(nfsd_vfs_getattr_class,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_fh *fhp
+	),
+	TP_ARGS(rqstp, fhp),
+	TP_STRUCT__entry(
+		NFSD_TRACE_PROC_CALL_FIELDS(rqstp)
+		__field(u32, fh_hash)
+	),
+	TP_fast_assign(
+		NFSD_TRACE_PROC_CALL_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x",
+		__entry->xid, __entry->fh_hash
+	)
+);
+
+#define DEFINE_NFSD_VFS_GETATTR_EVENT(__name)		\
+DEFINE_EVENT(nfsd_vfs_getattr_class, __name,		\
+	TP_PROTO(					\
+		const struct svc_rqst *rqstp,		\
+		const struct svc_fh *fhp		\
+	),						\
+	TP_ARGS(rqstp, fhp))
+
+DEFINE_NFSD_VFS_GETATTR_EVENT(nfsd_vfs_getattr);
+DEFINE_NFSD_VFS_GETATTR_EVENT(nfsd_vfs_statfs);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 41314b2a8199..d0dfd97de4d3 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2290,6 +2290,8 @@ nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *fhp, struct kstatfs *stat, in
 {
 	__be32 err;
 
+	trace_nfsd_vfs_statfs(rqstp, fhp);
+
 	err = fh_verify(rqstp, fhp, 0, NFSD_MAY_NOP | access);
 	if (!err) {
 		struct path path = {
-- 
2.49.0


