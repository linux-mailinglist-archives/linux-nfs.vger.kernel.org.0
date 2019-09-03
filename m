Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39808A6106
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Sep 2019 08:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfICGHz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Sep 2019 02:07:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbfICGHz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Sep 2019 02:07:55 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 319848146146BA4DE1DF;
        Tue,  3 Sep 2019 14:07:52 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 3 Sep 2019 14:07:41 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>
CC:     <zhongjiang@huawei.com>, <linux-nfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] NFS: remove the redundant check when kfree an object in nfs_netns_client_release
Date:   Tue, 3 Sep 2019 14:04:48 +0800
Message-ID: <1567490688-17872-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

kfree has taken the null check in account. hence it is unnecessary to add the
null check before kfree the object. Just remove it.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 fs/nfs/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 4f3390b..c489496 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -121,8 +121,7 @@ static void nfs_netns_client_release(struct kobject *kobj)
 			struct nfs_netns_client,
 			kobject);
 
-	if (c->identifier)
-		kfree(c->identifier);
+	kfree(c->identifier);
 	kfree(c);
 }
 
-- 
1.7.12.4

