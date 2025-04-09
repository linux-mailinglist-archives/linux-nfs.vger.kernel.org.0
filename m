Return-Path: <linux-nfs+bounces-11056-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A209A82806
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 16:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE031BA1D76
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 14:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51655267715;
	Wed,  9 Apr 2025 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q107yTs3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691025D908;
	Wed,  9 Apr 2025 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209188; cv=none; b=JTew4FLbublAc5hpbmBaguaILMzkq8nBZ10KRC45Z+sx72WxtI7e25RfPqdQz3rSW6Ws+wLuMJzug0azHzMg+tvwh31MnkK3C3zYeiklgwgTX8PrCBEFXArtaxpEw8sGOqzRXNR/4Cv2JPGLZUwNahy+r12KuxD2OXvMgqaluJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209188; c=relaxed/simple;
	bh=zAC5eP0LXF+hgwORpWpvsUmRBvw+t8mnhNhIY/cgPIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JxW8rZLMf5Md2Nat0xAWq2RWN008/tjBgvVaAnr8+LbLOiTQsRb24UUy+JcJBai9WLMZrG4aTe/Pf4GnR6udF1uhMtjg8MWHu08YP2V5Z9RmhTgqHqRuQJifTYyICHEdrbhghEpQPHdebtlcQxFKpenKLZXHQX/+5+ARcDaeKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q107yTs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C79C4CEEC;
	Wed,  9 Apr 2025 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209187;
	bh=zAC5eP0LXF+hgwORpWpvsUmRBvw+t8mnhNhIY/cgPIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q107yTs3+mm02BTQzIYlQYquns9ujrtYj2Qu5Fj0GBStTvfz8XFVnb4miFzxrnDq3
	 wdyH25GlP/zq+4j4hbPB+4YcSedkB6M7Ckxq5RNT2BELLNRJ1Xuwf3O/IF3EocbfYO
	 z+5oeBdhAxdLJlmuT0my4TXB6h+DhROo8qPj3bTYcp9LK7OpnWwdUCymApKogJq2ni
	 LVu2gDR3nbOTjWvYKWNR/NiStBg2fPyUniVcZiEf50VjFmMelqeitA2hUoiSrpEalK
	 GzI+8QaVm3JmfDsYpdTXc3D0nlq6WGZj08GOdU7H3lnGjxonrrATcxGC5Kn4g+iUa5
	 KEyGW8wO23eiw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 09 Apr 2025 10:32:28 -0400
Subject: [PATCH v2 06/12] nfsd: add tracepoints around nfsd_create events
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-nfsd-tracepoints-v2-6-cf4e084fdd9c@kernel.org>
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
In-Reply-To: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6343; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=zAC5eP0LXF+hgwORpWpvsUmRBvw+t8mnhNhIY/cgPIQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn9oUa+OgcktwyR8lbU2wdUf24sVUU7rVawtqnH
 obmVMeNm5+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/aFGgAKCRAADmhBGVaC
 FQCwD/wOA2Uel01YilhIR4K7BPvlJ2IfGvxwykJZLkSvP0bJvluO1HOpdWk+t8+q57faUkoKTDM
 hEJSBwJQKCjLzC3cEFcym++GVezNeZ5arl7b0O0X8sOUP+cScvRnxGoXxJEtFUmbUYtKz03f+TB
 hGroFkTjqkXs/zvVU3hjXCSvxvom8rb3B6/7C9eM/VkpjcTsArLxx2ITHsCnm3yD/eCtAxOwasR
 HCI/AFldw3t4cLCSG7tIAq//Ytt7gC9Nv2WmVyPy6GMrkgLXHa85aNNaA5aG55TCL8oIId247pE
 a3yhKOwDVsLAuRSrKvqTq8qnEgGkKxGiWhAdNcatU2g3M2XNZvQ4sK+TaF2LcXMnDk06f6/biIl
 PJZQDGlyQSHhBw35uJqJXATYXRwmGvqrEVztTfoOzFrjJfU3QHGE+P1xVuqgB6J1eXuuBa8tExo
 lRWISIywp+HLWpw3RHYRkf+l7h8n4g4lFSxGJMQDguY3E2UjTTt7HCm/E/PekqXOHsUb4YJtO/i
 FF6mGDYEeEWPcIrnkkibtZdLocieKMH2LamI9GGl+m+HL/YtIa3QBRszKlToL6TBeUH8AZEzygG
 gmLoTokxoez5CF95vHynCCUShA7vVvNre+WlK+eht0S/11Qy0DyvwQT2nFU3GAEL1gxHUlwp7yl
 xymF3XKi8X9hoDg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

