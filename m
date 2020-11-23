Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36C62C1623
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbgKWUL3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732750AbgKWUL3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:11:29 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F11C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:11:29 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id v143so18276967qkb.2
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Mmvlka5gfdV0+lyx25y6g02ZkCluirzUtz5sI79OE0c=;
        b=ari6p6NYQWUwM5wQ4P1Q4hc0+Xr4ZKEkAAf09t2bHLfJen5iwB+j/51fMqIvMfJ2pk
         IDzC83b/EJ5mHWEUJFWZ8WjuwJcawaPEt0IxzS+xxbsacS51fMB3h50UV+xt19QnMnUb
         ZGWaX+ahyCRrXTw3O9ZYggiKyBMAGVFftjYRXoYzAPakYSRzZC5I7UohuffS0RQv2HnR
         ysVmXRvMh7R1/Ay1bKp43yH2OMHdb17chAFsfxxItaZqnld5s5/Bn+SnqhbK4JKZAHqM
         lvcHoBG79re3x45fbapXuU/vijQiBnP3A66IXuOm3FJ2T1rpQ3GYT1qyMotCCXqnHshq
         uVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Mmvlka5gfdV0+lyx25y6g02ZkCluirzUtz5sI79OE0c=;
        b=DcMnY2YyHeN9ng74KKR6edwe4UpieQVmUmiZrKXuYxHeJ0nsNV4agQzt1D+8pKrWwh
         y9JJpCt2T3HZDeK9aHB3zTFiooNg9HXf+Eu7zoTPBZz8axlM7sGZZVC+iXQw59Lsy47k
         8FXluvhvqmkORZZmDpci9THl9uJXgr0EIPPoKs36l6CzUBR6CLjifY+QD5BwI+dWi55u
         a65yd+AbZ9Vz5mhC8Cf8R8Y/oksZG2+8UWTw5K6U7BzEZtmKZQW5y8mvemyMnDJvkRrT
         Dj6wsc8fnInvinqaPFSjcMTWM6/fgZC2j0WR+59g0NaX79fY8IcNUZmRtnueu0txmhdj
         AvXQ==
X-Gm-Message-State: AOAM530ffiKVUJpqDAwEevrbW5If38TkF8Vh1NZOanWCVF6V3CO2kOes
        W5C2X7o5nqygvACx1t9tpHUlfJeLgKU=
X-Google-Smtp-Source: ABdhPJyOYSKnwfBsmE3e23c8qPFf2eU+GcigCuvE9urfw8cJLjVw8iSsE78eNxDzWbc1WN1OwmZweQ==
X-Received: by 2002:a37:6c06:: with SMTP id h6mr1274684qkc.288.1606162288103;
        Mon, 23 Nov 2020 12:11:28 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m25sm10453795qka.107.2020.11.23.12.11.26
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:11:27 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANKBQTV010539
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:11:26 GMT
Subject: [PATCH v3 85/85] NFSD: Remove macros that are no longer used
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:11:26 -0500
Message-ID: <160616228617.51996.12808577536167674350.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
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
index 1e81c8e1e98a..6a2d78be58ad 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -102,45 +102,6 @@ check_filename(char *str, int len)
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
@@ -5461,7 +5422,6 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, __be32 *p)
 	struct nfsd4_compoundargs *args = rqstp->rq_argp;
 
 	/* svcxdr_tmp_alloc */
-	args->tmpp = NULL;
 	args->to_free = NULL;
 
 	args->xdr = &rqstp->rq_xdr_stream;
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 2c31f3a7d7c7..e12fbe382e3f 100644
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


