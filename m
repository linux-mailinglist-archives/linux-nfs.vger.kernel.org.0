Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A0032FDD2
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Mar 2021 23:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhCFWcO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Mar 2021 17:32:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhCFWcI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 6 Mar 2021 17:32:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C9D7650D0
        for <linux-nfs@vger.kernel.org>; Sat,  6 Mar 2021 22:32:08 +0000 (UTC)
Subject: [PATCH v2 29/43] NFSD: Count bytes instead of pages in the NFSv2
 READDIR encoder
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 06 Mar 2021 17:32:07 -0500
Message-ID: <161506992747.4312.14709463751972537678.stgit@klimt.1015granger.net>
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
 fs/nfsd/nfsproc.c |    4 ----
 fs/nfsd/nfsxdr.c  |    3 ++-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 5a0dd6e23c85..1acff9f4aaf1 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -578,14 +578,12 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 	struct nfsd_readdirargs *argp = rqstp->rq_argp;
 	struct nfsd_readdirres *resp = rqstp->rq_resp;
 	loff_t		offset;
-	__be32		*buffer;
 
 	dprintk("nfsd: READDIR  %s %d bytes at %d\n",
 		SVCFH_fmt(&argp->fh),		
 		argp->count, argp->cookie);
 
 	nfsd_init_dirlist_pages(rqstp, resp, argp->count);
-	buffer = resp->buffer;
 
 	resp->offset = NULL;
 	resp->common.err = nfs_ok;
@@ -593,8 +591,6 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
 	offset = argp->cookie;
 	resp->status = nfsd_readdir(rqstp, &argp->fh, &offset,
 				    &resp->common, nfssvc_encode_entry);
-
-	resp->count = resp->buffer - buffer;
 	nfssvc_encode_nfscookie(resp, offset);
 
 	fh_put(&argp->fh);
diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
index a87b21cfe0d0..8ae23ed6dc5d 100644
--- a/fs/nfsd/nfsxdr.c
+++ b/fs/nfsd/nfsxdr.c
@@ -584,7 +584,7 @@ nfssvc_encode_readdirres(struct svc_rqst *rqstp, __be32 *p)
 	p = resp->buffer;
 	*p++ = 0;			/* no more entries */
 	*p++ = htonl((resp->common.err == nfserr_eof));
-	rqstp->rq_res.page_len = (((unsigned long)p-1) & ~PAGE_MASK)+1;
+	rqstp->rq_res.page_len = resp->count << 2;
 
 	return 1;
 }
@@ -667,6 +667,7 @@ nfssvc_encode_entry(void *ccdv, const char *name,
 	cd->offset = p;			/* remember pointer */
 	*p++ = htonl(~0U);		/* offset of next entry */
 
+	cd->count += p - cd->buffer;
 	cd->buflen = buflen;
 	cd->buffer = p;
 	cd->common.err = nfs_ok;


