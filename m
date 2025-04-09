Return-Path: <linux-nfs+bounces-11061-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF57A82815
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 16:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CE01BC282C
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 14:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382A3268FCF;
	Wed,  9 Apr 2025 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZNyJ9I4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1218D25E805;
	Wed,  9 Apr 2025 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209193; cv=none; b=DtQjM4Xf7oi8ZdaXyQuoN40yN34Y5Q3Xmry8avbkwYpuLhR6ac4epG2lryuPpqJV48t07r9yPzvbkDOe8lmCvii1T3FlPkY5ypePNxIJLBFhFQlzHstFMG79UcVXEEL44n8dOJ6/yJa9lxWHq4tciXw1e3I4rGPK/wSyt37e1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209193; c=relaxed/simple;
	bh=oaQeRok/l0C3UUQzpwkDXPCVOoJQExZYMyv+R3SQNt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BnONtzRSwMFR2KCuc1uEa+fymqmeERFEirv0r8e1urOlSsQ1W6YGWIpgvsBewVlAmzhjwfyFsqKxAns8P0E7KRg5LJA9arS/zo9T8laaGUBVMxiGwh+rfIk+Bx7l2fLDDyaGThq0/nyf9xTUw4HdCTdrle3TrRn5OiGYo3OgkuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZNyJ9I4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18713C4CEE2;
	Wed,  9 Apr 2025 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209192;
	bh=oaQeRok/l0C3UUQzpwkDXPCVOoJQExZYMyv+R3SQNt4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nZNyJ9I4mK9+Z/DRi2cAEUcE6pjXeuII+nIJ1zLRPTCbCKUXZLCvrM1YE7yEnrO4d
	 AfxtTllBXHbZpuPI0nb2B0OG+ei5nG7w1aCOlCtM7hHAdqcwzRUhtUWRGFvwewtNG0
	 VidMcGYMkn5uURaIw23x6BCK8qrIRstU0ApOAHPmCFKfFagFtLpYq70qufzor9OwY+
	 P3TDpj5/bliqjkRyXPWIP43fQKkKS+WVXObjy7kJc4Ny4J2ut877UmjVgxwKrd2w7k
	 3Kkkp+kiDjAOiylEMWfzZ6zmVFdQEcrXyTyKlp0a/03h6bDTRgP+irD82LMXCvLt5s
	 V7vJ+uYaD0oRg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 09 Apr 2025 10:32:33 -0400
Subject: [PATCH v2 11/12] nfsd: add tracepoints for readdir events
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-nfsd-tracepoints-v2-11-cf4e084fdd9c@kernel.org>
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
In-Reply-To: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4020; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oaQeRok/l0C3UUQzpwkDXPCVOoJQExZYMyv+R3SQNt4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn9oUbuD5WkocwS2DaTsowycQRmsAzcOCEZSPsx
 UNTkRWr9iyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/aFGwAKCRAADmhBGVaC
 Fc9MEACqZjfdeK4LfG1ld4kLoKz1zzdYgTnDxKmn0TH4dVl6PtdpdjDIOiBQ/NZX90hy44y86Ss
 xXNc1LXGLmiQfvJgAILbE/NbW1SqMhR8EQnJ89TQfIoeOqQ2y6SsxJJO5YVbAhS//kA1xMsjpvf
 fZtbYvFiu/sXHgwmzl+QuDnDbXANhKTTgAQU2/GSUoooSmiTYV0653oVwpjxArvKR4ZBMbSnizy
 10Wa/ulmmA6vmn/uEJTKrgDfxmQgCh0GqwGe5fZUKQwFaVyVr0CzgRIlWuk7a+ofpLzRGe7YZqb
 Tlx8X9gLGssPvvj6uONDBVlRL2iybbhTISAXeZ4yyaVifBsym+rz+EG5mrLwnjTkHrWs04sgQU6
 yU56K46ZS+KR9hNdPWIjSDatl24bbfCfAqrZ88FBh5jo0iKqeR9cp8hXKbAoPLJ9MVPIBzSQ2ym
 kz5UaxY28K5EO+kBWhT5Ez46EMvwFxL+ZODxjJh7Ckl6UP5+tIYNbm+HppFcnsfDBDDxNtQIdAP
 DVTq+7q+2fjTDOpFdq0nH0suppD4Zhq7XBuXW/X+90hE/YCbgmuwyo0ZvJmB8ss8OqxPY3EOfY0
 TnZRelBbudQNn46CHcYHyO8mIrk40Z411xeGO0ww+qbVil/IMFLGRwp/JHs/kAQcla6/SeEIbDQ
 HBiINz5m+A4kGyA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

