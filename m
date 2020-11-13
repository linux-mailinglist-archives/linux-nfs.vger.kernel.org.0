Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA77F2B1DF2
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgKMPCt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMPCt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:02:49 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D475C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:02:49 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g17so6841679qts.5
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ughBf5cj0fVlg9AT/pfePNEsb5YuYzOEecguLnhUCaU=;
        b=D232lo+MLNCBb/YPHyCLNv5SC1ZITTHEh3/+1Yx4EqFgrD6KCEUFK2cS79hZ/uFxLE
         a0lzhXG07F9xhOrHxPGSgBDkixuOc/mlLKqcfi/RDUNqwXnlxareg2y6eB8AAj88Lw6k
         pccRHd+A9j/CoBiCmEd5NHh4qvs46F2jRrjlmV+VtNNszZodcJ1hORtJKx0SoVYCBEVW
         lheptB3eYfV8rfzqWBhLOnxmY7N0Gw6PtmR0BQFaNV4R7+SEl5mGEWidj5Q798EVEY1G
         L1CUZaZsah43UCP+w2k9fkHLR1FQLUwI6wgzO4UVIlSmUbCmqnN2gg28jJHamUJ2J5qN
         B+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ughBf5cj0fVlg9AT/pfePNEsb5YuYzOEecguLnhUCaU=;
        b=GeI7NOx1VroXrpzXwm8armelxcrhdASOBWRixr09QiUlXWfy2yE7VhrWCxMjTGjbgH
         5carOxMI9nRfKLhDLurmafWhnEL82mO4ff4mNkuFD0CJvwgKxk6PeFtPD7XbD+obpLjd
         8ox0XTDy5ZUVYg5l0ZDOknv2x9UxsIA6OEd/vIo/xbGMsZT4mmONDD6bryUgMcBwRRlv
         JLbwZQvS1M8TDQ/oGW4oPeY7lcmDQ0HdSfkLnT9wKgXHMvSDTBJSYakimoCSkUhhU49x
         xqB0XWm8IaZRA8QB+qxUKkwE6Uv0KErGUricOuCpQ7QHRuaICq0HSV8dRF0KlDXKinqV
         ndOg==
X-Gm-Message-State: AOAM530kFg27Q3WU909kSV78sRA02VwaagEKVKBzyYUonaKG9jDxG36t
        1bGALvrC7n3vBq2k4abgOiife19cQ8o=
X-Google-Smtp-Source: ABdhPJz7CeZfTtOFbnwVg2yQsubrpIr4L0LS9y0o98inj5NgcHGgSOIMed3574na50h3d1NT0fnn0w==
X-Received: by 2002:ac8:5985:: with SMTP id e5mr2354821qte.88.1605279766673;
        Fri, 13 Nov 2020 07:02:46 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 199sm6884214qkm.62.2020.11.13.07.02.45
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:02:46 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF2i1q032649
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:02:44 GMT
Subject: [PATCH v1 04/61] NFSD: Add common helpers to decode void args and
 encode void results
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:02:44 -0500
Message-ID: <160527976487.6186.6781888621062566433.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Start off the conversion to xdr_stream by de-duplicating the functions
that decode void arguments and encode void results.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs2acl.c  |   21 ++++-----------------
 fs/nfsd/nfs3acl.c  |    8 ++++----
 fs/nfsd/nfs3proc.c |   10 ++++------
 fs/nfsd/nfs3xdr.c  |   11 -----------
 fs/nfsd/nfs4proc.c |    8 ++++----
 fs/nfsd/nfs4xdr.c  |   12 ------------
 fs/nfsd/nfsd.h     |    8 ++++++++
 fs/nfsd/nfsproc.c  |   25 ++++++++++++-------------
 fs/nfsd/nfssvc.c   |   23 +++++++++++++++++++++++
 fs/nfsd/nfsxdr.c   |   10 ----------
 fs/nfsd/xdr.h      |    2 --
 fs/nfsd/xdr3.h     |    2 --
 fs/nfsd/xdr4.h     |    2 --
 13 files changed, 59 insertions(+), 83 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 6a900f770dd2..b0f66604532a 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -185,10 +185,6 @@ static __be32 nfsacld_proc_access(struct svc_rqst *rqstp)
 /*
  * XDR decode functions
  */
