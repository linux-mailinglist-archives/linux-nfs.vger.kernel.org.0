Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC132B1E08
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgKMPEP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgKMPEO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:04:14 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A02C0617A6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:06 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id a15so2543156qvk.5
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=CJpLObXKDWplMczr0mRkE0WSGVo20lbrroX6Hmsm/nM=;
        b=KnNZ02yRvfwswT0obceKjhYasTWBU2rOyvySU+GKvm+yKHr6rsKIbNTxD5t4f3fMVS
         Y4pIgNhXCRiu1ihhGBxKjPw9R52e9tSgTnFPoEs7Y7qyjeYwugBXV/f7dmfNM4umu39C
         2uKvyOdDEgYgtLduVdrMWmCwekeiz5iWc/U5Tukv51l6M3AzJ2wwgW8TEoNaRHQhFyz1
         8zK8HEbigqguWfGRK/lMhFAAbTkjHsxofITICh2zpxXkC7LDLKlxO5YBDI8k1fXnzG9b
         yD8Tz9R2pqHascsrX0dWSTtS7L4vGfZx3TW8QgaPvra3zF3aOmMKT8k2GUs7vJDBdSkA
         9PMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=CJpLObXKDWplMczr0mRkE0WSGVo20lbrroX6Hmsm/nM=;
        b=q7ymYl9ZnLe625Nh8QUQycMzcZJNcn/SNfyiPK3ODe2LlPzjUEyLgU6dCtLNQlR+tF
         GMJDPlFtN12PnRDzI30wqCIL4z5lA62HEN6HPxvkbIcJGH3E4qGXG/iE9kNSPqsU4q4T
         Go1TCoUugqqoWGUbo5Zk+aXW5gvNH9tiyLPjWJGxTmkTbESljCYEjP1BXo+0QlxMPcGG
         zjRR6Ej80vRhwwMS+EJdaLrkrpWKxm/syHx+veIr8+oZmL83AV8jcuEklGRHa8kGwY9k
         W4woXIlR/eQVQXmf0mJ8EMC7JcqlLJai4qCKqP5usFDE8gxMjZqdhpEb913ZI7NLPQ0e
         OSOA==
X-Gm-Message-State: AOAM531IBhekvQFkPUQS0xzsk+dlNLOwBNIRHxcJpyRRbEloY+MalQ5y
        Dg9raNX1LYj8JcXy3RfHrrSeQX+kg6Q=
X-Google-Smtp-Source: ABdhPJzhaVL0uUKNSQOtvDhQ/RK2RZIZWdCm/Vc4/Oja8uXjjdpofjF5SxjAvNQG9Hp5RK/7DS/Wyw==
X-Received: by 2002:a0c:8d8b:: with SMTP id t11mr2586737qvb.13.1605279844650;
        Fri, 13 Nov 2020 07:04:04 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h129sm6808670qkd.35.2020.11.13.07.04.03
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:04:04 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF42Jp032694
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:04:02 GMT
Subject: [PATCH v1 19/61] NFSD: Replace READ* macros in nfsd4_decode_open()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:04:02 -0500
Message-ID: <160527984295.6186.2380316984697857571.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Note that op_fname is the only instance of an NFSv4 filename stored
in a struct xdr_netobj. Convert it to a u32/char * pair so that the
new nfsd4_decode_filename() helper can be used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    8 +--
 fs/nfsd/nfs4xdr.c  |  160 +++++++++++++++++++++++++++++++---------------------
 fs/nfsd/xdr4.h     |    3 +
 3 files changed, 100 insertions(+), 71 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 91197626d0d2..b810d048c5f8 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -257,8 +257,8 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 		 * in NFSv4 as in v3 except EXCLUSIVE4_1.
 		 */
 		current->fs->umask = open->op_umask;
-		status = do_nfsd_create(rqstp, current_fh, open->op_fname.data,
-					open->op_fname.len, &open->op_iattr,
+		status = do_nfsd_create(rqstp, current_fh, open->op_fname,
+					open->op_fnamelen, &open->op_iattr,
 					*resfh, open->op_createmode,
 					(u32 *)open->op_verf.data,
 					&open->op_truncate, &open->op_created);
@@ -283,7 +283,7 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 		 * a chance to an acquire a delegation if appropriate.
 		 */
 		status = nfsd_lookup(rqstp, current_fh,
-				     open->op_fname.data, open->op_fname.len, *resfh);
+				     open->op_fname, open->op_fnamelen, *resfh);
 	if (status)
 		goto out;
 	status = nfsd_check_obj_isreg(*resfh);
