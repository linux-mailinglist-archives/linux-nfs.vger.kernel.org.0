Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CD472C60C
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 15:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbjFLNeK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 09:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjFLNeJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 09:34:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C6F109;
        Mon, 12 Jun 2023 06:34:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9900F611CC;
        Mon, 12 Jun 2023 13:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530B3C433D2;
        Mon, 12 Jun 2023 13:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686576847;
        bh=CducP5IqvGJjjNpSYSzFQgS1ZXIbd1XVtQqmaXSf5+k=;
        h=From:To:Cc:Subject:Date:From;
        b=NfuuHD0hlIev++OR8YgKdYFsgVfHgLpZ+6YlIDIhHxrxkYWW6DzVOBTw4QZJpIvJX
         tHTh0u2rofzfb+4CbAfJm1bMP0JRliL28g6l+FjXn7//y2sVPGBHpHjpzD6R/6jckR
         osF62zNBDHGbLfzVqnPt7WNoj0IZaqFz44nyLGBKTTfSBLxyoZKJFs9D8yM34krDvD
         8ojlXgRBzPOIo9Y9PpHCfMGXYgcZ5VMaZVOldTtSsG9yaC7ukTPkWfb0NN7ef/MU0U
         JnaaKfU+Om+/g40todryJ5Cp1xqJ+mwvCM/bUxm9ug7N6oCw+MIlI+hTtE2fGRECtW
         rgFr3JZOUz6Ag==
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, NeilBrown <neilb@suse.de>
Cc:     stable@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nfs: don't report STATX_BTIME in ->getattr
Date:   Mon, 12 Jun 2023 09:34:04 -0400
Message-Id: <20230612133404.181166-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NFS doesn't properly support reporting the btime in getattr (yet), but
61a968b4f05e mistakenly added it to the request_mask. This causes statx
for STATX_BTIME to report a zeroed out btime instead of properly
clearing the flag.

Cc: stable@vger.kernel.org # v6.3+
Fixes: 61a968b4f05e ("nfs: report the inode version in getattr if requested")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index bc4cac08bb24..9b51ffd7281d 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -846,7 +846,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	request_mask &= STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
 			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
-			STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_BTIME |
+			STATX_INO | STATX_SIZE | STATX_BLOCKS |
 			STATX_CHANGE_COOKIE;
 
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
-- 
2.40.1

