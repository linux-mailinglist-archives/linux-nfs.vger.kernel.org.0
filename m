Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3259032FDC8
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Mar 2021 23:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCFWbH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Mar 2021 17:31:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhCFWa4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 6 Mar 2021 17:30:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B51806509D
        for <linux-nfs@vger.kernel.org>; Sat,  6 Mar 2021 22:30:55 +0000 (UTC)
Subject: [PATCH v2 17/43] NFSD: Count bytes instead of pages in the NFSv3
 READDIR encoder
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 06 Mar 2021 17:30:55 -0500
Message-ID: <161506985498.4312.18379864621054288654.stgit@klimt.1015granger.net>
In-Reply-To: <161506956174.4312.17478383686779759287.stgit@klimt.1015granger.net>
References: <161506956174.4312.17478383686779759287.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Counting the bytes used by each returned directory entry
seems less brittle to me than trying to measure consumed pages after
the fact.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |   31 ++-----------------------------
 fs/nfsd/nfs3xdr.c  |    1 +
 2 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 90566cd01bdc..791d77363acd 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -462,10 +462,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 {
 	struct nfsd3_readdirargs *argp = rqstp->rq_argp;
 	struct nfsd3_readdirres  *resp = rqstp->rq_resp;
-	int		count = 0;
 	loff_t		offset;
-	struct page	**p;
-	caddr_t		page_addr = NULL;
 
 	dprintk("nfsd: READDIR(3)  %s %d bytes at %d\n",
 				SVCFH_fmt(&argp->fh),
@@ -476,6 +473,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	/* Read directory and encode entries on the fly */
 	fh_copy(&resp->fh, &argp->fh);
 
+	resp->count = 0;
 	resp->common.err = nfs_ok;
 	resp->rqstp = rqstp;
 	offset = argp->cookie;
@@ -483,18 +481,6 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	resp->status = nfsd_readdir(rqstp, &resp->fh, &offset,
 				    &resp->common, nfs3svc_encode_entry);
 	memcpy(resp->verf, argp->verf, 8);
-	count = 0;
-	for (p = rqstp->rq_respages + 1; p < rqstp->rq_next_page; p++) {
-		page_addr = page_address(*p);
-
-		if (((caddr_t)resp->buffer >= page_addr) &&
-		    ((caddr_t)resp->buffer < page_addr + PAGE_SIZE)) {
-			count += (caddr_t)resp->buffer - page_addr;
-			break;
-		}
-		count += PAGE_SIZE;
-	}
-	resp->count = count >> 2;
 	nfs3svc_encode_cookie3(resp, offset);
 
 	return rpc_success;
@@ -509,10 +495,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 {
 	struct nfsd3_readdirargs *argp = rqstp->rq_argp;
 	struct nfsd3_readdirres  *resp = rqstp->rq_resp;
-	int	count = 0;
 	loff_t	offset;
-	struct page **p;
-	caddr_t	page_addr = NULL;
 
 	dprintk("nfsd: READDIR+(3) %s %d bytes at %d\n",
 				SVCFH_fmt(&argp->fh),
@@ -523,6 +506,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 	/* Read directory and encode entries on the fly */
 	fh_copy(&resp->fh, &argp->fh);
 
+	resp->count = 0;
 	resp->common.err = nfs_ok;
 	resp->rqstp = rqstp;
 	offset = argp->cookie;
@@ -539,17 +523,6 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 	resp->status = nfsd_readdir(rqstp, &resp->fh, &offset,
 				    &resp->common, nfs3svc_encode_entry_plus);
 	memcpy(resp->verf, argp->verf, 8);
-	for (p = rqstp->rq_respages + 1; p < rqstp->rq_next_page; p++) {
-		page_addr = page_address(*p);
-
-		if (((caddr_t)resp->buffer >= page_addr) &&
-		    ((caddr_t)resp->buffer < page_addr + PAGE_SIZE)) {
-			count += (caddr_t)resp->buffer - page_addr;
-			break;
-		}
-		count += PAGE_SIZE;
-	}
-	resp->count = count >> 2;
 	nfs3svc_encode_cookie3(resp, offset);
 
 out:
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index e334a1454edb..523b2dca0494 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -1364,6 +1364,7 @@ encode_entry(struct readdir_cd *ccd, const char *name, int namlen,
 		return -EINVAL;
 	}
 
+	cd->count += num_entry_words;
 	cd->buflen -= num_entry_words;
 	cd->buffer = p;
 	cd->common.err = nfs_ok;