...and remove the legacy dprintks.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs3proc.c | 18 +++++-------------
 fs/nfsd/nfs4proc.c | 29 +++++++++++++++++++++++++++++
 fs/nfsd/nfsproc.c  |  6 +++---
 fs/nfsd/trace.h    | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 372bdcf5e07a5c835da240ecebb02e3576eb2ca6..ea1280970ea11b2a82f0de88ad0422eef7063d6d 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -14,6 +14,7 @@
 #include "xdr3.h"
 #include "vfs.h"
 #include "filecache.h"
+#include "trace.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
@@ -380,10 +381,7 @@ nfsd3_proc_create(struct svc_rqst *rqstp)
 	struct nfsd3_diropres *resp = rqstp->rq_resp;
 	svc_fh *dirfhp, *newfhp;
 
-	dprintk("nfsd: CREATE(3)   %s %.*s\n",
-				SVCFH_fmt(&argp->fh),
-				argp->len,
-				argp->name);
+	trace_nfsd3_proc_create(rqstp, &argp->fh, S_IFREG, argp->name, argp->len);
 
 	dirfhp = fh_copy(&resp->dirfh, &argp->fh);
 	newfhp = fh_init(&resp->fh, NFS3_FHSIZE);
@@ -405,10 +403,7 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 		.na_iattr	= &argp->attrs,
 	};
 
-	dprintk("nfsd: MKDIR(3)    %s %.*s\n",
-				SVCFH_fmt(&argp->fh),
-				argp->len,
-				argp->name);
+	trace_nfsd3_proc_mkdir(rqstp, &argp->fh, S_IFDIR, argp->name, argp->len);
 
 	argp->attrs.ia_valid &= ~ATTR_SIZE;
 	fh_copy(&resp->dirfh, &argp->fh);
@@ -471,13 +466,10 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 	struct nfsd_attrs attrs = {
 		.na_iattr	= &argp->attrs,
 	};
-	int type;
+	int type = nfs3_ftypes[argp->ftype];
 	dev_t	rdev = 0;
 
-	dprintk("nfsd: MKNOD(3)    %s %.*s\n",
-				SVCFH_fmt(&argp->fh),
-				argp->len,
-				argp->name);
+	trace_nfsd3_proc_mknod(rqstp, &argp->fh, type, argp->name, argp->len);
 
 	fh_copy(&resp->dirfh, &argp->fh);
 	fh_init(&resp->fh, NFS3_FHSIZE);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 6e23d6103010197c0316b07c189fe12ec3033812..2c795103deaa4044596bd07d90db788169a32a0c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -250,6 +250,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32 status;
 	int host_err;
 
+	trace_nfsd4_create_file(rqstp, fhp, S_IFREG, open->op_fname, open->op_fnamelen);
+
 	if (isdotent(open->op_fname, open->op_fnamelen))
 		return nfserr_exist;
 	if (!(iap->ia_valid & ATTR_MODE))
@@ -807,6 +809,29 @@ nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status;
 }
 
+static umode_t nfs_type_to_vfs_type(enum nfs_ftype4 nfstype)
+{
+	switch (nfstype) {
+	case NF4REG:
+		return S_IFREG;
+	case NF4DIR:
+		return S_IFDIR;
+	case NF4BLK:
+		return S_IFBLK;
+	case NF4CHR:
+		return S_IFCHR;
+	case NF4LNK:
+		return S_IFLNK;
+	case NF4SOCK:
+		return S_IFSOCK;
+	case NF4FIFO:
+		return S_IFIFO;
+	default:
+		break;
+	}
+	return 0;
+}
+
 static __be32
 nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
