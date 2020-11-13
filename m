Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15AA2B1E2B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgKMPGe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgKMPGd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:06:33 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3924C0617A6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:33 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id f93so6817782qtb.10
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=vU71J1LaDg9CBzAq7tC3UaWK29Ekeq671auKyYB0610=;
        b=mxHI4AkTcT9JA7xAtatD2kfeMjqtA2b7jFsMZSePZFvhxu7Kw4tPAnmAy0+dtQXyxE
         MTd27MgI/4Wjq0SlYc3O9zfLaSCa12BEnEv/ovoUFsgP/ySNQS4yae2SUzsDAv41w+jF
         v+mvTbQZCeT8XLlOVounBQGfkBoMUFeT83UWH62kOHn3b0y2KIvZCS3EWEwFcNoyrL6E
         hfB2MvuQEp3itcm8xrXCfbPdBj4EW5qhKxShqotOmmwdFuTnKFldKWmQia+dMtbw4Gnw
         lgYkKHgsQsBDCngIUVkHF/WC1AC0iea0cVQXt8bnKnFrAXe8F6BOAisoDX/2NkG74Et0
         s0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=vU71J1LaDg9CBzAq7tC3UaWK29Ekeq671auKyYB0610=;
        b=Vr/o5g4/YaviPpWrOiqIBJgGt5vovYb7rTXFez0LXfsddDjw5ML02NSGzQV1O2MqdH
         X13GieNUKQWCw8lSlaKlwWHibmDiYJPsmabv+zQsuxxrLT4I/K2kM0NGJRbmnvkgNCqs
         lFA00rQCYOJ1YhwM+F1W6heGsuVHuvlBcj6VvG69OTV4MFesjspSK+lyqVxCCpW1dW6B
         wVbgXvzITFakEgiuGe1TspvDu8yDeXwK25j0NskG4Sxm6AUEWhxinROgB0vXZfxpBgYN
         V27PdEiqaSJ1c45SSqyFAKBLE34RaHjzFDFVvAPqggoO9mjaSi4VTwm3RRP/gB1TsM6D
         POww==
X-Gm-Message-State: AOAM530DYycSt3uK6cUXrXM9XFm038kRmL9Q7Sub9ZzM1T7UYNWnBtxf
        NoO3bzpXP5mRiqnnd/xbgFHMOhuHRvM=
X-Google-Smtp-Source: ABdhPJz53QkwNlfvGFBJrKXml+hXAOweOSrYi9CbQoczdzs7ZEIEcbUcQ6XpthFExEWE7WjJEIZWIQ==
X-Received: by 2002:aed:3383:: with SMTP id v3mr2343685qtd.353.1605279991972;
        Fri, 13 Nov 2020 07:06:31 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j124sm6944211qkf.113.2020.11.13.07.06.31
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:06:31 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF6UxH000310
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:06:30 GMT
Subject: [PATCH v1 47/61] NFSD: Replace READ* macros in
 nfsd4_decode_layoutreturn()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:06:30 -0500
Message-ID: <160527999039.6186.8941072746737164622.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   68 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c48fa1427421..91f2612b3d2c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1889,37 +1889,63 @@ nfsd4_decode_layoutget(struct nfsd4_compoundargs *argp,
 }
 
 static __be32
-nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
-		struct nfsd4_layoutreturn *lrp)
+nfsd4_decode_layoutreturn4(struct nfsd4_compoundargs *argp,
+			   struct nfsd4_layoutreturn *lrp)
 {
-	DECODE_HEAD;
-
-	READ_BUF(16);
-	lrp->lr_reclaim = be32_to_cpup(p++);
-	lrp->lr_layout_type = be32_to_cpup(p++);
-	lrp->lr_seg.iomode = be32_to_cpup(p++);
-	lrp->lr_return_type = be32_to_cpup(p++);
-	if (lrp->lr_return_type == RETURN_FILE) {
-		READ_BUF(16);
-		p = xdr_decode_hyper(p, &lrp->lr_seg.offset);
-		p = xdr_decode_hyper(p, &lrp->lr_seg.length);
+	__be32 status;
 
+	if (xdr_stream_decode_u32(argp->xdr, &lrp->lr_return_type) < 0)
+		goto xdr_error;
+	switch (lrp->lr_return_type) {
+	case RETURN_FILE:
+		if (xdr_stream_decode_u64(argp->xdr, &lrp->lr_seg.offset) < 0)
+			goto xdr_error;
+		if (xdr_stream_decode_u64(argp->xdr, &lrp->lr_seg.length) < 0)
+			goto xdr_error;
 		status = nfsd4_decode_stateid4(argp, &lrp->lr_sid);
 		if (status)
-			return status;
-
-		READ_BUF(4);
-		lrp->lrf_body_len = be32_to_cpup(p++);
+			goto out;
+		if (xdr_stream_decode_u32(argp->xdr, &lrp->lrf_body_len) < 0)
+			goto xdr_error;
 		if (lrp->lrf_body_len > 0) {
-			READ_BUF(lrp->lrf_body_len);
-			READMEM(lrp->lrf_body, lrp->lrf_body_len);
+			lrp->lrf_body = xdr_inline_decode(argp->xdr, lrp->lrf_body_len);
+			if (!lrp->lrf_body)
+				goto xdr_error;
 		}
-	} else {
+		break;
+	case RETURN_FSID:
+	case RETURN_ALL:
 		lrp->lr_seg.offset = 0;
 		lrp->lr_seg.length = NFS4_MAX_UINT64;
+		break;
+	default:
+		goto xdr_error;
 	}
 
-	DECODE_TAIL;
+	status = nfs_ok;
+out:
+	return status;
+xdr_error:
+	return nfserr_bad_xdr;
+}
+
+static __be32
+nfsd4_decode_layoutreturn(struct nfsd4_compoundargs *argp,
+		struct nfsd4_layoutreturn *lrp)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(argp->xdr, sizeof(__be32));
+	if (!p)
+		goto xdr_error;
+	lrp->lr_reclaim = (*p == xdr_zero) ? 0 : 1;
+	if (xdr_stream_decode_u32(argp->xdr, &lrp->lr_layout_type) < 0)
+		goto xdr_error;
+	if (xdr_stream_decode_u32(argp->xdr, &lrp->lr_seg.iomode) < 0)
+		goto xdr_error;
+	return nfsd4_decode_layoutreturn4(argp, lrp);
+xdr_error:
+	return nfserr_bad_xdr;
 }
 #endif /* CONFIG_NFSD_PNFS */
 


