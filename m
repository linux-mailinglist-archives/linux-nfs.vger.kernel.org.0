Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9272BB79C
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbgKTUmg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731685AbgKTUmg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:42:36 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033A7C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:36 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id 7so8152825qtp.1
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ulf/SxLJcl+ynfXaAd9A3ayCeLA+sOXQmQJwly/TucA=;
        b=EwN3DDzF83DhBtVXYCMiVluiKqnNA63gFQgMxgKsd/pXmaq312dcbcOoMj2kyQle7m
         Pus6tNN8NaUU6ASVwVQC7r22bLGAqGtdPQ9BhbgywYNczS/exlsRXnRqrH6boRgYO/Ip
         vTjk7knXv0tsuah5yG05tFf/F+OOAoMfY2rct3Fb2wcpTAczd+iI6BmHV3f6hRVD+BT+
         NXuDktkinbeMuL1H6R08qfdwITNiI8jyC2fN7p0nGuIHblAzGEw4lfEz7SQUsM5BNwkq
         FcCU//ABBN2+HpXsLOefvdMMEYW0vYXZUECm8XuSsl3/DwW35lr3ZVLsRt+uEU6v62K9
         yAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Ulf/SxLJcl+ynfXaAd9A3ayCeLA+sOXQmQJwly/TucA=;
        b=lsS1yd3+jXcVwDikPZv3KspdfjOYkboyqX+Ch+MaMEwNaXyE4G2JGGcR9mk4ukxxOW
         RLk9cDEc89dAFSTPk2UW22B+6LRfwul2OxL4BjBqgf5KYlWC6PR6zGc+iYFUpB4xKl2c
         opQ7aOvixIOHPYQtArgLoZp5x1sk3SR3OxfUPRdkRHtxeLTrm0pfDCDwYFrrIAkjPU6B
         EUXVD+7mYHaz/v5XoArHP8Epny5m4Kx//f4R7MCYGG0/9qSgeTKTIX34jk3MV2HzaWn7
         0rArZzGccsDy8aihwnovLiyUnmEjOOQUZqVBL/6o+nKS/is4U88Sk/9rVcDqFqllzWqO
         cXvg==
X-Gm-Message-State: AOAM533n4EUPpLhuQi2X5fbKEINfmnBiSTgeM1M9MtZMjZYS8obCkWc7
        MYHsEyp4u59WMj/P5SGw0kMIZ80CHUw=
X-Google-Smtp-Source: ABdhPJztgwjVgdIV8pvhEdMKLFfCGev8bKoTCHgLyu2EVNqRAAuF2ZpmK9VG2aUPA85wVE+bL2F6SA==
X-Received: by 2002:ac8:75da:: with SMTP id z26mr17176554qtq.36.1605904954920;
        Fri, 20 Nov 2020 12:42:34 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r62sm2824700qkd.80.2020.11.20.12.42.34
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:42:34 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKgXEQ029510
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:42:33 GMT
Subject: [PATCH v2 099/118] NFSD: Update the NFSv2 WRITE argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:42:33 -0500
Message-ID: <160590495320.1340.4131707414205861028.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsxdr.c |   56 ++++++++++++++++++++----------------------------------
 1 file changed, 21 insertions(+), 35 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 7488fb396627..68a17a9b750f 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -264,47 +264,33 @@ nfssvc_decode_readargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd_writeargs *args = rqstp->rq_argp;
-	unsigned int len, hdr, dlen;
 	struct kvec *head = rqstp->rq_arg.head;
+	struct kvec *tail = rqstp->rq_arg.tail;
+	size_t remaining;
 
-	p = decode_fh(p, &args->fh);
+	if (!svcxdr_decode_fhandle(xdr, &args->fh))
+		return XDR_DECODE_FAILED;
+	p = xdr_inline_decode(xdr, sizeof(__be32) * 4);
 	if (!p)
-		return 0;
-
-	p++;				/* beginoffset */
-	args->offset = ntohl(*p++);	/* offset */
-	p++;				/* totalcount */
-	len = args->len = ntohl(*p++);
-	/*
-	 * The protocol specifies a maximum of 8192 bytes.
-	 */
-	if (len > NFSSVC_MAXBLKSIZE_V2)
-		return 0;
-
-	/*
-	 * Check to make sure that we got the right number of
-	 * bytes.
-	 */
-	hdr = (void*)p - head->iov_base;
-	if (hdr > head->iov_len)
-		return 0;
-	dlen = head->iov_len + rqstp->rq_arg.page_len - hdr;
+		return XDR_DECODE_FAILED;
+	p++;	/* beginoffset is ignored */
+	args->offset = be32_to_cpup(p++);
+	p++;	/* totalcount is ignored */
 
-	/*
-	 * Round the length of the data which was specified up to
-	 * the next multiple of XDR units and then compare that
-	 * against the length which was actually received.
-	 * Note that when RPCSEC/GSS (for example) is used, the
-	 * data buffer can be padded so dlen might be larger
-	 * than required.  It must never be smaller.
-	 */
-	if (dlen < XDR_QUADLEN(len)*4)
-		return 0;
+	/* opaque data */
+	args->len = be32_to_cpup(p++);
+	if (args->len > NFSSVC_MAXBLKSIZE_V2)
+		return XDR_DECODE_FAILED;
+	remaining = head->iov_len + rqstp->rq_arg.page_len + tail->iov_len;
+	remaining -= xdr_stream_pos(xdr);
+	if (remaining < xdr_align_size(args->len))
+		return XDR_DECODE_FAILED;
+	args->first.iov_base = p;
+	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
 
-	args->first.iov_base = (void *)p;
-	args->first.iov_len = head->iov_len - hdr;
-	return 1;
+	return XDR_DECODE_DONE;
 }
 
 int