-static int nfsaclsvc_decode_voidarg(struct svc_rqst *rqstp, __be32 *p)
-{
-	return 1;
-}
 
 static int nfsaclsvc_decode_getaclargs(struct svc_rqst *rqstp, __be32 *p)
 {
@@ -255,15 +251,6 @@ static int nfsaclsvc_decode_accessargs(struct svc_rqst *rqstp, __be32 *p)
  * XDR encode functions
  */
 
-/*
- * There must be an encoding function for void results so svc_process
- * will work properly.
- */
-static int nfsaclsvc_encode_voidres(struct svc_rqst *rqstp, __be32 *p)
-{
-	return xdr_ressize_check(rqstp, p);
-}
-
 /* GETACL */
 static int nfsaclsvc_encode_getaclres(struct svc_rqst *rqstp, __be32 *p)
 {
@@ -378,10 +365,10 @@ struct nfsd3_voidargs { int dummy; };
 static const struct svc_procedure nfsd_acl_procedures2[5] = {
 	[ACLPROC2_NULL] = {
 		.pc_func = nfsacld_proc_null,
-		.pc_decode = nfsaclsvc_decode_voidarg,
-		.pc_encode = nfsaclsvc_encode_voidres,
-		.pc_argsize = sizeof(struct nfsd3_voidargs),
-		.pc_ressize = sizeof(struct nfsd3_voidargs),
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
 	},
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 34a394e50e1d..7c30876a31a1 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -245,10 +245,10 @@ struct nfsd3_voidargs { int dummy; };
 static const struct svc_procedure nfsd_acl_procedures3[3] = {
 	[ACLPROC3_NULL] = {
 		.pc_func = nfsd3_proc_null,
-		.pc_decode = nfs3svc_decode_voidarg,
-		.pc_encode = nfs3svc_encode_voidres,
-		.pc_argsize = sizeof(struct nfsd3_voidargs),
-		.pc_ressize = sizeof(struct nfsd3_voidargs),
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
 	},
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index e0ad18d6b5a8..581a93b17bee 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -693,8 +693,6 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
 #define nfsd3_attrstatres		nfsd3_attrstat
 #define nfsd3_wccstatres		nfsd3_attrstat
 #define nfsd3_createres			nfsd3_diropres
-#define nfsd3_voidres			nfsd3_voidargs
-struct nfsd3_voidargs { int dummy; };
 
 #define ST 1		/* status*/
 #define FH 17		/* filehandle with length */
@@ -705,10 +703,10 @@ struct nfsd3_voidargs { int dummy; };
 static const struct svc_procedure nfsd_procedures3[22] = {
 	[NFS3PROC_NULL] = {
 		.pc_func = nfsd3_proc_null,
-		.pc_decode = nfs3svc_decode_voidarg,
-		.pc_encode = nfs3svc_encode_voidres,
-		.pc_argsize = sizeof(struct nfsd3_voidargs),
-		.pc_ressize = sizeof(struct nfsd3_voidres),
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST,
 	},
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 186b07a72373..a6718b952975 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -304,11 +304,6 @@ void fill_post_wcc(struct svc_fh *fhp)
 /*
  * XDR decode functions
  */
-int
-nfs3svc_decode_voidarg(struct svc_rqst *rqstp, __be32 *p)
-{
-	return 1;
-}
 
 int
 nfs3svc_decode_fhandle(struct svc_rqst *rqstp, __be32 *p)
@@ -642,12 +637,6 @@ nfs3svc_decode_commitargs(struct svc_rqst *rqstp, __be32 *p)
  * XDR encode functions
  */
 
-int
-nfs3svc_encode_voidres(struct svc_rqst *rqstp, __be32 *p)
-{
-	return xdr_ressize_check(rqstp, p);
-}
-
 /* GETATTR */
 int
 nfs3svc_encode_attrstat(struct svc_rqst *rqstp, __be32 *p)
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5fbda469fbfe..7295b8eeb43f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3300,10 +3300,10 @@ struct nfsd4_voidargs { int dummy; };
 static const struct svc_procedure nfsd_procedures4[2] = {
 	[NFSPROC4_NULL] = {
 		.pc_func = nfsd4_proc_null,
-		.pc_decode = nfs4svc_decode_voidarg,
-		.pc_encode = nfs4svc_encode_voidres,
-		.pc_argsize = sizeof(struct nfsd4_voidargs),
-		.pc_ressize = sizeof(struct nfsd4_voidres),
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 1,
 	},
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 66274ad05a9c..6c3d45f68b75 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5271,12 +5271,6 @@ nfsd4_encode_replay(struct xdr_stream *xdr, struct nfsd4_op *op)
 	p = xdr_encode_opaque_fixed(p, rp->rp_buf, rp->rp_buflen);
 }
 
-int
-nfs4svc_encode_voidres(struct svc_rqst *rqstp, __be32 *p)
-{
-        return xdr_ressize_check(rqstp, p);
-}
-
 void nfsd4_release_compoundargs(struct svc_rqst *rqstp)
 {
 	struct nfsd4_compoundargs *args = rqstp->rq_argp;
@@ -5294,12 +5288,6 @@ void nfsd4_release_compoundargs(struct svc_rqst *rqstp)
 	}
 }
 
-int
-nfs4svc_decode_voidarg(struct svc_rqst *rqstp, __be32 *p)
-{
-	return 1;
-}
-
 int
 nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, __be32 *p)
 {
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index cb742e17e04a..7907de3f2ee6 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -73,6 +73,14 @@ extern unsigned long		nfsd_drc_mem_used;
 
 extern const struct seq_operations nfs_exports_op;
 
+/*
+ * Common void argument and result helpers
+ */
+struct nfsd_voidargs { };
+struct nfsd_voidres { };
+int		nfssvc_decode_voidarg(struct svc_rqst *rqstp, __be32 *p);
+int		nfssvc_encode_voidres(struct svc_rqst *rqstp, __be32 *p);
+
 /*
  * Function prototypes.
  */
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 0d71549f9d42..9473d048efec 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -609,7 +609,6 @@ nfsd_proc_statfs(struct svc_rqst *rqstp)
  * NFSv2 Server procedures.
  * Only the results of non-idempotent operations are cached.
  */
-struct nfsd_void { int dummy; };
 
 #define ST 1		/* status */
 #define FH 8		/* filehandle */
@@ -618,10 +617,10 @@ struct nfsd_void { int dummy; };
 static const struct svc_procedure nfsd_procedures2[18] = {
 	[NFSPROC_NULL] = {
 		.pc_func = nfsd_proc_null,
-		.pc_decode = nfssvc_decode_void,
-		.pc_encode = nfssvc_encode_void,
-		.pc_argsize = sizeof(struct nfsd_void),
-		.pc_ressize = sizeof(struct nfsd_void),
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 0,
 	},
@@ -647,10 +646,10 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	},
 	[NFSPROC_ROOT] = {
 		.pc_func = nfsd_proc_root,
-		.pc_decode = nfssvc_decode_void,
-		.pc_encode = nfssvc_encode_void,
-		.pc_argsize = sizeof(struct nfsd_void),
-		.pc_ressize = sizeof(struct nfsd_void),
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 0,
 	},
@@ -685,10 +684,10 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	},
 	[NFSPROC_WRITECACHE] = {
 		.pc_func = nfsd_proc_writecache,
-		.pc_decode = nfssvc_decode_void,
-		.pc_encode = nfssvc_encode_void,
-		.pc_argsize = sizeof(struct nfsd_void),
-		.pc_ressize = sizeof(struct nfsd_void),
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = 0,
 	},
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index daeab72975a3..cae6fbf10514 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -28,6 +28,7 @@
 #include "vfs.h"
 #include "netns.h"
 #include "filecache.h"
+#include "xdr.h"
 
 #define NFSDDBG_FACILITY	NFSDDBG_SVC
 
@@ -1075,6 +1076,28 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	return 1;
 }
 
+/**
+ * nfssvc_decode_voidarg - Decode void arguments
+ * @rqstp: Server RPC transaction context
+ * @p: buffer containing arguments to decode
+ *
+ */
+int nfssvc_decode_voidarg(struct svc_rqst *rqstp, __be32 *p)
+{
+	return XDR_DECODE_DONE;
+}
+
+/**
+ * nfssvc_encode_voidres - Encode void results
+ * @rqstp: Server RPC transaction context
+ * @p: buffer in which to encode results
+ *
+ */
+int nfssvc_encode_voidres(struct svc_rqst *rqstp, __be32 *p)
+{
+        return xdr_ressize_check(rqstp, p);
+}
+
 int nfsd_pool_stats_open(struct inode *inode, struct file *file)
 {
 	int ret;
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 9e00a902113e..7aa6e8aca2c1 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -192,11 +192,6 @@ __be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *f
 /*
  * XDR decode functions
  */
-int
-nfssvc_decode_void(struct svc_rqst *rqstp, __be32 *p)
-{
-	return xdr_argsize_check(rqstp, p);
-}
 
 int
 nfssvc_decode_fhandle(struct svc_rqst *rqstp, __be32 *p)
@@ -423,11 +418,6 @@ nfssvc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p)
 /*
  * XDR encode functions
  */
-int
-nfssvc_encode_void(struct svc_rqst *rqstp, __be32 *p)
-{
-	return xdr_ressize_check(rqstp, p);
-}
 
 int
 nfssvc_encode_stat(struct svc_rqst *rqstp, __be32 *p)
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 0ff336b0b25f..ad77387734cc 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -144,7 +144,6 @@ union nfsd_xdrstore {
 #define NFS2_SVC_XDRSIZE	sizeof(union nfsd_xdrstore)
 
 
-int nfssvc_decode_void(struct svc_rqst *, __be32 *);
 int nfssvc_decode_fhandle(struct svc_rqst *, __be32 *);
 int nfssvc_decode_sattrargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_diropargs(struct svc_rqst *, __be32 *);
@@ -156,7 +155,6 @@ int nfssvc_decode_readlinkargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_linkargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_symlinkargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_readdirargs(struct svc_rqst *, __be32 *);
-int nfssvc_encode_void(struct svc_rqst *, __be32 *);
 int nfssvc_encode_stat(struct svc_rqst *, __be32 *);
 int nfssvc_encode_attrstat(struct svc_rqst *, __be32 *);
 int nfssvc_encode_diropres(struct svc_rqst *, __be32 *);
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index ae6fa6c9cb46..456fcd7a1038 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -273,7 +273,6 @@ union nfsd3_xdrstore {
 
 #define NFS3_SVC_XDRSIZE		sizeof(union nfsd3_xdrstore)
 
-int nfs3svc_decode_voidarg(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_fhandle(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_sattrargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_diropargs(struct svc_rqst *, __be32 *);
@@ -290,7 +289,6 @@ int nfs3svc_decode_symlinkargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_readdirargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_readdirplusargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_commitargs(struct svc_rqst *, __be32 *);
-int nfs3svc_encode_voidres(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_attrstat(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_wccstat(struct svc_rqst *, __be32 *);
 int nfs3svc_encode_diropres(struct svc_rqst *, __be32 *);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 679d40af1bbb..37f89ad5e992 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -781,8 +781,6 @@ set_change_info(struct nfsd4_change_info *cinfo, struct svc_fh *fhp)
 
 
 bool nfsd4_mach_creds_match(struct nfs4_client *cl, struct svc_rqst *rqstp);
-int nfs4svc_decode_voidarg(struct svc_rqst *, __be32 *);
-int nfs4svc_encode_voidres(struct svc_rqst *, __be32 *);
 int nfs4svc_decode_compoundargs(struct svc_rqst *, __be32 *);
 int nfs4svc_encode_compoundres(struct svc_rqst *, __be32 *);
 __be32 nfsd4_check_resp_size(struct nfsd4_compoundres *, u32);


