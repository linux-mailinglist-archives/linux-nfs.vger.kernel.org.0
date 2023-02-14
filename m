Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9826967F6
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 16:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjBNPYy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Feb 2023 10:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjBNPYq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 10:24:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E062B60B;
        Tue, 14 Feb 2023 07:24:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBA62B81BFA;
        Tue, 14 Feb 2023 15:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC0FC433EF;
        Tue, 14 Feb 2023 15:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676388275;
        bh=hHNCMMKRLHJy05248W2d4GXueax2ArtVMUz/DS2OwBg=;
        h=Subject:From:To:Cc:Date:From;
        b=sNgjTCAivxJNVxtja0NXdz8pVXMqA82EZ1P4KOSzgibVwKwNzPsPQZ1+RtDGREZuz
         9B4dWcj7FApYwVAngCp6uNlRjlrel11dAd5NfH1bo3AHvtkaHI8mcmyKMV3NZujm+J
         NMhffC2lBHKfMtJYJIqujR5vrB3fih/QR9441YgaDvcEAZvbXa5eWeIErh9/fBWdbw
         JHmUogSfh5AkAXF2PW1+ZUaIeV+nLQkqjZkUg7r2FhovkYdtWYgXvOJmNZQOTMofKV
         5wgJRlK7oHLgLXXNZmbTQkqyVJV0J86oEoK3xc3Q67nov6tSwQLor8nGdXnfJz4bJj
         q2jj7ECxpjh3A==
Subject: [PATCH] NFSD: Clean up nfsd_symlink()
From:   Chuck Lever <cel@kernel.org>
To:     colin.i.king@gmail.com, error27@gmail.com
Cc:     jlayton@redhat.com, linux-nfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Feb 2023 10:24:34 -0500
Message-ID: <167638827427.6570.12643671133126504826.stgit@bazille.1015granger.net>
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

The pointer dentry is assigned a value that is never read, the
assignment is redundant and can be removed.

Cleans up clang-scan warning:
fs/nfsd/nfsctl.c:1231:2: warning: Value stored to 'dentry' is
never read [deadcode.DeadStores]
       dentry = ERR_PTR(ret);

No need to initialize "int ret = -ENOMEM;" either.

These are vestiges of nfsd_mkdir(), from whence I copied
nfsd_symlink().

Reported-by: Colin Ian King <colin.i.king@gmail.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 04474b8ccf0a..7b8f17ee5224 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1214,22 +1214,17 @@ static void nfsd_symlink(struct dentry *parent, const char *name,
 {
 	struct inode *dir = parent->d_inode;
 	struct dentry *dentry;
-	int ret = -ENOMEM;
+	int ret;
 
 	inode_lock(dir);
 	dentry = d_alloc_name(parent, name);
 	if (!dentry)
-		goto out_err;
+		goto out;
 	ret = __nfsd_symlink(d_inode(parent), dentry, S_IFLNK | 0777, content);
 	if (ret)
-		goto out_err;
+		dput(dentry);
 out:
 	inode_unlock(dir);
-	return;
-out_err:
-	dput(dentry);
-	dentry = ERR_PTR(ret);
-	goto out;
 }
 #else
 static inline void nfsd_symlink(struct dentry *parent, const char *name,


