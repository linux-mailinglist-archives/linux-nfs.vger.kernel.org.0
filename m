Return-Path: <linux-nfs+bounces-11060-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 497A6A82814
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 16:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648761BC211E
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C294268C4C;
	Wed,  9 Apr 2025 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHq+9KFs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DA7268C50;
	Wed,  9 Apr 2025 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209192; cv=none; b=gd2XfMceReT8I6/Bvhn6ntVU2z99G7sG/4Gsm5RIQAbp92BLTfqUet1AlqbKr4y0bVmqZDq7onLqHNa0kfByPuXFLajW9AK1lqhyDdMZquifuUagiBTtDLSee0AB6WgCkMPzOamYQ440++Wa5dui7pYlROQB46AtsOAijf1FcmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209192; c=relaxed/simple;
	bh=YP8MVqkc2wYCpRP5TRXKJks7JhMz5pr10dLGKRWIxqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zn6ILIMHdtlDwSjqaz8I7HEu1O00hl6wv/8mmknK8toIe9uWhsGe5clZ08XgkgHV3E8n6Okpf8FBl1PhAG3qFeC8GcjpQ/wxCSWobjAgvfxYJV9QWTPZs4ul4mL/YbBXYDKzMtfm+vP2OMpGfobECBJIfxeFwzhktm/bT//JRTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHq+9KFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03792C4CEE7;
	Wed,  9 Apr 2025 14:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209191;
	bh=YP8MVqkc2wYCpRP5TRXKJks7JhMz5pr10dLGKRWIxqk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nHq+9KFsriENKspAxKaipPJL6TtRIav5du+O11O/QodNrEpmSeb7Hl0lobk1U68zf
	 FqeC4tJkUbJR+wb/HeisqXxd6SrWtFkgR5RY+oFNPirn/hu5vdB2VI16I0NuTTX2S7
	 Y/ErqAdordZd2jO5KWzMgzGryactwE7aAPCeYeZCPlkBCa008pdFDFVtsu/6piWBC5
	 oN2TlwUrEFIiMIoys0di17EmCoggxM+4jxJ5vqH5JL4Ij3x+UdgRDTPVEia8FX3aOi
	 zWdvhxlVS9ngeXTdbDcQUO51RCIACsJTxGfwBS0goCk2/XTLDd7FPGbwtROUeEZvTa
	 WnNINH+oks2mg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 09 Apr 2025 10:32:32 -0400
Subject: [PATCH v2 10/12] nfsd: add tracepoints to rename events
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-nfsd-tracepoints-v2-10-cf4e084fdd9c@kernel.org>
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
In-Reply-To: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4407; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YP8MVqkc2wYCpRP5TRXKJks7JhMz5pr10dLGKRWIxqk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn9oUbVSzit7w0zJS22tgFmHjNdb2zuwvgZH8ZR
 4DHn0BAeDiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/aFGwAKCRAADmhBGVaC
 FcJGEAC3ACJE3QEArhYnBqaeoPRgkMg2Ir5IDEbaDehNIHMm8ov/btyUom5EAIbastz/rOMRqJl
 rS/DYaPjYPQF4D2LkJAjDZ6VVS7s8b0putiBRfArKxespJv2f9/m3jfoRMrEakcRUrCtur9EEt6
 XO2t2ITbE2Bwv3mtwuwbAnQ5/DXF6rYQ/Sa4ykRT5b/qmEkTYRf/zRuge6RN3qt16EcTGYBkznT
 Sv4p2eekyEpvxLd3oOreYfvBIHcETKzogFFvr7TOp9oCmeOcnwpgsNM52YJy8yi5/bIO81XBAPO
 5bHdb4CMLrp0zqFjqWGIqqFAhnHzH9tr0XnrgakuacjkMw+evmCm2a9APxVcaQQr131kd9nK5BI
 FVPR1Z8Y9Aop42vxmn9YlmaOZb5+nvhoNLj7Yg3rWrlJ+YtXOFszETzqUu3UhbRdf/4Wn9l6jK1
 gHaXdweUSeGO4Df2wOVBfl3hO7kS1PqITiAe0jqSdKho2xRT+D1pWMd7NAQoPs/E7Ojb1EUv9x+
 ZGdkjcarN2Yvy+ZJzlyrMnynkhZ2V7m+k5bL4hLJwEzeslRvsUNsAGGjTxgJmJ86Yp+pMmjwZYC
 /TmQ69WlTQ45awz7zogOCu0A1p6NCEURk9mT9ohIAnkV9P6+6D6QF3JWV+3TOaxx8bmBysrDUGM
 O2RoW+AncQbsLHQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

...and remove the legacy dprintks.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c | 10 ++--------
 fs/nfsd/nfs4proc.c |  4 ++++
 fs/nfsd/nfsproc.c  |  6 ++----
 fs/nfsd/trace.h    | 40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 8893bf5e0b1d15b24e9c2c71fa1a8a09586a03d3..4fd3c2284eb96c1d712639675140412b84eadb2f 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -535,14 +535,8 @@ nfsd3_proc_rename(struct svc_rqst *rqstp)
 	struct nfsd3_renameargs *argp = rqstp->rq_argp;
 	struct nfsd3_renameres *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: RENAME(3)   %s %.*s ->\n",
