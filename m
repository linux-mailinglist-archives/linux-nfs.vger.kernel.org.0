Return-Path: <linux-nfs+bounces-11057-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B290FA8280C
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 16:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E19170658
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 14:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47637267B04;
	Wed,  9 Apr 2025 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tys4fbeJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7E9267AF7;
	Wed,  9 Apr 2025 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209189; cv=none; b=MfGIH4hlt7UvjHZCef824XCkQzmX+ckPLdGxlCb1qbPDevP/N1/zpLd8UxE9qB+IGzGyZaf8pjT8GgxXna4nXCLzyBwAacEwqkAxTQJXbVZtug+t6NMRyxeQcfORScFcGT0VMoOeXLU1bK4NEQqkldjKyqPl0Ct2roFc//28L5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209189; c=relaxed/simple;
	bh=ekUDtU0ckGeDcsMCKYAcCgd1T5HW+m+3MYIY/k+QHlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RrXGKgWdNRpiFiJ6ZbeMHG3UgWaAtBXexCll1+XrLFcYwXXA6BIJExVMZsLOXsf7/Q3p3rlcECU5tk4OnHOczU2HKNE/9jZDuvXzjugr5yyuX9bmi7S/v0GkOhL3JUPP74HrVlONwqqeANkq8/c7XcBJQEjyE3yMzkXunYSeBuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tys4fbeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7B8C4CEE9;
	Wed,  9 Apr 2025 14:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209188;
	bh=ekUDtU0ckGeDcsMCKYAcCgd1T5HW+m+3MYIY/k+QHlo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tys4fbeJu83/cY8C8+fskxatUevxi6bhwNT5jCBt3Czh7c/5lCqv4qU80ljtm+nsi
	 A/J9utegfxWOZZ4vAP8CWfNg1ExZEu+NyR3ZS6kp0LOIb1qIsYybXtJpsjrX2IFftO
	 HekMX7r3GHA7a1OgqF/q3tSPq/PiNFiEDbislVQwcHIhRFA1suJ8wAhq7v8zjN4GgV
	 M+9uD6ssLzsIKGOCi8sdwB2PY+6ITL2Oz4jrsSN1usvkHXGEHBkE0cvLdl6skcUEH3
	 sdvvgL6WKJJ13E74wuewTU8WC/PMqts5aeEQyoseulvjTDuHr9oh8kSZ8gKv5EBC5K
	 ufNJNsi8lDxiw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 09 Apr 2025 10:32:29 -0400
Subject: [PATCH v2 07/12] nfsd: add tracepoints for symlink events
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-nfsd-tracepoints-v2-7-cf4e084fdd9c@kernel.org>
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
In-Reply-To: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4368; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ekUDtU0ckGeDcsMCKYAcCgd1T5HW+m+3MYIY/k+QHlo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn9oUasbGQ0nDBUIo1tqWpeldYe2wlnI9MgxrON
 nEQMrEnHDmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/aFGgAKCRAADmhBGVaC
 FR+QD/0bTiH3CTaaKlaYw9cnL9R1uU/mxQUdAuY/B7tzcm/tpy4GV+UBFF26H0dgWBbatF8kqdZ
 azGMZLEdQ1muFx//XNsETF0Fas1i5uNZ1cowctsoJd5B4mdrlMUzWYq6AlEWRkYHMA+O9Bi9OtY
 SkhfvmGKOCqqI7cPKBKqqj+4wpbnNY7aHX9TZmFBEl9gJmpNilWCCfzWE/d4GpQLCK4c2JEr0bt
 iEFLF5vRbo4H/L1ez4JvuRfryw9di6uzeUnexVqOIisHQrWKFQE2QRxI04sVD+3Mhf62CzZXi8R
 Pb/eEcP32BGB71Jrco7r+jjO02EgaSJW3U4plVb9LVRQPX95PoRxoNQfaauanKBwz0lKIJt578H
 c4d7tWg3Z5tu0QEvJYL2A/IjM5rp4FVq11o4JzEJzpzVeggIKWNFJhR+DB3GkFxi1pxHKLaB3uy
 UJ4mBxxXm77IktahQ1eomGDglSHm8am59tqAYzesCV+v8lNXq2BHBH2qM3adavu5L0UpDv6BGOc
 hOTAJpbzJulUG8FSB1TPMeJ8jsNJMc42eZ2K0ajMlCeMxjjJK1nuBF7k2rATTvQzISnbBxqr0Vv
 6BILheVDyp71DlOpnSBMOo658Afi4Pks9y5dAFH6oEgpYIjDBMgBpP5PAN7DY7CTYDrbE/FcrbJ
 7yL4Gt5iDlM56ZA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

