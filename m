Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4C64F876A
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 20:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347003AbiDGSy2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 14:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347005AbiDGSy2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 14:54:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C24194FD8
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 11:52:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F69761DD8
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 18:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2999C385A4
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 18:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649357546;
        bh=Zscj20Ax5HbRGyhailQq0xwvJA8LRNJg/hclC6BAr+w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=prNq6Kyp0nk5e60FaFI1VU79hobISgr+5ob4JKrWBytBpFTCEmRsNlT0woKIUbKzy
         n74s82AdoshbMlWiGMGo8/CeLtLy0QXzE+aT30UttDBkshz6FqghqOQOlBQoY5TFnG
         GshykJa7l60Gl22PonFKEEVQBs1oZMQFQClhBxJxRAfS//eq3UDficZNzvAqo85PCN
         79Umqek+CwNtHOouOmKIq0w5IAsFALcU49ZuFcsrkYGZDRms7SoaOaQL7TKDeehXhI
         iEKy5OL88pw5UZDLDw9OhlhvXo2a4fPez03Sa8JmduwfzDZ/nQpkmqRapZ7iZAsDEM
         dMZzTAcIEiKsQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 5/8] NFS: Ensure rpc_run_task() cannot fail in nfs_async_rename()
Date:   Thu,  7 Apr 2022 14:45:58 -0400
Message-Id: <20220407184601.1064640-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407184601.1064640-4-trondmy@kernel.org>
References: <20220407184601.1064640-1-trondmy@kernel.org>
 <20220407184601.1064640-2-trondmy@kernel.org>
 <20220407184601.1064640-3-trondmy@kernel.org>
 <20220407184601.1064640-4-trondmy@kernel.org>
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

Ensure the call to rpc_run_task() cannot fail by preallocating the
rpc_task.

Fixes: 910ad38697d9 ("NFS: Fix memory allocation in rpc_alloc_task()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/unlink.c         | 1 +
 include/linux/nfs_xdr.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 5fa11e1aca4c..6f325e10056c 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -347,6 +347,7 @@ nfs_async_rename(struct inode *old_dir, struct inode *new_dir,
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (data == NULL)
 		return ERR_PTR(-ENOMEM);
+	task_setup_data.task = &data->task;
 	task_setup_data.callback_data = data;
 
 	data->cred = get_current_cred();
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 49ba486aea5f..2863e5a69c6a 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1694,6 +1694,7 @@ struct nfs_unlinkdata {
 struct nfs_renamedata {
 	struct nfs_renameargs	args;
 	struct nfs_renameres	res;
+	struct rpc_task		task;
 	const struct cred	*cred;
 	struct inode		*old_dir;
 	struct dentry		*old_dentry;
-- 
2.35.1

