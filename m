Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A142BB7BF
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgKTUoM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbgKTUoM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:44:12 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CE1C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:44:12 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id g17so8140226qts.5
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JQPRAYqZFcmavsWwgSJ6lsvvG8qs4+k2c2SGzdHxflk=;
        b=ZWrb2vnPIgb0tpiUpemrmFn22/arNlx7ip0JzCyrmNsDl9Qgg97Zvabts7LrvoPtgU
         EfnaKfZZ3k0zHau5KXB3op+AphWEYrLgG5Uhohn8AGHaH9fDZaVRopjj93GAv86IOcOG
         5Fa1qhB9Or59pEoPzejY+diTGtcuSqQGSiUW48eHXj9g7RnByYM17OZWbx4L6S/boS+C
         p1bIVqoD1rUOVfiL1S9X1mOQwCHr+/zHfaNfuJT/4VLx9BUfSq43F6ylCrHJCfPjXHwh
         AdRi5VYPoZNnj53qTg4HyyRZTxN0kNK8vYJY/jxwYMRpNBngLoi/9OA2JcE5TCXZFLn7
         rgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JQPRAYqZFcmavsWwgSJ6lsvvG8qs4+k2c2SGzdHxflk=;
        b=ToOxLB4/lBcFjGZ3SWUA70x1SolOwFaggmJ1a74KrZMV+6u7PCe1hednRWawCvg6sd
         fY8+L7s9ny2bVuFMB/gFLGFp0NhvBBZSXxN6WW0Emrdik9QX/c5bEkGQNljC/345AaMB
         t6evDFkw9/bpPkrcHRUUy83gxbFiteFHxUwFqoYb25CIcSu41sYOKjFXdMELOb6Upj1b
         TU/WtszKHmft+i3ex6iThfIItjFxmHaYVqSkOutP8YKMvuFnZU+6oQikundbaYdajVA9
         25jACXtde/9q0mCA40MFvPD67fkaka5eZM1dAfmuSB8JrscMPgl9+x2k3EnMxWXOd/gY
         GLiQ==
X-Gm-Message-State: AOAM5328NAxiCBmVyqJRxIQDnjwQO1PVOSApqEPWH4MoQaeGxWD/SCo7
        wcM9Ei98kCooiIJOw7tbzH6ujBOydPk=
X-Google-Smtp-Source: ABdhPJyx25XcN7YlS9AgBxgzanbEYXKlIsiU4uGUNpBh8oLdpTZsrCDbe9jXMkoRFa2CIC8Dm/Zs9g==
X-Received: by 2002:ac8:6b92:: with SMTP id z18mr17494411qts.30.1605905051156;
        Fri, 20 Nov 2020 12:44:11 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k1sm2954423qtc.24.2020.11.20.12.44.10
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:44:10 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKi9sL029566
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:44:09 GMT
Subject: [PATCH v2 117/118] NFSD: Update the NFSv2 SETACL argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:44:09 -0500
Message-ID: <160590504937.1340.17157925079005318852.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3acl.c |   39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index b8c452b951dc..8deb0d22e62a 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -140,28 +140,23 @@ static int nfs3svc_decode_getaclargs(struct svc_rqst *rqstp, __be32 *p)
 
 static int nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p)
 {
-	struct nfsd3_setaclargs *args = rqstp->rq_argp;
-	struct kvec *head = rqstp->rq_arg.head;
-	unsigned int base;
-	int n;
-
-	p = nfs3svc_decode_fh(p, &args->fh);
-	if (!p)
-		return 0;
-	args->mask = ntohl(*p++);
-	if (args->mask & ~NFS_ACL_MASK ||
-	    !xdr_argsize_check(rqstp, p))
-		return 0;
-
-	base = (char *)p - (char *)head->iov_base;
-	n = nfsacl_decode(&rqstp->rq_arg, base, NULL,
-			  (args->mask & NFS_ACL) ?
-			  &args->acl_access : NULL);
-	if (n > 0)
-		n = nfsacl_decode(&rqstp->rq_arg, base + n, NULL,
-				  (args->mask & NFS_DFACL) ?
-				  &args->acl_default : NULL);
-	return (n > 0);
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
+	struct nfsd3_setaclargs *argp = rqstp->rq_argp;
+
+	if (!svcxdr_decode_nfs_fh3(xdr, &argp->fh))
+		return XDR_DECODE_FAILED;
+	if (xdr_stream_decode_u32(xdr, &argp->mask) < 0)
+		return XDR_DECODE_FAILED;
+	if (argp->mask & ~NFS_ACL_MASK)
+		return XDR_DECODE_FAILED;
+	if (!nfs_stream_decode_acl(xdr, NULL, (argp->mask & NFS_ACL) ?
+				   &argp->acl_access : NULL))
+		return XDR_DECODE_FAILED;
+	if (!nfs_stream_decode_acl(xdr, NULL, (argp->mask & NFS_DFACL) ?
+				   &argp->acl_default : NULL))
+		return XDR_DECODE_FAILED;
+
+	return XDR_DECODE_DONE;
 }
 
 /*