...and remove the legacy dprintks.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c |  8 +++-----
 fs/nfsd/nfs4proc.c |  3 +++
 fs/nfsd/nfsproc.c  |  7 +++----
 fs/nfsd/trace.h    | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index ea1280970ea11b2a82f0de88ad0422eef7063d6d..587fc92597e7c77d078e871b8d12684c6b5efa2d 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -423,6 +423,9 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
 		.na_iattr	= &argp->attrs,
 	};
 
+	trace_nfsd3_proc_symlink(rqstp, &argp->ffh, argp->fname, argp->flen,
+				 argp->tname, argp->tlen);
+
 	if (argp->tlen == 0) {
 		resp->status = nfserr_inval;
 		goto out;
@@ -440,11 +443,6 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
 		goto out;
 	}
 
-	dprintk("nfsd: SYMLINK(3)  %s %.*s -> %.*s\n",
-				SVCFH_fmt(&argp->ffh),
-				argp->flen, argp->fname,
-				argp->tlen, argp->tname);
-
 	fh_copy(&resp->dirfh, &argp->ffh);
 	fh_init(&resp->fh, NFS3_FHSIZE);
 	resp->status = nfsd_symlink(rqstp, &resp->dirfh, argp->fname,
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2c795103deaa4044596bd07d90db788169a32a0c..e22596a2e311861be1e4f595d77547be04634ce7 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -873,6 +873,9 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	current->fs->umask = create->cr_umask;
 	switch (create->cr_type) {
 	case NF4LNK:
+		trace_nfsd4_symlink(rqstp, &cstate->current_fh,
+				    create->cr_name, create->cr_namelen,
+				    create->cr_data, create->cr_datalen);
 		status = nfsd_symlink(rqstp, &cstate->current_fh,
 				      create->cr_name, create->cr_namelen,
 				      create->cr_data, &attrs, &resfh);
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 33d8cbf8785588d38d4ec5efd769c1d1d06c6a91..0674ed6b978f6caa1325a9271f2fde9b3ef60945 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -506,6 +506,9 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
 	};
 	struct svc_fh	newfh;
 
+	trace_nfsd_proc_symlink(rqstp, &argp->ffh, argp->fname, argp->flen,
+				argp->tname, argp->tlen);
+
 	if (argp->tlen > NFS_MAXPATHLEN) {
 		resp->status = nfserr_nametoolong;
 		goto out;
@@ -519,10 +522,6 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
 		goto out;
 	}
 
-	dprintk("nfsd: SYMLINK  %s %.*s -> %.*s\n",
-		SVCFH_fmt(&argp->ffh), argp->flen, argp->fname,
-		argp->tlen, argp->tname);
-
 	fh_init(&newfh, NFS_FHSIZE);
 	resp->status = nfsd_symlink(rqstp, &argp->ffh, argp->fname, argp->flen,
 				    argp->tname, &attrs, &newfh);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index c6aff23a845f06c87e701d57ec577c2c5c5a743c..850dbf1240b234b67dd7d75d6903c0f49dc01261 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2430,6 +2430,41 @@ DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_mknod);
 DEFINE_NFSD_VFS_CREATE_EVENT(nfsd4_create);
 DEFINE_NFSD_VFS_CREATE_EVENT(nfsd4_create_file);
 
+DECLARE_EVENT_CLASS(nfsd_vfs_symlink_class,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh *fhp,
+		 const char *name,
+		 unsigned int namelen,
+		 const char *tgt,
+		 unsigned int tgtlen),
+	TP_ARGS(rqstp, fhp, name, namelen, tgt, tgtlen),
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS(rqstp)
+		__field(u32, fh_hash)
+		__string_len(name, name, namelen)
+		__string_len(tgt, tgt, tgtlen)
+	),
+	TP_fast_assign(
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__assign_str(name);
+		__assign_str(tgt);
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x name=%s target=%s",
+		  __entry->xid, __entry->fh_hash,
+		  __get_str(name), __get_str(tgt))
+);
+
+#define DEFINE_NFSD_VFS_SYMLINK_EVENT(__name)					\
+	DEFINE_EVENT(nfsd_vfs_symlink_class, __name,				\
+		     TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp,	\
+			      const char *name, unsigned int namelen,		\
+			      const char *tgt, unsigned int tgtlen),		\
+		     TP_ARGS(rqstp, fhp, name, namelen, tgt, tgtlen))
+
+DEFINE_NFSD_VFS_SYMLINK_EVENT(nfsd_proc_symlink);
+DEFINE_NFSD_VFS_SYMLINK_EVENT(nfsd3_proc_symlink);
+DEFINE_NFSD_VFS_SYMLINK_EVENT(nfsd4_symlink);
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH

-- 
2.49.0


