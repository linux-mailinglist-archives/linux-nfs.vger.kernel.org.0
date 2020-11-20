Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4482BB7B8
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgKTUne (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbgKTUne (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:43:34 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2017CC0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:34 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id k4so10184407qko.13
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=DryE8JqL2omDj0I6iyrs9atF/pf66DBI88wfAvtzJl8=;
        b=KddNm1LgPVWMLYAkrQav2kUTkO5b4w12Ac3z1PfSALYWtY7EEOV6kAQcPhMSxO1WW8
         ZtuZAmbfM/uBFwhNl7sjVMlSvbW2bv38ze9GZQPfQS1B092rLkAgfgLtnfEFkKkOrtEU
         UEMvmZ7ip1J0fE/38S2hEuL30tJdqAVAJPtE3PZlQr9lIkIrBNcO6tjF3JrSyDaH5TJ5
         O//qvzGfhIAtWIUALyhvgbQMaoA9EqzjrZFqqN6Zw5LzG4LMrtV2L2TzV1BT8Ta+OW7k
         cjrzSUvR+UPKwIVybsBbWrPh4yEkSGmTk5xVy3kw6fqvgw4y9sYaEt6Fw+Y05shFQqYO
         +kOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=DryE8JqL2omDj0I6iyrs9atF/pf66DBI88wfAvtzJl8=;
        b=YyFXDbRH/jggxY+Z0DmC/JqzgNP67CfJsMSxTyMiWBfJsHxNuky9j20IQwZRJ6AR+h
         VuHVXTtCps6W+d8E0hGlvdj0H2lk4WZraebzO2Q/JoZZB+XnKhGhYUcekxAXmbx64nwh
         X24nT01fz5j0d1GaJKthbg2HKhL/iJtUVdLTTV77ZwziHWsQZUi80dyQz6m636w/sq33
         b5IPCGRds4pVAAj+5YGl+abP+l6IVG/gxeibm/LDbnSAppyQSJ7yfblvnVo4gfJCPGig
         t6OdlQPM2NIu3Vk0RRekE+7fyC34QyxbqVJuSnaPtpOY7W3ZcSsyY6l+DwMj0Lt5B87r
         wHjg==
X-Gm-Message-State: AOAM532D6rNgL/Qt3KaCDHyYrETyRkttXSufEfyCOO/2QKRwtJO4nb7s
        6h1FGmX+n2AVhIY53G/cZ/0imfoKGyc=
X-Google-Smtp-Source: ABdhPJx/cVupKUwnoNDMT076ZSvWmPHp7McZ7iYx21Q+m763zNN5bbIED/xSCiYke2GKaBrZadcbXg==
X-Received: by 2002:a37:78c:: with SMTP id 134mr18948371qkh.359.1605905013058;
        Fri, 20 Nov 2020 12:43:33 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id r190sm2623539qkf.101.2020.11.20.12.43.32
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:43:32 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKhVba029544
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:43:31 GMT
Subject: [PATCH v2 110/118] NFSD: Update the NFSv2 GETACL argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:43:31 -0500
Message-ID: <160590501137.1340.10261024050275031553.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs2acl.c |   12 ++++++------
 fs/nfsd/nfsxdr.c  |   11 ++++++++++-
 fs/nfsd/xdr.h     |    2 ++
 fs/nfsd/xdr3.h    |    2 +-
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index b0f66604532a..0e62c3b53a58 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -188,17 +188,17 @@ static __be32 nfsacld_proc_access(struct svc_rqst *rqstp)
 
 static int nfsaclsvc_decode_getaclargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd3_getaclargs *argp = rqstp->rq_argp;
 
-	p = nfs2svc_decode_fh(p, &argp->fh);
-	if (!p)
-		return 0;
-	argp->mask = ntohl(*p); p++;
+	if (!svcxdr_decode_fhandle(xdr, &argp->fh))
+		return XDR_DECODE_FAILED;
+	if (xdr_stream_decode_u32(xdr, &argp->mask) < 0)
+		return XDR_DECODE_FAILED;
 
-	return xdr_argsize_check(rqstp, p);
+	return XDR_DECODE_DONE;
 }
 
-
 static int nfsaclsvc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd3_setaclargs *argp = rqstp->rq_argp;
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 92e9143842d3..efa2760316eb 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -38,7 +38,16 @@ decode_fh(__be32 *p, struct svc_fh *fhp)
 	return p + (NFS_FHSIZE >> 2);
 }
 
-static enum xdr_decode_result
+/**
+ * svcxdr_decode_fhandle - Decode an NFSv2 file handle
+ * @xdr: XDR stream positioned at an encoded NFSv2 FH
+ * @fhp: OUT: filled-in server file handle
+ *
+ * Return values:
+ *  %XDR_DECODE_FAILED: The encoded file handle was not valid
+ *  %XDR_DECODE_DONE: Success
+ */
+enum xdr_decode_result
 svcxdr_decode_fhandle(struct xdr_stream *xdr, struct svc_fh *fhp)
 {
 	__be32 *p;
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index d700838f6512..6d3fb133f366 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -165,5 +165,7 @@ void nfssvc_release_readres(struct svc_rqst *rqstp);
 /* Helper functions for NFSv2 ACL code */
 __be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp, struct kstat *stat);
 __be32 *nfs2svc_decode_fh(__be32 *p, struct svc_fh *fhp);
+enum xdr_decode_result
+svcxdr_decode_fhandle(struct xdr_stream *xdr, struct svc_fh *fhp);
 
 #endif /* LINUX_NFSD_H */
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 64af5b01c5d7..43db4206cd25 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -102,7 +102,7 @@ struct nfsd3_commitargs {
 
 struct nfsd3_getaclargs {
 	struct svc_fh		fh;
-	int			mask;
+	__u32			mask;
 };
 
 struct posix_acl;