@@ -360,7 +360,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	bool reclaim = false;
 
 	dprintk("NFSD: nfsd4_open filename %.*s op_openowner %p\n",
-		(int)open->op_fname.len, open->op_fname.data,
+		(int)open->op_fnamelen, open->op_fname,
 		open->op_openowner);
 
 	/* This check required by spec. */
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9a6116cee94b..2ff3dfaca4a1 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -261,6 +261,20 @@ static __be32 nfsd4_decode_component4(struct nfsd4_compoundargs *argp,
 	return nfserr_jukebox;
 }
 
+static __be32 nfsd4_decode_verifier4(struct nfsd4_compoundargs *argp,
+				     nfs4_verifier *verf)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(argp->xdr, NFS4_VERIFIER_SIZE);
+	if (!p)
+		goto xdr_error;
+	memcpy(verf->data, p, sizeof(verf->data));
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
+}
+
 static __be32
 nfsd4_decode_nfstime4(struct nfsd4_compoundargs *argp, struct timespec64 *tv)
 {
@@ -887,11 +901,10 @@ nfsd4_decode_lookup(struct nfsd4_compoundargs *argp, struct nfsd4_lookup *lookup
 
 static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *share_access, u32 *deleg_want, u32 *deleg_when)
 {
-	__be32 *p;
 	u32 w;
 
-	READ_BUF(4);
-	w = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &w) < 0)
+		goto xdr_error;
 	*share_access = w & NFS4_SHARE_ACCESS_MASK;
 	*deleg_want = w & NFS4_SHARE_WANT_MASK;
 	if (deleg_when)
@@ -940,22 +953,66 @@ static __be32 nfsd4_decode_share_access(struct nfsd4_compoundargs *argp, u32 *sh
 
 static __be32 nfsd4_decode_share_deny(struct nfsd4_compoundargs *argp, u32 *x)
 {
-	__be32 *p;
-
-	READ_BUF(4);
-	*x = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, x) < 0)
+		goto xdr_error;
 	/* Note: unlinke access bits, deny bits may be zero. */
 	if (*x & ~NFS4_SHARE_DENY_BOTH)
-		return nfserr_bad_xdr;
+		goto xdr_error;
 	return nfs_ok;
 xdr_error:
 	return nfserr_bad_xdr;
 }
 
+static __be32
+nfsd4_decode_createhow4(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
+{
+	__be32 status;
+
+	if (xdr_stream_decode_u32(argp->xdr, &open->op_createmode) < 0)
+		goto xdr_error;
+	switch (open->op_createmode) {
+	case NFS4_CREATE_UNCHECKED:
+	case NFS4_CREATE_GUARDED:
+		status = nfsd4_decode_fattr4(argp, open->op_bmval,
+					     ARRAY_SIZE(open->op_bmval),
+					     &open->op_iattr, &open->op_acl,
+					     &open->op_label, &open->op_umask);
+		if (status)
+			goto out;
+		break;
+	case NFS4_CREATE_EXCLUSIVE:
+		status = nfsd4_decode_verifier4(argp, &open->op_verf);
+		if (status)
+			goto out;
+		break;
+	case NFS4_CREATE_EXCLUSIVE4_1:
+		if (argp->minorversion < 1)
+			goto xdr_error;
+		status = nfsd4_decode_verifier4(argp, &open->op_verf);
+		if (status)
+			goto out;
+		status = nfsd4_decode_fattr4(argp, open->op_bmval,
+					     ARRAY_SIZE(open->op_bmval),
+					     &open->op_iattr, &open->op_acl,
+					     &open->op_label, &open->op_umask);
+		if (status)
+			goto out;
+		break;
+	default:
+		goto xdr_error;
+	}
+	status = nfs_ok;
+
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
+}
+
 static __be32
 nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 {
-	DECODE_HEAD;
+	__be32 status;
 	u32 dummy;
 
 	memset(open->op_bmval, 0, sizeof(open->op_bmval));
@@ -964,8 +1021,8 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 
 	open->op_xdr_error = 0;
 	/* seqid, share_access, share_deny, clientid, ownerlen */
-	READ_BUF(4);
-	open->op_seqid = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &open->op_seqid) < 0)
+		goto xdr_error;
 	/* decode, yet ignore deleg_when until supported */
 	status = nfsd4_decode_share_access(argp, &open->op_share_access,
 					   &open->op_deleg_want, &dummy);
@@ -974,80 +1031,47 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 	status = nfsd4_decode_share_deny(argp, &open->op_share_deny);
 	if (status)
 		goto xdr_error;
-	READ_BUF(sizeof(clientid_t));
-	COPYMEM(&open->op_clientid, sizeof(clientid_t));
-	status = nfsd4_decode_opaque(argp, &open->op_owner);
+	status = nfsd4_decode_state_owner4(argp, &open->op_clientid,
+					   &open->op_owner);
 	if (status)
