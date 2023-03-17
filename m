Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4C96BE758
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 11:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjCQK4O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 06:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCQK4O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 06:56:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C95E9180
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 03:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8C7BB824F2
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 10:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32144C433D2;
        Fri, 17 Mar 2023 10:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679050570;
        bh=iTYJNvHM8Ug2eK3rT2uOxNcqm9wpPVMnMj3O0/+M3Dc=;
        h=From:To:Cc:Subject:Date:From;
        b=LpNOfvJB1SoweditB+HB1V9VxZNkLZJPilL9i/NjtR67oX2bwDKVhtgwoeO+qybZR
         x6SVDzp3zGctXB28L/stjQxW6v1DW+Qls+U+gWDSCrQ+LzFnAyh8/H29AE6stdt8KZ
         f0rOuMTKZkXZfrMNFSpxj5jOqZf+jD3bhn9RjQGC9GrOIgtt0kYLycV3mAC0RyqGJh
         opI07K9qynbh9uCf3yfM3ISeOFsG8tlxK5RSCCXGYt4fkBkYzAxWRDh+nKG7rhkOPZ
         boUo8M31s3AvsnQxEv9d5+KYs+vBOe3lrf18Qt7jCK+d/2+aAtABUw9f7BpG7y9awU
         HkfCkCiuIWUnw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, dcritch@redhat.com, d.lesca@solinos.it
Subject: [PATCH 1/2] nfsd: don't replace page in rq_pages if it's a continuation of last page
Date:   Fri, 17 Mar 2023 06:56:07 -0400
Message-Id: <20230317105608.19393-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

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
91e23b1c3982 removed the check for it, and started universally replacing
pages.

Fixes: 91e23b1c3982 ("NFSD: Clean up nfsd_splice_actor()")
Reported-by: Dario Lesca <d.lesca@solinos.it>
Tested-by: David Critch <dcritch@redhat.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2150630
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/vfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 502e1b7742db..3709ef57d96e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -941,8 +941,11 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 	struct page *last_page;
 
 	last_page = page + (offset + sd->len - 1) / PAGE_SIZE;
-	for (page += offset / PAGE_SIZE; page <= last_page; page++)
-		svc_rqst_replace_page(rqstp, page);
+	for (page += offset / PAGE_SIZE; page <= last_page; page++) {
+		/* Only replace page if we haven't already done so */
+		if (page != *(rqstp->rq_next_page - 1))
+			svc_rqst_replace_page(rqstp, page);
+	}
 	if (rqstp->rq_res.page_len == 0)	// first call
 		rqstp->rq_res.page_base = offset % PAGE_SIZE;
 	rqstp->rq_res.page_len += sd->len;
-- 
2.39.2

