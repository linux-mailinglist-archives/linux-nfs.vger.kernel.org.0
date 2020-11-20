Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB8F2BB78C
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbgKTUlQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730631AbgKTUlQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:41:16 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58F3C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:15 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id y197so10211379qkb.7
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YFUG6VqpJOpmkb5ByhOUjmvLvwfm4lNUw7Azvk5bWT4=;
        b=SYR6Ze974sbhlGxJkSjnMMQjDrIQft8G8xD7lF1DW8L6reegz7gCLvN43g2Kqy4/xv
         81RCPPsqWTiakSwpeC+RyoESnq72wuhfz3HhTKzyS3TxW025m23JrOLyKeT0BoHB1AqP
         TTu/OxZ7L3lKd3LHSif2cVVKNWFQ/tC3jQ+QQqmWZ1J+pOASeFTPTi/n0Bd5db/Xl56l
         vHo5csDj+lPcZHDHljjUzREp8XsE/42ylrhmhYKVWHtRA/Z0LY96sqnPlfaCOX3WCqv6
         l3emwdw87iL8bR67wGXISD/BmYDnsOVj3FkHV0CCGzR9hFG3G1TcE2xv4Xga3rg0X088
         5/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=YFUG6VqpJOpmkb5ByhOUjmvLvwfm4lNUw7Azvk5bWT4=;
        b=lz33IMTdHmCCwhx/GFa5/IAFjUTf2JOwI81jDNyupe5PRpHrZJt/rzlMip0RXZpaGL
         EDH55hwoT9bgnUfwHwqT0IkRpfuNVtL3Rs4jeEoMJGj8/1rSQJmR1PBn+MZSR4vqdsAJ
         PHxjskRH9FItcnERzbZVqwC2vPPtqKo5JEBc98HsFik30iHgE8yCgj236Ad14+9Qig2F
         KJad4jruVZUxLsIuyWgIvWt3R9c9WChtxN6T7SJx2yZBOQlvw2VP6h6pXoqEcMrG7xCL
         0ZPeYWWLMTvlhWfaZ5uDiE3jztWW7AT7PX23rp2stkHLbO3mzVP5Y7sJrN7pmTK/V2mq
         vlRA==
X-Gm-Message-State: AOAM530ZQqSR/ZtAgkKxy0s3MBB4OwrzT6/gukq8WLUqCgKzob/3+TQG
        4F6FD/fR4XFlOSiATnHqkU8EUExMH5E=
X-Google-Smtp-Source: ABdhPJzelyGvhqzyTR4zczqH1/kZTrOSSJeXfFXfOkb6eZnj2Gp4KOnp9/Ucpdvjm9gh6J96WGmbJQ==
X-Received: by 2002:a37:6143:: with SMTP id v64mr18384973qkb.490.1605904874856;
        Fri, 20 Nov 2020 12:41:14 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c27sm2754593qkk.57.2020.11.20.12.41.13
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:41:14 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKfDmA029465
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:41:13 GMT
Subject: [PATCH v2 084/118] NFSD: Update WRITE3arg decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:41:13 -0500
Message-ID: <160590487318.1340.4098500934407742189.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

As part of the update, open code that sanity-checks the size of the
data payload against the length of the RPC Call message has to be
re-implemented to use xdr_stream infrastructure.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3xdr.c |   56 +++++++++++++++++++++--------------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 2b51686c238f..38dad447a760 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -400,53 +400,41 @@ nfs3svc_decode_readargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd3_writeargs *args = rqstp->rq_argp;
-	unsigned int len, hdr, dlen;
 	u32 max_blocksize = svc_max_payload(rqstp);
 	struct kvec *head = rqstp->rq_arg.head;
 	struct kvec *tail = rqstp->rq_arg.tail;
+	size_t remaining;
 
-	p = decode_fh(p, &args->fh);
+	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
+		return XDR_DECODE_FAILED;
+	p = xdr_inline_decode(xdr, sizeof(__be32) * 5);
 	if (!p)
-		return 0;
+		return XDR_DECODE_FAILED;
 	p = xdr_decode_hyper(p, &args->offset);
+	args->count = be32_to_cpup(p++);
+	args->stable = be32_to_cpup(p++);
 
-	args->count = ntohl(*p++);
-	args->stable = ntohl(*p++);
-	len = args->len = ntohl(*p++);
-	if ((void *)p > head->iov_base + head->iov_len)
-		return 0;
-	/*
-	 * The count must equal the amount of data passed.
-	 */
-	if (args->count != args->len)
-		return 0;
-
-	/*
-	 * Check to make sure that we got the right number of
-	 * bytes.
-	 */
-	hdr = (void*)p - head->iov_base;
-	dlen = head->iov_len + rqstp->rq_arg.page_len + tail->iov_len - hdr;
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
 
+	/* request sanity */
+	if (args->count != args->len)
+		return XDR_DECODE_FAILED;
+	remaining = head->iov_len + rqstp->rq_arg.page_len + tail->iov_len;
+	remaining -= xdr_stream_pos(xdr);
+	if (remaining < xdr_align_size(args->len))
+		return XDR_DECODE_FAILED;
 	if (args->count > max_blocksize) {
 		args->count = max_blocksize;
-		len = args->len = max_blocksize;
+		args->len = max_blocksize;
 	}
 
-	args->first.iov_base = (void *)p;
-	args->first.iov_len = head->iov_len - hdr;
-	return 1;
+	args->first.iov_base = p;
+	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
+
+	return XDR_DECODE_DONE;
 }
 
 int


