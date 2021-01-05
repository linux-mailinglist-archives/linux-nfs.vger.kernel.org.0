Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750C12EAE72
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbhAEPcU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbhAEPcU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:32:20 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9464AC061795
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:31:39 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id p14so26786979qke.6
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Zf/yoElT6MWQefrSE2xQsbQMfIvzjt/LKHYK3aScOJM=;
        b=aVDRuJLnOz2OgMWdcOFp+lGNwnEEnNTiosBnevqRXdUCGzwSpu69D7wNWcuK1V2ym8
         H/Ki0iiTIAVNUd9Lf4mMJsCFVmdT3bog6Cr8Y0C0141tP5kZSYGk1rTqQwlDsvU4ZJa1
         1qyrf8xxJtML37Jjtg+2EV4X2CM6DMicgwpaTMdTuLHKfWjHE9V4DDvd3pVJXPFmx3W+
         SoVHm8cwnACY7AdSNr4ZmP4NeLhFMWgiZ4MAwSG6IgsbRZKypq+Z+FucH+622LjAWQOy
         Y+0h5hz8FgI9ksRIFYZTxA41Gfq0dbqUEf+Z5hgwuSIRxtMpd6vkHcMUwbZZkrywy2tU
         1DWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Zf/yoElT6MWQefrSE2xQsbQMfIvzjt/LKHYK3aScOJM=;
        b=TRxl+Q8aCjF2um44J0UnHlKbuSeLwIwGnpsJ9lSCtHGjbkfuoKUD4HO3mf+BOs35Z4
         DKf7kKxJOJ/P1Pf+6vvmUTSISGD4PDDuZJhWWirU8Aqtq7gkaPMQeZQOEE5WtzVRs0fq
         pFZ5ep50skzVAdyVFx2RKOirMy9i9/LiANvAx/tS13Wv7uN5u+OKEjbvz69o0l4/7nHc
         RJ1CYpi9piEkCcrgl2JrVj4jkQlfrY1BYHWnZnx1IRaLIT5nRWmXwu4oU1JheHPp3J10
         5vdu+qhuofZalgRcE0veZt9aBrpaLpLkFY/6hvpy6QEd6M+cPPTWwmZLsugVbAY5eqcg
         D/GA==
X-Gm-Message-State: AOAM531TGkmN3zuRce+DW3C+SisXhe06/zUv6QRLjIGt+9VAWG8gMVGY
        otSljxpNkWHXeLQzcba38P+csO5PaMc=
X-Google-Smtp-Source: ABdhPJyYfdpUre6tY41EmZT1dbvpc5tGUKQIc1IXMFweHDSlUAtCSuL8cLtNSfzpSXSUoVKQr7gMHg==
X-Received: by 2002:a37:63c7:: with SMTP id x190mr16508qkb.277.1609860698479;
        Tue, 05 Jan 2021 07:31:38 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x49sm73409qtx.6.2021.01.05.07.31.37
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:31:37 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FVamV020886
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:31:36 GMT
Subject: [PATCH v1 22/42] NFSD: Update the NFSv2 READ argument decoder to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:31:36 -0500
Message-ID: <160986069683.5532.10097341043519053080.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The code that sets up rq_vec is refactored so that it is now
adjacent to the nfsd_read() call site where it is used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsproc.c |   32 ++++++++++++++++++--------------
 fs/nfsd/nfsxdr.c  |   36 ++++++++++++------------------------
 fs/nfsd/xdr.h     |    1 -
 3 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index b9bc162a5c77..814762793f9c 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -171,32 +171,36 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 {
 	struct nfsd_readargs *argp = rqstp->rq_argp;
 	struct nfsd_readres *resp = rqstp->rq_resp;
+	unsigned int len;
 	u32 eof;
+	int v;
 
 	dprintk("nfsd: READ    %s %d bytes at %d\n",
 		SVCFH_fmt(&argp->fh),
 		argp->count, argp->offset);
 
+	argp->count = min_t(u32, argp->count, NFSSVC_MAXBLKSIZE_V2);
+
+	v = 0;
+	len = argp->count;
+	while (len > 0) {
+		struct page *page = *(rqstp->rq_next_page++);
+
+		rqstp->rq_vec[v].iov_base = page_address(page);
+		rqstp->rq_vec[v].iov_len = min_t(unsigned int, len, PAGE_SIZE);
+		len -= rqstp->rq_vec[v].iov_len;
+		v++;
+	}
+
 	/* Obtain buffer pointer for payload. 19 is 1 word for
 	 * status, 17 words for fattr, and 1 word for the byte count.
 	 */
-
-	if (NFSSVC_MAXBLKSIZE_V2 < argp->count) {
-		char buf[RPC_MAX_ADDRBUFLEN];
-		printk(KERN_NOTICE
-			"oversized read request from %s (%d bytes)\n",
-				svc_print_addr(rqstp, buf, sizeof(buf)),
-				argp->count);
-		argp->count = NFSSVC_MAXBLKSIZE_V2;
-	}
 	svc_reserve_auth(rqstp, (19<<2) + argp->count + 4);
 
 	resp->count = argp->count;
-	resp->status = nfsd_read(rqstp, fh_copy(&resp->fh, &argp->fh),
-				 argp->offset,
-				 rqstp->rq_vec, argp->vlen,
-				 &resp->count,
-				 &eof);
+	fh_copy(&resp->fh, &argp->fh);
+	resp->status = nfsd_read(rqstp, &resp->fh, argp->offset,
+				 rqstp->rq_vec, v, &resp->count, &eof);
 	if (resp->status == nfs_ok)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index f3189e1be20f..1eacaa2c13a9 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -246,33 +246,21 @@ nfssvc_decode_diropargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_readargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_readargs *args = rqstp->rq_argp;
-	unsigned int len;
-	int v;
-	p = decode_fh(p, &args->fh);
-	if (!p)
-		return 0;
+	u32 totalcount;
 
-	args->offset    = ntohl(*p++);
-	len = args->count     = ntohl(*p++);
-	p++; /* totalcount - unused */
-
-	len = min_t(unsigned int, len, NFSSVC_MAXBLKSIZE_V2);
+	if (!svcxdr_decode_fhandle(xdr, &args->fh))
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &args->offset) < 0)
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
+		return 0;
+	/* totalcount is ignored */
+	if (xdr_stream_decode_u32(xdr, &totalcount) < 0)
+		return 0;
 
-	/* set up somewhere to store response.
-	 * We take pages, put them on reslist and include in iovec
-	 */
-	v=0;
-	while (len > 0) {
-		struct page *p = *(rqstp->rq_next_page++);
-
-		rqstp->rq_vec[v].iov_base = page_address(p);
-		rqstp->rq_vec[v].iov_len = min_t(unsigned int, len, PAGE_SIZE);
-		len -= rqstp->rq_vec[v].iov_len;
-		v++;
-	}
-	args->vlen = v;
-	return xdr_argsize_check(rqstp, p);
+	return 1;
 }
 
 int
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 84256a6a1ba1..d2ffda96975d 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -27,7 +27,6 @@ struct nfsd_readargs {
 	struct svc_fh		fh;
 	__u32			offset;
 	__u32			count;
-	int			vlen;
 };
 
 struct nfsd_writeargs {


