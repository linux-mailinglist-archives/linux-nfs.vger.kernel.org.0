Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31FA2BB713
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbgKTUdy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbgKTUdy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:33:54 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42801C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:33:54 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q5so10157363qkc.12
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lI50/gELjS2rXymyXdCFIVVfAWwxhe722H5bkJzcpsk=;
        b=Rx7M0SaN3JkAweKmKpDrph/ndbZ6nGAh81pxptwLrHVxfcswY5iGYJcr4MkFdFj585
         mJPZaGBC40S7++jQim0O0YPWuDYhAu5BUGmHZAcZhkrjyq2eZblhCDtEdAMmRa3dOwan
         P7oIPo4f5UaBEbyIshL9vYSSmPA9HKuy6VnvpHX4Qb/dayv14IFoQAm/G5UG5pmXAxql
         CdZZdrqvPImDhB8EbGbRnJ5PVrWre+4PkEJsYd+Bw4f/P6HUv5LDlLcjaoIkTewfsRF7
         wOMWnFBgIjXLNWVSzRXlOy4CeWASWCwc6gjz00h2L2IsgHR/afswqAq7YrgL2S4yVSKd
         JqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=lI50/gELjS2rXymyXdCFIVVfAWwxhe722H5bkJzcpsk=;
        b=cdkKOeso2YPzBFRBjmZWc5YRKy1mUSxghAsk7EtYJc/+NH6qrZTIlvse3ty3izZn/w
         npZCylS9QrbDcqohijkICluxBviZcOMVoQRJdiKRmCYmwE9hhy235afnhaC7BNMq1tf6
         FyMXhsjWPMK/qBIXKbPkizEayAJRKGD3dIThHpLx0OAjxR1Lx/jXCVue12VPxUC1RxT8
         jnFapUbORJYqp6sIBuUY54Jctmlafmmm1vGB02CaQ/2fxBZ+xp//S9hsdLLYpxHWZw0H
         642dSLj4K61DYzFceUJL20OTmUWnTqWO480q41LfAz6iFa+Eyx0guztPl0SPyZmdH1iu
         HJNg==
X-Gm-Message-State: AOAM530QcUZhjkVYIdSoDJZ6SGwNef/wszSE4MYX/G6zd3Os5DDLB88y
        6o1EmFuK6zhJb7EjFz9xghSe3iowJsM=
X-Google-Smtp-Source: ABdhPJxNYfgZ5/kRrddTBIsz3uelVQLwmKQkBvNnRKYog1CZWpTFDNGNHTfinyk+8b4UkiyvcH8Drg==
X-Received: by 2002:a37:90c3:: with SMTP id s186mr18805538qkd.130.1605904433179;
        Fri, 20 Nov 2020 12:33:53 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s68sm2765980qkc.43.2020.11.20.12.33.52
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:33:52 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKXpcC029205
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:33:51 GMT
Subject: [PATCH v2 001/118] NFSD: Fix returned READDIR offset cookie
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:33:51 -0500
Message-ID: <160590443133.1340.6772360578279663543.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
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