-				SVCFH_fmt(&argp->ffh),
-				argp->flen,
-				argp->fname);
-	dprintk("nfsd: -> %s %.*s\n",
-				SVCFH_fmt(&argp->tfh),
-				argp->tlen,
-				argp->tname);
+	trace_nfsd3_proc_rename(rqstp, &argp->ffh, &argp->tfh, argp->fname,
+				argp->flen, argp->tname, argp->tlen);
 
 	fh_copy(&resp->ffh, &argp->ffh);
 	fh_copy(&resp->tfh, &argp->tfh);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 8524e78201e22984517e93cd9a2834190266c633..7e6c80e0482a997d4085c87dae88d10c2f06b77b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1132,6 +1132,10 @@ nfsd4_rename(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_rename *rename = &u->rename;
 	__be32 status;
 
+	trace_nfsd4_rename(rqstp, &cstate->save_fh, &cstate->current_fh,
+			   rename->rn_sname, rename->rn_snamelen,
+			   rename->rn_tname, rename->rn_tnamelen);
+
 	if (opens_in_grace(SVC_NET(rqstp)))
 		return nfserr_grace;
 	status = nfsd_rename(rqstp, &cstate->save_fh, rename->rn_sname,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 55656bb0264c31c10419ed41240c91ba66493106..d99e1bff2f8a99e477e3cf21eb7058cfe40a7cb4 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -461,10 +461,8 @@ nfsd_proc_rename(struct svc_rqst *rqstp)
 	struct nfsd_renameargs *argp = rqstp->rq_argp;
 	struct nfsd_stat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: RENAME   %s %.*s -> \n",
-		SVCFH_fmt(&argp->ffh), argp->flen, argp->fname);
-	dprintk("nfsd:        ->  %s %.*s\n",
-		SVCFH_fmt(&argp->tfh), argp->tlen, argp->tname);
+	trace_nfsd_proc_rename(rqstp, &argp->ffh, &argp->tfh, argp->fname,
+			       argp->flen, argp->tname, argp->tlen);
 
 	resp->status = nfsd_rename(rqstp, &argp->ffh, argp->fname, argp->flen,
 				   &argp->tfh, argp->tname, argp->tlen);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index dd984917bd0a741ac545c06631ab2a7de8af5158..7bf3ee4acd9862171cae5caefced3507f4897e90 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2534,6 +2534,46 @@ DEFINE_NFSD_VFS_UNLINK_EVENT(nfsd3_proc_remove);
 DEFINE_NFSD_VFS_UNLINK_EVENT(nfsd3_proc_rmdir);
 DEFINE_NFSD_VFS_UNLINK_EVENT(nfsd4_remove);
 
+DECLARE_EVENT_CLASS(nfsd_vfs_rename_class,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh *sfhp,
+		 struct svc_fh *tfhp,
+		 const char *name,
+		 unsigned int namelen,
+		 const char *tgt,
+		 unsigned int tgtlen),
+	TP_ARGS(rqstp, sfhp, tfhp, name, namelen, tgt, tgtlen),
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS(rqstp)
+		__field(u32, sfh_hash)
+		__field(u32, tfh_hash)
+		__string_len(name, name, namelen)
+		__string_len(tgt, tgt, tgtlen)
+	),
+	TP_fast_assign(
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
+		__entry->sfh_hash = knfsd_fh_hash(&sfhp->fh_handle);
+		__entry->tfh_hash = knfsd_fh_hash(&tfhp->fh_handle);
+		__assign_str(name);
+		__assign_str(tgt);
+	),
+	TP_printk("xid=0x%08x sfh_hash=0x%08x tfh_hash=0x%08x name=%s target=%s",
+		  __entry->xid, __entry->sfh_hash, __entry->tfh_hash,
+		  __get_str(name), __get_str(tgt))
+);
+
+#define DEFINE_NFSD_VFS_RENAME_EVENT(__name)					\
+	DEFINE_EVENT(nfsd_vfs_rename_class, __name,				\
+		     TP_PROTO(struct svc_rqst *rqstp,				\
+			      struct svc_fh *sfhp, struct svc_fh *tfhp,		\
+			      const char *name, unsigned int namelen,		\
+			      const char *tgt, unsigned int tgtlen),		\
+		     TP_ARGS(rqstp, sfhp, tfhp, name, namelen, tgt, tgtlen))
+
+DEFINE_NFSD_VFS_RENAME_EVENT(nfsd_proc_rename);
+DEFINE_NFSD_VFS_RENAME_EVENT(nfsd3_proc_rename);
+DEFINE_NFSD_VFS_RENAME_EVENT(nfsd4_rename);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH

-- 
2.49.0


