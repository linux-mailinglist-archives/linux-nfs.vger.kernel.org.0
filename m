Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BD32EAE91
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbhAEPdz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbhAEPdy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:33:54 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B613C061798
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:33:14 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id u21so21035064qtw.11
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WO97NFUa0HrLEcjhuOBR1FhOyRH1V+18yT7ZttUzK1Q=;
        b=vQ1xOGaF12zsG/lf9qwwsr/bYnZ49ROeNAaiPjokXztLLy9MVsjxrKIVtNzVgAmsAX
         Y+7mSuZuDC+19WhLe+BsQ6Qji0lzODKuyRyySZDZCEqd5V0HTUd7ppn5UAshkwRH65Bf
         lP2HwvtcK2N5g+SJeSqhIxq2OLN4Wb2WIrisorEVZ+c+545yunbpmwerbwzpT9cQ6Kt6
         RmFzSOR2wisncFeZ+4OeRKOf5l26fltOzwjDl1wGWulGd9VM1PTW6iqln8X7Z9/s+z40
         Rz2gI3t6Q8ebT7+2APOmZCEGHKXFqImiI/MrVpntt/fRLpzLrmchs4ppVNE/Nzuj5Fv9
         zpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=WO97NFUa0HrLEcjhuOBR1FhOyRH1V+18yT7ZttUzK1Q=;
        b=UeUsEMjodI61V6aD1M6KNK8u/VnfcNVoHUzeBIPYMETwxkwlUpO0nbGBxJ/GQSy4kx
         lSzjxUIX9UExp9mAEdLPzdTsj/7plG8GTlxUnT8w3uzI1Q4hDFqPEINEjZJWzQa7sfpH
         /UAzaozYla04YctaKHOS+OYcCRu22a0fw8bNsfKE9+UhNojqb0QrMDBXZwOsdrMG2RFe
         ToJ99OZCBwcVMcxfUz4+D3xcGoNmgv5lI3WXF4FEc3A/POHUpVbXeE4JYutMRophRApw
         emP1FLT3rDJFNwTIEwLmrXu502jdLS9mu55WiHQtDfmEctHulCMrU7JetJEMbRahOIr/
         i6Kw==
X-Gm-Message-State: AOAM530ILDzdYqFXvmcLkB+uzKZWTrL/eXAN0OKDru9sCqIMfCb+A8pV
        nA6LCVBaJOQInUH7lFz6iEgx2MCawec=
X-Google-Smtp-Source: ABdhPJwus3JWFanImEw3ArqXht0GoelY7bcZRZxh1BnRMdAi2CNg2jdt2NANgIJtfycMkWSE5mO36Q==
X-Received: by 2002:a05:622a:14e:: with SMTP id v14mr63030qtw.298.1609860793368;
        Tue, 05 Jan 2021 07:33:13 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q20sm156054qkj.49.2021.01.05.07.33.12
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:33:12 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FXBG9020940
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:33:11 GMT
Subject: [PATCH v1 40/42] NFSD: Update the NFSv3 GETACL argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:33:11 -0500
Message-ID: <160986079166.5532.16277092571503242339.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3acl.c |   11 ++++++-----
 fs/nfsd/nfs3xdr.c |   11 ++++++++++-
 fs/nfsd/xdr3.h    |    1 +
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 9e1a92fb9771..addb0d7d5500 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -124,19 +124,20 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 /*
  * XDR decode functions
  */
+
 static int nfs3svc_decode_getaclargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd3_getaclargs *args = rqstp->rq_argp;
 
-	p = nfs3svc_decode_fh(p, &args->fh);
-	if (!p)
+	if (!svcxdr_decode_nfs_fh3(xdr, &args->fh))
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &args->mask) < 0)
 		return 0;
-	args->mask = ntohl(*p); p++;
 
-	return xdr_argsize_check(rqstp, p);
+	return 1;
 }
 
-
 static int nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_setaclargs *args = rqstp->rq_argp;
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 5fb7e8a599c4..4be38599f331 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -53,7 +53,16 @@ svcxdr_decode_nfstime3(struct xdr_stream *xdr, struct timespec64 *timep)
 	return true;
 }
 
-static bool
+/**
+ * svcxdr_decode_nfs_fh3 - Decode an NFSv3 file handle
+ * @xdr: XDR stream positioned at an undecoded NFSv3 FH
+ * @fhp: OUT: filled-in server file handle
+ *
+ * Return values:
+ *  %false: The encoded file handle was not valid
+ *  %true: @fhp has been initialized
+ */
+bool
 svcxdr_decode_nfs_fh3(struct xdr_stream *xdr, struct svc_fh *fhp)
 {
 	__be32 *p;
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 5afb3ce4f062..7456aee74f3d 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -308,6 +308,7 @@ int nfs3svc_encode_entry_plus(void *, const char *name,
 __be32 *nfs3svc_encode_post_op_attr(struct svc_rqst *rqstp, __be32 *p,
 				struct svc_fh *fhp);
 __be32 *nfs3svc_decode_fh(__be32 *p, struct svc_fh *fhp);
+bool svcxdr_decode_nfs_fh3(struct xdr_stream *xdr, struct svc_fh *fhp);
 
 
 #endif /* _LINUX_NFSD_XDR3_H */


