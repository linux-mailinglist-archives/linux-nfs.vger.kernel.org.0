Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCCDAFEB0B
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2019 08:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfKPHAX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Nov 2019 02:00:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbfKPHAW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Nov 2019 02:00:22 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 723AFBAB6E498210B564;
        Sat, 16 Nov 2019 15:00:19 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Sat, 16 Nov 2019 15:00:12 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] NFS: remove redundant null pointer check before kfree
Date:   Sat, 16 Nov 2019 15:07:33 +0800
Message-ID: <1573888053-2358-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

kfree has taken null pointer check into account. so it is safe
to remove the unnecessary check.

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
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
2.7.4