...and remove the legacy dprintks.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c |  8 ++------
 fs/nfsd/nfs4proc.c |  2 ++
 fs/nfsd/nfsproc.c  |  4 +---
 fs/nfsd/trace.h    | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 4fd3c2284eb96c1d712639675140412b84eadb2f..b9ed55a4cdd740bc0aa84b7cbc0e37906d55d666 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -592,9 +592,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	struct nfsd3_readdirres  *resp = rqstp->rq_resp;
 	loff_t		offset;
 
-	dprintk("nfsd: READDIR(3)  %s %d bytes at %d\n",
-				SVCFH_fmt(&argp->fh),
-				argp->count, (u32) argp->cookie);
+	trace_nfsd3_proc_readdir(rqstp, &argp->fh, argp->cookie, argp->count);
 
 	nfsd3_init_dirlist_pages(rqstp, resp, argp->count);
 
@@ -626,9 +624,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 	struct nfsd3_readdirres  *resp = rqstp->rq_resp;
 	loff_t	offset;
 
-	dprintk("nfsd: READDIR+(3) %s %d bytes at %d\n",
-				SVCFH_fmt(&argp->fh),
-				argp->count, (u32) argp->cookie);
+	trace_nfsd3_proc_readdirplus(rqstp, &argp->fh, argp->cookie, argp->count);
 
 	nfsd3_init_dirlist_pages(rqstp, resp, argp->count);
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7e6c80e0482a997d4085c87dae88d10c2f06b77b..8dd1233693dc82febe300f6f2714059c718909bc 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1080,6 +1080,8 @@ nfsd4_readdir(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	u64 cookie = readdir->rd_cookie;
 	static const nfs4_verifier zeroverf;
 
+	trace_nfsd4_readdir(rqstp, &cstate->current_fh, cookie, readdir->rd_dircount);
+
 	/* no need to check permission - this will be done in nfsd_readdir() */
 
 	if (readdir->rd_bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1)
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index d99e1bff2f8a99e477e3cf21eb7058cfe40a7cb4..ce3f1ca636f79687e65077effcc0588639d9366d 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -606,9 +606,7 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 	struct nfsd_readdirres *resp = rqstp->rq_resp;
 	loff_t		offset;
 
-	dprintk("nfsd: READDIR  %s %d bytes at %d\n",
-		SVCFH_fmt(&argp->fh),		
-		argp->count, argp->cookie);
+	trace_nfsd_proc_readdir(rqstp, &argp->fh, argp->cookie, argp->count);
 
 	nfsd_init_dirlist_pages(rqstp, resp, argp->count);
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 7bf3ee4acd9862171cae5caefced3507f4897e90..1d48a37dd33fb4c6e338534d576bcc8fd1a8f54d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2574,6 +2574,38 @@ DEFINE_NFSD_VFS_RENAME_EVENT(nfsd_proc_rename);
 DEFINE_NFSD_VFS_RENAME_EVENT(nfsd3_proc_rename);
 DEFINE_NFSD_VFS_RENAME_EVENT(nfsd4_rename);
 
+DECLARE_EVENT_CLASS(nfsd_vfs_readdir_class,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh *fhp,
+		 u64 cookie, u32 count),
+	TP_ARGS(rqstp, fhp, cookie, count),
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS(rqstp)
+		__field(u32, fh_hash)
+		__field(u64, cookie)
+		__field(u32, count)
+	),
+	TP_fast_assign(
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->cookie = cookie;
+		__entry->count = count;
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x cookie=0x%llx count=%u",
+		  __entry->xid, __entry->fh_hash, __entry->cookie, __entry->count)
+);
+
+#define DEFINE_NFSD_VFS_READDIR_EVENT(__name)					\
+	DEFINE_EVENT(nfsd_vfs_readdir_class, __name,				\
+		     TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp,	\
+			      u64 cookie, u32 count),				\
+		     TP_ARGS(rqstp, fhp, cookie, count))
+
+DEFINE_NFSD_VFS_READDIR_EVENT(nfsd_proc_readdir);
+DEFINE_NFSD_VFS_READDIR_EVENT(nfsd3_proc_readdir);
+DEFINE_NFSD_VFS_READDIR_EVENT(nfsd3_proc_readdirplus);
+DEFINE_NFSD_VFS_READDIR_EVENT(nfsd4_readdir);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH

-- 
2.49.0


