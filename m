Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B260E6E97E2
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Apr 2023 17:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjDTPCi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Apr 2023 11:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjDTPCh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Apr 2023 11:02:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7544224
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 08:02:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A8A60A51
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 15:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9068C4339E
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682002955;
        bh=maAzsRbLWODnaOw4KBbv37SLgiI4Ow5q0qnh/zC9w9g=;
        h=Subject:From:To:Date:From;
        b=STDw+4rOpGVsURGi65w/15ydJu4VKT83p3RnFawbp9lp5MrNdtoed1rz0qOgW8g0j
         8tGBRVtG0isH4NxSX+KQ+tu4qvRf9IaVmu4gqhsCCF0nHnop1wLoaDFwTrXLOiBcMW
         9hO2Gy8roCNmG7asF85zd6wJMRqXEytnhLn3jGGcdSvigHdfZZF9dlSNHbcozjL/rF
         1PddQKqeHMghf840VvZW7ZY/xjg7CP4eA4MjV8InzfgStlxODgCb8nd/8x5WHstEcV
         BuPXwYjdimg9NQ0ICqBgQe3cnbysu31Py8UjaIcNZEdm5IXMhmLjEcJUa+ly5ltJf1
         aNi5U1WLbyILw==
Subject: [PATCH] NFSD: Clean up xattr memory allocation flags
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Thu, 20 Apr 2023 11:02:33 -0400
Message-ID: <168200295385.15631.450467456689355871.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Tetsuo points out:
> Since GFP_KERNEL is "GFP_NOFS | __GFP_FS", usage like
> "GFP_KERNEL | GFP_NOFS" does not make sense.

The original intent was to hold the inode lock while estimating
the buffer requirements for the requested information. Frank van
der Linden, the author of NFSD's xattr code, says:

> ... you need inode_lock to get an atomic view of an xattr. Since
> both nfsd_getxattr and nfsd_listxattr to the standard trick of
> querying the xattr length with a NULL buf argument (just getting
> the length back), allocating the right buffer size, and then
> querying again, they need to hold the inode lock to avoid having
> the xattr changed from under them while doing that.
>
> From that then flows the requirement that GFP_FS could cause
> problems while holding i_rwsem, so I added GFP_NOFS.

However, Dave Chinner states:
> You can do GFP_KERNEL allocations holding the i_rwsem just fine.
> All that it requires is the caller holds a reference to the
> inode ...

Since these code paths acquire a dentry, they do indeed hold a
reference. It is therefore safe to use GFP_KERNEL for these memory
allocations. In particular, that's what this code is already doing;
but now the C source code looks sane too.

At a later time we can revisit in order to remove the inode lock in
favor of simply retrying if the estimated buffer size is too small.

Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 10aa68ca82ef..bb9d47172162 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2168,7 +2168,7 @@ nfsd_getxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 		goto out;
 	}
 
-	buf = kvmalloc(len, GFP_KERNEL | GFP_NOFS);
+	buf = kvmalloc(len, GFP_KERNEL);
 	if (buf == NULL) {
 		err = nfserr_jukebox;
 		goto out;
@@ -2231,10 +2231,7 @@ nfsd_listxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char **bufp,
 		goto out;
 	}
 
-	/*
-	 * We're holding i_rwsem - use GFP_NOFS.
-	 */
-	buf = kvmalloc(len, GFP_KERNEL | GFP_NOFS);
+	buf = kvmalloc(len, GFP_KERNEL);
 	if (buf == NULL) {
 		err = nfserr_jukebox;
 		goto out;


