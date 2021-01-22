Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04ACC300D9E
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 21:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbhAVUWs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jan 2021 15:22:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbhAVUVw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 22 Jan 2021 15:21:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D21F23AFC
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jan 2021 20:21:11 +0000 (UTC)
Subject: [PATCH RFC] NFSD: Reduce svc_rqst::rq_pages churn during READDIR
 operations
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 22 Jan 2021 15:21:10 -0500
Message-ID: <161134687025.19311.4882007133082076189.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
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
NFSv2 READDIR operation.

Eventually we should nail down why these pages need to be released
at all in order to avoid allocating and releasing pages
unnecessarily.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 8675851199f8..569bfff314f0 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -492,6 +492,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
 		}
 		count += PAGE_SIZE;
 	}
+	rqstp->rq_next_page = p;
 	resp->count = count >> 2;
 	if (resp->offset) {
 		if (unlikely(resp->offset1)) {
@@ -557,6 +558,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *rqstp)
 		}
 		count += PAGE_SIZE;
 	}
+	rqstp->rq_next_page = p;
 	resp->count = count >> 2;
 	if (resp->offset) {
 		if (unlikely(resp->offset1)) {


