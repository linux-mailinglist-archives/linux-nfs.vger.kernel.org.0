Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490A8625684
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 10:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiKKJVt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 04:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiKKJVs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 04:21:48 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A56E26576;
        Fri, 11 Nov 2022 01:21:47 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7tVl1F8DzHvnM;
        Fri, 11 Nov 2022 17:21:19 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 17:21:45 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <chuck.lever@oracle.com>, <jlayton@kernel.org>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] NFSD: Use struct_size() helpler in alloc_session()
Date:   Fri, 11 Nov 2022 17:18:35 +0800
Message-ID: <20221111091835.151942-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use struct_size() helper to simplify the code, no functional changes.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 fs/nfsd/nfs4state.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2ec981fd2985..97badca3135e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1833,13 +1833,12 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	int numslots = fattrs->maxreqs;
 	int slotsize = slot_bytes(fattrs);
 	struct nfsd4_session *new;
-	int mem, i;
+	int i;
 
-	BUILD_BUG_ON(NFSD_MAX_SLOTS_PER_SESSION * sizeof(struct nfsd4_slot *)
-			+ sizeof(struct nfsd4_session) > PAGE_SIZE);
-	mem = numslots * sizeof(struct nfsd4_slot *);
+	BUILD_BUG_ON(struct_size(new, se_slots, NFSD_MAX_SLOTS_PER_SESSION)
+		     > PAGE_SIZE);
 
-	new = kzalloc(sizeof(*new) + mem, GFP_KERNEL);
+	new = kzalloc(struct_size(new, se_slots, numslots), GFP_KERNEL);
 	if (!new)
 		return NULL;
 	/* allocate each struct nfsd4_slot and data cache in one piece */
-- 
2.17.1

