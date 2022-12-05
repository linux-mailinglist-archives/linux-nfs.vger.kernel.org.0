Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD88F6425A0
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Dec 2022 10:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiLEJTx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Dec 2022 04:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiLEJTf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Dec 2022 04:19:35 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB34612D32;
        Mon,  5 Dec 2022 01:19:31 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NQdKZ1c5Sz4xVng;
        Mon,  5 Dec 2022 17:19:30 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B59JEZ4022117;
        Mon, 5 Dec 2022 17:19:14 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 5 Dec 2022 17:19:16 +0800 (CST)
Date:   Mon, 5 Dec 2022 17:19:16 +0800 (CST)
X-Zmail-TransId: 2af9638db79465f1e0a1
X-Mailer: Zmail v1.0
Message-ID: <202212051719169589575@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <trond.myklebust@hammerspace.com>
Cc:     <anna@kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBmczogbmZzOiBzeXNmczogdXNlIHN5c2ZzX2VtaXQoKSB0byBpbnN0ZWFkIG9mIHNjbnByaW50Zigp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B59JEZ4022117
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 638DB7A2.000 by FangMail milter!
X-FangMail-Envelope: 1670231970/4NQdKZ1c5Sz4xVng/638DB7A2.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638DB7A2.000/4NQdKZ1c5Sz4xVng
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 fs/nfs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 67a87800b3a9..0cbcd2dfa732 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -82,7 +82,7 @@ static ssize_t nfs_netns_identifier_show(struct kobject *kobj,
 	ssize_t ret;

 	rcu_read_lock();
-	ret = scnprintf(buf, PAGE_SIZE, "%s\n", rcu_dereference(c->identifier));
+	ret = sysfs_emit(buf, "%s\n", rcu_dereference(c->identifier));
 	rcu_read_unlock();
 	return ret;
 }
-- 
2.25.1
