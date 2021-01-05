Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC982EAE58
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbhAEPbI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbhAEPbH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:31:07 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35801C061793
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:30:21 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 186so26795760qkj.3
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1pVZopU2CsbRndKPbGGCSJiKrCH8+GFDj1p4QPlGB8I=;
        b=n63S6pmlZTGo4N1D/XJEmHMb9dZKqPYMafVdD+kO80cKgjZ5hhsYccfLNuAodTr4vC
         E2nT6GCLFCLo8XPGIs+cQRrDvydFsBy1ifdRRY/RwX4Z1EWTDTFnxVWoZ2Z5WCLtZwXt
         44/BFfur4MxVH/CyjsO8CatahzhdS1ybPbI4rJJcalDS1LL/ojLyHbgfs3R21DPtYYNb
         Fjnu7U4GM2QJqDZ2CBKsvhpkzKUpT0CiU1d8Q0HXyPCZhHyXdarGAxCxMyUk9WJZgeLT
         c2YnHYwRHc+JLWIJQzxMtZrixJl2ceNZ7Yj/cVnb1C4Nalc5gbxVlCDL84fhrXk5VaHd
         ZHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=1pVZopU2CsbRndKPbGGCSJiKrCH8+GFDj1p4QPlGB8I=;
        b=QaWJlnWQGHbdVObdZjuYpMtia9tcg+bnmpYPJmJVC/2RR9txUoP2FTkbX4YMC5xEFt
         DvAgFYjqQTe9CswXErHXDAQXWTmlLx/ecmcKVF4en5KrcoEiCBbA0D9/462a/SplgaYg
         uF9MCFCyemv76zE+dMpqWsNoRmPu6+BebU4zq51fG6oXj2+C8u8eqxRdAIueS3BufY4p
         kQgtOLJvoZ4eJYinJdcqNgxVYRW7Xm/yf2jbjxLdisDH8sSDVm6t52zV5fCehtIjV6G9
         uEwxc+6OwWMIBiKalwLNH+xqs/Czbs4MbAtghcI+kBoaGtT8vnLBuOCVcVyaW92ogEKu
         25VA==
X-Gm-Message-State: AOAM533KqKkdFQp3WgD57YRla9y3TocF7ZLp4MJLwDuBysBtvRMMy46O
        TeCfXZZv9cbeFmqUi0Yx3B5NpKhqTgE=
X-Google-Smtp-Source: ABdhPJwroRa0rc0tAT+yFWCeefyEikiDqCCg7Ccst7q436fithZ3E+kkoVZEHICAyM62WFxklkNTIQ==
X-Received: by 2002:a37:76c6:: with SMTP id r189mr83210qkc.24.1609860620107;
        Tue, 05 Jan 2021 07:30:20 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id n66sm117010qkn.136.2021.01.05.07.30.18
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:30:19 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FUIxj020841
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:30:18 GMT
Subject: [PATCH v1 07/42] NFSD: Update WRITE3arg decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:30:18 -0500
Message-ID: <160986061812.5532.3122782251888690881.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3xdr.c |   51 ++++++++++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index ff98eae5db81..0aafb096de91 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -405,52 +405,41 @@ nfs3svc_decode_readargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_writeargs *args = rqstp->rq_argp;
-	unsigned int len, hdr, dlen;
 	u32 max_blocksize = svc_max_payload(rqstp);
 	struct kvec *head = rqstp->rq_arg.head;
 	struct kvec *tail = rqstp->rq_arg.tail;
+	size_t remaining;
 
-	p = decode_fh(p, &args->fh);
-	if (!p)
+	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
 		return 0;
-	p = xdr_decode_hyper(p, &args->offset);
-
-	args->count = ntohl(*p++);
-	args->stable = ntohl(*p++);
-	len = args->len = ntohl(*p++);
-	if ((void *)p > head->iov_base + head->iov_len)
+	if (xdr_stream_decode_u64(xdr, &args->offset) < 0)
 		return 0;
-	/*
-	 * The count must equal the amount of data passed.
-	 */
-	if (args->count != args->len)
+	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &args->stable) < 0)
 		return 0;
 
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
+	/* opaque data */
+	if (xdr_stream_decode_u32(xdr, &args->len) < 0)
 		return 0;
 
+	/* request sanity */
+	if (args->count != args->len)
+		return 0;
+	remaining = head->iov_len + rqstp->rq_arg.page_len + tail->iov_len;
+	remaining -= xdr_stream_pos(xdr);
+	if (remaining < xdr_align_size(args->len))
+		return 0;
 	if (args->count > max_blocksize) {
 		args->count = max_blocksize;
-		len = args->len = max_blocksize;
+		args->len = max_blocksize;
 	}
 
-	args->first.iov_base = (void *)p;
-	args->first.iov_len = head->iov_len - hdr;
+	args->first.iov_base = xdr->p;
+	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
+
 	return 1;
 }
 


