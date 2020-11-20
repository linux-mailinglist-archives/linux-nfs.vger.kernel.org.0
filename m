Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563A92BB7BA
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgKTUnp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbgKTUnp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:43:45 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DA0C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:45 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z24so6111712qto.3
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nEMrv+oXcuXrri8aG4ydWd0UUuh0YoSurn9CYn3jvk8=;
        b=XUMQvxomGfzoQ0jDGXoNNxxNFFKt40N6ZhMKHFGVbnN9GsY30S+EryGUkPWWnk7lc6
         AS0MbjaIaBpcn1rUa1uMqJfINcW3/p3Bfd4Zv09aFwW1UfkADD/qTdfVaF50wdIQuxuN
         AgTM2YuqAlY4rA/S/2YZiXosal0YP8JHkPdHDVZcFobLDNuljXCoxLiVwV6rrxa2ed/P
         weoQ1cC4GQ7uykOe0uLnb6FJ8HmWrU2nGGB/5uuL2EzUcQ5g/pRQTu0SiBck7ycDTdTO
         9HBjWyIKEVNL1nrSdY/0WrYltkcKQ44I1jsWLtIa3H/EDrKlUqcutRwn1qlBHxtr71J8
         HjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=nEMrv+oXcuXrri8aG4ydWd0UUuh0YoSurn9CYn3jvk8=;
        b=P4Emx9Xt2WUg/rbADZiKOWjJ+lfK0XvC/penpgRfHqQ13uSC1jRCLlIq6tFWwcc0en
         ZyBSQRHEf6QDjO3ouSLD+nKF16CpXhRHyoA6ZTdFDm+7YhQHx2Virhq96w1Qp9auDcIA
         r1fvwSvVNGQI6q0E/lrHiswrYZcj9L6n/T/kbLhJ0hhwveC3u0anEaC+UxyVbRH6BP9s
         ELFEVorv7xwoA+IJlirT2UheU4dW4+/mS8W1dQMnSIGgfbi0cyhK/R1ZNE6OI+hxO25g
         nf43K4jSON8IAjSUr2HyPj3S9UDE9qXb5vxwxyjwdGDIWcxQe9vKgQpHHLgvWYrn/N8E
         9J+Q==
X-Gm-Message-State: AOAM532+Ul4VPBsFfbXKMpqD+Gjg0W9uaWc5LuGAzgngogE8SqxPaM7u
        Wi2+e+8hc9BUZs4cV6Vg8pRaoHeD0wU=
X-Google-Smtp-Source: ABdhPJwkFwBJrbrKMUZ4QNP8s8QW2VfzVZpSe6WOodBaGlREIl0NQPVqDeXFW1YuLpVKZoxiviA/4A==
X-Received: by 2002:aed:38c8:: with SMTP id k66mr17692879qte.385.1605905023890;
        Fri, 20 Nov 2020 12:43:43 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w138sm2756665qkb.130.2020.11.20.12.43.43
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:43:43 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKhghF029550
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:43:42 GMT
Subject: [PATCH v2 112/118] NFSD: Update the NFSv2 SETACL argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:43:42 -0500
Message-ID: <160590502218.1340.856421484434409408.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs2acl.c |   33 ++++++++++++++-------------------
 fs/nfsd/xdr3.h    |    2 +-
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 0e62c3b53a58..2e44b56e33ad 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -201,28 +201,23 @@ static int nfsaclsvc_decode_getaclargs(struct svc_rqst *rqstp, __be32 *p)
 
 static int nfsaclsvc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p)
 {
+	struct xdr_stream *xdr = &rqstp->rq_xdr_stream;
 	struct nfsd3_setaclargs *argp = rqstp->rq_argp;
-	struct kvec *head = rqstp->rq_arg.head;
-	unsigned int base;
-	int n;
 
-	p = nfs2svc_decode_fh(p, &argp->fh);
-	if (!p)
-		return 0;
-	argp->mask = ntohl(*p++);
-	if (argp->mask & ~NFS_ACL_MASK ||
-	    !xdr_argsize_check(rqstp, p))
-		return 0;
+	if (!svcxdr_decode_fhandle(xdr, &argp->fh))
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
 
-	base = (char *)p - (char *)head->iov_base;
-	n = nfsacl_decode(&rqstp->rq_arg, base, NULL,
-			  (argp->mask & NFS_ACL) ?
-			  &argp->acl_access : NULL);
-	if (n > 0)
-		n = nfsacl_decode(&rqstp->rq_arg, base + n, NULL,
-				  (argp->mask & NFS_DFACL) ?
-				  &argp->acl_default : NULL);
-	return (n > 0);
+	return XDR_DECODE_DONE;
 }
 
 static int nfsaclsvc_decode_fhandleargs(struct svc_rqst *rqstp, __be32 *p)
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 43db4206cd25..5afb3ce4f062 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -108,7 +108,7 @@ struct nfsd3_getaclargs {
 struct posix_acl;
 struct nfsd3_setaclargs {
 	struct svc_fh		fh;
-	int			mask;
+	__u32			mask;
 	struct posix_acl	*acl_access;
 	struct posix_acl	*acl_default;
 };


