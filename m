Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99122B1DFC
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgKMPDa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgKMPD3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:03:29 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD02C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:29 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id r7so9038177qkf.3
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=htbRPpqNGWgLCgocdrmBD/ExvwxMXPfld3y9lISCIGU=;
        b=sH3VF6xnsI4YWuDXVanfS4sm781njH17DwHMI7VaTjLXmR3PFxiY6RIiJhYrF+s5Jx
         v2KgWZkDnDM+DJu+2dYNci7ZIUlMEgNPshg/h7rSDWqE7R6jjnmykGghxm1wqr2LNAk1
         ZAN407IIKwi51V7Gf3dBOCa4NpaxdAjGAw6ydc9N996RFBprp7uu9md+l8yfG1CjtE1r
         a3ieWGrbczx7Tk6V6cmiE7tgIiSWKxzlVWByK3JXqBDjePdpUyI1Ut9OgKXITi9m7bmA
         RzfLQthnkRNnH2HPvjg64x9ZA4iE50a1Zf3TYoHiQW+awt65IZ9WGioFd1IT9pBu5CUb
         LaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=htbRPpqNGWgLCgocdrmBD/ExvwxMXPfld3y9lISCIGU=;
        b=qzFUl0N4dWw4DLh7643U6z48TsX6cmUGUgIN2V4pCj9XSqePg8Vjea4LXabIlB7yPs
         pQlyI+r1Kou0IazKM5kKn1TBfG+/i+I1+9vGfAwicQ67lYYzgG358QGhy3RnSqt+F/yR
         mMjygM6L6wFCRCqSVnjQW0Rt9fO62Wl8CgkHd4jtMXU+VNUJFsXq3Ouw7Cld46bBk90e
         4c5UT9h+pvAPseV57DmXvfpehh/4oOxosWq1LLoLLxprqizkKIgEYEdss9taP+NLZf+A
         GlEbjvDIrJ7s9JOede3b+Ft+WLxpuzThknvcKZ12/2VkxS7A6moRvCwVRftkq1V4r4fo
         8/OA==
X-Gm-Message-State: AOAM532KxoGQ4iou3S/i9GyxXYXA0ZkOCr5zhisKdkcBs/7yn6t6z8Vf
        qsNVLSS55ZrtIO7QLtREgjHRTcIarwE=
X-Google-Smtp-Source: ABdhPJzabFdJgr9nxPnF1fitnHUHSI/5RkQF+op+FJpSH5dIMZY8emvd2jVrYxjybmokyuVVpCek2w==
X-Received: by 2002:a37:96c6:: with SMTP id y189mr2358591qkd.87.1605279808255;
        Fri, 13 Nov 2020 07:03:28 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d66sm5973715qke.132.2020.11.13.07.03.27
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:03:27 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF3QPp032673
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:03:26 GMT
Subject: [PATCH v1 12/61] NFSD: Relocate nfsd4_decode_opaque()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:03:26 -0500
Message-ID: <160527980659.6186.2801085824570006023.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Enable nfsd4_decode_opaque() to be used in more decoders, and
replace the READ* macros in nfsd4_decode_opaque().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 970c647f8df6..c621a38e7874 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -205,6 +205,36 @@ static char *savemem(struct nfsd4_compoundargs *argp, __be32 *p, int nbytes)
 	return ret;
 }
 
+
+/*
+ * NFSv4 basic data type decoders
+ */
+
+static __be32 nfsd4_decode_opaque(struct nfsd4_compoundargs *argp, struct xdr_netobj *o)
+{
+	__be32 *p;
+	u32 len;
+
+	if (xdr_stream_decode_u32(argp->xdr, &len) < 0)
+		goto xdr_error;
+	if (len == 0 || len > NFS4_OPAQUE_LIMIT)
+		return nfserr_bad_xdr;
+	p = xdr_inline_decode(argp->xdr, len);
+	if (!p)
+		goto xdr_error;
+	o->data = svcxdr_tmpalloc(argp, len);
+	if (!o->data)
+		goto nomem;
+	o->len = len;
+	memcpy(o->data, p, len);
+
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
+nomem:
+	return nfserr_jukebox;
+}
+
 static __be32 nfsd4_decode_component4(struct nfsd4_compoundargs *argp,
 				      char **namp, u32 *lenp)
 {
@@ -837,22 +867,6 @@ static __be32 nfsd4_decode_share_deny(struct nfsd4_compoundargs *argp, u32 *x)
 	return nfserr_bad_xdr;
 }
 
-static __be32 nfsd4_decode_opaque(struct nfsd4_compoundargs *argp, struct xdr_netobj *o)
-{
-	DECODE_HEAD;
-
-	READ_BUF(4);
-	o->len = be32_to_cpup(p++);
-
-	if (o->len == 0 || o->len > NFS4_OPAQUE_LIMIT)
-		return nfserr_bad_xdr;
-
-	READ_BUF(o->len);
-	SAVEMEM(o->data, o->len);
-
-	DECODE_TAIL;
-}
-
 static __be32
 nfsd4_decode_open(struct nfsd4_compoundargs *argp, struct nfsd4_open *open)
 {


