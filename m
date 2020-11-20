Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5535D2BB7A0
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgKTUm5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgKTUm5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:42:57 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A29C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:57 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id a13so10251372qkl.4
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=f30Xo7DK/c+DEe+I+sHL9V3M2tixuG43UPm6leFj/LY=;
        b=D9hm5N0VLfcHWXyxn+GK7dCvu3TJVPqpfFix2A0sMTm1HmpsbJrN4FrSMsGI87rdap
         u59kP3PDu2dz5BsTo3s4YCstwky6swBRkT6Avc5I3IxXstwKnLFfKDwMMVfmv5wHIWjZ
         UeVvCSYneclwxXepb8DkJVmUq0wI2GotHTDSrrRVdunVT6K4h7gioV4Gc3LKgVYR0cuG
         25oAv1oAbA1CxccUV8e/97apkMD+9h1dN39hr+euxpHBJ1eoVPL6JpeEDORStfTNJ/mn
         INouVd7+O16rRZSERDa77QyGXXobmAcsL63fkdaFaLRwMxoP38CBKVNMGC1dXTWzZUc3
         ITOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=f30Xo7DK/c+DEe+I+sHL9V3M2tixuG43UPm6leFj/LY=;
        b=eZCZd1eRwjx166Y8bCYoOP5GF8Emllnp4gDFIZ0kTdDCKz+qi7ndNBngiZOOdf/wVw
         l/E49q/7yjUWgjJYN7RAEmdyf6VEjl6Pl072ed+neBEmP9RoIwG5n+RFl0hshi3HmlaW
         SZrie56MjAkMFMzGMZL3skRGrU4w9o5/xFzr53TgLD3j8FnQ9oHTbXJarHB6Oc6eaDVG
         YTWvANAVUyS+XpU5LDZ7f6dFLf4cMl60ORZAL3Ekn0af2jvTkl4ooB7M7fryjRMAiOH5
         ZHDrFJbSPKThHe6Y8loa0P/V4tWVsv8qgxKgm9K5ZjkV0hwEYiyKEwmsv3UaP+wWBqLX
         UgMg==
X-Gm-Message-State: AOAM531GVBWpHmLAe5rq+MmH8EuFvlREf18M6juNCZX8O41A/gQuS/Jq
        FVITtwvSRPoTD32iIDuqOCwztH+DY3Q=
X-Google-Smtp-Source: ABdhPJyCTYBzbrQxzBdLHJYCdDQ9+QGVDoy+Syf9ci6mKg5wKXE0mwat4odoXUcaIWTnvHv33kSvuA==
X-Received: by 2002:a37:9ecc:: with SMTP id h195mr18784156qke.103.1605904976214;
        Fri, 20 Nov 2020 12:42:56 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id l28sm2642943qkl.7.2020.11.20.12.42.55
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:42:55 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKgsZY029523
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:42:54 GMT
Subject: [PATCH v2 103/118] NFSD: Update NFSv2 diropargs decoding to use
 struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:42:54 -0500
Message-ID: <160590497442.1340.1904406098812168977.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfsxdr.c |   40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 6f4115303f58..9986b4ea78f4 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -86,6 +86,39 @@ decode_filename(__be32 *p, char **namp, unsigned int *lenp)
 	return p;
 }
 
+static enum xdr_decode_result
+svcxdr_decode_filename(struct xdr_stream *xdr, char **name, unsigned int *len)
+{
+	u32 size, i;
+	__be32 *p;
+	char *c;
+
+	if (xdr_stream_decode_u32(xdr, &size) < 0)
+		return XDR_DECODE_FAILED;
+	if (size == 0 || size > NFS_MAXNAMLEN)
+		return XDR_DECODE_FAILED;
+	p = xdr_inline_decode(xdr, size);
+	if (!p)
+		return XDR_DECODE_FAILED;
+
+	*len = size;
+	*name = (char *)p;
+	for (i = 0, c = *name; i < size; i++, c++)
+		if (*c == '\0' || *c == '/')
+			return XDR_DECODE_FAILED;
+
+	return XDR_DECODE_DONE;
+}
+
+static enum xdr_decode_result
+svcxdr_decode_diropargs(struct xdr_stream *xdr, struct svc_fh *fhp,
+			char **name, unsigned int *len)
+{
+	if (!svcxdr_decode_fhandle(xdr, fhp))
+		return XDR_DECODE_FAILED;
+	return svcxdr_decode_filename(xdr, name, len);
+}
+
 static __be32 *
 decode_sattr(__be32 *p, struct iattr *iap, struct user_namespace *userns)
 {
@@ -234,13 +267,10 @@ nfssvc_decode_sattrargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_diropargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd_diropargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->fh))
-	 || !(p = decode_filename(p, &args->name, &args->len)))
-		return 0;
-
-	return xdr_argsize_check(rqstp, p);
+	return svcxdr_decode_diropargs(xdr, &args->fh, &args->name, &args->len);
 }
 
 int


