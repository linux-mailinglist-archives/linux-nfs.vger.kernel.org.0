Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADE82EAE50
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbhAEPaw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbhAEPaw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:30:52 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8084AC061795
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:30:36 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 19so26747017qkm.8
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9dSk3Mv8A4t4rF3p0ZZ95kkr2TeDYiyldkVbX+1Fsjk=;
        b=qo07Y8F0W6aqDFuuoD/NoXlOl5TELk1vIogxPd+ba+S28ZTq7mqYwwYmgadn0XOWYr
         EkhJnxSJKHgPP1lz9g/X72So/wybq76LPzNiHKbEhNJHr6Gdlgalo+pg1t54WpxZvw9e
         HP+DRdkh3J7SzyFIlPh1w2wLHm0CPc46OKq6BgnCF59s21u4u9yKLaxub1+puDUgWd1O
         2LEe6ryzsZAywrrS4tK3181nN5jbAMN36hCRnqoqyHRUHzKHgd1bWYWdyq4HCCotHy8t
         JIAYIXvlw+Sjnk4JzxxBIjl+bte+t6vLU9iUdavR1bw//jdXzSviyo8+rIVIZQfEQr1I
         3/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=9dSk3Mv8A4t4rF3p0ZZ95kkr2TeDYiyldkVbX+1Fsjk=;
        b=hGbrlZKSA+YhuHjDaSWIVHWNnZFfLcq/g4ccrIj0Bqw1/8aKxNLjp6PSmOqEEmGH8s
         e4BGx2dYcI2M+GXCzJfIg5klViBv2QAXL0L9kWHsTpSF+Ys9RGiAFTQvC3ZXYbrqfJgJ
         43CPeC/FpPPLcesvYGXBNlY0usN11D9DqDxYU2U01nmuUvnTiVh1sZ3LLWyBPw/+xEAG
         0obEC9j+gO5UZs6caClSdV02ZvWOQGZH2G/mHRfXc3k80rjTOWrb7kDcQ9lujYrQBsR+
         e4FT4M5nthC2WYHYOmFIiuehPXx57+zQEzZpG95RcWYZmOKAezbeFHjq9iOJw6rYfuX9
         16Eg==
X-Gm-Message-State: AOAM530pO/hukw5KZ6V4mIiMO5lDfTamuEc6hXxmaCFpWtA/WzXbtozA
        8BmZSHdE3Et9ft9TdGub3vuN8hc/PUE=
X-Google-Smtp-Source: ABdhPJy3cwp+Hu8d3T5WBhDMqzC0bc6xD43RNoeuCc+fv0URNJ4dCiQwRd4e01qlmqQet4G2I91F4g==
X-Received: by 2002:a37:544:: with SMTP id 65mr67764qkf.204.1609860635400;
        Tue, 05 Jan 2021 07:30:35 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e11sm47294qtg.46.2021.01.05.07.30.34
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:30:34 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FUX7E020850
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:30:33 GMT
Subject: [PATCH v1 10/42] NFSD: Add helper to set up the pages where the
 dirlist is encoded
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:30:33 -0500
Message-ID: <160986063393.5532.9597204694840100223.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

De-duplicate some code that is used by both READDIR and READDIRPLUS
to build the dirlist in the Reply. Because this code is not related
to decoding READ arguments, it is moved to a more appropriate spot.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |   29 +++++++++++++++++++----------
 fs/nfsd/nfs3xdr.c  |   20 --------------------
 fs/nfsd/xdr3.h     |    1 -
 3 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 7ea2fb127f6f..8675851199f8 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -435,6 +435,23 @@ nfsd3_proc_link(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
+static void nfsd3_init_dirlist_pages(struct svc_rqst *rqstp,
+				     struct nfsd3_readdirres *resp,
+				     int count)
+{
+	count = min_t(u32, count, svc_max_payload(rqstp));
+
+	/* Convert byte count to number of words (i.e. >> 2),
+	 * and reserve room for the NULL ptr & eof flag (-2 words) */
+	resp->buflen = (count >> 2) - 2;
+
+	resp->buffer = page_address(*rqstp->rq_next_page);
+	while (count > 0) {
+		rqstp->rq_next_page++;
+		count -= PAGE_SIZE;
+	}
+}
+
 /*
  * Read a portion of a directory.
  */
@@ -452,16 +469,12 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 				SVCFH_fmt(&argp->fh),
 				argp->count, (u32) argp->cookie);
 
-	/* Make sure we've room for the NULL ptr & eof flag, and shrink to
-	 * client read size */
-	count = (argp->count >> 2) - 2;
+	nfsd3_init_dirlist_pages(rqstp, resp, argp->count);
 
 	/* Read directory and encode entries on the fly */
 	fh_copy(&resp->fh, &argp->fh);
 
-	resp->buflen = count;
 	resp->common.err = nfs_ok;
-	resp->buffer = argp->buffer;
 	resp->rqstp = rqstp;
 	offset = argp->cookie;
 
@@ -513,16 +526,12 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 				SVCFH_fmt(&argp->fh),
 				argp->count, (u32) argp->cookie);
 
-	/* Convert byte count to number of words (i.e. >> 2),
-	 * and reserve room for the NULL ptr & eof flag (-2 words) */
-	resp->count = (argp->count >> 2) - 2;
+	nfsd3_init_dirlist_pages(rqstp, resp, argp->count);
 
 	/* Read directory and encode entries on the fly */
 	fh_copy(&resp->fh, &argp->fh);
 
 	resp->common.err = nfs_ok;
-	resp->buffer = argp->buffer;
-	resp->buflen = resp->count;
 	resp->rqstp = rqstp;
 	offset = argp->cookie;
 
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index db1d6ebf1353..b601f0c6156f 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -560,8 +560,6 @@ int
 nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_readdirargs *args = rqstp->rq_argp;
-	int len;
-	u32 max_blocksize = svc_max_payload(rqstp);
 
 	p = decode_fh(p, &args->fh);
 	if (!p)
@@ -570,14 +568,6 @@ nfs3svc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p)
 	args->verf   = p; p += 2;
 	args->dircount = ~0;
 	args->count  = ntohl(*p++);
-	len = args->count  = min_t(u32, args->count, max_blocksize);
-
-	while (len > 0) {
-		struct page *p = *(rqstp->rq_next_page++);
-		if (!args->buffer)
-			args->buffer = page_address(p);
-		len -= PAGE_SIZE;
-	}
 
 	return xdr_argsize_check(rqstp, p);
 }
@@ -586,8 +576,6 @@ int
 nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_readdirargs *args = rqstp->rq_argp;
-	int len;
-	u32 max_blocksize = svc_max_payload(rqstp);
 
 	p = decode_fh(p, &args->fh);
 	if (!p)
@@ -597,14 +585,6 @@ nfs3svc_decode_readdirplusargs(struct svc_rqst *rqstp, __be32 *p)
 	args->dircount = ntohl(*p++);
 	args->count    = ntohl(*p++);
 
-	len = args->count = min(args->count, max_blocksize);
-	while (len > 0) {
-		struct page *p = *(rqstp->rq_next_page++);
-		if (!args->buffer)
-			args->buffer = page_address(p);
-		len -= PAGE_SIZE;
-	}
-
 	return xdr_argsize_check(rqstp, p);
 }
 
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 08f909142ddf..789a364d5e69 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -93,7 +93,6 @@ struct nfsd3_readdirargs {
 	__u32			dircount;
 	__u32			count;
 	__be32 *		verf;
-	__be32 *		buffer;
 };
 
 struct nfsd3_commitargs {


