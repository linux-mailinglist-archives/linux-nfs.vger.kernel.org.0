Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C85E328225
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbhCAPSS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:18:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237119AbhCAPR5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:17:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C57B464E42
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:17:01 +0000 (UTC)
Subject: [PATCH v1 17/42] NFSD: Count bytes instead of pages in the NFSv3
 READDIR encoder
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:17:01 -0500
Message-ID: <161461182108.8508.1449976990501801347.stgit@klimt.1015granger.net>
In-Reply-To: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
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
index aef72d00d5a9..9f8afc5b126b 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -1364,6 +1364,7 @@ encode_entry(struct readdir_cd *ccd, const char *name, int namlen,
 		return -EINVAL;
 	}
 
+	cd->count += num_entry_words;
 	cd->buflen -= num_entry_words;
 	cd->buffer = p;
 	cd->common.err = nfs_ok;


