Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2317B5A9950
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 15:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbiIANo5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 09:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbiIANod (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 09:44:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1271F5F20E
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 06:44:11 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MJMcq0xK9zlWL4;
        Thu,  1 Sep 2022 21:40:43 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 21:44:09 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 21:44:08 +0800
Message-ID: <ae07856f-ef34-270e-91b2-9364fdcd6563@huawei.com>
Date:   Thu, 1 Sep 2022 21:44:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To:     <steved@redhat.com>
CC:     <linux-nfs@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH] nfs-blkmapd: Fix the error status when nfs-blkmapd stops
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100006.china.huawei.com (7.185.36.169) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The systemctl stop nfs-blkmap.service will sends the SIGTERM signal
to the nfs-blkmap.service first.If the process fails to be stopped,
it sends the SIGKILL signal again to kill the process.
However, exit(1) is executed in the SIGTERM processing function of
nfs-blkmap.service. As a result, systemd receives an error message
indicating that nfs-blkmap.service failed.
"Active: failed" is displayed when the systemctl status
nfs-blkmap.service command is executed.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
---
  utils/blkmapd/device-discovery.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/blkmapd/device-discovery.c 
b/utils/blkmapd/device-discovery.c
index 2736ac89..49935c2e 100644
--- a/utils/blkmapd/device-discovery.c
+++ b/utils/blkmapd/device-discovery.c
@@ -462,7 +462,7 @@ static void sig_die(int signal)
  		unlink(PID_FILE);
  	}
  	BL_LOG_ERR("exit on signal(%d)\n", signal);
-	exit(1);
+	exit(0);
  }
  static void usage(void)
  {
-- 
2.33.0

