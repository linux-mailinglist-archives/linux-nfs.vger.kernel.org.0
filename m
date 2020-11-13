Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B102B1E3E
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgKMPHs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgKMPHr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:07:47 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A157C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:47 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id g17so6854552qts.5
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=d6RR6f6r3EsCnCokdGgPRh3LTVdPPGEAj+AsZPCBwIU=;
        b=vexd7SsglNBxAiRnMPEbxhQqSNrtNox+EAXFEI0q/lY4gJp5r2Y6fWvQkRFEogohSs
         Hf/E9A/y5IbL9c04uzzSQzzR61CcPhyDbu1t2tBmva6Sz0JCqYcNzNRrrKK1H+1l67fz
         D+JBQwn22Bgt2OvLG3cb+VOqwRHl9LRgYfpT/VtKqe22ZY5TF3cn3Nbk5+/D1+5XUfIe
         0pohwC2sbw2jj5MeULTmH8Js55oDSJaik513XRukkzsLDtQH2e+bCDJuphqHMdaCcU9y
         1NqM8hxUZPD4oLtjYBZX8Ht8oHPOESvJ/vnyPKLi5PqhAv1dUluUZLzS8bRcI+Eck+fa
         4vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=d6RR6f6r3EsCnCokdGgPRh3LTVdPPGEAj+AsZPCBwIU=;
        b=Cju7y/TI98Q+n7jsWm9mRBfYCs4bg1voiGpArQ/st3KGDc53cV2oUX8243ZbGRhyPz
         lO+b9BoRqBR7fwIu5ZhUVDJs4KIBmy6ayfaaXuzJhPzVw5RaP26kFCeFIKdWGtZqfsA6
         5afpDBGNEFtnOrkxunPFpj0QQb2qFZTfQGxKEMEhrjK8zjVHyTSnY8xq0z390rD863oQ
         zpC3+oB6lfeB9OpcEKbo73RV4XY6pUp8wzAbepgIgIP9+JN/pKNiih9Nm8BQ2RsIqqsh
         N0H6JXWTBVMwYZtcln2XzGNCVHxByydBuhHi2eqptwj8bokxuzSH9RYGeIgFqBVTD+Fv
         9M/g==
X-Gm-Message-State: AOAM530+la2RHDOMpUzHy1Nbq1M7z8XbyGQgeA7YvHDPaChDuRqFQK8j
        xFL7qnG96FR0rvwFf1ohFSl4UuCTTE0=
X-Google-Smtp-Source: ABdhPJz46RsMNO/JzNJ5ar/czFj8h89zGHMYk+xVb8OJBAZLYU68STJsc5M0cZZk2XEYgxSNf7jtNQ==
X-Received: by 2002:ac8:6953:: with SMTP id n19mr2466336qtr.184.1605280066285;
        Fri, 13 Nov 2020 07:07:46 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d184sm6924338qkf.136.2020.11.13.07.07.45
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:07:45 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF7irA000352
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:07:44 GMT
Subject: [PATCH v1 61/61] NFSD: Remove macros that are no longer used
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:07:44 -0500
Message-ID: <160528006463.6186.2700423294066360127.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that all the NFSv4 decoder functions have been converted to
make direct calls to the xdr helpers, remove the unused C macros.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   40 ----------------------------------------
 fs/nfsd/xdr4.h    |    9 ---------
 2 files changed, 49 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 3ab248433f44..68d9dec9bc32 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -100,45 +100,6 @@ check_filename(char *str, int len)
 	return 0;
 }
 
-#define DECODE_HEAD				\
-	__be32 *p;				\
-	__be32 status
-#define DECODE_TAIL				\
-	status = 0;				\
-out:						\
-	return status;				\
-xdr_error:					\
-	dprintk("NFSD: xdr error (%s:%d)\n",	\
-			__FILE__, __LINE__);	\
-	status = nfserr_bad_xdr;		\
-	goto out
-
-#define READMEM(x,nbytes) do {			\
-	x = (char *)p;				\
-	p += XDR_QUADLEN(nbytes);		\
-} while (0)
-#define SAVEMEM(x,nbytes) do {			\
-	if (!(x = (p==argp->tmp || p == argp->tmpp) ? \
- 		savemem(argp, p, nbytes) :	\
- 		(char *)p)) {			\
-		dprintk("NFSD: xdr error (%s:%d)\n", \
-				__FILE__, __LINE__); \
-		goto xdr_error;			\
-		}				\
-	p += XDR_QUADLEN(nbytes);		\
-} while (0)
-#define COPYMEM(x,nbytes) do {			\
-	memcpy((x), p, nbytes);			\
-	p += XDR_QUADLEN(nbytes);		\
-} while (0)
-#define READ_BUF(nbytes)			\
-	do {					\
-		p = xdr_inline_decode(argp->xdr,\
-				      nbytes);	\
-		if (!p)				\
-			goto xdr_error;		\
-	} while (0)
-
 static int zero_clientid(clientid_t *clid)
 {
 	return (clid->cl_boot == 0) && (clid->cl_id == 0);
@@ -5546,7 +5507,6 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, __be32 *p)
 	struct nfsd4_compoundargs *args = rqstp->rq_argp;
 
 	/* svcxdr_tmp_alloc */
-	args->tmpp = NULL;
 	args->to_free = NULL;
 
 	args->xdr = &rqstp->rq_xdr_stream;
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 749c2d711d21..dc951768c695 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -386,13 +386,6 @@ struct nfsd4_setclientid_confirm {
 	nfs4_verifier	sc_confirm;
 };
 
-struct nfsd4_saved_compoundargs {
-	__be32 *p;
-	__be32 *end;
-	int pagelen;
-	struct page **pagelist;
-};
-
 struct nfsd4_test_stateid_id {
 	__be32			ts_id_status;
 	stateid_t		ts_id_stateid;
@@ -696,8 +689,6 @@ struct svcxdr_tmpbuf {
 
 struct nfsd4_compoundargs {
 	/* scratch variables for XDR decode */
-	__be32				tmp[8];
-	__be32 *			tmpp;
 	struct xdr_stream		*xdr;
 	struct svcxdr_tmpbuf		*to_free;
 	struct svc_rqst			*rqstp;


