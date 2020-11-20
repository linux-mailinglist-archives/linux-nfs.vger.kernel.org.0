Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F80D2BB7BE
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgKTUoH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbgKTUoG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:44:06 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F2DC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:44:06 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id q5so10185890qkc.12
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=grxY7Jj7+Ffevdb8Y3aosIAD15GaaTPSTIXrVtrjCQw=;
        b=Q+R3os7TmDwpzJflm/1Y+MCkQw4p+lMmF7k1JhyQfYt38lrwCB1k4vumZQ6R2DaYRJ
         WHiDpArsZsUF/aKOh66LL8cUwk93GAG8/pSNfe7HKMvCKpuJ6G1ESDt4KPLDdyvP9joW
         VOa+gbr32iMQlCF2sTM7cU0O1uOr+iNefgj5s3KnndPH7K+ewpHXqSNdBttV6EW8I9EC
         dRBbz8iqj1NGfvWIcGKXNYPCiBh0ZZivg2doa1dfxFIDbCruv+6SoQsmDxoFMTWdqFz0
         HRiZ72X0jqmpfkUkt50cNHObilXoc2/igIL0nsR4JR8vPxaYAB9Xg/MM2LjftwkqM4y4
         V0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=grxY7Jj7+Ffevdb8Y3aosIAD15GaaTPSTIXrVtrjCQw=;
        b=JeneBzsD4xjEIMtVx9PcoMrFautPLjl4vUEohn8q042REKcUFVuOsrU9T9EkQKyAJE
         MU2DkZ0ftmlBdcgBhv6Ug2h0tlC7xTbRFePMCSGq8s5gqk1wFRV8LiWqxHaDgDaUtYQy
         OGOO5VfUN/0Iw1VH/YDEkeS9Ayho0n6O1Hfjq4Rz7MADaFT6Tua/R2y9Htt3onDTkuIG
         hW7k6TDze0EAna98i8ClZKd7uffXzn8G36fKMMeqwy71XTSh97Lfo81+h5jxLpoM45aj
         8ljazTi+XeqEGL4e3GVMxspNxkQcJSVvMpf+9+7Zek1ceo11YEhayYE/5wMsnyWclKGi
         njgw==
X-Gm-Message-State: AOAM533Lp3LPWpIIIK63HuqmcEK50YhB4ouTc2vgsBMDAfHuw9P66x7E
        U/AcOnuWnBNDm9G1zNIet75gk/15uWY=
X-Google-Smtp-Source: ABdhPJx3mBRbF8LsZZItEMK2ylHlRXlXE8uGX4kO3h2xuZUvTGRxCMYw59xYm3+gkyHbDCBeUrhnzw==
X-Received: by 2002:a05:620a:11ad:: with SMTP id c13mr18483050qkk.399.1605905045658;
        Fri, 20 Nov 2020 12:44:05 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e10sm2753559qkn.126.2020.11.20.12.44.04
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:44:05 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKi4LN029562
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:44:04 GMT
Subject: [PATCH v2 116/118] NFSD: Update the NFSv3 GETACL argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:44:04 -0500
Message-ID: <160590504385.1340.15145791563296531133.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3acl.c |   13 +++++++------
 fs/nfsd/nfs3xdr.c |   11 ++++++++++-
 fs/nfsd/xdr3.h    |    2 ++
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 7c30876a31a1..b8c452b951dc 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -124,19 +124,20 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 /*
  * XDR decode functions
  */
+
 static int nfs3svc_decode_getaclargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd3_getaclargs *args = rqstp->rq_argp;
 
-	p = nfs3svc_decode_fh(p, &args->fh);
-	if (!p)
-		return 0;
-	args->mask = ntohl(*p); p++;
+	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
+		return XDR_DECODE_FAILED;
+	if (xdr_stream_decode_u32(xdr, &args->mask) < 0)
+		return XDR_DECODE_FAILED;
 
-	return xdr_argsize_check(rqstp, p);
+	return XDR_DECODE_DONE;
 }
 
-
 static int nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_setaclargs *args = rqstp->rq_argp;
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index df593dd9924b..091baf06c494 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -53,7 +53,16 @@ svcxdr_decode_nfstime3(struct xdr_stream *xdr, struct timespec64 *timep)
 	return XDR_DECODE_DONE;
 }
 
-static enum xdr_decode_result
+/**
+ * svcxdr_decode_nfs_fh3 - Decode an NFSv3 file handle
+ * @xdr: XDR stream positioned at an undecoded NFSv3 FH
+ * @fhp: OUT: filled-in server file handle
+ *
+ * Return values:
+ *  %XDR_DECODE_FAILED: The encoded file handle was not valid
+ *  %XDR_DECODE_DONE: Success
+ */
+enum xdr_decode_result
 svcxdr_decode_nfs_fh3(struct xdr_stream *xdr, struct svc_fh *fhp)
 {
 	__be32 *p;
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 5afb3ce4f062..1fd5328d867a 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -308,6 +308,8 @@ int nfs3svc_encode_entry_plus(void *, const char *name,
 __be32 *nfs3svc_encode_post_op_attr(struct svc_rqst *rqstp, __be32 *p,
 				struct svc_fh *fhp);
 __be32 *nfs3svc_decode_fh(__be32 *p, struct svc_fh *fhp);
+enum xdr_decode_result
+svcxdr_decode_nfs_fh3(struct xdr_stream *xdr, struct svc_fh *fhp);
 
 
 #endif /* _LINUX_NFSD_XDR3_H */


