Return-Path: <linux-nfs+bounces-11059-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB72A82811
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 16:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB821BA56C2
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 14:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5DC268685;
	Wed,  9 Apr 2025 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMwJfusd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53738267F79;
	Wed,  9 Apr 2025 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209191; cv=none; b=KEGyWhOVv1OZzhvH9aIYXHuIYlhHzzG3xqMPhYFYuBjWr+M6D3ULmRCg32X10weJcgQjPuZCxTYbRxjv8kUoKz3iW41TaDOiny9o+5fP74Sl6uOEIKkCyo4TP2gv4DVfyt1nsQ6Iri9yFxoBqd6j0GRD6Tf7FCRw0hsRV1xcqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209191; c=relaxed/simple;
	bh=3lBHNRhbn3AyscwreqTw127PVjP+C97TIOi1V8Aszcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LaR74r71Qx3NU8f5KNQKy9gJGL5WFJWvjsYfGSG6YwaNfXgxmdb4ar+vJLQVArgx/t0e38/BruyAMJD1li9VKlzsFKFFLx1bwC+kThJGtUsMwS564DpynWFdKBACmdAB4dF5brO+Vlvmfk2JdYMTZAmrB6l5xd8lmRvVvsEsRj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMwJfusd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C12C4AF0C;
	Wed,  9 Apr 2025 14:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209190;
	bh=3lBHNRhbn3AyscwreqTw127PVjP+C97TIOi1V8Aszcg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HMwJfusdPxV8voWS7Sqw2PBQO6q5upDqmm2/Yo9E8uvCMwGMKLMbDRizirIkEohMK
	 xSFK0LwKrU2SYjUu9xw4HRqeKKIkt5fElSm70M37P3WvhIBcR2NB9yLSCtOJvWWeTI
	 Fvu2UxREQRJSTpsiB3q+tSf0tOeETs4Ya4rEJJAIXkMznCCY/7MIlBlBNYbq6ei4CS
	 flh/FCVLSqVRho7+RUDhQmlAePI6m2vRtgQdNbxOJUiP2jKlyv+3XY7I10hp89qZgC
	 imb9fMYKUqbB5vONX/U0eCQiruwgYqA7HPcT3m234HfoZvD6ddg3KwmAuBKzKrgdna
	 O1p/WO3EL3NVQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 09 Apr 2025 10:32:31 -0400
Subject: [PATCH v2 09/12] nfsd: add tracepoints for unlink events
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-nfsd-tracepoints-v2-9-cf4e084fdd9c@kernel.org>
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
In-Reply-To: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4556; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3lBHNRhbn3AyscwreqTw127PVjP+C97TIOi1V8Aszcg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn9oUbB1oc1qBHjTKKUupXcV+Lp28pd7wRhuufh
 OsyAZPZKi2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/aFGwAKCRAADmhBGVaC
 Fa3OEAC0HXdQHCfGj5TMz1y7xL4fE7crJNIFSPJViMYkZMkU5Px+tBZy31jznxY0TKewDu0GvPR
 YPgDckRf/srWi3yVCEy5CGOYcaaIaTJ5yq4Lt/+d9o4ZNAvfb/9nzGDJCwZY3Ke2+98+DGcGieQ
 yEaUI7p6XbnYc2mE9ax0mgLSTQTfyyQzNOB//W4DSNeA6vOHm+ERC/oNdYg4NPymcYMar+w/Wes
 n5jnvf/VXkqGY/YwGI63iCENvPs4mVSEivY1VFZD9KJlbWEC2SUlOeTACK41LePP956HtsM5P3S
 +rm1uwdBVI9FWdTQehYFy6PdNH078lFOh0t39GhXXwC7QvtCkGAoprWB8k/khLoOj5L6Qhn5uIk
 WzBD/rM8ds3H/WNxQFgb43iX3GlQiY6SoOxK9/FqQaijS3mnbjo/m3RbkFmY1wDwMONwvvQRX5c
 bo+5waTt56qdW4hXNyIvqGnQl+q9zWdUV6YSNnekxHjMfsLoC6zcyTFc6pDc++ued3aN1z832EZ
 AHvBzE3DKIPcXbWJumEa0nt4p20myM2el0DHqVd5PyYtR1V7c7mpKLAsQ3IbhShDim2sCIMNsQQ
 TGtw6wbzxgAc2b3ErF6NQ5zCYn+xdlFqSz+gUkinXS+/+r6P3pqgj6VCgLv7giS1hf2TeHic4yZ
 XmWcY+LElztba2g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

