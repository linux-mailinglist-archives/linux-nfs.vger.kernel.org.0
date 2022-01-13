Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B2A48D925
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jan 2022 14:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiAMNiM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jan 2022 08:38:12 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31158 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbiAMNiH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jan 2022 08:38:07 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JZQRB6kfVz8wN3;
        Thu, 13 Jan 2022 21:35:18 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 21:38:02 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 13 Jan
 2022 21:38:02 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-nfs@vger.kernel.org>
CC:     <anna.schumaker@netapp.com>, <trond.myklebust@hammerspace.com>
Subject: [PATCH -next] NFSv4.1 Use kmemdup_nul() helper
Date:   Thu, 13 Jan 2022 21:43:17 +0800
Message-ID: <20220113134317.3130643-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use kmemdup_nul() helper instead of open-coding to
simplify the code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 fs/nfs/nfs4proc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e6b49d6318bc..60fcd98b40a6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4004,11 +4004,10 @@ static void test_fs_location_for_trunking(struct nfs4_fs_location *location,
 			return;
 		xprt_args.dstaddr = &addr;
 		xprt_args.addrlen = addrlen;
-		servername = kmalloc(srv_loc->len + 1, GFP_KERNEL);
+		servername = kmemdup_nul(srv_loc->data, srv_loc->len,
+					 GFP_KERNEL);
 		if (!servername)
 			return;
-		memcpy(servername, srv_loc->data, srv_loc->len);
-		servername[srv_loc->len] = '\0';
 		xprt_args.servername = servername;
 
 		xprtdata.cred = nfs4_get_clid_cred(clp);
-- 
2.25.1

