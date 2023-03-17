Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18676BF5EB
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Mar 2023 00:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCQXDL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 19:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCQXDK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 19:03:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB7A305FD
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 16:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B91F60B46
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 23:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566B2C433D2;
        Fri, 17 Mar 2023 23:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679094099;
        bh=uhETMx3Y+MC6Z0xrt6qTQ/9nXmtm6z4r+CzxRN57Qto=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sfL7d0PDNGRj3Ql7hVaMql2GfqFmEzGvNqBgFbhCTNCSbwf8uUEb+BT/u5EXpToZG
         vjupKNBSU6WXIdpR7qNIm6MHm6FgDYXB/Q+fHFJWuirqEcuIVAxAJMUt2ABqu1J3Ux
         iOkZ11e8ijhr3GStYB1LkRDQ80+eJQQa5/UXM1d/jcjK1Xw1DmksPP6e7MJ7w/sz+L
         zFQ8PQQS/T4wjU7TfhYO32TFa35LiEuQkj2ihkLhPvxf8ABaIJwXZtWjL3NrelWcw2
         6Q+DBuLh+UgTM6FUKQKDHmOxgCj/TmiuW+tfqo4jvhX6hIKKPToovdBCI2mbYErh9m
         Ytk9rfb/qYNCg==
Subject: [PATCH v1 3/3] NFSD: Watch for rq_pages bounds checking errors in
 nfsd_splice_actor()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, dcritch@redhat.com, d.lesca@solinos.it
Date:   Fri, 17 Mar 2023 19:01:38 -0400
Message-ID: <167909409842.1672.18284039985769877598.stgit@klimt.1015granger.net>
In-Reply-To: <167909365790.1672.13118429954916842449.stgit@klimt.1015granger.net>
References: <167909365790.1672.13118429954916842449.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

This is a "should never happen" condition, but if for some reason
the pipe splice actor should attempt to walk past the end of
rq_pages, it needs to terminate the READ operation to prevent
corruption of the pointer addresses in the fields just beyond the
array.

A server crash is thus prevented. Since the code is not behaving,
the READ operation returns -EIO to the client. None of the READ
payload data can be trusted if the splice actor isn't operating as
expected.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5783209f17fc..10aa68ca82ef 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -930,6 +930,9 @@ nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp, int may_flags,
  * Grab and keep cached pages associated with a file in the svc_rqst
  * so that they can be passed to the network sendmsg/sendpage routines
  * directly. They will be released after the sending has completed.
+ *
+ * Return values: Number of bytes consumed, or -EIO if there are no
+ * remaining pages in rqstp->rq_pages.
  */
 static int
 nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
@@ -948,7 +951,8 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
 		 */
 		if (page == *(rqstp->rq_next_page - 1))
 			continue;
-		svc_rqst_replace_page(rqstp, page);
+		if (unlikely(!svc_rqst_replace_page(rqstp, page)))
+			return -EIO;
 	}
 	if (rqstp->rq_res.page_len == 0)	// first call
 		rqstp->rq_res.page_base = offset % PAGE_SIZE;


