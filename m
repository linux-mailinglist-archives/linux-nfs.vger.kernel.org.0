Return-Path: <linux-nfs+bounces-11400-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A43AA8148
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 17:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC7B9810A3
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CBB27CB38;
	Sat,  3 May 2025 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBOGzoAl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8327CB30;
	Sat,  3 May 2025 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285115; cv=none; b=j/UXaY7QOo/0Pr+LiAtttVWhdGe/a5+7LSUDbu6bjBZtuMNecTygK0kEQeXl1BvLD2KZMo3zfr0u6WoN/l+YgtirdtSB8p48W/cTHvHSSa0ObjnZrjuzw1UEAyZOIKVu5tSy18FlMhOcFv+kRbf0FImUnNcidFON3lOBlb2npeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285115; c=relaxed/simple;
	bh=rXX/BKYshS2lmjJ8Wq8yvdgE+Sd2NYuaMpACqzgvbbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQlVODiA0r1RxX0HdL9ygUeIjmnKAGZIGH4UhUtEXA6256A047oRAQzqrtKrzih0GTvwaJEWy7yS+W7SAeq12pY6PR10O45lrKqBCkAXmhfjXSPk41rjHKNECywkme64+I38s/SgfUWWx2OmQbyzCZLBXWFQe3KQA4MSYH3mrXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBOGzoAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D933C4CEE9;
	Sat,  3 May 2025 15:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746285115;
	bh=rXX/BKYshS2lmjJ8Wq8yvdgE+Sd2NYuaMpACqzgvbbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mBOGzoAlTeRVpgwEJDINftCdVSl1bo+wZGoCxSZIcs9mE+V+sGPpMO22FmqC4MIx6
	 RXM75gtHWtdDDjh47oZBMD7s0nOKMOluLtTxFWI2KdN13oqEou7m3zt0QJ6TuUMEz4
	 laPQe/Ec+Mu+YE8G313l65VYSx25i5HJe+YJlssbnj0/Qd64iXdgTtxo2Ds+MiJGbR
	 bwirs7Mmsst+ZjG179abnbp3UKnNweeBOvPApCvHkYkOEaW74cuQxO1EkvL6xKrRWW
	 DfstDStszKXW6nQUCqLaBvBHL8MPu6RevOFqAGDKRNbU5yLpr6fjMSBbKSMk/+KIvx
	 7fGrYb/WEAuLA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 03 May 2025 11:11:26 -0400
Subject: [PATCH v3 10/17] nfsd: add tracepoint for getattr and statfs
 events
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-nfsd-tracepoints-v3-10-d89f445969af@kernel.org>
References: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
In-Reply-To: <20250503-nfsd-tracepoints-v3-0-d89f445969af@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, NeilBrown <neil@brown.name>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3631; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rXX/BKYshS2lmjJ8Wq8yvdgE+Sd2NYuaMpACqzgvbbc=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGgWMi7IU+NBaAEOigXwKWUW1PzOYdcty/4AnIsZ6GmVS7o9f
 4kCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJoFjIuAAoJEAAOaEEZVoIVljwP/1zF
 9PakPkXqZiZEDllLnJP3ty3uA/NDkqMijYOw+G5HbI+vmXuGQKpRHqO+71JZJIfypyp1uwBNWzb
 yCmuKY33dVxPjT5xe/+H+ZlZGp0CqBf+5SNPfFyPXgQbbqHFcGxxHd8gUskV/2VJnlhsQCZuk54
 onDIsYPU12uZmDJbLYmjaLWMk/VCF3vYouI6FDulxoFIHM4MxwzaP/DNcXHdk2GYAWh4GQyRFn3
 HXDy4fq+wapEAUqBCQwAiZDUKrBeNOkQ4MC02h5We2w4Xha9AjoTtHTg+V54jWjsd7scmeGFPr5
 h3noB9kij8EWPEEULyKl79+nYTI9AoOu6qmNhWAxNMrRjKIN7p37oUDgEqhJOom1ke8qrJrqF2Q
 p6VfW4wXryiSvrL2XOpGB9tv3xqS2H4n91P6AKy2OiuB7RL69w3s1Xa4EPbHg4HRm4Qt2fcI7WO
 mYt5FvnEco1cVW5YXzospi8As5TbySeYfZ6bBEQIXiNa6F7pMrjWqT7XXTAzTndlHLnW0xJNcl4
 lRoga6zWs8wzR160BAAra76918qnrri7kBVUdwVViGrbJOyrihHjTwYwgojjfpR0P3tyOf7J0Oq
 q1/UzHsQKzdwhzaRhKGfoLT+6qrraPars11h4ih5woGfsZcsMw6+gE/vEM/Ank52YijD7joLpV6
 YJRvy
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

