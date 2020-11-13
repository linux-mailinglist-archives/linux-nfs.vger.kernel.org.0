Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2987E2B1DEF
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgKMPCc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMPCc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:02:32 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63D5C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:02:31 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id d9so9003496qke.8
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lI50/gELjS2rXymyXdCFIVVfAWwxhe722H5bkJzcpsk=;
        b=ckyoV4VNkU62soH+O/IjwEyqnBMUDQZF0QYg/uoWQAfj/pxCPaZlkQ+zINfCPMwQRW
         37QEj3vD8ZUguvArRkMwJTnRE7sTSIjSOtOlRBHe31XZLwBF8FDXEEq/pA8m9P2jyt3V
         e33ZU3I7/haPbu2lZ7K5VVJHCwBZUP5ATckJFo4q8as3Id+UCsFMu0Q+KFR23Wr7a/5H
         AIEWnCf/7uul5dn5fl1Wk8RFmUVF/61Cm6ao1JOIyO4BU49S2ZWUdn1WNP5LRg8sfh4w
         4YtSnuivgb/P6vJzor3A8HXGU6jGAYb+cIDuYCp3D6hs9xPk9GQJfGwnuNbUPF0e3AA9
         PTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=lI50/gELjS2rXymyXdCFIVVfAWwxhe722H5bkJzcpsk=;
        b=YPT9naEwLyib962PHM0iHuRf3Zxz8toRZQYCZCTgdURqAHSyebb62eRoywOV1os3OH
         1BOVglFL+LuqBZjgMgpRN7L60bWr6fdnnp77sO3ckyjKvVKBzGfWOnXxCSMj5OpJvsvc
         SvVBAzNicKrLXzwi+tpI3QBFmamGplnWohHFrGvidvWLRrekQqVpd7oREy2sD7eaBL06
         77rox2OOjJsPbCmYIqkDNy1X9pBTmV28SJIrWeSSvbWAlxQIyKhBLlsXNjc3WvxYtD25
         ONuIr560RGt43v+jNT6O39u41NpVQmNPcY4tR4xRn7OeaBnyXqPwyZ4HP2yYCuIaIDRo
         FRPQ==
X-Gm-Message-State: AOAM530UxDr3tzdTvgKFxJW3O2KlPctsD0VtRV9xY0C9L5sYBS3fW1mv
        iwLJllBPEoXycODvnZLczpY5S+y/UcE=
X-Google-Smtp-Source: ABdhPJzZt3JSanGtWo9UfKgFKFCELIHz2pOl1LF7pYZMR8QTZppQsh7VB2RrL52+mSm81+eVGDSzaA==
X-Received: by 2002:a37:7903:: with SMTP id u3mr2298418qkc.226.1605279750765;
        Fri, 13 Nov 2020 07:02:30 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 82sm6837386qke.76.2020.11.13.07.02.29
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:02:30 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF2SK3032640
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:02:28 GMT
Subject: [PATCH v1 01/61] NFSD: Fix returned READDIR offset cookie
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:02:28 -0500
Message-ID: <160527974881.6186.12322949032060570965.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Code inspection shows that the server's NFSv3 READDIR implementation
returns the same offset cookie as the client sent, instead of the
last cookie it returns in the reply's dirlist. This is unlike the
NFSv2 READDIR, NFSv3 READDIRPLUS, and NFSv4 READDIR implementations,
and it's been like this since the beginning of kernel git history.

I copied the logic from nfsd3_proc_readdirplus().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index d9be589fed15..e0ad18d6b5a8 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -430,6 +430,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	struct nfsd3_readdirargs *argp = rqstp->rq_argp;
 	struct nfsd3_readdirres  *resp = rqstp->rq_resp;
 	int		count = 0;
+	loff_t		offset;
 	struct page	**p;
 	caddr_t		page_addr = NULL;
 
@@ -448,7 +449,9 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	resp->common.err = nfs_ok;
 	resp->buffer = argp->buffer;
 	resp->rqstp = rqstp;
-	resp->status = nfsd_readdir(rqstp, &resp->fh, (loff_t *)&argp->cookie,
+	offset = argp->cookie;
+
+	resp->status = nfsd_readdir(rqstp, &resp->fh, &offset,
 				    &resp->common, nfs3svc_encode_entry);
 	memcpy(resp->verf, argp->verf, 8);
 	count = 0;
@@ -464,8 +467,6 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	}
 	resp->count = count >> 2;
 	if (resp->offset) {
-		loff_t offset = argp->cookie;
-
 		if (unlikely(resp->offset1)) {
 			/* we ended up with offset on a page boundary */
 			*resp->offset = htonl(offset >> 32);


