Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097A75823EF
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 12:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiG0KOf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 06:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiG0KOG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 06:14:06 -0400
X-Greylist: delayed 588 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Jul 2022 03:14:04 PDT
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C60B1277B;
        Wed, 27 Jul 2022 03:14:04 -0700 (PDT)
Received: from mxde.zte.com.cn (unknown [10.35.8.63])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4Lt8Wf6X0KzvLC;
        Wed, 27 Jul 2022 18:04:14 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4Lt8WN3JS5zCVKg3;
        Wed, 27 Jul 2022 18:04:00 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4Lt8WJ6mXSzdmXX7;
        Wed, 27 Jul 2022 18:03:56 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Lt8WF1LG4z8R047;
        Wed, 27 Jul 2022 18:03:53 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
        by mse-fl1.zte.com.cn with SMTP id 26RA3VN4074081;
        Wed, 27 Jul 2022 18:03:31 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-cloudhost8.zte.com.cn (unknown [10.234.72.110])
        by smtp (Zmail) with SMTP;
        Wed, 27 Jul 2022 18:03:32 +0800
X-Zmail-TransId: 3e8162e10d73022-19baa
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        Zhang Xianwei <zhang.xianwei8@zte.com.cn>
Subject: [PATCH] NFSv4.1: RECLAIM_COMPLETE must handle EACCES
Date:   Wed, 27 Jul 2022 18:01:07 +0800
Message-Id: <20220727100107.3062-1-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 2.33.0.rc0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 26RA3VN4074081
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 62E10D9D.000 by FangMail milter!
X-FangMail-Envelope: 1658916255/4Lt8Wf6X0KzvLC/62E10D9D.000/10.35.8.63/[10.35.8.63]/mxde.zte.com.cn/<wang.yi59@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 62E10D9D.000/4Lt8Wf6X0KzvLC
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Zhang Xianwei <zhang.xianwei8@zte.com.cn>

A client should be able to handle getting an EACCES error while doing
a mount operation to reclaim state due to NFS4CLNT_RECLAIM_REBOOT
being set. If the server returns RPC_AUTH_BADCRED because authentication
failed when we execute "exportfs -au", then RECLAIM_COMPLETE will go a
wrong way. After mount succeeds, all OPEN call will fail due to an
NFS4ERR_GRACE error being returned. This patch is to fix it by resending
a RPC request.

Signed-off-by: Zhang Xianwei <zhang.xianwei8@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 fs/nfs/nfs4proc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index bb0e84a46d61..b51b83506011 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9477,6 +9477,9 @@ static int nfs41_reclaim_complete_handle_errors(struct rpc_task *task, struct nf
 		rpc_delay(task, NFS4_POLL_RETRY_MAX);
 		fallthrough;
 	case -NFS4ERR_RETRY_UNCACHED_REP:
+	case -EACCES:
+		dprintk("%s: failed to reclaim complete error %d for server %s, retrying\n",
+			__func__, task->tk_status, clp->cl_hostname);
 		return -EAGAIN;
 	case -NFS4ERR_BADSESSION:
 	case -NFS4ERR_DEADSESSION:
-- 
2.18.4
