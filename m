Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E02962DD4B
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Nov 2022 14:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiKQNxh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Nov 2022 08:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240201AbiKQNxY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Nov 2022 08:53:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7003C40905
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 05:53:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2482FB8206C
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 13:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AA6C433D6
        for <linux-nfs@vger.kernel.org>; Thu, 17 Nov 2022 13:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668693198;
        bh=LUOIINk5ghp8dtH/txOTyiGBaZw7R9e/2CYiSyzKc64=;
        h=From:To:Subject:Date:From;
        b=dSYuOCJEFhJD4b2sBgyX3dtQb+EMIXknLdq/omzYjatEgh9xKzjXmbb41dtLHcgfs
         aXcJkG5DMuzZmOmOIdepRmq/rDxbd/Up8Aq9DLa1LDB1/mLkYsmwHqX1ewETnfvTnN
         EPqeQ8wSPJIsbu+MUFNz7kroIc0v5LRZ8Yny0ALLmaeclhcxhwsZRS8/Nyl8QXdmK4
         y7wxMTr97yQ8/tjXt6C1DImdTJdgVPbc6CoAVWh7BmAK5u4D3oevSQUvteXUxXJT/F
         XxrcsYwKloIb4hhTnO9KE3FobAmdEf5weBPj14o/AJqatB6bgXddbvXam90RFoCpvc
         lUNai5zGcCc8w==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Fix an Oops in nfs_d_automount()
Date:   Thu, 17 Nov 2022 08:47:12 -0500
Message-Id: <20221117134713.9069-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.38.1
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

When mounting from a NFSv4 referral, path->dentry can end up being a
negative dentry, so derive the struct nfs_server from the dentry
itself instead.

Fixes: 2b0143b5c986 ("VFS: normal filesystems (and lustre): d_inode() annotations")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 2f336ace7555..88a23af2bd5c 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -147,7 +147,7 @@ struct vfsmount *nfs_d_automount(struct path *path)
 	struct nfs_fs_context *ctx;
 	struct fs_context *fc;
 	struct vfsmount *mnt = ERR_PTR(-ENOMEM);
-	struct nfs_server *server = NFS_SERVER(d_inode(path->dentry));
+	struct nfs_server *server = NFS_SB(path->dentry->d_sb);
 	struct nfs_client *client = server->nfs_client;
 	int timeout = READ_ONCE(nfs_mountpoint_expiry_timeout);
 	int ret;
-- 
2.38.1

