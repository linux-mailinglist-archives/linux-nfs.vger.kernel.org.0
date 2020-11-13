Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3F22B1E0A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgKMPEW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgKMPEV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:04:21 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD9DC0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:21 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 7so6868318qtp.1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2z9peJ4779RtajGw6k2j0GHq4OPnvZpJp3+/Ydr2gDk=;
        b=IF+rIIjV/xX3g3SJp80VvSePEY9jZgyI/zU5ZBzQY2Lu0SBiVWpzALfdZz5vWt7DSi
         s3BAWERGS+iC+5hSrJXmQIvzpwxOwLIMPtMF0aImdsq2zWUR/mIHH2TkCmnITd1IsTRT
         xTYZ5NDklzLTY4xu0hdzpP9Kz+vUgiwQpmTg+bIc1SLC5XH00hsjXqRN3KccI+AA9yRf
         5g1igNhYcvb0OWmhRbqiNluzhBEdocmF/sGMr/I9DFtAuUpxiqq710wuivdmKn482yzY
         qttNAVrJoqRobIGlESmPKl2ol8ZHGgKftI2TgXdAyF6imedDCXqPAfOh/1YkDR7u4IKv
         Yvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=2z9peJ4779RtajGw6k2j0GHq4OPnvZpJp3+/Ydr2gDk=;
        b=OjQFr+V6fdbZurQB5YG/ieUU+61fkeJ0B1c/wiRaUBuib/qMgVB54xzSsOl+5o1okn
         dSyqe8hFfbfOsqVL14RgRJlAxBqAdIarh2BTim02GwbUmQVK/fqNwneWECFm0ayYHUPt
         nzziW3BMJTs/fvD49Qxbrw4waH2zc8afXq80dkRCgrJL7wKoL66PgDI58D5BgCxzdHw6
         wWXM6Q0z9+uNfUy8dxCeKnIANQBqpCKtLGCKH5rcpGt6ggHGIgzHFZ1qGxRO1qHaQ44Z
         NXhSK5Y0QF8TIJKnMZ5wWjG7oynv8bbVwuXLlYUQoDoWACW8LjFtdOasoEcMQ4Q+c9lO
         EPeA==
X-Gm-Message-State: AOAM533ZhHMDZ3Lf6MyCGD++HCnwClo/vJg/bdicJpaQHdfRxCPxFHTZ
        CIPQ50Z9CLr7v2J+j5qmwQhkOAEUiz8=
X-Google-Smtp-Source: ABdhPJzwzJ9iFLz3OopXZVKhHbbi0aFLVJwfD0csAojmPqRmjYEbNAUcnDVkJpOC5NK3OhPc2Z7cxA==
X-Received: by 2002:ac8:4f02:: with SMTP id b2mr2362542qte.284.1605279860425;
        Fri, 13 Nov 2020 07:04:20 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q20sm6928910qke.0.2020.11.13.07.04.19
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:04:19 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF4IRS032703
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:04:18 GMT
Subject: [PATCH v1 22/61] NFSD: Replace READ* macros in nfsd4_decode_putfh()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:04:18 -0500
Message-ID: <160527985881.6186.1569684664420097129.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c7e7854b5e19..c7f4040efd40 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1146,16 +1146,24 @@ nfsd4_decode_open_downgrade(struct nfsd4_compoundargs *argp, struct nfsd4_open_d
 static __be32
 nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, struct nfsd4_putfh *putfh)
 {
-	DECODE_HEAD;
+	__be32 *p;
 
-	READ_BUF(4);
-	putfh->pf_fhlen = be32_to_cpup(p++);
+	if (xdr_stream_decode_u32(argp->xdr, &putfh->pf_fhlen) < 0)
+		goto xdr_error;
 	if (putfh->pf_fhlen > NFS4_FHSIZE)
 		goto xdr_error;
-	READ_BUF(putfh->pf_fhlen);
-	SAVEMEM(putfh->pf_fhval, putfh->pf_fhlen);
-
-	DECODE_TAIL;
+	p = xdr_inline_decode(argp->xdr, putfh->pf_fhlen);
+	if (!p)
+		goto xdr_error;
+	putfh->pf_fhval = svcxdr_tmpalloc(argp, putfh->pf_fhlen);
+	if (!putfh->pf_fhval)
+		goto nomem;
+	memcpy(putfh->pf_fhval, p, putfh->pf_fhlen);
+	return nfs_ok;
+xdr_error:
+	return nfserr_bad_xdr;
+nomem:
+	return nfserr_jukebox;
 }
 
 static __be32


