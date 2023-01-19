Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D52674573
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jan 2023 23:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjASWDU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Jan 2023 17:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjASWCs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Jan 2023 17:02:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F70159565
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 13:40:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73D2461D91
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 21:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AF2C433F2;
        Thu, 19 Jan 2023 21:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674164428;
        bh=cTUelAc/uEnB+p0V7+95YgbegMhVccETAc/DBIf3sS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uz8qQwcqt1Cbmvrz+oWzpYodP34XtK8KMSfFhzMfXtG9XcDknULAilFRU3iiuVpDg
         pTo0fUxvrSdMv2lmIhncAh02sNBRMVjlrDrhWttw6uXtQObJsdgv5N4AZenbgyweA8
         cFmuu6/j9Mi7LkTmKCaqYemHVPfNx7lXnaeRHAEXRsc5UBXCMRV3qtuAExajdLYzg3
         8IkFnuFijnH6OseNjRY5wiY/ukyNvBC2Vg6JrVSW4+ZdWg621rnpDiQ0lqn5zF9ErT
         dO+/138W1FIgSS0KFe110SGNVIoVlqXvlE6uBmVKkI1XWWhNgnfe4lud0V3nGRoWL4
         PF6z6bFGhS/fA==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 18/18] NFS: Remove unnecessary check in nfs_read_folio()
Date:   Thu, 19 Jan 2023 16:33:51 -0500
Message-Id: <20230119213351.443388-19-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119213351.443388-18-trondmy@kernel.org>
References: <20230119213351.443388-1-trondmy@kernel.org>
 <20230119213351.443388-2-trondmy@kernel.org>
 <20230119213351.443388-3-trondmy@kernel.org>
 <20230119213351.443388-4-trondmy@kernel.org>
 <20230119213351.443388-5-trondmy@kernel.org>
 <20230119213351.443388-6-trondmy@kernel.org>
 <20230119213351.443388-7-trondmy@kernel.org>
 <20230119213351.443388-8-trondmy@kernel.org>
 <20230119213351.443388-9-trondmy@kernel.org>
 <20230119213351.443388-10-trondmy@kernel.org>
 <20230119213351.443388-11-trondmy@kernel.org>
 <20230119213351.443388-12-trondmy@kernel.org>
 <20230119213351.443388-13-trondmy@kernel.org>
 <20230119213351.443388-14-trondmy@kernel.org>
 <20230119213351.443388-15-trondmy@kernel.org>
 <20230119213351.443388-16-trondmy@kernel.org>
 <20230119213351.443388-17-trondmy@kernel.org>
 <20230119213351.443388-18-trondmy@kernel.org>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

All the callers are expected to supply a valid struct file argument, so
there is no need for the NULL check.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/read.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index bf4154f9b48c..c380cff4108e 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -355,13 +355,7 @@ int nfs_read_folio(struct file *file, struct folio *folio)
 	if (NFS_STALE(inode))
 		goto out_unlock;
 
-	if (file == NULL) {
-		ret = -EBADF;
-		desc.ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
-		if (desc.ctx == NULL)
-			goto out_unlock;
-	} else
-		desc.ctx = get_nfs_open_context(nfs_file_open_context(file));
+	desc.ctx = get_nfs_open_context(nfs_file_open_context(file));
 
 	xchg(&desc.ctx->error, 0);
 	nfs_pageio_init_read(&desc.pgio, inode, false,
-- 
2.39.0

