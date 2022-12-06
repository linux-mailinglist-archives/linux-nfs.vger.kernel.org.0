Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60378644C37
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Dec 2022 20:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiLFTJA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Dec 2022 14:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLFTJA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Dec 2022 14:09:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AF5FD3C
        for <linux-nfs@vger.kernel.org>; Tue,  6 Dec 2022 11:08:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA9F7B81AE1
        for <linux-nfs@vger.kernel.org>; Tue,  6 Dec 2022 19:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66843C433C1;
        Tue,  6 Dec 2022 19:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670353736;
        bh=0KctS+f4MN6WF+T+KGNsTg8VvBcAsFxhR9Y+Vrj3X50=;
        h=From:To:Cc:Subject:Date:From;
        b=XhG73Rn/C9GilrzuY8iEa84rlscRaPoR7l1fvAzF/utKfFnooFMURUTZdXpmjNcxO
         A6/LOXud3l/w51Ig5ih57JTgIKXEPOaQTkW9Xa9bJ21wfN1FIq/h6xiJlFRIvocpVa
         Q/KFtsoxbglzL/gVtGgKCF6jmFnybsK0TUW6yUxecegrCUMkx6oGPPK2o27/HTu3Tw
         9Phxa+H9CvM65C3JYsRT3rrnlvxVzGf7SDgg/SU2t/NUbXvuCxeG91rtKPJsLReg3d
         ctplAdnZKZmVRIxVqWh194aPvOM/6OKO5PU0ZmJ1pm04wmFvWjhyWn4vdYBk93wNnH
         6IOTj1be5nOAA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     ChenXiaoSong <chenxiaosong2@huawei.com>
Subject: [PATCH] NFSv4.x: Fail client initialisation if state manager thread can't run
Date:   Tue,  6 Dec 2022 14:02:49 -0500
Message-Id: <20221206190249.438037-1-trondmy@kernel.org>
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

If the state manager thread fails to start, then we should just mark the
client initialisation as failed so that other processes or threads don't
get stuck in nfs_wait_client_init_complete().

Reported-by: ChenXiaoSong <chenxiaosong2@huawei.com>
Fixes: 4697bd5e9419 ("NFSv4: Fix a race in the net namespace mount notification")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4state.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 7c1f43507813..5720196141e1 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1230,6 +1230,8 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 	if (IS_ERR(task)) {
 		printk(KERN_ERR "%s: kthread_run: %ld\n",
 			__func__, PTR_ERR(task));
+		if (!nfs_client_init_is_complete(clp))
+			nfs_mark_client_ready(clp, PTR_ERR(task));
 		nfs4_clear_state_manager_bit(clp);
 		clear_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state);
 		nfs_put_client(clp);
-- 
2.38.1

