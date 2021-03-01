Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604AD32822D
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Mar 2021 16:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbhCAPSb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Mar 2021 10:18:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237079AbhCAPSM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 1 Mar 2021 10:18:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4A19614A5
        for <linux-nfs@vger.kernel.org>; Mon,  1 Mar 2021 15:17:31 +0000 (UTC)
Subject: [PATCH v1 22/42] NFSD: Reduce svc_rqst::rq_pages churn during READDIR
 operations
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 01 Mar 2021 10:17:31 -0500
Message-ID: <161461185115.8508.17657260621552734607.stgit@klimt.1015granger.net>
In-Reply-To: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
References: <161461145466.8508.13379815439337754427.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

During NFSv2 and NFSv3 READDIR/PLUS operations, NFSD advances
rq_next_page to the full size of the client-requested buffer, then
releases all those pages at the end of the request. The next request
to use that nfsd thread has to refill the pages.

NFSD does this even when the dirlist in the reply is small. With
NFSv3 clients that send READDIR operations with large buffer sizes,
that can be 256 put_page/alloc_page pairs per READDIR request, even
though those pages often remain unused.

We can save some work by not releasing dirlist buffer pages that
were not used to form the READDIR Reply. I've left the NFSv2 code
alone since there are never more than three pages involved in an
NFSv2 READDIR Reply.

Eventually we should nail down why these pages need to be released
at all in order to avoid allocating and releasing pages
unnecessarily.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index bc64e95a168d..17715a6c7a40 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -493,6 +493,9 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 	memcpy(resp->verf, argp->verf, 8);
 	nfs3svc_encode_cookie3(resp, offset);
 
+	/* Recycle only pages that were part of the reply */
+	rqstp->rq_next_page = resp->xdr.page_ptr + 1;
+
 	return rpc_success;
 }
 
@@ -533,6 +536,9 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 	memcpy(resp->verf, argp->verf, 8);
 	nfs3svc_encode_cookie3(resp, offset);
 
+	/* Recycle only pages that were part of the reply */
+	rqstp->rq_next_page = resp->xdr.page_ptr + 1;
+
 out:
 	return rpc_success;
 }


