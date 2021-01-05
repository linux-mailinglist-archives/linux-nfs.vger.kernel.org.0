Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4C22EAE67
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbhAEPcA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbhAEPcA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:32:00 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8944C061574
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:31:44 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 4so14823768qvh.1
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9VW1Ou8LjJrNLzLN8qVcgBlEKXmYO24Pd+5GLIp6BMI=;
        b=s4yfVLOoLsMk3BIM2bGxMY9eWgbYP3xAUS4ac7s9wF7+p1M3CeoRvpJwLj/Gvb2bJW
         mRa1GakKpIuOHWQG/zZBBZNVCfRvvYKjRDDjndExI0pSBgMDPDeGilSAGEayrVQ97fOb
         wHNgZ48Qp0kecT+iwQbJ1fJQu5CdmvsDYSqggreXsGhU3h7JHttJppDqSu/c0fgXlnIB
         zYsG/yU18I4gWVgJ+y+xGZV7GU2P+0I40eNnhvs+KITVlNWdA25tAPXhvkysMCzNULgU
         0zY+ADILH3rZseAW70TRpz1R+c3ED5Vqg/6+/n7ZvxKxos6s7tL87wcIp7Xpx2zwx6Uw
         /6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=9VW1Ou8LjJrNLzLN8qVcgBlEKXmYO24Pd+5GLIp6BMI=;
        b=TQLwnFK9aH1pBNjpIBgbOuWlvMZJDADZ7+jIc7bX7yv87vrD9xnL+atG7z5qGIDgLd
         kd5uu5wvqtFYh7a9Iab0PAlWvQFN8YJAcaRFxWSN3YFADUn/Q+EkfqxCT9skNA8ESovE
         D28ajDNaOYlMHfT/fTLE0V4r6iphwY/fZGqJrQqUvU0E3KEvmGUB4D+uCDqFtYiRLWQc
         TXvJT0z6zXU98IyNfSv8imT7CbQBATSuXckCVXNWtf2EmNVdxyAOIscgBD2A+4ydR81v
         FhVV49+hoBUUHhlqXxs5e4eK5oNJshUczvoYYntyx0HQ3t9AAX9cdgK3oqljE1Fgkd5w
         7TVQ==
X-Gm-Message-State: AOAM532xjxBQoFMiJMZ26/VAbm87uyteMCtdOtlaw2KdD5oqtw/vozBL
        IkAMU/IMQ0vHo0g/byHHkEH08vLkdMc=
X-Google-Smtp-Source: ABdhPJxrPl2l1Q6EuIypnQzjHqM6eKaWE82E9eDI6gAPQ7nh+iZlccTiOIk8tU+utefE771Ze4sBig==
X-Received: by 2002:a0c:f1ce:: with SMTP id u14mr80985960qvl.24.1609860703754;
        Tue, 05 Jan 2021 07:31:43 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g28sm19074qtm.91.2021.01.05.07.31.42
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:31:43 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FVgkE020889
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:31:42 GMT
Subject: [PATCH v1 23/42] NFSD: Update the NFSv2 WRITE argument decoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:31:42 -0500
Message-ID: <160986070212.5532.1358874372009048952.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsxdr.c |   52 +++++++++++++++++++++-------------------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 1eacaa2c13a9..11d27b219cff 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -266,46 +266,36 @@ nfssvc_decode_readargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_writeargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_writeargs *args = rqstp->rq_argp;
-	unsigned int len, hdr, dlen;
 	struct kvec *head = rqstp->rq_arg.head;
+	struct kvec *tail = rqstp->rq_arg.tail;
+	u32 beginoffset, totalcount;
+	size_t remaining;
 
-	p = decode_fh(p, &args->fh);
-	if (!p)
+	if (!svcxdr_decode_fhandle(xdr, &args->fh))
 		return 0;
-
-	p++;				/* beginoffset */
-	args->offset = ntohl(*p++);	/* offset */
-	p++;				/* totalcount */
-	len = args->len = ntohl(*p++);
-	/*
-	 * The protocol specifies a maximum of 8192 bytes.
-	 */
-	if (len > NFSSVC_MAXBLKSIZE_V2)
+	/* beginoffset is ignored */
+	if (xdr_stream_decode_u32(xdr, &beginoffset) < 0)
 		return 0;
-
-	/*
-	 * Check to make sure that we got the right number of
-	 * bytes.
-	 */
-	hdr = (void*)p - head->iov_base;
-	if (hdr > head->iov_len)
+	if (xdr_stream_decode_u32(xdr, &args->offset) < 0)
+		return 0;
+	/* totalcount is ignored */
+	if (xdr_stream_decode_u32(xdr, &totalcount) < 0)
 		return 0;
-	dlen = head->iov_len + rqstp->rq_arg.page_len - hdr;
 
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
+		return 0;
+	if (args->len > NFSSVC_MAXBLKSIZE_V2)
+		return 0;
+	remaining = head->iov_len + rqstp->rq_arg.page_len + tail->iov_len;
+	remaining -= xdr_stream_pos(xdr);
+	if (remaining < xdr_align_size(args->len))
 		return 0;
+	args->first.iov_base = xdr->p;
+	args->first.iov_len = head->iov_len - xdr_stream_pos(xdr);
 
-	args->first.iov_base = (void *)p;
-	args->first.iov_len = head->iov_len - hdr;
 	return 1;
 }
 


