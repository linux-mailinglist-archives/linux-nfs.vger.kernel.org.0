Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708D22EAE59
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbhAEPbM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbhAEPbL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:31:11 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D670C061574
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:30:31 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id c7so26778025qke.1
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=His8wXJJ6Md9Zao5EcfjkbJnoHe65nCQDA9M06KsFag=;
        b=imlLuH14PuPSUUsMUMxDcbxAldovNPcJxBUYDpkU9qXg5SH8yhT1TTJzRzR928zknm
         1UqNNuarg6bGtECF9o9ICDV9VUxxG1v1pLhHK4pSDc6G3zYlcxTIHq1t4AgCBnjFrlLb
         l4i5J6oz8Eh7yGyq02ztwd52TtS5lkEiwHJtl/Uh9tCXShcmL8cUCnM2oO8JsMZpgnmY
         3bE8p6J4ylFXzv39BVEKTfTO7tN2ApwEYKVZip/oO4XEoBf87xdK7FCFjZITo9SDhaB6
         l0a3e5UFqlQb2U7GZZsSNPXaNit375JkO3XCbGk8GJXNW+TiUOQ0YB9iHZe64HBWL4Qh
         kykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=His8wXJJ6Md9Zao5EcfjkbJnoHe65nCQDA9M06KsFag=;
        b=q49mlQKw43SI4X4zKkdWV8+LuJostZqZiLEGgpsy5g4Q+/wLEoelXmRo2z+i1eU3UG
         lk1GehDcn/TnEYIL5YQBYQKZNz/2h92DIF16AdeYjRjGIBhO2rg4YFnnSgOay60eaOfU
         exT1dQ/YUtulIZqXGguXyzQKc2RmsCdu6FhfkxtBj4WKGg6gwkzvIGfm9Rf20QO7Nme6
         zaYwK3xnRL7RH3g9RdbHKdXs3KBUDRiXctL57s/MpOo1sDtb70qSCvqpA6eqroSyB9uM
         hN9fTyYAElrVIFNQa+x70KT7TTqogdscCrlzJrbi/OS1AjJtWwTWRc4KPyLTwbDRw1PS
         Qxsg==
X-Gm-Message-State: AOAM53336SPINUQYkKLEa+2LdCOHn67QO+XlruAL39iYts/ljtgkIaUk
        GfC6aL0n8gjasE6LSxTjBKUDrh9h9Ns=
X-Google-Smtp-Source: ABdhPJxYYsIO/EU+af78mPfT8/cFXHPfE98urosvaJxVPTx30fSC9YEonGMTOtpMbr7Ns0VMUS5ADg==
X-Received: by 2002:a37:9c82:: with SMTP id f124mr2000qke.369.1609860630333;
        Tue, 05 Jan 2021 07:30:30 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id b15sm27353qta.75.2021.01.05.07.30.29
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:30:29 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FUSOL020847
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:30:28 GMT
Subject: [PATCH v1 09/42] NFSD: Fix returned READDIR offset cookie
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:30:28 -0500
Message-ID: <160986062865.5532.2413664838273345962.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Code inspection shows that the server's NFSv3 READDIR implementation
handles offset cookies slightly differently than the NFSv2 READDIR,
NFSv3 READDIRPLUS, and NFSv4 READDIR implementations,
and there doesn't seem to be any need for this difference.

As a clean up, I copied the logic from nfsd3_proc_readdirplus().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 9e289e0f439b..7ea2fb127f6f 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -444,6 +444,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	struct nfsd3_readdirargs *argp = rqstp->rq_argp;
 	struct nfsd3_readdirres  *resp = rqstp->rq_resp;
 	int		count = 0;
+	loff_t		offset;
 	struct page	**p;
 	caddr_t		page_addr = NULL;
 
@@ -462,7 +463,9 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
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
@@ -478,8 +481,6 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	}
 	resp->count = count >> 2;
 	if (resp->offset) {
-		loff_t offset = argp->cookie;
-
 		if (unlikely(resp->offset1)) {
 			/* we ended up with offset on a page boundary */
 			*resp->offset = htonl(offset >> 32);


