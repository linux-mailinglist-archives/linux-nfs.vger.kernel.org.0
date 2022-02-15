Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671574B7B0D
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Feb 2022 00:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiBOXL6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Feb 2022 18:11:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbiBOXL5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Feb 2022 18:11:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2D013CF6
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 15:11:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6641161502
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 23:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA7FC340F0
        for <linux-nfs@vger.kernel.org>; Tue, 15 Feb 2022 23:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644966705;
        bh=UCn/QnjNhOcTDfq8uqDXDR/GNHqDfhklFjWfMyBMeV8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lrOcH27EOdlPgor7/m8dqXGmS2FbjDbdQAUL4RLGDwS4hSDBtiMsz2DES0+lFhaz+
         s/WEA105TMeFjIyhbA2vFtiNkFV9lMCIqjigyb4iNHcNecgH9q9fchLo+mx52EY8ZU
         2TPL3bHHSY0pBA7YvEl7mny0CmJm05HiZd05Ro6ZfykT7nMfopiabVxxRjNPM6BbTO
         CWViNlX/EhXNsWp6wVBGbCxyY0QXpkzLyPKboJy8XAdp7dxx4ZYvE7/WjsFqFP3jye
         UDO4KvVisrEareG4bOKyhYj3huKFdAne7KXiadStYBBIl6Z6kCfeyjwrQmCQcCv5t2
         rZoCX6ezrtSdg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS: Do not report writeback errors in nfs_getattr()
Date:   Tue, 15 Feb 2022 18:05:18 -0500
Message-Id: <20220215230518.24923-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215230518.24923-1-trondmy@kernel.org>
References: <20220215230518.24923-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The result of the writeback, whether it is an ENOSPC or an EIO, or
anything else, does not inhibit the NFS client from reporting the
correct file timestamps.

Fixes: 79566ef018f5 ("NFS: Getattr doesn't require data sync semantics")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 90432fc389a0..f9fc506ebb29 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -850,12 +850,9 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	}
 
 	/* Flush out writes to the server in order to update c/mtime.  */
-	if ((request_mask & (STATX_CTIME|STATX_MTIME)) &&
-			S_ISREG(inode->i_mode)) {
-		err = filemap_write_and_wait(inode->i_mapping);
-		if (err)
-			goto out;
-	}
+	if ((request_mask & (STATX_CTIME | STATX_MTIME)) &&
+	    S_ISREG(inode->i_mode))
+		filemap_write_and_wait(inode->i_mapping);
 
 	/*
 	 * We may force a getattr if the user cares about atime.
-- 
2.35.1

