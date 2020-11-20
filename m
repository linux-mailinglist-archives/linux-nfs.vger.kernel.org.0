Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D372BB768
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbgKTUi6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731622AbgKTUi5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:38:57 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CCFC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:57 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id i12so8141290qtj.0
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ERWeQx0b9I504ZY8495XoH+f0EYm6nmNQuxoo4nrlgI=;
        b=Qv3M3sUs8Et7sHY7V3ei16YplI+pW0Y1jFQfsnbGQMMF5okFMTwuShKQkpMNl5i2sH
         5EVs1JuhW3q/IH8uyCWMa+mc+D06U3nW0XsfeRxwcwHp5XfyEFgwnTObcEZZ4ZHNO4w/
         5RFXrTk+xvSaP7/i5PRmB8TSmsSM04Gj/b/g/DbMB1PuAkDB0cYnTiSEamo7R8RfiOpU
         f6rPAahtqGWBcFTAdC+fPvQahsYOOTww8iKUP5fAEaMfzisEtv0wgan4S25fucXZwXS4
         FazydJMCnoE3alIUmXmxzk77vkijqoZ9+w057SjLk9Oo7MwUyV9HlHL8igVo7JQKg0UF
         0MKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ERWeQx0b9I504ZY8495XoH+f0EYm6nmNQuxoo4nrlgI=;
        b=IoEDYyMensS6xU5xNJvkjIoajGSWLSbNJwmX2CNomFdHNCjVTzQuJCMFvmrb1Bx436
         W5dY+vdxig/UDoktuLx2PEjF8YwTvdvDpvgXK+U9EPMYWgaOT46TIbQPLC2dzgzIwuNM
         SRlUiJLhBN1bOpM3EgPP99X2w3BCmLt7DRQOXWED75ctGnSs+KzsHNuYxVfGYn8ZEJgv
         SaXTlsVo6tWw3cmZl147DZmE8aNPMkize17wBFv4gQ2dpp+zUmNl6UtQvGfMtA0qHJlp
         BO95321nSEP5RNEF/zgrq3DhvBeSVMI2AQJa8Xyoy+G0OsO17NLDT1NuuztV+NE1hVld
         6xSQ==
X-Gm-Message-State: AOAM532s+08Leyq1EzJj59mTKWwd0X1PZKLg2/aJPJ3xhJOb/7PfYEZi
        XhD7hyg8MuizogNJQ3Ti3nrwaWlwAng=
X-Google-Smtp-Source: ABdhPJyc+GLD4SXBMIt+qO9T6BUx2nRAE/pVaaoJsX36hNiyDTQptFfx4JB8eCI/rpgtNJ566ocqrg==
X-Received: by 2002:ac8:6750:: with SMTP id n16mr18110408qtp.362.1605904736360;
        Fri, 20 Nov 2020 12:38:56 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n125sm2948520qkd.85.2020.11.20.12.38.55
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:38:55 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKcsMx029377
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:38:54 GMT
Subject: [PATCH v2 058/118] NFSD: Add a helper to decode channel_attrs4
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:38:54 -0500
Message-ID: <160590473454.1340.270725180136028565.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

De-duplicate some code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   71 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 18b41af204a6..e2b0895c2a32 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1555,6 +1555,38 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 	return nfsd4_decode_nfs_impl_id4(argp, exid);
 }
 
+static __be32
+nfsd4_decode_channel_attrs4(struct nfsd4_compoundargs *argp,
+			    struct nfsd4_channel_attrs *ca)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(argp->xdr, XDR_UNIT * 7);
+	if (!p)
+		return nfserr_bad_xdr;
+
+	/* headerpadsz is ignored */
+	p++;
+	ca->maxreq_sz = be32_to_cpup(p++);
+	ca->maxresp_sz = be32_to_cpup(p++);
+	ca->maxresp_cached = be32_to_cpup(p++);
+	ca->maxops = be32_to_cpup(p++);
+	ca->maxreqs = be32_to_cpup(p++);
+	ca->nr_rdma_attrs = be32_to_cpup(p);
+	switch (ca->nr_rdma_attrs) {
+	case 0:
+		break;
+	case 1:
+		if (xdr_stream_decode_u32(argp->xdr, &ca->rdma_attrs) < 0)
+			return nfserr_bad_xdr;
+		break;
+	default:
+		return nfserr_bad_xdr;
+	}
+
+	return nfs_ok;
+}
+
 static __be32
 nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 			    struct nfsd4_create_session *sess)
@@ -1566,39 +1598,12 @@ nfsd4_decode_create_session(struct nfsd4_compoundargs *argp,
 	sess->seqid = be32_to_cpup(p++);
 	sess->flags = be32_to_cpup(p++);
 
-	/* Fore channel attrs */
-	READ_BUF(28);
-	p++; /* headerpadsz is always 0 */
-	sess->fore_channel.maxreq_sz = be32_to_cpup(p++);
-	sess->fore_channel.maxresp_sz = be32_to_cpup(p++);
-	sess->fore_channel.maxresp_cached = be32_to_cpup(p++);
-	sess->fore_channel.maxops = be32_to_cpup(p++);
-	sess->fore_channel.maxreqs = be32_to_cpup(p++);
-	sess->fore_channel.nr_rdma_attrs = be32_to_cpup(p++);
-	if (sess->fore_channel.nr_rdma_attrs == 1) {
-		READ_BUF(4);
-		sess->fore_channel.rdma_attrs = be32_to_cpup(p++);
-	} else if (sess->fore_channel.nr_rdma_attrs > 1) {
-		dprintk("Too many fore channel attr bitmaps!\n");
-		goto xdr_error;
-	}
-
-	/* Back channel attrs */
-	READ_BUF(28);
-	p++; /* headerpadsz is always 0 */
-	sess->back_channel.maxreq_sz = be32_to_cpup(p++);
-	sess->back_channel.maxresp_sz = be32_to_cpup(p++);
-	sess->back_channel.maxresp_cached = be32_to_cpup(p++);
-	sess->back_channel.maxops = be32_to_cpup(p++);
-	sess->back_channel.maxreqs = be32_to_cpup(p++);
-	sess->back_channel.nr_rdma_attrs = be32_to_cpup(p++);
-	if (sess->back_channel.nr_rdma_attrs == 1) {
-		READ_BUF(4);
-		sess->back_channel.rdma_attrs = be32_to_cpup(p++);
-	} else if (sess->back_channel.nr_rdma_attrs > 1) {
-		dprintk("Too many back channel attr bitmaps!\n");
-		goto xdr_error;
-	}
+	status = nfsd4_decode_channel_attrs4(argp, &sess->fore_channel);
+	if (status)
+		return status;
+	status = nfsd4_decode_channel_attrs4(argp, &sess->back_channel);
+	if (status)
+		return status;
 
 	READ_BUF(4);
 	sess->callback_prog = be32_to_cpup(p++);


