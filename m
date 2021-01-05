Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75172EAE77
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbhAEPch (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbhAEPcg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:32:36 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED16C061798
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:31:56 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id az16so14808724qvb.5
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=qe/aD+xPugXqU3gg0YpNxbsKePZr14mVF6vn3CIw7xE=;
        b=pSvCIS2er8hCVqNxCMmfoRtwqWn6DpKrzIPC0dKtRhuPSEx4pfwFAtdezSzQmCHxb2
         lgIY1aKFFTZ8b4D/VgaQZ4R/hdsTw8ozJTQ7xA1o32grL0GTK8prAlZf+5ZSzQjX73Uh
         kJlpKdZbUz58QigTMd8mo/dvKyrKJq5evHcKfNbP8TLaCpNWZLTnzXpmxNugvhYaDql/
         vsdS2s+5ZOjrxTczkp/5sCf/UGts5mZsIior58Ogbbo7pFfRhUDHpTcfcZe5P3qzpVsJ
         w/vuUITIvOxZNjA/iax+pY3O0bnUVC05Y4/1l8+pUP36bVAeBU/Ox79+yi9fLPy8XFlt
         grPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=qe/aD+xPugXqU3gg0YpNxbsKePZr14mVF6vn3CIw7xE=;
        b=pejSMMcgYTDQE8tjafW9J4+SEpIr0PL+vC5Bd93f2uvWTzdpyc2164i1s8HiLmn8Y4
         VT5RMQuBOGRUDIIYV3uI88I2GEAyrKafE+KnnQ2IIIoVwEspevw2gkSDOGgAB4CSnX30
         vYpU2Uw4Uza1DtChniQiXXNB8Yb2i2HCE8jpU0DAq9HpxwBHnkvSjOx5uahxvysf7u1l
         M45QlazFuZBgyZ1kX44mB1erPxEzWnmO+BKXvUQVEzD9N5pkaf1WKkkOfw4hBiHdlj/7
         uRxzhzskW2WnzKg0+I1qB0VwOQ2gveI55faPF/VxIadgPcTmFMsB6pzeCwCvRHJdFcxR
         ArNQ==
X-Gm-Message-State: AOAM532sSp/MxuZivAq/d0Bg7ZdUwwtAWjvjOAuge4eZnbzVKSzGQYrn
        MY5HGKsnfCpNTP1j7RK5NE5kNx7qyj0=
X-Google-Smtp-Source: ABdhPJzPH3JO3V1yxgyBk2ZrRhElpz0+w85QJ2oNyZiC6hPq5Ow77afU/ybLyjIOUtihvlE0ENAkDQ==
X-Received: by 2002:a05:6214:d4a:: with SMTP id 10mr137904qvr.62.1609860714361;
        Tue, 05 Jan 2021 07:31:54 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z15sm131732qkz.103.2021.01.05.07.31.53
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 07:31:53 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 105FVqfq020895
        for <linux-nfs@vger.kernel.org>; Tue, 5 Jan 2021 15:31:52 GMT
Subject: [PATCH v1 25/42] NFSD: Add helper to set up the pages where the
 dirlist is encoded
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Jan 2021 10:31:52 -0500
Message-ID: <160986071268.5532.3436167990107485019.stgit@klimt.1015granger.net>
In-Reply-To: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
References: <160986050640.5532.16498408936966394862.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a helper similar to nfsd3_init_dirlist_pages().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsproc.c |   29 ++++++++++++++++++-----------
 fs/nfsd/nfsxdr.c  |    2 --
 fs/nfsd/xdr.h     |    1 -
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index bdb47848f7fd..b2f8035f166b 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -553,6 +553,20 @@ nfsd_proc_rmdir(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
+static void nfsd_init_dirlist_pages(struct svc_rqst *rqstp,
+				    struct nfsd_readdirres *resp,
+				    int count)
+{
+	count = min_t(u32, count, PAGE_SIZE);
+
+	/* Convert byte count to number of words (i.e. >> 2),
+	 * and reserve room for the NULL ptr & eof flag (-2 words) */
+	resp->buflen = (count >> 2) - 2;
+
+	resp->buffer = page_address(*rqstp->rq_next_page);
+	rqstp->rq_next_page++;
+}
+
 /*
  * Read a portion of a directory.
  */
@@ -561,31 +575,24 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 {
 	struct nfsd_readdirargs *argp = rqstp->rq_argp;
 	struct nfsd_readdirres *resp = rqstp->rq_resp;
-	int		count;
 	loff_t		offset;
+	__be32		*buffer;
 
 	dprintk("nfsd: READDIR  %s %d bytes at %d\n",
 		SVCFH_fmt(&argp->fh),		
 		argp->count, argp->cookie);
 
-	/* Shrink to the client read size */
-	count = (argp->count >> 2) - 2;
-
-	/* Make sure we've room for the NULL ptr & eof flag */
-	count -= 2;
-	if (count < 0)
-		count = 0;
+	nfsd_init_dirlist_pages(rqstp, resp, argp->count);
+	buffer = resp->buffer;
 
-	resp->buffer = argp->buffer;
 	resp->offset = NULL;
-	resp->buflen = count;
 	resp->common.err = nfs_ok;
 	/* Read directory and encode entries on the fly */
 	offset = argp->cookie;
 	resp->status = nfsd_readdir(rqstp, &argp->fh, &offset,
 				    &resp->common, nfssvc_encode_entry);
 
-	resp->count = resp->buffer - argp->buffer;
+	resp->count = resp->buffer - buffer;
 	if (resp->offset)
 		*resp->offset = htonl(offset);
 
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index 02dd9888d93b..3d72334e1673 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -388,8 +388,6 @@ nfssvc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p)
 		return 0;
 	args->cookie = ntohl(*p++);
 	args->count  = ntohl(*p++);
-	args->count  = min_t(u32, args->count, PAGE_SIZE);
-	args->buffer = page_address(*(rqstp->rq_next_page++));
 
 	return xdr_argsize_check(rqstp, p);
 }
diff --git a/fs/nfsd/xdr.h b/fs/nfsd/xdr.h
index 288c29a999db..d700838f6512 100644
--- a/fs/nfsd/xdr.h
+++ b/fs/nfsd/xdr.h
@@ -73,7 +73,6 @@ struct nfsd_readdirargs {
 	struct svc_fh		fh;
 	__u32			cookie;
 	__u32			count;
-	__be32 *		buffer;
 };
 
 struct nfsd_stat {


