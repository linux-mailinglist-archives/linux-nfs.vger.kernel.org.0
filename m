Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716984B9FED
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Feb 2022 13:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbiBQMRC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Feb 2022 07:17:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbiBQMQ4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Feb 2022 07:16:56 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7C37E097
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 04:16:42 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jzv1107j9zbkYx
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 20:15:33 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 20:16:40 +0800
Received: from huawei.com (10.175.101.6) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Feb
 2022 20:16:39 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     <linux-nfs@vger.kernel.org>
CC:     Zhiqiang Liu <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        "Wenchao Hao" <haowenchao@huawei.com>,
        <yanglongkang@h-partners.com>
Subject: [PATCH] idmapd: Fix error status when nfs-idmapd exits
Date:   Thu, 17 Feb 2022 20:27:32 -0500
Message-ID: <20220218012732.1549586-1-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs-idmapd.service would report following error when stopped:

Feb 17 07:32:05 fedora systemd[1]: Starting NFSv4 ID-name mapping service...
Feb 17 07:32:05 fedora rpc.idmapd[1198]: Setting log level to 0
Feb 17 07:32:05 fedora systemd[1]: Started NFSv4 ID-name mapping service.
Feb 17 07:32:11 fedora rpc.idmapd[1198]: exiting on signal 15
Feb 17 07:32:11 fedora systemd[1]: Stopping NFSv4 ID-name mapping service...
Feb 17 07:32:11 fedora systemd[1]: nfs-idmapd.service: Main process exited, code=exited, status=1/FAILURE
Feb 17 07:32:11 fedora systemd[1]: nfs-idmapd.service: Failed with result 'exit-code'.
Feb 17 07:32:11 fedora systemd[1]: Stopped NFSv4 ID-name mapping service.

commit 93e8f092(idmapd: Add graceful exit and resource cleanup)
redirected SIGTERM, so when executing "systemctl stop nfs-idmapd", the
main() of idmapd would running to tail to return, while it returned 1
which considered as error by systemd.

So here just return 0 in main().

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
---
 utils/idmapd/idmapd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/idmapd/idmapd.c b/utils/idmapd/idmapd.c
index e2c160e8..e79c124d 100644
--- a/utils/idmapd/idmapd.c
+++ b/utils/idmapd/idmapd.c
@@ -474,7 +474,7 @@ main(int argc, char **argv)
 		event_free(svrdirev);
 	event_base_free(evbase);
 
-	return 1;
+	return 0;
 }
 
 static void
-- 
2.32.0

