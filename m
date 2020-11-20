Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF8E2BB79B
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbgKTUmb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731685AbgKTUma (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:42:30 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AE2C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:30 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 199so10191739qkg.9
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2n47fKiM2da24ENTeYnLfiEuqJfAHR6goaY+lknednU=;
        b=ZRB6M9lGgLiurn6qktZAXP6fkzHVJynrhDvA+bs6AayCRLtsD3rekD7we2lBzoxOS3
         5kOUDloIw8aVtMjh/vAjyApqwG/nAzg03a9ZrEq4ZXU49RvHHnAVPGYkNiW60XVBASH/
         7DNU00KkM4WaTud5kNdF7H3ItkO73yJI0kQL5xtSfTn+/jn9gmiqEKOxEf5MG1Z+TD5N
         1PpBCg/FqEhOwrg89sluR2H7Y1HiolrAkkyYqZbXZvKTAUANRDuxHaKNlUPX4Im8URk1
         2NMviEv4QYSFU9OT8sFoOfHpDJgtLqzjzdGR9zlbGGdnW1gFH/H6Qem46krc6xkrvIMn
         uAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2n47fKiM2da24ENTeYnLfiEuqJfAHR6goaY+lknednU=;
        b=a0TayLnqV1yyDqGAxiLGH01P/NAVWAQL3G8KvH6HJc9HjHaH9hWmQ9Z9i7hFkzSWs9
         zJ6gTyILwUHYHREquIE6KK7MooK3+5SLhW1GE0vgKbd+2QIOD8ZFo5ahFkvJFqCsY5cB
         w4e6WNnjGGhaOnw8TVaoTOME0Zwsjde2Ix3PHC73kvY5PZ9Jvk60RdTZEtsLtEBOvXcm
         19Bc6qb96x+vZsm1XGsX845KtRSfSU/VZSPVlUbp/upoElMqL3L/18ubQujJ+J+CUvO/
         R4jmram7jWXusKNRlEYhMYZo+DBqDQ8FJzufVpjOyykamm1DwUTdQ+HCYV23xHU+BuCE
         iKOQ==
X-Gm-Message-State: AOAM531SMFKY4DyPRRfD9yBwGYsIsBL5wehfBtdep3wLiLNa3ynpeIdc
        JX6ugd5eMIySFDZ/Fc//7fuCSCRL4c4=
X-Google-Smtp-Source: ABdhPJwPQK8y3IPBnVqTTU65Bt1nT9fRXAeSU3VNbNMNkzgx3SF7fwmPorlOjRin1SHXIhuQaoEokA==
X-Received: by 2002:a37:a78c:: with SMTP id q134mr19626770qke.189.1605904949555;
        Fri, 20 Nov 2020 12:42:29 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j17sm2663946qtn.2.2020.11.20.12.42.28
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:42:28 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKgR48029507
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:42:27 GMT
Subject: [PATCH v2 098/118] NFSD: Update the NFSv2 READ argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:42:27 -0500
Message-ID: <160590494786.1340.6179902743258104536.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfsproc.c |   32 ++++++++++++++++++--------------
 fs/nfsd/nfsxdr.c  |   34 ++++++++++------------------------
 fs/nfsd/xdr.h     |    1 -
 3 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 5b8436af43a9..998a1f94c6f8 100644
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
index 36765a96abae..7488fb396627 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -246,33 +246,19 @@ nfssvc_decode_diropargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_readargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd_readargs *args = rqstp->rq_argp;
-	unsigned int len;
-	int v;
-	p = decode_fh(p, &args->fh);
-	if (!p)
-		return 0;
-
-	args->offset    = ntohl(*p++);
-	len = args->count     = ntohl(*p++);
-	p++; /* totalcount - unused */
 
-	len = min_t(unsigned int, len, NFSSVC_MAXBLKSIZE_V2);
+	if (!svcxdr_decode_fhandle(xdr, &args->fh))
+		return XDR_DECODE_FAILED;
+	p = xdr_inline_decode(xdr, sizeof(__be32) * 3);
+	if (!p)
+		return XDR_DECODE_FAILED;
+	args->offset = be32_to_cpup(p++);
+	args->count = be32_to_cpup(p);
+	/* totalcount is ignored */
 
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
+	return XDR_DECODE_DONE;
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


