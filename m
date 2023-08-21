Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A28278291F
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Aug 2023 14:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbjHUMbf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Aug 2023 08:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjHUMb3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Aug 2023 08:31:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37516FB
        for <linux-nfs@vger.kernel.org>; Mon, 21 Aug 2023 05:31:26 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RTsF94gLbztShX;
        Mon, 21 Aug 2023 20:27:41 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 20:31:23 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
        <kolga@netapp.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
        <trond.myklebust@hammerspace.com>, <anna@kernel.org>
CC:     <linux-nfs@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH -next] SUNRPC: Remove unused declarations
Date:   Mon, 21 Aug 2023 20:31:18 +0800
Message-ID: <20230821123118.50436-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit c7d7ec8f043e ("SUNRPC: Remove svc_shutdown_net()") removed svc_close_net()
implementation but left declaration in place. Remove it.
Commit 1f11a034cdc4 ("SUNRPC new transport for the NFSv4.1 shared back channel")
removed svc_sock_create() and svc_sock_create() implementations but not the declarations.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/sunrpc/svcsock.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index d4a173c5b3be..7c78ec6356b9 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -56,7 +56,6 @@ static inline u32 svc_sock_final_rec(struct svc_sock *svsk)
 /*
  * Function prototypes.
  */
-void		svc_close_net(struct svc_serv *, struct net *);
 void		svc_recv(struct svc_rqst *rqstp);
 void		svc_send(struct svc_rqst *rqstp);
 void		svc_drop(struct svc_rqst *);
@@ -66,8 +65,6 @@ int		svc_addsock(struct svc_serv *serv, struct net *net,
 			    const struct cred *cred);
 void		svc_init_xprt_sock(void);
 void		svc_cleanup_xprt_sock(void);
-struct svc_xprt *svc_sock_create(struct svc_serv *serv, int prot);
-void		svc_sock_destroy(struct svc_xprt *);
 
 /*
  * svc_makesock socket characteristics
-- 
2.34.1

