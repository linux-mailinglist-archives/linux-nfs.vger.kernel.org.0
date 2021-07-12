Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FE73C630B
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jul 2021 20:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhGLTAy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jul 2021 15:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhGLTAy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 12 Jul 2021 15:00:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49844611AD;
        Mon, 12 Jul 2021 18:58:05 +0000 (UTC)
Subject: [PATCH v4 3/3] NFSD: Batch release pages during splice read
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-mm@kvack.org
Cc:     neilb@suse.de
Date:   Mon, 12 Jul 2021 14:58:04 -0400
Message-ID: <162611628458.1416.5951210328076512466.stgit@klimt.1015granger.net>
In-Reply-To: <162611520339.1416.14646909890289253420.stgit@klimt.1015granger.net>
References: <162611520339.1416.14646909890289253420.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Large splice reads call put_page() repeatedly. put_page() is
relatively expensive to call, so replace it with the new
svc_rqst_replace_page() helper to help amortize that cost.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/vfs.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 46a6d9fce3d2..7732a384f949 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -849,15 +849,10 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 	struct page *page = buf->page;
 
 	if (rqstp->rq_res.page_len == 0) {
-		get_page(page);
-		put_page(*rqstp->rq_next_page);
-		*(rqstp->rq_next_page++) = page;
+		svc_rqst_replace_page(rqstp, page);
 		rqstp->rq_res.page_base = buf->offset;
 	} else if (page != pp[-1]) {
-		get_page(page);
-		if (*rqstp->rq_next_page)
-			put_page(*rqstp->rq_next_page);
-		*(rqstp->rq_next_page++) = page;
+		svc_rqst_replace_page(rqstp, page);
 	}
 	rqstp->rq_res.page_len += sd->len;
 


