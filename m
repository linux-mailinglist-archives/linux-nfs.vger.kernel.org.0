Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0A22BB78B
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbgKTUlM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730631AbgKTUlM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:41:12 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FFCC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:10 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id y11so5300928qvu.10
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=A4SfpDgUKmiQOphape7Rod4t6lp5H5w0YY/Q8qkDK0s=;
        b=qBzVU0AISmT7X1GHehXcsq+4WZxx4s3iHiBrqe3NT64EEy30M5JGj1XOn4Y++OAoMI
         0Q/RRx+Gvye/50deD6dR9vj3BRzH26Hq1obzeD+wd0XPmDrWkd/NWmKGie+Oeiz1jY6D
         EEbVCDcM8DHSkIWSDRzV1FhFKSfWpx7Me0cyMlsAZRQwL/WC7aLx9Pi6TevgF/tIK36M
         8FVmGwIpO/Hb2PaibQMzIVf1Na/vZ55Dy97M4JIxF3CVk1CwerETi9Wkh5xyWAITzGS/
         PxCWPId4J/wXykQocaHiS3hm1h/3sWym/glwtpzV/Bn93rbZmlYFSuTTadjgbpsaOTpK
         SXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=A4SfpDgUKmiQOphape7Rod4t6lp5H5w0YY/Q8qkDK0s=;
        b=Nrji9YElx7SfpL3y7260O/Qp84+mZl6uNqg9UVJiIaD3zHlcz64gl8N/j22XlojJfi
         0nx8vcfdwiqd0B15m3x/Zt09QjHiclW5IkVP9tTO8DRcgZNdUeoMzE7E1e3FvGZc5Yxk
         9qtVk3RiBznHCUNglfkrRmZJVju90rwf9al2gq8gZiQEmqagtHuZ3IQO/OQmhw3/yIt/
         THaHKLFsREpy9vYnDQIUUgFmf6qUpFNOhqY8IJODXFR0V76T0S9jjF8i5iF83p0VoCaj
         qYujkx1wbjrEMeuOEzDsTOr9KM9gt2BoU40X3l77Ot8ecc/v0i8eoHNBAMVEqZwMWrH6
         mqMQ==
X-Gm-Message-State: AOAM530ycAIkTdoEXoFkKVgO1ZUskFhnDYBGKKJvPluhTlKXcE+yWpd2
        KCBVSsGtJiei+1bI3sYfn18zEEk54do=
X-Google-Smtp-Source: ABdhPJx8CK/aC8HUCaRsJhlh7p3RNJn3MzA/niBhUmvV2xHScIIJduMNXT6xzEomWCZDCtmRuKMQyw==
X-Received: by 2002:a0c:ecc1:: with SMTP id o1mr17421419qvq.6.1605904869538;
        Fri, 20 Nov 2020 12:41:09 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w15sm2836341qkf.52.2020.11.20.12.41.08
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:41:08 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKf7Q2029462
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:41:07 GMT
Subject: [PATCH v2 083/118] NFSD: Update READ3arg decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:41:07 -0500
Message-ID: <160590486784.1340.9612166122815548998.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3proc.c |   23 ++++++++++++++++++-----
 fs/nfsd/nfs3xdr.c  |   27 +++++++--------------------
 fs/nfsd/xdr3.h     |    1 -
 3 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index b6c2c1c837a0..5c0664486485 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -144,25 +144,38 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
 {
 	struct nfsd3_readargs *argp = rqstp->rq_argp;
 	struct nfsd3_readres *resp = rqstp->rq_resp;
-	u32	max_blocksize = svc_max_payload(rqstp);
-	unsigned long cnt = min(argp->count, max_blocksize);
+	u32 max_blocksize = svc_max_payload(rqstp);
+	unsigned int len;
+	int v;
+
+	argp->count = min_t(u32, argp->count, max_blocksize);
 
 	dprintk("nfsd: READ(3) %s %lu bytes at %Lu\n",
 				SVCFH_fmt(&argp->fh),
 				(unsigned long) argp->count,
 				(unsigned long long) argp->offset);
 
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
 	/* Obtain buffer pointer for payload.
 	 * 1 (status) + 22 (post_op_attr) + 1 (count) + 1 (eof)
 	 * + 1 (xdr opaque byte count) = 26
 	 */
-	resp->count = cnt;
+	resp->count = argp->count;
 	svc_reserve_auth(rqstp, ((1 + NFS3_POST_OP_ATTR_WORDS + 3)<<2) + resp->count +4);
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_read(rqstp, &resp->fh, argp->offset,
-				 rqstp->rq_vec, argp->vlen, &resp->count,
-				 &resp->eof);
+				 rqstp->rq_vec, v, &resp->count, &resp->eof);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 600bc45db66e..2b51686c238f 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -383,31 +383,18 @@ nfs3svc_decode_accessargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_readargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd3_readargs *args = rqstp->rq_argp;
-	unsigned int len;
-	int v;
-	u32 max_blocksize = svc_max_payload(rqstp);
 
-	p = decode_fh(p, &args->fh);
+	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
+		return XDR_DECODE_FAILED;
+	p = xdr_inline_decode(xdr, sizeof(__be32) * 3);
 	if (!p)
-		return 0;
+		return XDR_DECODE_FAILED;
 	p = xdr_decode_hyper(p, &args->offset);
+	args->count = be32_to_cpup(p);
 
-	args->count = ntohl(*p++);
-	len = min(args->count, max_blocksize);
-
-	/* set up the kvec */
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
+	return XDR_DECODE_DONE;
 }
 
 int
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index a4dce4baec7c..7dfeeaa4e1df 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -32,7 +32,6 @@ struct nfsd3_readargs {
 	struct svc_fh		fh;
 	__u64			offset;
 	__u32			count;
-	int			vlen;
 };
 
 struct nfsd3_writeargs {


