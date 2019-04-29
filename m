Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3BBDF6B
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2019 11:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfD2J2P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Apr 2019 05:28:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727325AbfD2J2P (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Apr 2019 05:28:15 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D98831F91F8ED0BC2DE7;
        Mon, 29 Apr 2019 17:28:12 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Mon, 29 Apr 2019 17:28:06 +0800
From:   ZhangXiaoxu <zhangxiaoxu5@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <bfields@fieldses.org>, <jlayton@kernel.org>,
        <davem@davemloft.net>, <linux-nfs@vger.kernel.org>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH] SUNRPC: task should be exit if encode return EKEYEXPIRED more times
Date:   Mon, 29 Apr 2019 17:32:31 +0800
Message-ID: <1556530351-81780-1-git-send-email-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the rpc.gssd always return cred success, but now the cred is
expired, then the task will loop in call_refresh and call_transmit.

Exit the rpc task after retry.

Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
---
 net/sunrpc/clnt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 8ff11dc..a32d3f1 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1793,7 +1793,14 @@ call_encode(struct rpc_task *task)
 			rpc_delay(task, HZ >> 4);
 			break;
 		case -EKEYEXPIRED:
-			task->tk_action = call_refresh;
+			if (!task->tk_cred_retry) {
+				rpc_exit(task, task->tk_status);
+			} else {
+				task->tk_action = call_refresh;
+				task->tk_cred_retry--;
+				dprintk("RPC: %5u %s: retry refresh creds\n",
+					task->tk_pid, __func__);
+			}
 			break;
 		default:
 			rpc_exit(task, task->tk_status);
-- 
2.7.4

