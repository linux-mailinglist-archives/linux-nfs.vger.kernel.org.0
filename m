Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB892EAE89
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbhAEPdf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbhAEPdf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:33:35 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1D7C06179A
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:33:19 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id c7so26787483qke.1
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jGfOYjWuHpLahZsNYViQB8eHdJGH5wEjc/CCta9CnfY=;
        b=BilD+gQRTnjPxJuEbzmnzQ4wg6EaCTPNzWd9Y+/A9f4Rzs9WFBcy5tg2i3/T7L1ReL
         LFgOSuQAu0zmjAqQo+30dQxrOPrFwgXc9YeFNuNn76z8i6zpRT7/e851PxT1J8ajILTT
         b7fHNUpEI91WtwsmN4NOryBfIifJtO+O5ag1GNdjojunYo8WQq8+IPE3koWCrmRdbBBV
         MvXd80MJzm7t101ye4/YMzZ5bsIu6U9qlsQr8dXlmBzYN8xl2LCfWQ5aS3ZWLqQpXvYY
         fwMhe4CXkebZ+ROFLnEpVPGC9feC3LrM1B9c1UG69zhkIEaNpHgqHFwxBKYiB2eSLVY7
         XIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=jGfOYjWuHpLahZsNYViQB8eHdJGH5wEjc/CCta9CnfY=;
        b=UfKig4MpM+acq/yxoH9s7ObZK2zB0JRbiN0GIKGE/1hpwcNY3DhOXWKIYyv4YGwVp6
         TiTefS3aKSaTBAeIfhjpK5KREfCnW4NhJn4Gjysr2QyFqgW5AaJEd02ZNK4DowU9iJZZ
         VLwq74SjOTduJhk5HObc4fTy6N94SkGQO7JftQBvWe2sW7RcG6aRFAnVUWCKumuBttIC
         untMYO4pUee64mScOFd7sF7L2K2/6OanLDDxMzWmomGHojXIiz4HJcx/KFj6Pd3sAfF3
         2kCWJfchN38NCHcWFKdJJvk/vAjKWVO5Qf/FGaBxSF1WJhKUK0QfAGaghxCSN00wy11W
         Q67Q==
X-Gm-Message-State: AOAM532Rl25Cu2b9+lpxknQR6kVzYKpS/mhCZlYXco27c72n+g9BNDG/
        grOdCiWcjSwuASbBOM0Adpx4qQaGlOo=
X-Google-Smtp-Source: ABdhPJzrsB4JWc2ekNKzEDFXO51jnqgDzY186wqCKbhZ7bi630ux85KJTEkN/BzK4NAcFz5glgAjUQ==
X-Received: by 2002:a37:a50c:: with SMTP id o12mr99510qke.98.1609860798755;
        Tue, 05 Jan 2021 07:33:18 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a203sm172206qkb.31.2021.01.05.07.33.17
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:33:18 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FXHdQ020943
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:33:17 GMT
Subject: [PATCH v1 41/42] NFSD: Update the NFSv2 SETACL argument decoder to
 use struct xdr_stream
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:33:17 -0500
Message-ID: <160986079701.5532.7699961428525697515.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfs3acl.c |   31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index addb0d7d5500..a568b842e9eb 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -140,28 +140,23 @@ static int nfs3svc_decode_getaclargs(struct svc_rqst *rqstp, __be32 *p)
 
 static int nfs3svc_decode_setaclargs(struct svc_rqst *rqstp, __be32 *p)
 {
-	struct nfsd3_setaclargs *args = rqstp->rq_argp;
-	struct kvec *head = rqstp->rq_arg.head;
-	unsigned int base;
-	int n;
+	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
+	struct nfsd3_setaclargs *argp = rqstp->rq_argp;
 
-	p = nfs3svc_decode_fh(p, &args->fh);
-	if (!p)
+	if (!svcxdr_decode_nfs_fh3(xdr, &argp->fh))
+		return 0;
+	if (xdr_stream_decode_u32(xdr, &argp->mask) < 0)
 		return 0;
-	args->mask = ntohl(*p++);
-	if (args->mask & ~NFS_ACL_MASK ||
-	    !xdr_argsize_check(rqstp, p))
+	if (argp->mask & ~NFS_ACL_MASK)
+		return 0;
+	if (!nfs_stream_decode_acl(xdr, NULL, (argp->mask & NFS_ACL) ?
+				   &argp->acl_access : NULL))
+		return 0;
+	if (!nfs_stream_decode_acl(xdr, NULL, (argp->mask & NFS_DFACL) ?
+				   &argp->acl_default : NULL))
 		return 0;
 
-	base = (char *)p - (char *)head->iov_base;
-	n = nfsacl_decode(&rqstp->rq_arg, base, NULL,
-			  (args->mask & NFS_ACL) ?
-			  &args->acl_access : NULL);
-	if (n > 0)
-		n = nfsacl_decode(&rqstp->rq_arg, base + n, NULL,
-				  (args->mask & NFS_DFACL) ?
-				  &args->acl_default : NULL);
-	return (n > 0);
+	return 1;
 }
 
 /*


