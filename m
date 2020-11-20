Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011132BB787
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbgKTUkz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731564AbgKTUkz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:40:55 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65CCC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:54 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q5so10176686qkc.12
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jMeJzSTHZgInT0J97QhxshVAsehGP3IrbAcNkx8zxfk=;
        b=nzSzKgGNxGrpmB+Jm+5Oaps6DjL/IO5eZ8jSLth7xswZfk7xM65cyVx63GkBWGQj0L
         +DqUUSVfPoumt1Fo8kMpQgSe+fXAoQWFF5+w4lpr36MMHFyRs6NDSyn8uj6KarTFjWVC
         06p1NoPordww99dvNn29wJmaC8jhqtBR0qroGsV6zcCrQQcIOa1hgGzvlXn2u0/hVjcl
         33r5ka8rKSWaC5FrkXw5tMyLS4qF51cLkxdfamHRXxzU5TYoYJp6j8x9xMfCUkIQg1Jw
         eozXoVCkBzazRhx9vyTyc+7IrPyC0Udt6sEXq4RnIkUpGqB/3f17jhspchxrzwuT6AX5
         4uCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jMeJzSTHZgInT0J97QhxshVAsehGP3IrbAcNkx8zxfk=;
        b=i1vKo4LUsR7MiX+0bXut+RSHd4y9VnlZTd/vvbea/0bsvWPlAA+qvA9DhGeW+fyy0l
         GE2FD5i1AQD2kvOlW27Massy1oROdfKbNHS1tO+8G9Dk7Mfe/586YvAo1SQURmy+mLlR
         Q1jg7fZQ1ykjs2ezbwLiyWCUyAsIpneJb4BkBasVATdA79hP4gT5fyB1fScQfPEv6rJY
         fgYeYxIx9mJrof5tR8unwMchJ66c2iaMmTasp6mHpcLA9P0I6Lxxgv3F/bm0+ZndPnHM
         WdLl0zv9rrhP8OgBHILYr1V0WdcS3YBgU5PqC0H289rH3cAXnQjqU+6gBxFh2y9wadVy
         w/2Q==
X-Gm-Message-State: AOAM533Jzg3Oav7s6qAQTDKNKMAjJXCzGA8xRNc54Rv6wcMKiMrvtcIV
        2XAwcmIffRLwZK/pxGafmZeMgLbwINo=
X-Google-Smtp-Source: ABdhPJzC7vc7ALKvd6Ztg7yTtnG1qCkKJybm5uud6oBRtuO2cEc1X0s+NnoUd4/6Zx7I82OPCa+LPg==
X-Received: by 2002:a37:8f47:: with SMTP id r68mr15131805qkd.262.1605904853708;
        Fri, 20 Nov 2020 12:40:53 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s7sm2716902qkm.124.2020.11.20.12.40.52
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:40:53 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKepjp029453
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:40:51 GMT
Subject: [PATCH v2 080/118] NFSD: Remove macros that are no longer used
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:40:51 -0500
Message-ID: <160590485189.1340.10598533794363592019.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
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
index da9b458cf9dc..b101b8b3ddbe 100644
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
@@ -5406,7 +5367,6 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, __be32 *p)
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


