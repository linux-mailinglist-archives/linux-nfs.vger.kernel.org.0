Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3633647C21
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Dec 2022 03:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiLICSb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Dec 2022 21:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLICSa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Dec 2022 21:18:30 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2C2284;
        Thu,  8 Dec 2022 18:18:29 -0800 (PST)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NSvjv3HnJz6HJG9;
        Fri,  9 Dec 2022 10:14:59 +0800 (CST)
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 02:18:26 +0000
From:   Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To:     <trond.myklebust@hammerspace.com>
CC:     <anna@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-nfs@vger.kernel.org>, <yusongping@huawei.com>,
        <hukeping@huawei.com>, <artem.kuzin@huawei.com>
Subject: [PATCH] fs: NFSv4.1: Fix memory leakage
Date:   Fri, 9 Dec 2022 10:18:23 +0800
Message-ID: <20221209021823.1232874-1-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.66.134]
X-ClientProxiedBy: mscpeml100002.china.huawei.com (7.188.26.75) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This commit fixes potential memory leakage of 'calldata' memory chunk
in _nfs41_proc_sequence() function.

Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
---
 fs/nfs/nfs4proc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 86ed5c0142c3..b7aa66167341 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9416,8 +9416,10 @@ static struct rpc_task *_nfs41_proc_sequence(struct nfs_client *clp,
 	task_setup_data.callback_data = calldata;
 
 	ret = rpc_run_task(&task_setup_data);
-	if (IS_ERR(ret))
+	if (IS_ERR(ret)) {
+		kfree(calldata);
 		goto out_err;
+	}
 	return ret;
 out_put_clp:
 	nfs_put_client(clp);
-- 
2.25.1

