Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86ED2EAE65
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbhAEPbt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbhAEPbt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:31:49 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEFFC061793
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:31:34 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id p14so26786612qke.6
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+qeCAeb1hdNWv49AZvNpZobfUYtECvNdrSN/jZ0uEdY=;
        b=dsv3JRvtHTJusKIOGhoo0+bUQj9PczYGUWeZEpF8CvR0umZkrw4spok6tW2EpBwXTJ
         7jOK+QFbBsE2hHGuwkGvaxxkzdS/Jxb4AzlqE1LE5chVDDaIIxecWd/yQoNnD21v1qDe
         Dan7SKYcSdUTdQNgmFK5GD8XwolbAogMgSXl2O7oupCo0dLOfLsgYIbmmlmK9BLH4FV/
         iYfMX7qPELqUs4lit2fOtO/4t2g6uq3fl4zX5Q6c65YWIwYghAZvIlHkM9qlIEg6+8pB
         FFxlEL1cqj/YVZgY+KmVWe2WYnuilN6gEJo5wjuqYrjT5LOLzu7qCwnSA3KRqIa3iVK6
         ErRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=+qeCAeb1hdNWv49AZvNpZobfUYtECvNdrSN/jZ0uEdY=;
        b=QrJJK+yFCGmXezlOMzShTIe3nRubggNcEWmR8e4h0zGpqOsXBdyEMEbEqqJpxjVqFn
         dGQRwG1hGWcRa5d4x0tVELAIQUiyvKb5Q63gNzaJkII0ltdi5GAgGzakbjn98GNsHPat
         NKHgQUjdxe9KYSXWhyD426oBLDZhU4AgpH59vDACpj06yJo+fUqDglXhO9YtZnwfL4CF
         4oU4g6ngPFL5sMSS2OVz3RhFAd0SVnfvsumIaqN00q77bheIzKDD8UDsJ07somxgq7ol
         WJD9M65Wacbo09nJ2BlCggLukevz4FK1OTacpwVo022IhNU26gfnCLE7tfo8MqFikTCe
         fTmA==
X-Gm-Message-State: AOAM532YD4dtY7hf1QadhXDsnarXv0uQECdyLDxZkc7QzhIboePSFw45
        r/szqHjKo7lmrneiM/D04Lc8RxbhfGE=
X-Google-Smtp-Source: ABdhPJy2jJ8SsELqb1EgrVzacZ+WXXiDcfuY7eh0RVTGwxYiDfxvZyBtYfb1W2IYBXbSfW6GCgI1Rw==
X-Received: by 2002:a37:a796:: with SMTP id q144mr95463qke.38.1609860693171;
        Tue, 05 Jan 2021 07:31:33 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 195sm132724qke.108.2021.01.05.07.31.32
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:31:32 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FVVaQ020883
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:31:31 GMT
Subject: [PATCH v1 21/42] NFSD: Update the NFSv2 GETATTR argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:31:31 -0500
Message-ID: <160986069154.5532.12958943826555170241.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfsproc.c |    4 ++--
 fs/nfsd/nfsxdr.c  |   26 ++++++++++++++++++++------
 fs/nfsd/xdr.h     |    2 +-
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 1f85a4dc9d1b..b9bc162a5c77 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -627,7 +627,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	},
 	[NFSPROC_GETATTR] = {
 		.pc_func = nfsd_proc_getattr,
-		.pc_decode = nfssvc_decode_fhandle,
+		.pc_decode = nfssvc_decode_fhandleargs,
 		.pc_encode = nfssvc_encode_attrstat,
 		.pc_release = nfssvc_release_attrstat,
 		.pc_argsize = sizeof(struct nfsd_fhandle),
@@ -793,7 +793,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 	},
 	[NFSPROC_STATFS] = {
 		.pc_func = nfsd_proc_statfs,
-		.pc_decode = nfssvc_decode_fhandle,
+		.pc_decode = nfssvc_decode_fhandleargs,
 		.pc_encode = nfssvc_encode_statfsres,
 		.pc_argsize = sizeof(struct nfsd_fhandle),
 		.pc_ressize = sizeof(struct nfsd_statfsres),
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 7aa6e8aca2c1..f3189e1be20f 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -23,8 +23,9 @@ static u32	nfs_ftypes[] = {
 
 
 /*
- * XDR functions for basic NFS types
+ * Basic NFSv2 data types (RFC 1094 Section 2.3)
  */
+
 static __be32 *
 decode_fh(__be32 *p, struct svc_fh *fhp)
 {
@@ -37,6 +38,21 @@ decode_fh(__be32 *p, struct svc_fh *fhp)
 	return p + (NFS_FHSIZE >> 2);
 }
 
+static bool
+svcxdr_decode_fhandle(struct xdr_stream *xdr, struct svc_fh *fhp)
+{
+	__be32 *p;
+
+	p = xdr_inline_decode(xdr, NFS_FHSIZE);
+	if (!p)
+		return false;
+	fh_init(fhp, NFS_FHSIZE);
+	memcpy(&fhp->fh_handle.fh_base, p, NFS_FHSIZE);
+	fhp->fh_handle.fh_size = NFS_FHSIZE;
+
+	return true;
+}
+
 /* Helper function for NFSv2 ACL code */
 __be32 *nfs2svc_decode_fh(__be32 *p, struct svc_fh *fhp)
 {
@@ -194,14 +210,12 @@ __be32 *nfs2svc_encode_fattr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *f
  */
 
 int
-nfssvc_decode_fhandle(struct svc_rqst *rqstp, __be32 *p)
+nfssvc_decode_fhandleargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_fhandle *args = rqstp->rq_argp;
 
-	p = decode_fh(p, &args->fh);
-	if (!p)
-		return 0;
-	return xdr_argsize_check(rqstp, p);
+	return svcxdr_decode_fhandle(xdr, &args->fh);
 }
 
 int
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index ad77387734cc..84256a6a1ba1 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -144,7 +144,7 @@ union nfsd_xdrstore {
 #define NFS2_SVC_XDRSIZE	sizeof(union nfsd_xdrstore)
 
 
-int nfssvc_decode_fhandle(struct svc_rqst *, __be32 *);
+int nfssvc_decode_fhandleargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_sattrargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_diropargs(struct svc_rqst *, __be32 *);
 int nfssvc_decode_readargs(struct svc_rqst *, __be32 *);


