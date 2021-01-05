Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6336C2EAE4E
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbhAEPam (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbhAEPam (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:30:42 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E308C0617A0
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:30:15 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 22so26745531qkf.9
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lgOPBssOoEXl+FYJvwhUQej6ZdNMZl4H/mvYHxOmzRE=;
        b=Qd72ktgu6w5Zus/y6J0nP3L+o+Qn9EDX+RvHJ34KmAhKM5UK+rZ6Ee/WMcQEZ7BPUX
         n5HcoYWAQMN8EVaBVyXKK15y7bjKhDyDXytLyuEBbasjgGhydoMS0TYK/AV68LsrM3d4
         qPdyW89KKVRVdFHGxiC8KZvtk9DviGTZ1igG8HE0EA+7Af/L0PlRu5XHKvMC2/q3Zi0A
         mfwjPT6f/lGxVliObOZ5XeJFV8OumdCEVe2VlD5V/Pc/E3n72coVi+8j7WCSwnig9y+2
         EH2qNydgvdtAobnrD9Py+jhQnH+YNt4lypHjbXlbX3UgqE+o7WH0R+Qaey8t3SvVEAME
         oHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=lgOPBssOoEXl+FYJvwhUQej6ZdNMZl4H/mvYHxOmzRE=;
        b=F/l5TBqnEppFEsrv/h71zaORRp3SxrdYxJ8/OFz3rliioo2oLKmVcHhB6Bgt7pZBJI
         JpMNkqvHFpaYBcdeMaK9pkLkBU/b6s5RQGLM+mD53+warqhkygDPO8sYFClHsP4L2How
         XEGfWR6kIbjfvgYSKMsZxY128caEjTvJWKb6OYnhXY+ElgeVHyoeR7QRSoflOkDm5wFm
         SxePv0ikDuYZoqrsEkeHeumS1bWz86WdcK/nswCczlWvaKvAvd6ZwQFU7S3k1+FD1KHb
         pdJBnxHFdRQUKW0JHmY6vNIJzx8PgHwgIk9LFKaZqLAcW9kw1IO6to4JxNEMrJHgw8yw
         XtZg==
X-Gm-Message-State: AOAM532572Y+6Lw7s07tiOrz+5Ioxan7UDiW3ikOKEdGY5JZp5uFjv7d
        3IMcaxWf2c19Rbg412g3Ha8AflPOimo=
X-Google-Smtp-Source: ABdhPJz5fW3tq1vStifk4h0+cTMzR8DT4dAsUUQLVtYKjxqLSfSWK+RhAmDCCZzDCdtgXQNXp2HQ2g==
X-Received: by 2002:a37:495:: with SMTP id 143mr31905qke.37.1609860614497;
        Tue, 05 Jan 2021 07:30:14 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d123sm118463qke.95.2021.01.05.07.30.13
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:30:13 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FUD1a020838
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:30:13 GMT
Subject: [PATCH v1 06/42] NFSD: Update READ3arg decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:30:13 -0500
Message-ID: <160986061305.5532.14704732180124620703.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3proc.c |   23 ++++++++++++++++++-----
 fs/nfsd/nfs3xdr.c  |   28 +++++++---------------------
 fs/nfsd/xdr3.h     |    1 -
 3 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 4b66f055141b..acdf47179a38 100644
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
index ac680f34fcba..ff98eae5db81 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -389,31 +389,17 @@ nfs3svc_decode_accessargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfs3svc_decode_readargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_readargs *args = rqstp->rq_argp;
-	unsigned int len;
-	int v;
-	u32 max_blocksize = svc_max_payload(rqstp);
 
-	p = decode_fh(p, &args->fh);
-	if (!p)
+	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
+		return 0;
+	if (xdr_stream_decode_u64(xdr, &args->offset) < 0)
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &args->count) < 0)
 		return 0;
-	p = xdr_decode_hyper(p, &args->offset);
-
-	args->count = ntohl(*p++);
-	len = min(args->count, max_blocksize);
-
-	/* set up the kvec */
-	v=0;
-	while (len > 0) {
-		struct page *p = *(rqstp->rq_next_page++);
 
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


