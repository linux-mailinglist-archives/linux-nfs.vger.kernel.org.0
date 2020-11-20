Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1502BB79E
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbgKTUmr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731110AbgKTUmr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:42:47 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AF6C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:47 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id f93so8088805qtb.10
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=XlTZ/HGy0ucXQaI1X53pA8JPUG61jLS6Bwy2Wee7MZs=;
        b=tUzoo+7ksYsSP96lN/pl3eJmOB4/SU7oU2kt1iLJp+SYe6u5Q5WIzgSIxu0h+kbsJD
         T/Plh3vHlFjo3g4uPbcfSrY/bR9f9snLCe952dx6Shg3/7e9PzpL3Th9V+vI64FvCWHN
         LIXuT/pdaidofCxJwijyeVzeNMU9456JogKRzWWzhzqv1W/M4P6G62Q0R5EADKC3/0Sb
         JdQx6VvGnL1pP7R3nqqWGviBgBmNURgF+bA8KfFtuggx0LFstUyshBRPTQP3X4gipgo7
         bOedsLik4Rei0z9LNJowZ+ouPXWu8XQ3vfRcCMpiAnRsM+JriN4eylb/a2zwoocV26Z1
         axqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=XlTZ/HGy0ucXQaI1X53pA8JPUG61jLS6Bwy2Wee7MZs=;
        b=eMva4Y0H5JIjn34jW3pkNNMtzENoqeeguTMUwKUPhS1sCoEiZ8oO8DGeCjitRPl0XD
         V0k6ueskK9axRVixSKLytPr6QDyKo8XzmrIQcmw+Eip6WFvW49rma3JSC3hjgcyTHAjU
         xaWpgzknHBgiYKSj3HS3iaw95LELsOMnNY9cTTI8/HGMioFlFSk4s/l4nBMShnsWogAn
         zigxqdT2jfdesF215RzT1Y15Odq54e4o2XmAOVftI4pMT+AT2/ah7a6I9++8n1zkllVj
         3qKeQ0qK8933QmEet3FIMpaLGD23PXnddBdgjT4qd+QabSxnArSknBc65GObnuui2OxG
         nktA==
X-Gm-Message-State: AOAM532npnnaCjX6nrVbwN1jHnsYtVox1yd/IxVpI2Hqbu9DpxcmKnIk
        EQLXWf5OTnS7FSXZngWAo+y4OSADDkA=
X-Google-Smtp-Source: ABdhPJynAaDAzjhKcT+IGbwuboOSmPpNlD9yJWQXx42CKJVUscLkNuOaI7sZWrjvZby97oQiZGtKYA==
X-Received: by 2002:ac8:4e87:: with SMTP id 7mr17020705qtp.310.1605904965882;
        Fri, 20 Nov 2020 12:42:45 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c6sm3021347qkg.54.2020.11.20.12.42.44
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:42:45 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKgiY6029516
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:42:44 GMT
Subject: [PATCH v2 101/118] NFSD: Add helper to set up the pages where the
 dirlist is encoded
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:42:44 -0500
Message-ID: <160590496391.1340.15643192492842825964.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
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
index 94b1fa0c3c58..3bbbb2a000bb 100644
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
index d2af4ab51418..2664101aa1dc 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -382,8 +382,6 @@ nfssvc_decode_readdirargs(struct svc_rqst *rqstp, __be32 *p)
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


