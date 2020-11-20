Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3620A2BB743
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbgKTUg5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbgKTUg4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:36:56 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057D7C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:55 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id u4so10181894qkk.10
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=t4gNRHBg7Hc7ZqKB984Us/qEFP1391mi1SFjBh6yYXQ=;
        b=BIsKybs0U+FtnSftwHtCHK1DswQkPKtxcJrEnJLURF1xfrLvZQWOCZVQGA3bVIexYo
         o3dV9jgz+Cp2xscwwULUZCk9mfT4Ec4PjOupeav6ogG7uctlqBI2QIpLhpqRvv6OE20x
         i7pItS2osZHf/dN5lGS+mpg4F94vSPoKcw+zZdGkngi8nffAMYcXCUg5ktXdAbIdjrWx
         k5AOD4JKlaXxrORQsSd+ndXRg1/Tg4F3K1nvF4a2wxvkLKgafP5hxvnJpMuBDpnnn+ex
         0znYT8aPnli37GMMpfsAMRy3pEDUWJs3Cc2nHUCVSWxqFRpUH8EfTM4wjyrjiv8gb4cc
         8oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=t4gNRHBg7Hc7ZqKB984Us/qEFP1391mi1SFjBh6yYXQ=;
        b=P7is5M/hBIE3J1ZId9bGtn5LGdKK0e7E+d0PtmHiAn3j9/X8PHWV1iS6dcAe06YnLE
         rF47TE8Q6SUde2bvTx42ddaxAF2maa8q/3eyQnX5u8UFQOCRV072Bjm/REppFtF5XWga
         fAxNhNlud7JadA6T9hkSiqv1bNsHXbi4+FDdy1P5//DPMoh/MGt5NRECxGH4ob5uPs1W
         VmE4OiIet5d9E/4eDju+YLnUL4SJvrPYrSvEVzKUcgw+7FotulsOUziIT1DJQDzO9wyX
         1iKhcsg0MnfM7EZCreoBykWzQMa4ijbpPAFzqyiIbSsHHm9nk6uR4WI2WthGDdiW3Dwm
         tjNQ==
X-Gm-Message-State: AOAM531u4K6Rhg84kvgSmQj7N2usZ+N5jdKPgqosWzMkACZhqaOKOc3/
        SGnQwqO6wTPBmT+dz88t9RliVVSIgjE=
X-Google-Smtp-Source: ABdhPJx20etkHzb5lNGQqxsBTmGyFiTAV7rrOWagOb5h5wmXY3k82WZmL7hLbQNokXi5L/npBRhTTw==
X-Received: by 2002:a05:620a:22eb:: with SMTP id p11mr19539516qki.224.1605904613852;
        Fri, 20 Nov 2020 12:36:53 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k128sm1080414qkd.48.2020.11.20.12.36.53
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:36:53 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKaqUZ029307
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:36:52 GMT
Subject: [PATCH v2 035/118] NFSD: Add helper to decode OPEN's open_claim4
 argument
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:36:52 -0500
Message-ID: <160590461220.1340.5213833030984402582.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
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
index dc5c9fb1888b..07756483aa70 100644
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
index fa16bc32f3c9..32929a1106a2 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1019,6 +1019,55 @@ static __be32 nfsd4_decode_share_deny(struct nfsd4_compoundargs *argp, u32 *x)
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
@@ -1049,51 +1098,7 @@ nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
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
-		status = nfsd4_decode_stateid4(argp, &open->op_delegate_stateid);
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
-		status = nfsd4_decode_stateid4(argp, &open->op_delegate_stateid);
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


