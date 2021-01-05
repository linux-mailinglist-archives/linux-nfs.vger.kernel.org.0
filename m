Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E9C2EAE73
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbhAEPcW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbhAEPcV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:32:21 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1074CC061793
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:32:06 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 4so14824370qvh.1
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=53z1wSTIBTrnZn9EQSK0Z4+C/5arTycITmh8o8oOk4k=;
        b=AQhtisLiwZwwp+gBEIAWJ4VSX0itSGFPcyKowQWzNNIqBA2x6DMF6oYGI2QoUIUv9p
         zaX4/W+FMyHM/snRH/UZ4sAJsxSe53BoetHPNgAoEOvHP9GK6bYQPchWo4Zeb3aYB8BX
         veLAh9IcXwJImOSkCsHTGt38y0SILLj4x90qDMneZ0wCFLUUtXtNk1olClbQnwrnxJS2
         ltQiVsKTN2yYcy7aR+uYynDxlumDwafr5TJQbSYUWSHnRnd+3c5fncDIyuD0AWoTrrbD
         Nc5EuhE69IXMGoInhV7U8e6OvtSfBQnUvOIlQ/IPtvZAkiiDkU1vU8mXKqnwqUgDCpHY
         Mtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=53z1wSTIBTrnZn9EQSK0Z4+C/5arTycITmh8o8oOk4k=;
        b=bOLJW2MMLMtqA3fVVJqc6hUSXoo3YziEGY3sYBjoqKFUpppwXsOhEmvjsqxFrp3A9h
         iEFz/oBYZVf3KIAOEYC3Mv8t1MOjm9yqn+o4BPR7kgzz63+JGXFZNhz+IEGPHb4GudSE
         PNZmBO9qq2hahH0MkgzSww3tWycA1iimOcsKtyNlBYouDCWrG68WHhgcObsRZMsKMZjy
         oVNUT8qrB7NtiAbHfma2QgpyVHn8tvjMAdQx/t4bZVbzKtNdI9AdxrOqdfcHfQP3GMWI
         JEiM4rskE87oRqN471ocMHDrZlANXMsZMEjn6KsYvZpCKnTMMDzM1CpkO97ZgFUlxgYw
         6gqw==
X-Gm-Message-State: AOAM532gj8hQFWW/RNPSE6sAvsB8d9WLVIxmBKk2B9NvEtILkI/Q1YQw
        E7wp5WaPJmmrT9J/eZAJwE1cZB8ESj4=
X-Google-Smtp-Source: ABdhPJxzq6OiiYglwNuXoQarq3ScHc/SxFYhBj/qsIZTOkzVMB7ZvU2JmJgSvWZ9B+m53TJnBqSZQA==
X-Received: by 2002:a0c:fcc5:: with SMTP id i5mr82159734qvq.48.1609860724958;
        Tue, 05 Jan 2021 07:32:04 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c14sm23279qtg.85.2021.01.05.07.32.04
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:32:04 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FW3g0020901
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:32:03 GMT
Subject: [PATCH v1 27/42] NFSD: Update NFSv2 diropargs decoding to use struct
 xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:32:03 -0500
Message-ID: <160986072325.5532.3901165670133816464.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfsxdr.c |   39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 7b33093f8d8b..00a7db8548eb 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -86,6 +86,38 @@ decode_filename(__be32 *p, char **namp, unsigned int *lenp)
 	return p;
 }
 
+static bool
+svcxdr_decode_filename(struct xdr_stream *xdr, char **name, unsigned int *len)
+{
+	u32 size, i;
+	__be32 *p;
+	char *c;
+
+	if (xdr_stream_decode_u32(xdr, &size) < 0)
+		return false;
+	if (size == 0 || size > NFS_MAXNAMLEN)
+		return false;
+	p = xdr_inline_decode(xdr, size);
+	if (!p)
+		return false;
+
+	*len = size;
+	*name = (char *)p;
+	for (i = 0, c = *name; i < size; i++, c++)
+		if (*c == '\0' || *c == '/')
+			return false;
+
+	return true;
+}
+
+static bool
+svcxdr_decode_diropargs(struct xdr_stream *xdr, struct svc_fh *fhp,
+			char **name, unsigned int *len)
+{
+	return svcxdr_decode_fhandle(xdr, fhp) &&
+		svcxdr_decode_filename(xdr, name, len);
+}
+
 static __be32 *
 decode_sattr(__be32 *p, struct iattr *iap, struct user_namespace *userns)
 {
@@ -234,13 +266,10 @@ nfssvc_decode_sattrargs(struct svc_rqst *rqstp, __be32 *p)
 int
 nfssvc_decode_diropargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct nfsd_diropargs *args = rqstp->rq_argp;
 
-	if (!(p = decode_fh(p, &args->fh))
-	 || !(p = decode_filename(p, &args->name, &args->len)))
-		return 0;
-
-	return xdr_argsize_check(rqstp, p);
+	return svcxdr_decode_diropargs(xdr, &args->fh, &args->name, &args->len);
 }
 
 int


