Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422B16BF5E9
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Mar 2023 00:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCQXCW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 19:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQXCV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 19:02:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3BB4FF13
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 16:01:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A33A60BC5
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 23:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A28C433EF;
        Fri, 17 Mar 2023 23:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679094086;
        bh=1hDX9JSkvaA2c2aqNndSO+fLzP94W74efh2KnHoeg9w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Qtbx+f6+q/Yu4YpUjnU6Dr9dM4F86BtfJpFDciFsIR6baqv+oSFdYfdDEwbpVBarz
         FAlNL9XCmivlYWgWeEgbpVbQkxRKokJ2QQqOhCoAMa3gJgFJa16xiin9FvDKdXWrvY
         fxKlTc3G3xRINDJnZ34Hal78YcYFOFCQRKWXq+2knKPQ1Q5u7EZ4uftFoqD+lUPnCf
         JP6p04mFd/dF/BghcTp4tbGctWKpv6YvGyvP3ga7dheSXNYoUNrQRH6t7OevmxYaa0
         Pgs4UF416G9CXZHpk3uQ4YYHrimtB6ToS4fF0FhkbHTEmUxNHlUy9/FBw0559vvtyX
         iWdH1r7V20qdw==
Subject: [PATCH v1 1/3] nfsd: don't replace page in rq_pages if it's a
 continuation of last page
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, dcritch@redhat.com, d.lesca@solinos.it
Date:   Fri, 17 Mar 2023 19:01:25 -0400
Message-ID: <167909408510.1672.11351348839166110078.stgit@klimt.1015granger.net>
In-Reply-To: <167909365790.1672.13118429954916842449.stgit@klimt.1015granger.net>
References: <167909365790.1672.13118429954916842449.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

The splice read calls nfsd_splice_actor to put the pages containing file
data into the svc_rqst->rq_pages array. It's possible however to get a
splice result that only has a partial page at the end, if (e.g.) the
filesystem hands back a short read that doesn't cover the whole page.

nfsd_splice_actor will plop the partial page into its rq_pages array and
return. Then later, when nfsd_splice_actor is called again, the
remainder of the page may end up being filled out. At this point,
nfsd_splice_actor will put the page into the array _again_ corrupting
the reply. If this is done enough times, rq_next_page will overrun the
array and corrupt the trailing fields -- the rq_respages and
rq_next_page pointers themselves.

If we've already added the page to the array in the last pass, don't add
it to the array a second time when dealing with a splice continuation.
This was originally handled properly in nfsd_splice_actor, but commit
91e23b1c3982 ("NFSD: Clean up nfsd_splice_actor()") removed the check
for it.

Fixes: 91e23b1c3982 ("NFSD: Clean up nfsd_splice_actor()")
Cc: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: Dario Lesca <d.lesca@solinos.it>
Tested-by: David Critch <dcritch@redhat.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2150630
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 502e1b7742db..5783209f17fc 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -941,8 +941,15 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 	struct page *last_page;
 
 	last_page = page + (offset + sd->len - 1) / PAGE_SIZE;
-	for (page += offset / PAGE_SIZE; page <= last_page; page++)
+	for (page += offset / PAGE_SIZE; page <= last_page; page++) {
+		/*
+		 * Skip page replacement when extending the contents
+		 * of the current page.
+		 */
+		if (page == *(rqstp->rq_next_page - 1))
+			continue;
 		svc_rqst_replace_page(rqstp, page);
+	}
 	if (rqstp->rq_res.page_len == 0)	// first call
 		rqstp->rq_res.page_base = offset % PAGE_SIZE;
 	rqstp->rq_res.page_len += sd->len;


