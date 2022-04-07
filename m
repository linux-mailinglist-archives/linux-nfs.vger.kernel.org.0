Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169BF4F83EA
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 17:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345188AbiDGPq5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 11:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345131AbiDGPqh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 11:46:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C872AC6EEB
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 08:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5DA761ECD
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 15:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9BAC385A5
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 15:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649346273;
        bh=w8nqzRSE2X/ijqhm1W+uvklvYb3WU3hFSLvEYTI4jWg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PlTY2Bc6kMhji+YCNY1zbyjEA9KYR4/0m7gKdJpVQkdKM69s4wLHQlCvlRdofLsDf
         Fk7kKqpAEFuW0C1mnDUhBA2W7oXtwSkb8KmfGz1Pwh1QxjOOWxcVMg8fL8gjcb8Hms
         szVyHCJAVhyxiQrLr1aeGJY3M2dbOhPZxrOicuO7FRXV04lErIj2aNIo3BsK/w1ZrF
         iEPz5hXkf4YC5dl1XZOa9tv9h5JlO8NavxH3uEp2srkXcOEqbd0pfPYQyqJzyvsglb
         81fSGl+JbkPDJ/+YRxlN2DXsDPyf/9TAfMwkyosWM7H+LWU2u64Fh/PGDpWgUGOzbu
         C/xz/JeVzAodw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/7] NFS: Ensure rpc_run_task() cannot fail in nfs_async_rename()
Date:   Thu,  7 Apr 2022 11:38:07 -0400
Message-Id: <20220407153809.1053261-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407153809.1053261-4-trondmy@kernel.org>
References: <20220407153809.1053261-1-trondmy@kernel.org>
 <20220407153809.1053261-2-trondmy@kernel.org>
 <20220407153809.1053261-3-trondmy@kernel.org>
 <20220407153809.1053261-4-trondmy@kernel.org>
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

