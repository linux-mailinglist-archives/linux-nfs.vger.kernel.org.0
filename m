Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8E2767F25
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jul 2023 14:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjG2Mcd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 29 Jul 2023 08:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG2Mcd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 29 Jul 2023 08:32:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209F32D71;
        Sat, 29 Jul 2023 05:32:32 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RCkPR2Nh9zVjf7;
        Sat, 29 Jul 2023 20:30:51 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 29 Jul
 2023 20:32:29 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
        <kolga@netapp.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
        <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] xprtrdma: Remove unused function declaration rpcrdma_bc_post_recv()
Date:   Sat, 29 Jul 2023 20:31:52 +0800
Message-ID: <20230729123152.35132-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

rpcrdma_bc_post_recv() is never implemented since introduction in
commit f531a5dbc451 ("xprtrdma: Pre-allocate backward rpc_rqst and send/receive buffers").

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/sunrpc/xprtrdma/xprt_rdma.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 5e5ff6784ef5..da409450dfc0 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -593,7 +593,6 @@ void xprt_rdma_cleanup(void);
 int xprt_rdma_bc_setup(struct rpc_xprt *, unsigned int);
 size_t xprt_rdma_bc_maxpayload(struct rpc_xprt *);
 unsigned int xprt_rdma_bc_max_slots(struct rpc_xprt *);
-int rpcrdma_bc_post_recv(struct rpcrdma_xprt *, unsigned int);
 void rpcrdma_bc_receive_call(struct rpcrdma_xprt *, struct rpcrdma_rep *);
 int xprt_rdma_bc_send_reply(struct rpc_rqst *rqst);
 void xprt_rdma_bc_free_rqst(struct rpc_rqst *);
-- 
2.34.1