There isn't a common helper for getattrs, so add these into the
protocol-spefici helpers.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c |  2 ++
 fs/nfsd/nfs4proc.c |  2 ++
 fs/nfsd/nfsproc.c  |  3 +++
 fs/nfsd/trace.h    | 24 ++++++++++++++++++++++++
 fs/nfsd/vfs.c      |  2 ++
 5 files changed, 33 insertions(+)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 5d2b081072e8c2e286c6815c34e5e58d4be15067..c77e273e73a423c77047ff68126556ed36bc9c8e 100644
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
index 6e4c9bd15a6c820806832db19682e32a3d86507e..15508d2f5209b92fc62afb43ba03e72f195c2f77 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -923,6 +923,8 @@ nfsd4_getattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_getattr *getattr = &u->getattr;
 	__be32 status;
 
+	trace_nfsd_vfs_getattr(rqstp, &cstate->current_fh);
+
 	status = fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_NOP);
 	if (status)
 		return status;
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 5d842671fe6fb36a24799de6991c0e21a883fb52..dd6ad6c87b55b3c830b81a7beda10d674dc0d09c 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "xdr.h"
 #include "vfs.h"
+#include "trace.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
@@ -54,6 +55,8 @@ nfsd_proc_getattr(struct svc_rqst *rqstp)
 	struct nfsd_fhandle *argp = rqstp->rq_argp;
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 
+	trace_nfsd_vfs_getattr(rqstp, &argp->fh);
+
 	dprintk("nfsd: GETATTR  %s\n", SVCFH_fmt(&argp->fh));
 
 	fh_copy(&resp->fh, &argp->fh);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 6f73ecc6bbf09cc174a93ce1dce12edfff6f60b8..29b391c66ff0f0eaa0bb06b2ab9063a2b9831171 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2531,6 +2531,30 @@ TRACE_EVENT(nfsd_vfs_readdir,
 	TP_printk("xid=0x%08x fh_hash=0x%08x offset=0x%llx",
 		  __entry->xid, __entry->fh_hash, __entry->offset)
 );
+
+DECLARE_EVENT_CLASS(nfsd_vfs_getattr_class,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh *fhp),
+	TP_ARGS(rqstp, fhp),
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS(rqstp)
+		__field(u32, fh_hash)
+	),
+	TP_fast_assign(
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x",
+		  __entry->xid, __entry->fh_hash)
+);
+
+#define DEFINE_NFSD_VFS_GETATTR_EVENT(__name)					\
+	DEFINE_EVENT(nfsd_vfs_getattr_class, __name,				\
+		     TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp),	\
+		     TP_ARGS(rqstp, fhp))
+
+DEFINE_NFSD_VFS_GETATTR_EVENT(nfsd_vfs_getattr);
+DEFINE_NFSD_VFS_GETATTR_EVENT(nfsd_vfs_statfs);
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index ec07e5867912bf87497b935d26e3039364596864..f5ba30cb4b9358552c8f537ac5c7e5b733f57ffa 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2317,6 +2317,8 @@ nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *fhp, struct kstatfs *stat, in
 {
 	__be32 err;
 
+	trace_nfsd_vfs_statfs(rqstp, fhp);
+
 	err = fh_verify(rqstp, fhp, 0, NFSD_MAY_NOP | access);
 	if (!err) {
 		struct path path = {

-- 
2.49.0