+		goto out;
+	if (xdr_stream_decode_u32(argp->xdr, &open->op_create) < 0)
 		goto xdr_error;
-	READ_BUF(4);
-	open->op_create = be32_to_cpup(p++);
 	switch (open->op_create) {
 	case NFS4_OPEN_NOCREATE:
 		break;
 	case NFS4_OPEN_CREATE:
-		READ_BUF(4);
-		open->op_createmode = be32_to_cpup(p++);
-		switch (open->op_createmode) {
-		case NFS4_CREATE_UNCHECKED:
-		case NFS4_CREATE_GUARDED:
-			status = nfsd4_decode_fattr4(argp, open->op_bmval,
-						     ARRAY_SIZE(open->op_bmval),
-						     &open->op_iattr, &open->op_acl,
-						     &open->op_label, &open->op_umask);
-			if (status)
-				goto out;
-			break;
-		case NFS4_CREATE_EXCLUSIVE:
-			READ_BUF(NFS4_VERIFIER_SIZE);
-			COPYMEM(open->op_verf.data, NFS4_VERIFIER_SIZE);
-			break;
-		case NFS4_CREATE_EXCLUSIVE4_1:
-			if (argp->minorversion < 1)
-				goto xdr_error;
-			READ_BUF(NFS4_VERIFIER_SIZE);
-			COPYMEM(open->op_verf.data, NFS4_VERIFIER_SIZE);
-			status = nfsd4_decode_fattr4(argp, open->op_bmval,
-						     ARRAY_SIZE(open->op_bmval),
-						     &open->op_iattr, &open->op_acl,
-						     &open->op_label, &open->op_umask);
-			if (status)
-				goto out;
-			break;
-		default:
-			goto xdr_error;
-		}
+		status = nfsd4_decode_createhow4(argp, open);
+		if (status)
+			goto out;
 		break;
 	default:
 		goto xdr_error;
 	}
 
 	/* open_claim */
-	READ_BUF(4);
-	open->op_claim_type = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &open->op_claim_type) < 0)
+		goto xdr_error;
 	switch (open->op_claim_type) {
 	case NFS4_OPEN_CLAIM_NULL:
 	case NFS4_OPEN_CLAIM_DELEGATE_PREV:
-		READ_BUF(4);
-		open->op_fname.len = be32_to_cpup(p++);
-		READ_BUF(open->op_fname.len);
-		SAVEMEM(open->op_fname.data, open->op_fname.len);
-		if ((status = check_filename(open->op_fname.data, open->op_fname.len)))
-			return status;
+		status = nfsd4_decode_component4(argp, &open->op_fname,
+						 &open->op_fnamelen);
+		if (status)
+			goto out;
 		break;
 	case NFS4_OPEN_CLAIM_PREVIOUS:
-		READ_BUF(4);
-		open->op_delegate_type = be32_to_cpup(p++);
+		if (xdr_stream_decode_u32(argp->xdr, &open->op_delegate_type) < 0)
+			goto xdr_error;
 		break;
 	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
 		status = nfsd4_decode_stateid4(argp, &open->op_delegate_stateid);
 		if (status)
-			return status;
-		READ_BUF(4);
-		open->op_fname.len = be32_to_cpup(p++);
-		READ_BUF(open->op_fname.len);
-		SAVEMEM(open->op_fname.data, open->op_fname.len);
-		if ((status = check_filename(open->op_fname.data, open->op_fname.len)))
-			return status;
+			goto out;
+		status = nfsd4_decode_component4(argp, &open->op_fname,
+						 &open->op_fnamelen);
+		if (status)
+			goto out;
 		break;
 	case NFS4_OPEN_CLAIM_FH:
 	case NFS4_OPEN_CLAIM_DELEG_PREV_FH:
@@ -1060,13 +1084,17 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 			goto xdr_error;
 		status = nfsd4_decode_stateid4(argp, &open->op_delegate_stateid);
 		if (status)
-			return status;
+			goto out;
 		break;
 	default:
 		goto xdr_error;
 	}
 
-	DECODE_TAIL;
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
 }
 
 static __be32
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 0eb13bd603ea..6245004a9993 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -252,7 +252,8 @@ struct nfsd4_listxattrs {
 
 struct nfsd4_open {
 	u32		op_claim_type;      /* request */
-	struct xdr_netobj op_fname;	    /* request - everything but CLAIM_PREV */
+	u32		op_fnamelen;
+	char *		op_fname;	    /* request - everything but CLAIM_PREV */
 	u32		op_delegate_type;   /* request - CLAIM_PREV only */
 	stateid_t       op_delegate_stateid; /* request - response */
 	u32		op_why_no_deleg;    /* response - DELEG_NONE_EXT only */