...and remove the legacy dprintks.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c | 10 ++--------
 fs/nfsd/nfs4proc.c |  2 ++
 fs/nfsd/nfsproc.c  |  5 ++---
 fs/nfsd/trace.h    | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 97aaf98d0af7dc565b21937ecca4852dd9253221..8893bf5e0b1d15b24e9c2c71fa1a8a09586a03d3 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -501,10 +501,7 @@ nfsd3_proc_remove(struct svc_rqst *rqstp)
 	struct nfsd3_diropargs *argp = rqstp->rq_argp;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: REMOVE(3)   %s %.*s\n",
-				SVCFH_fmt(&argp->fh),
-				argp->len,
-				argp->name);
+	trace_nfsd3_proc_remove(rqstp, &argp->fh, argp->name, argp->len);
 
 	/* Unlink. -S_IFDIR means file must not be a directory */
 	fh_copy(&resp->fh, &argp->fh);
@@ -523,10 +520,7 @@ nfsd3_proc_rmdir(struct svc_rqst *rqstp)
 	struct nfsd3_diropargs *argp = rqstp->rq_argp;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: RMDIR(3)    %s %.*s\n",
-				SVCFH_fmt(&argp->fh),
-				argp->len,
-				argp->name);
+	trace_nfsd3_proc_rmdir(rqstp, &argp->fh, argp->name, argp->len);
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_unlink(rqstp, &resp->fh, S_IFDIR,
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7dffae2f16d9fa8dea043b7bf300eaca52c0aa7c..8524e78201e22984517e93cd9a2834190266c633 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1114,6 +1114,8 @@ nfsd4_remove(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_remove *remove = &u->remove;
 	__be32 status;
 
+	trace_nfsd4_remove(rqstp, &cstate->current_fh, remove->rm_name, remove->rm_namelen);
+
 	if (opens_in_grace(SVC_NET(rqstp)))
 		return nfserr_grace;
 	status = nfsd_unlink(rqstp, &cstate->current_fh, 0,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index b40b5ab1d3b17dd8974fcaeda3ac7c26baee67cf..55656bb0264c31c10419ed41240c91ba66493106 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -445,8 +445,7 @@ nfsd_proc_remove(struct svc_rqst *rqstp)
 	struct nfsd_diropargs *argp = rqstp->rq_argp;
 	struct nfsd_stat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: REMOVE   %s %.*s\n", SVCFH_fmt(&argp->fh),
-		argp->len, argp->name);
+	trace_nfsd_proc_remove(rqstp, &argp->fh, argp->name, argp->len);
 
 	/* Unlink. -SIFDIR means file must not be a directory */
 	resp->status = nfsd_unlink(rqstp, &argp->fh, -S_IFDIR,
@@ -572,7 +571,7 @@ nfsd_proc_rmdir(struct svc_rqst *rqstp)
 	struct nfsd_diropargs *argp = rqstp->rq_argp;
 	struct nfsd_stat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: RMDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
+	trace_nfsd_proc_rmdir(rqstp, &argp->fh, argp->name, argp->len);
 
 	resp->status = nfsd_unlink(rqstp, &argp->fh, S_IFDIR,
 				   argp->name, argp->len);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 9ff919a08f424bfe023cf91244fe08effbdf993e..dd984917bd0a741ac545c06631ab2a7de8af5158 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2500,6 +2500,40 @@ DECLARE_EVENT_CLASS(nfsd_vfs_link_class,
 DEFINE_NFSD_VFS_LINK_EVENT(nfsd_proc_link);
 DEFINE_NFSD_VFS_LINK_EVENT(nfsd3_proc_link);
 DEFINE_NFSD_VFS_LINK_EVENT(nfsd4_link);
+
+DECLARE_EVENT_CLASS(nfsd_vfs_unlink_class,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh *fhp,
+		 const char *name,
+		 unsigned int len),
+	TP_ARGS(rqstp, fhp, name, len),
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS(rqstp)
+		__field(u32, fh_hash)
+		__string_len(name, name, len)
+	),
+	TP_fast_assign(
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__assign_str(name);
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x name=%s",
+		  __entry->xid, __entry->fh_hash,
+		  __get_str(name))
+);
+
+#define DEFINE_NFSD_VFS_UNLINK_EVENT(__name)						\
+	DEFINE_EVENT(nfsd_vfs_unlink_class, __name,					\
+		     TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp,		\
+			      const char *name, unsigned int len),			\
+		     TP_ARGS(rqstp, fhp, name, len))
+
+DEFINE_NFSD_VFS_UNLINK_EVENT(nfsd_proc_remove);
+DEFINE_NFSD_VFS_UNLINK_EVENT(nfsd_proc_rmdir);
+DEFINE_NFSD_VFS_UNLINK_EVENT(nfsd3_proc_remove);
+DEFINE_NFSD_VFS_UNLINK_EVENT(nfsd3_proc_rmdir);
+DEFINE_NFSD_VFS_UNLINK_EVENT(nfsd4_remove);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH

-- 
2.49.0


