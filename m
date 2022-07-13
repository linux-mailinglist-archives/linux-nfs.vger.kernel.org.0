Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BC9573F77
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jul 2022 00:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiGMWNj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 18:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGMWNi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 18:13:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADB413C
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 15:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03EE660C96
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 22:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F381C34114
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 22:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657750416;
        bh=SvgT7qDjm6HAl5vBx8gVNZhnOY1BOFDokIlw83yI1zM=;
        h=From:To:Subject:Date:From;
        b=mPX96Mfz1k2CtdHI9fU5yLpBqDUcq8s8Cw1LWOGCOx4ZOwHWaZIA0vOYqYYNRkgCF
         Nl498c5GBOBlxz3+Akmtk8AbMdhgy+BpgR6uiqKGIT7lQHOkxOOSISgyVzGlFWgX+Y
         azUYSS9QQnFc6Cybj4/Qqis8nfs2uk3S9HIdxajJg+fDRfflvljJSSZmtY85oDy6ZW
         gxQqA3tmIED0ZHgq0GgF4JgDXrRiO3NyB2MBN1iOV+/aldPFKnNJNCcuceK3FTVJv8
         adLGkQm7bWJxA2kdDpQty1qak0y/JXLkA9v+IB/Jg/eSOdF6gons003AdA2NW9iLaK
         0QWlEinFxtu1w==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Fix case insensitive renames
Date:   Wed, 13 Jul 2022 18:06:49 -0400
Message-Id: <20220713220649.1038411-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

For filesystems that are case insensitive and case preserving, we need
to be able to rename from one case folded variant of the filename to
another.
Currently, if we have looked up the target filename before the call to
rename, then we may have a hashed dentry with that target name in the
dcache, causing the vfs to optimise away the rename.
To avoid that, let's drop the target dentry, and leave it to the server
to optimise away the rename if that is the correct thing to do.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 0c4e8dd6aa96..d9d277d7fa84 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1739,6 +1739,10 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 		goto out_bad;
 	}
 
+	if ((flags & LOOKUP_RENAME_TARGET) && d_count(dentry) < 2 &&
+	    nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE))
+		goto out_bad;
+
 	if (nfs_verifier_is_delegated(dentry))
 		return nfs_lookup_revalidate_delegated(dir, dentry, inode);
 
-- 
2.36.1

