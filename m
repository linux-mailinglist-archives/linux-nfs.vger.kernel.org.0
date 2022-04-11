Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76044FC6E0
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Apr 2022 23:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344791AbiDKVmz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Apr 2022 17:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350070AbiDKVmx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Apr 2022 17:42:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7EE338AB
        for <linux-nfs@vger.kernel.org>; Mon, 11 Apr 2022 14:40:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED24FB815C8
        for <linux-nfs@vger.kernel.org>; Mon, 11 Apr 2022 21:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2B8C385A9;
        Mon, 11 Apr 2022 21:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649713235;
        bh=Q0sQqucLrEsfxJiDJRj0jf8k0wqNqcX5dWyoVIv+DIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HsXUkcYuUgsP1jlK+RBMJ+l2CDqWtXiQ6sINn7yCycmpquiBYAS2V9xsOVnN8ySpk
         Y5js3q4szaVZbi8m+bezc6zI1hoYQtGp1GpTDYi0RkMC6T0P69f0PNSeTp4YIV6V6y
         5/efoCT8QHDV60Dn72PMqEFmKALNvTQ+cyfo6GrDMWt8XIcHoWoogiAOzF6DomneKw
         5yYym2Ax31bNiz6OPOk6DP8V/Sme7A/nsPBKdYN0mOAAZYAS9plmWQ+GEhUKlP4yYu
         UGk8cRb575n3UFniAGpYDw4y+Wq5JX9VIKuuJH+OoEiRbNMSa96PAOArMWcab0UkAL
         J/MhzH4WXdXKQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     ChenXiaoSong <chenxiaosong2@huawei.com>,
        Scott Mayhew <smayhew@redhat.com>
Subject: [PATCH v2 2/5] NFS: fsync() should report filesystem errors over EINTR/ERESTARTSYS
Date:   Mon, 11 Apr 2022 17:33:43 -0400
Message-Id: <20220411213346.762302-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411213346.762302-2-trondmy@kernel.org>
References: <20220411213346.762302-1-trondmy@kernel.org>
 <20220411213346.762302-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the commit to disk is interrupted, we should still first check for
filesystem errors so that we can report them in preference to the error
due to the signal.

Fixes: 2197e9b06c22 ("NFS: Fix up fsync() when the server rebooted")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 81c80548a5c6..95e1236d95c5 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -204,15 +204,16 @@ static int
 nfs_file_fsync_commit(struct file *file, int datasync)
 {
 	struct inode *inode = file_inode(file);
-	int ret;
+	int ret, ret2;
 
 	dprintk("NFS: fsync file(%pD2) datasync %d\n", file, datasync);
 
 	nfs_inc_stats(inode, NFSIOS_VFSFSYNC);
 	ret = nfs_commit_inode(inode, FLUSH_SYNC);
-	if (ret < 0)
-		return ret;
-	return file_check_and_advance_wb_err(file);
+	ret2 = file_check_and_advance_wb_err(file);
+	if (ret2 < 0)
+		return ret2;
+	return ret;
 }
 
 int
-- 
2.35.1

