Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572F452F7FA
	for <lists+linux-nfs@lfdr.de>; Sat, 21 May 2022 05:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352996AbiEUDYQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 May 2022 23:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiEUDYP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 May 2022 23:24:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C80D187D8F
        for <linux-nfs@vger.kernel.org>; Fri, 20 May 2022 20:24:14 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L4pnM2rp5zgY7f;
        Sat, 21 May 2022 11:22:47 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 11:24:12 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <zhangxiaoxu5@huawei.com>, <bfields@fieldses.org>,
        <chuck.lever@oracle.com>, <linux-nfs@vger.kernel.org>,
        <yi.zhang@huawei.com>, <luomeng12@huawei.com>, <dai.ngo@oracle.com>
Subject: [v2 1/2] nfsd: Unregister the cld notifier when laundry_wq create failed
Date:   Sat, 21 May 2022 12:08:44 +0800
Message-ID: <20220521040845.619409-2-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521040845.619409-1-zhangxiaoxu5@huawei.com>
References: <20220521040845.619409-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If laundry_wq create failed, the cld notifier should be unregistered.

Fixes: d76cc46b37e1 ("NFSD: move create/destroy of laundry_wq to init_nfsd and exit_nfsd")
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/nfsd/nfsctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 322a208878f2..55949e60897d 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1543,12 +1543,14 @@ static int __init init_nfsd(void)
 		goto out_free_filesystem;
 	retval = register_cld_notifier();
 	if (retval)
-		goto out_free_all;
+		goto out_free_subsys;
 	retval = nfsd4_create_laundry_wq();
 	if (retval)
 		goto out_free_all;
 	return 0;
 out_free_all:
+	unregister_cld_notifier();
+out_free_subsys:
 	unregister_pernet_subsys(&nfsd_net_ops);
 out_free_filesystem:
 	unregister_filesystem(&nfsd_fs_type);
-- 
2.31.1