@@ -822,6 +847,10 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	dev_t rdev;
 
+	trace_nfsd4_create(rqstp, &cstate->current_fh,
+			   nfs_type_to_vfs_type(create->cr_type),
+			   create->cr_name, create->cr_namelen);
+
 	fh_init(&resfh, NFS4_FHSIZE);
 
 	status = fh_verify(rqstp, &cstate->current_fh, S_IFDIR, NFSD_MAY_NOP);
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 6dda081eb24c00b834ab0965c3a35a12115bceb7..33d8cbf8785588d38d4ec5efd769c1d1d06c6a91 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "xdr.h"
 #include "vfs.h"
+#include "trace.h"
 
 #define NFSDDBG_FACILITY		NFSDDBG_PROC
 
@@ -292,8 +293,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	int		hosterr;
 	dev_t		rdev = 0, wanted = new_decode_dev(attr->ia_size);
 
-	dprintk("nfsd: CREATE   %s %.*s\n",
-		SVCFH_fmt(dirfhp), argp->len, argp->name);
+	trace_nfsd_proc_create(rqstp, dirfhp, S_IFREG, argp->name, argp->len);
 
 	/* First verify the parent file handle */
 	resp->status = fh_verify(rqstp, dirfhp, S_IFDIR, NFSD_MAY_EXEC);
@@ -548,7 +548,7 @@ nfsd_proc_mkdir(struct svc_rqst *rqstp)
 		.na_iattr	= &argp->attrs,
 	};
 
-	dprintk("nfsd: MKDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
+	trace_nfsd_proc_mkdir(rqstp, &argp->fh, S_IFDIR, argp->name, argp->len);
 
 	if (resp->fh.fh_dentry) {
 		printk(KERN_WARNING
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 382849d7c321d6ded8213890c2e7075770aa716c..c6aff23a845f06c87e701d57ec577c2c5c5a743c 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2391,6 +2391,45 @@ TRACE_EVENT(nfsd_lookup_dentry,
 	TP_printk("xid=0x%08x fh_hash=0x%08x name=%s",
 		  __entry->xid, __entry->fh_hash, __get_str(name))
 );
+
+DECLARE_EVENT_CLASS(nfsd_vfs_create_class,
+	TP_PROTO(struct svc_rqst *rqstp,
+		 struct svc_fh *fhp,
+		 umode_t type,
+		 const char *name,
+		 unsigned int len),
+	TP_ARGS(rqstp, fhp, type, name, len),
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS(rqstp)
+		__field(u32, fh_hash)
+		__field(umode_t, type)
+		__string_len(name, name, len)
+	),
+	TP_fast_assign(
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqstp);
+		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->type = type;
+		__assign_str(name);
+	),
+	TP_printk("xid=0x%08x fh_hash=0x%08x type=%s name=%s",
+		  __entry->xid, __entry->fh_hash,
+		  show_fs_file_type(__entry->type), __get_str(name))
+);
+
+#define DEFINE_NFSD_VFS_CREATE_EVENT(__name)						\
+	DEFINE_EVENT(nfsd_vfs_create_class, __name,					\
+		     TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp,		\
+			      umode_t type, const char *name, unsigned int len),	\
+		     TP_ARGS(rqstp, fhp, type, name, len))
+
+DEFINE_NFSD_VFS_CREATE_EVENT(nfsd_proc_create);
+DEFINE_NFSD_VFS_CREATE_EVENT(nfsd_proc_mkdir);
+DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_create);
+DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_mkdir);
+DEFINE_NFSD_VFS_CREATE_EVENT(nfsd3_proc_mknod);
+DEFINE_NFSD_VFS_CREATE_EVENT(nfsd4_create);
+DEFINE_NFSD_VFS_CREATE_EVENT(nfsd4_create_file);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH

-- 
2.49.0


