Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090A76BEF4F
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 18:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCQRNU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 13:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCQRNT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 13:13:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3001D423B
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 10:13:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6C8AB82640
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 17:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061C7C433EF;
        Fri, 17 Mar 2023 17:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679073191;
        bh=wyaQhkxgwzjdyStezUFZOA2eIjbXLPGLgQOOGBp+dLo=;
        h=From:To:Cc:Subject:Date:From;
        b=LtevvONYbQRbG5cFq8OwJU8KjMfvl411jAFsVXW8+6nHL+a+HTGWntMejdszsj3dh
         paqL8FY8zk16jFFh2InVtp3S2F5/1t5w8M2eFDHfMpkyj274Ld/I+2pLlCt7NfMV4L
         hZVU35NAgKheuK19mjaoDVJX1b+IsH/FG4FoHKy2V6yW9/JaIcym7JBKOUjcaNCVoB
         ifgPS/7F0GHHx9hQP560FRgsklO+twBTFDEOx3lOqKconnjGuLyPCzvM91v9nRE6Kg
         oWnec2jGTu5MB4DsRGzIx0HxnhdhlaqWVI7Doar4SHarHl2y7A4Gezf/wwkE1vCcFs
         330JwmZ66044Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, dcritch@redhat.com, d.lesca@solinos.it,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2 1/2] nfsd: don't replace page in rq_pages if it's a continuation of last page
Date:   Fri, 17 Mar 2023 13:13:08 -0400
Message-Id: <20230317171309.73607-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
91e23b1c3982 removed the check for it.

Fixes: 91e23b1c3982 ("NFSD: Clean up nfsd_splice_actor()")
Cc: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: Dario Lesca <d.lesca@solinos.it>
Tested-by: David Critch <dcritch@redhat.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2150630
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/vfs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 502e1b7742db..97b38b47c563 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -941,8 +941,14 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 	struct page *last_page;
 
 	last_page = page + (offset + sd->len - 1) / PAGE_SIZE;
-	for (page += offset / PAGE_SIZE; page <= last_page; page++)
-		svc_rqst_replace_page(rqstp, page);
+	for (page += offset / PAGE_SIZE; page <= last_page; page++) {
+		/*
+		 * Skip page replacement when extending the contents
+		 * of the current page.
+		 */
+		if (page != *(rqstp->rq_next_page - 1))
+			svc_rqst_replace_page(rqstp, page);
+	}
 	if (rqstp->rq_res.page_len == 0)	// first call
 		rqstp->rq_res.page_base = offset % PAGE_SIZE;
 	rqstp->rq_res.page_len += sd->len;
-- 
2.39.2

