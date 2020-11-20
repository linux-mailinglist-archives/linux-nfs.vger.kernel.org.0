Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB892BB798
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbgKTUmP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731598AbgKTUmO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:42:14 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FD4C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:14 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id l7so1824197qtp.8
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=tZ+wipNDwH32XP1tBhWQQdTHr47QmmncnySepXnvRX0=;
        b=lM7hHDenGIAa31gjsZQhG3JhSXbxm6PeLgRTmERCHQk9eKS5UtlYvQVct/l+dwSEr2
         kgH3H59xNhoF3ezUXzGX0QCz/mOLf7Kvtvayz7TA+g9Xr+pm64drIdN8p5uWhGBPYxSR
         ViAICeG4NV/ian3ergXVdM0sWlaGu0areNRqsbJeALYtrz68OnBCFbM+9eY6qFH/y+qF
         ghV5wRN6Z3Z3SHw8oG+DyAZ5Q9Xh5xJ8dSR/6Ul7Mwa0efFLQQBqCWRWffliLbYPFBkt
         h3fdhie/G8ANLgXhIfCcLh1+9OlrUy461y1e9M+CtZ0MINwGZHc0fhAy/IrtiDPb3Cnu
         5G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=tZ+wipNDwH32XP1tBhWQQdTHr47QmmncnySepXnvRX0=;
        b=sCeqDtClZ3T5Jp9bFIPcp9yNstjSQ2vOwLcaYp8cp034fWWiz3hr+jhcsNbfXOIHe5
         UoHAp307vRkGWD6ERNSnlPCJCSeQYR3Mko0kcrtJGcWH+ZwI114H7dSXnOvvRPhzRBbu
         NU6sD4CEABAc4MZI8aB1jw7WvlZdJ1zj5+0zJE0p65x+zpv53pH+xC0keH3akLp1y3W4
         eE+7cNG8lt7QiQ5am89FBKW5w7SAKBLE+4Vb/9rQXh8Tt2py1pLTXZEmvEJT3jjNUzoo
         Rjep1HBYZQiEHqvEvFtf5n5JpbA+UqJzBu/mr45679nFbn9h8DqhQCwI+drmIxq/9fhx
         UnBw==
X-Gm-Message-State: AOAM531q9xCJIHKYS2ke/8/EUc5iijg5FQXtrDqPjUEo4xhzkRUNj416
        olQQbJ0V/lOb0EN6kASU57nf0JN+ShU=
X-Google-Smtp-Source: ABdhPJxG4eLNNbhBXTGUKi5dayzaw40oHzKKtx5dguOnMxryTAPjIcYMrz7wSPrTPoBC4JpIHGRxJQ==
X-Received: by 2002:aed:3668:: with SMTP id e95mr1588899qtb.69.1605904933510;
        Fri, 20 Nov 2020 12:42:13 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b197sm2853877qkg.65.2020.11.20.12.42.12
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:42:12 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKgBZs029498
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:42:11 GMT
Subject: [PATCH v2 095/118] NFSD: Update the SYMLINK3args decoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:42:11 -0500
Message-ID: <160590493180.1340.14177384748797931925.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Similar to the WRITE decoder, code that checks the sanity of the
payload size is re-wired to work with xdr_stream infrastructure.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index ec4778f01472..6dfab4bd6c2c 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -623,26 +623,29 @@ nfs3svc_decode_mkdirargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd3_symlinkargs *args = rqstp->rq_argp;
-	char *base = (char *)p;
-	size_t dlen;
+	struct kvec *head = rqstp->rq_arg.head;
+	struct kvec *tail = rqstp->rq_arg.tail;
+	size_t remaining;
 
-	if (!(p = decode_fh(p, &args->ffh)) ||
-	    !(p = decode_filename(p, &args->fname, &args->flen)))
-		return 0;
-	p = decode_sattr3(p, &args->attrs, nfsd_user_namespace(rqstp));
+	if (!svcxdr_decode_diropargs3(xdr, &args->ffh, &args->fname, &args->flen))
+		return XDR_DECODE_FAILED;
+	if (!svcxdr_decode_sattr3(rqstp, xdr, &args->attrs))
+		return XDR_DECODE_FAILED;
+	if (xdr_stream_decode_u32(xdr, &args->tlen) < 0)
+		return XDR_DECODE_FAILED;
 
-	args->tlen = ntohl(*p++);
+	/* request sanity */
+	remaining = head->iov_len + rqstp->rq_arg.page_len + tail->iov_len;
+	remaining -= xdr_stream_pos(xdr);
+	if (remaining < xdr_align_size(args->tlen))
+		return XDR_DECODE_FAILED;
 
-	args->first.iov_base = p;
-	args->first.iov_len = rqstp->rq_arg.head[0].iov_len;
-	args->first.iov_len -= (char *)p - base;
+	args->first.iov_base = xdr->p;
+	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
 
-	dlen = args->first.iov_len + rqstp->rq_arg.page_len +
-	       rqstp->rq_arg.tail[0].iov_len;
-	if (dlen < XDR_QUADLEN(args->tlen) << 2)
-		return 0;
-	return 1;
+	return XDR_DECODE_DONE;
 }
 
 int


