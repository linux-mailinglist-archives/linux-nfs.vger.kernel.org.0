Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123B3642589
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Dec 2022 10:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiLEJOd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Dec 2022 04:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiLEJNy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Dec 2022 04:13:54 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B79C1A;
        Mon,  5 Dec 2022 01:13:51 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NQdC16lNRz4y0vH;
        Mon,  5 Dec 2022 17:13:49 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B59DgsV013217;
        Mon, 5 Dec 2022 17:13:43 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 5 Dec 2022 17:13:45 +0800 (CST)
Date:   Mon, 5 Dec 2022 17:13:45 +0800 (CST)
X-Zmail-TransId: 2af9638db64962714073
X-Mailer: Zmail v1.0
Message-ID: <202212051713453189387@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <trond.myklebust@hammerspace.com>
Cc:     <anna@kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIE5GUzogdXNlIHN5c2ZzX2VtaXQoKSB0byBpbnN0ZWFkIG9mIHNjbnByaW50Zigp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B59DgsV013217
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 638DB64D.000 by FangMail milter!
X-FangMail-Envelope: 1670231629/4NQdC16lNRz4y0vH/638DB64D.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638DB64D.000/4NQdC16lNRz4y0vH
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
 fs/nfs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 88a23af2bd5c..b0ef7e7ddb30 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -354,7 +354,7 @@ static int param_get_nfs_timeout(char *buffer, const struct kernel_param *kp)
 			num = (num + (HZ - 1)) / HZ;
 	} else
 		num = -1;
-	return scnprintf(buffer, PAGE_SIZE, "%li\n", num);
+	return sysfs_emit(buffer, "%li\n", num);
 }

 static const struct kernel_param_ops param_ops_nfs_timeout = {
-- 
2.25.1
