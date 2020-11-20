Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5580D2BB789
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbgKTUlC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731558AbgKTUlB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:41:01 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1665FC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:00 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id u4so10193529qkk.10
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BT/gohtJVFGplEFiRA98nWwI59uVXx3gtpt8ZQSersM=;
        b=nSqkypdzvOI8Oc9qJI1SfQMWqWF9vw+/WcMd2fByUUVqGCNKFlGyDZQhckKAqkwE2K
         1x/4c+G+3o2iy7mXsc9n+IhzA8pYZUr/yE8kZwflUWGZgeE9WlzzXk+8QWckWQkuqg83
         G2yT+OL5XQrmwZHO5EgHy90Bsb8l+3v65nf7kK+JKSkNkWpF4tkW8hjGxGfkTIqD8kKS
         HIeMsq/EAN2Dqt/dyckYg4t8gCstc4AmuHna/F072JDewG4QmmtQ5DAfOsx6xWhmBiRT
         3zxVtLWaF3btSUQlqtlJU6wctj4nA4G5a47S0IyyB4UzpAJXQ5s29UJKmnU+8U+Cqkwp
         zxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=BT/gohtJVFGplEFiRA98nWwI59uVXx3gtpt8ZQSersM=;
        b=dpIOEFfKsFtZoYi5O0/4cyzuK5NTV24EuKYUB1IW2G0N4fhv18C6FRB2TbuZ1bOuDa
         5VK85UgkEgfvKTleAA7nupRXSO45LATqKNbmi4ouWGBPQpgwRY/0P6JXydYNXS2xZaSa
         T3A8NRrBKzFRW3uq0AyM3ojGs+xLwx49gDknVG8JYXPPa/9BkkrZRoIg6wLbhA0FgKyp
         Xzu4yh39dQ8b7REyUNYoeM3hQZZ6cyX317E88FoHs9VTSgIAkcEM1cJKVJK5JvlIgj6B
         AIhBUggjf1oISEitNpAJlGJR9ve0N7p93Z0tT/0FtpAcrvqkVYCvqlddDyGPR3E9571q
         QpVg==
X-Gm-Message-State: AOAM531Kt0o9HkRJQKbglSMmSu4GQsfOXyb/GYOEBeWaHBg5XwstnyZO
        v1P7hywjc1fjT8u9TXsL55G/W0f7374=
X-Google-Smtp-Source: ABdhPJzUcuyofLt60UG19TmhY5gsovuGEYzTeYyG2xTQ+qez0yRCUt7N6tzVP+rgjgY32L7Yglr3xw==
X-Received: by 2002:a05:620a:88e:: with SMTP id b14mr3999958qka.434.1605904859010;
        Fri, 20 Nov 2020 12:40:59 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z133sm2981855qka.20.2020.11.20.12.40.58
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:40:58 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKevPX029456
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:40:57 GMT
Subject: [PATCH v2 081/118] NFSD: Update GETATTR3args decoder to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:40:57 -0500
Message-ID: <160590485731.1340.13859840236294030487.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3proc.c |    3 +--
 fs/nfsd/nfs3xdr.c  |   31 +++++++++++++++++++++++++------
 fs/nfsd/xdr3.h     |    2 +-
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 581a93b17bee..b6c2c1c837a0 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -684,7 +684,6 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
  * NFSv3 Server procedures.
  * Only the results of non-idempotent operations are cached.
  */
-#define nfs3svc_decode_fhandleargs	nfs3svc_decode_fhandle
 #define nfs3svc_encode_attrstatres	nfs3svc_encode_attrstat
 #define nfs3svc_encode_wccstatres	nfs3svc_encode_wccstat
 #define nfsd3_mkdirargs			nfsd3_createargs
@@ -715,7 +714,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_decode = nfs3svc_decode_fhandleargs,
 		.pc_encode = nfs3svc_encode_attrstatres,
 		.pc_release = nfs3svc_release_fhandle,
-		.pc_argsize = sizeof(struct nfsd3_fhandleargs),
+		.pc_argsize = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd3_attrstatres),
 		.pc_cachetype = RC_NOCACHE,
 		.pc_xdrressize = ST+AT,
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index a6718b952975..f1bff0547da9 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -29,8 +29,9 @@ static u32	nfs3_ftypes[] = {
 
 
 /*
- * XDR functions for basic NFS types
+ * Basic NFSv3 data types (RFC 1813 Sections 2.5 and 2.6)
  */
+
 static __be32 *
 encode_time3(__be32 *p, struct timespec64 *time)
 {
@@ -46,6 +47,26 @@ decode_time3(__be32 *p, struct timespec64 *time)
 	return p;
 }
 
+static enum xdr_decode_result
+svcxdr_decode_nfs_fh3(struct xdr_stream *xdr, struct svc_fh *fhp)
+{
+	__be32 *p;
+	u32 size;
+
+	if (xdr_stream_decode_u32(xdr, &size) < 0)
+		return XDR_DECODE_FAILED;
+	if (size == 0 || size > NFS3_FHSIZE)
+		return XDR_DECODE_FAILED;
+	p = xdr_inline_decode(xdr, size);
+	if (!p)
+		return XDR_DECODE_FAILED;
+	fh_init(fhp, NFS3_FHSIZE);
+	fhp->fh_handle.fh_size = size;
+	memcpy(&fhp->fh_handle.fh_base, p, size);
+
+	return XDR_DECODE_DONE;
+}
+
 static __be32 *
 decode_fh(__be32 *p, struct svc_fh *fhp)
 {
@@ -306,14 +327,12 @@ void fill_post_wcc(struct svc_fh *fhp)
  */
 
 int
-nfs3svc_decode_fhandle(struct svc_rqst *rqstp, __be32 *p)
+nfs3svc_decode_fhandleargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd_fhandle *args = rqstp->rq_argp;
 
-	p = decode_fh(p, &args->fh);
-	if (!p)
-		return 0;
-	return xdr_argsize_check(rqstp, p);
+	return svcxdr_decode_nfs_fh3(xdr, &args->fh);
 }
 
 int
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 456fcd7a1038..62ea669768cf 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -273,7 +273,7 @@ union nfsd3_xdrstore {
 
 #define NFS3_SVC_XDRSIZE		sizeof(union nfsd3_xdrstore)
 
-int nfs3svc_decode_fhandle(struct svc_rqst *, __be32 *);
+int nfs3svc_decode_fhandleargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_sattrargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_diropargs(struct svc_rqst *, __be32 *);
 int nfs3svc_decode_accessargs(struct svc_rqst *, __be32 *);


