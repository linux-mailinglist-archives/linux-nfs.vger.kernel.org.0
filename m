Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5362C15B4
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgKWUHN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgKWUHM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:07:12 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB83C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:11 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id ek7so9447486qvb.6
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AUbsZ02sDEi1GQRus2wgYpQEhoYGOHNoJui9oe8tnp8=;
        b=NHDCHw5nQcaEFoxZ0tq2NwSvVFnhXPibFm0tgA2kE3sM0JCpqgAxKUmFJeFlEt3Zo3
         wsP0UHIC8dTM52KUpQTMqMia/6nQOcpuTgn03oSSJvIIt0rMnmuRA+pFvh7ADeEvNtKX
         QK61U5c9zW86T4NzigjeBRyLfTgR/95yzthepkmgEsbv1KPUCSOQirMMB7QehUNqBJlg
         fjdkRE0r/vxTTi+RnFP51BxSNI79kfdqXVP8bW02BV8nUYI4Z1ynuTg22DAQuamm2fbc
         H00xvWmNE8z9JqLEaEkJpMhdRnf/3/cpAFP0NrjRnx7FbeYPS1exwiHSNv9v8tjdnP/9
         eIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=AUbsZ02sDEi1GQRus2wgYpQEhoYGOHNoJui9oe8tnp8=;
        b=UgATdAYGDMkR247W1xewciZMcuG08UAF1T9M0aTQmn2yttFP520bqxXv6sXvoQ4LMh
         HP8APtdBjKvXr3Fra2TXh9YhisZUhvpxF1neHiBAUipQpxAtih04McyFux30Dau7RZzj
         jOVxp/LfIAiI0zeqPgt0eJqud044Zca+OdkpO86qRYbT0DmNcxLRNj4x+AsaonFGJO2V
         wXch3OkCwcX8WsT9dkFF5ZlFqmR4z/By3CC/3a2Pcz2M5LgHSyUH/LMedcY8zMglOSf2
         SXwvdwTcBL2QAPCOMteWFdNL0d2AnLgMeur0mKaSj8I9MGvPm1Fx974m+tEus3YyzKuL
         j4fw==
X-Gm-Message-State: AOAM530qvgpmlhdWZa+7gGcrV14f5VFFYsQ9ICOeScbvg7DPQBk9/yiz
        XnK8M/xrLgZxsaRPciFtLizugO+WhRY=
X-Google-Smtp-Source: ABdhPJxPLMEfXzHnuanvhKGNC4BvW1zvj/TObPoyeeunKGTEPyRST3F1ND31ONTcLlE9E+irx9cMqA==
X-Received: by 2002:a05:6214:17c1:: with SMTP id cu1mr1306279qvb.32.1606162030376;
        Mon, 23 Nov 2020 12:07:10 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k31sm10421101qtd.40.2020.11.23.12.07.09
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:07:09 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK78oX010376
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:07:08 GMT
Subject: [PATCH v3 36/85] NFSD: Add helper to decode OPEN's open_claim4
 argument
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:07:08 -0500
Message-ID: <160616202867.51996.9303361629968265860.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor for clarity.

Note that op_fname is the only instance of an NFSv4 filename stored
in a struct xdr_netobj. Convert it to a u32/char * pair so that the
new nfsd4_decode_filename() helper can be used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |    8 ++--
 fs/nfsd/nfs4xdr.c  |   95 +++++++++++++++++++++++++++-------------------------
 fs/nfsd/xdr4.h     |    3 +-
 3 files changed, 56 insertions(+), 50 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index df2d6f70c8d4..56d074a6cb31 100644
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
index 521b51b5607b..efd8ae108b2d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1072,6 +1072,55 @@ static __be32 nfsd4_decode_share_deny(struct nfsd4_compoundargs *argp, u32 *x)
 	return nfs_ok;
 }
 
+static __be32
+nfsd4_decode_open_claim4(struct nfsd4_compoundargs *argp,
+			 struct nfsd4_open *open)
+{
+	__be32 status;
+
+	if (xdr_stream_decode_u32(argp->xdr, &open->op_claim_type) < 0)
+		return nfserr_bad_xdr;
+	switch (open->op_claim_type) {
+	case NFS4_OPEN_CLAIM_NULL:
+	case NFS4_OPEN_CLAIM_DELEGATE_PREV:
+		status = nfsd4_decode_component4(argp, &open->op_fname,
+						 &open->op_fnamelen);
+		if (status)
+			return status;
+		break;
+	case NFS4_OPEN_CLAIM_PREVIOUS:
+		if (xdr_stream_decode_u32(argp->xdr, &open->op_delegate_type) < 0)
+			return nfserr_bad_xdr;
+		break;
+	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
+		status = nfsd4_decode_stateid4(argp, &open->op_delegate_stateid);
+		if (status)
+			return status;
+		status = nfsd4_decode_component4(argp, &open->op_fname,
+						 &open->op_fnamelen);
+		if (status)
+			return status;
+		break;
+	case NFS4_OPEN_CLAIM_FH:
+	case NFS4_OPEN_CLAIM_DELEG_PREV_FH:
+		if (argp->minorversion < 1)
+			return nfserr_bad_xdr;
+		/* void */
+		break;
+	case NFS4_OPEN_CLAIM_DELEG_CUR_FH:
+		if (argp->minorversion < 1)
+			return nfserr_bad_xdr;
+		status = nfsd4_decode_stateid4(argp, &open->op_delegate_stateid);
+		if (status)
+			return status;
+		break;
+	default:
+		return nfserr_bad_xdr;
+	}
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 {
@@ -1102,51 +1151,7 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 	status = nfsd4_decode_openflag4(argp, open);
 	if (status)
 		return status;
-
-	/* open_claim */
-	READ_BUF(4);
-	open->op_claim_type = be32_to_cpup(p++);
-	switch (open->op_claim_type) {
-	case NFS4_OPEN_CLAIM_NULL:
-	case NFS4_OPEN_CLAIM_DELEGATE_PREV:
-		READ_BUF(4);
-		open->op_fname.len = be32_to_cpup(p++);
-		READ_BUF(open->op_fname.len);
-		SAVEMEM(open->op_fname.data, open->op_fname.len);
-		if ((status = check_filename(open->op_fname.data, open->op_fname.len)))
-			return status;
-		break;
-	case NFS4_OPEN_CLAIM_PREVIOUS:
-		READ_BUF(4);
-		open->op_delegate_type = be32_to_cpup(p++);
-		break;
-	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
-		status = nfsd4_decode_stateid(argp, &open->op_delegate_stateid);
-		if (status)
-			return status;
-		READ_BUF(4);
-		open->op_fname.len = be32_to_cpup(p++);
-		READ_BUF(open->op_fname.len);
-		SAVEMEM(open->op_fname.data, open->op_fname.len);
-		if ((status = check_filename(open->op_fname.data, open->op_fname.len)))
-			return status;
-		break;
-	case NFS4_OPEN_CLAIM_FH:
-	case NFS4_OPEN_CLAIM_DELEG_PREV_FH:
-		if (argp->minorversion < 1)
-			goto xdr_error;
-		/* void */
-		break;
-	case NFS4_OPEN_CLAIM_DELEG_CUR_FH:
-		if (argp->minorversion < 1)
-			goto xdr_error;
-		status = nfsd4_decode_stateid(argp, &open->op_delegate_stateid);
-		if (status)
-			return status;
-		break;
-	default:
-		goto xdr_error;
-	}
+	status = nfsd4_decode_open_claim4(argp, open);
 
 	DECODE_TAIL;
 }
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


