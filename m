Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7625E72FC
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Sep 2022 06:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiIWEfa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Sep 2022 00:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIWEf2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Sep 2022 00:35:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC0811E0FC;
        Thu, 22 Sep 2022 21:35:27 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYfQC0jzKzpSyJ;
        Fri, 23 Sep 2022 12:32:35 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 12:35:25 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 12:35:24 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH v2 2/2] NFSv4: check FMODE_EXEC from open context mode in nfs4_opendata_access()
Date:   Fri, 23 Sep 2022 13:36:05 +0800
Message-ID: <20220923053605.2723395-3-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220923053605.2723395-1-chenxiaosong2@huawei.com>
References: <20220923053605.2723395-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After converting file f_flags to open context mode by flags_to_mode(), open
context mode will have FMODE_EXEC when file open for exec, so we check
FMODE_EXEC from open context mode.

No functional change, just simplify the code.

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/nfs/nfs4proc.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3ed14a2a84a4..806d243f66e8 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2624,8 +2624,7 @@ static int _nfs4_recover_proc_open(struct nfs4_opendata *data)
  */
 static int nfs4_opendata_access(const struct cred *cred,
 				struct nfs4_opendata *opendata,
-				struct nfs4_state *state, fmode_t fmode,
-				int openflags)
+				struct nfs4_state *state, fmode_t fmode)
 {
 	struct nfs_access_entry cache;
 	u32 mask, flags;
@@ -2636,11 +2635,7 @@ static int nfs4_opendata_access(const struct cred *cred,
 		return 0;
 
 	mask = 0;
-	/*
-	 * Use openflags to check for exec, because fmode won't
-	 * always have FMODE_EXEC set when file open for exec.
-	 */
-	if (openflags & __FMODE_EXEC) {
+	if (fmode & FMODE_EXEC) {
 		/* ONLY check for exec rights */
 		if (S_ISDIR(state->inode->i_mode))
 			mask = NFS4_ACCESS_LOOKUP;
@@ -3023,7 +3018,7 @@ static unsigned nfs4_exclusive_attrset(struct nfs4_opendata *opendata,
 }
 
 static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
-		int flags, struct nfs_open_context *ctx)
+		struct nfs_open_context *ctx)
 {
 	struct nfs4_state_owner *sp = opendata->owner;
 	struct nfs_server *server = sp->so_server;
@@ -3084,8 +3079,7 @@ static int _nfs4_open_and_get_state(struct nfs4_opendata *opendata,
 	/* Parse layoutget results before we check for access */
 	pnfs_parse_lgopen(state->inode, opendata->lgp, ctx);
 
-	ret = nfs4_opendata_access(sp->so_cred, opendata, state,
-			acc_mode, flags);
+	ret = nfs4_opendata_access(sp->so_cred, opendata, state, acc_mode);
 	if (ret != 0)
 		goto out;
 
@@ -3159,7 +3153,7 @@ static int _nfs4_do_open(struct inode *dir,
 	if (d_really_is_positive(dentry))
 		opendata->state = nfs4_get_open_state(d_inode(dentry), sp);
 
-	status = _nfs4_open_and_get_state(opendata, flags, ctx);
+	status = _nfs4_open_and_get_state(opendata, ctx);
 	if (status != 0)
 		goto err_opendata_put;
 	state = ctx->state;
-- 
2.31.1

