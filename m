Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02828776228
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Aug 2023 16:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjHIOOx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Aug 2023 10:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjHIOOw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Aug 2023 10:14:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EDC1FCC;
        Wed,  9 Aug 2023 07:14:50 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RLX8w3JBrz15NQq;
        Wed,  9 Aug 2023 22:13:36 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 22:14:47 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
        <kolga@netapp.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
        <yuehaibing@huawei.com>, <kuba@kernel.org>
CC:     <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH -next] SUNRPC: Remove unused declaration rpc_modcount()
Date:   Wed, 9 Aug 2023 22:14:26 +0800
Message-ID: <20230809141426.41192-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These declarations are never implemented since the beginning of git history.
Remove these, then merge the two #ifdef block for simplification.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/linux/sunrpc/stats.h | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/linux/sunrpc/stats.h b/include/linux/sunrpc/stats.h
index d94d4f410507..3ce1550d1beb 100644
--- a/include/linux/sunrpc/stats.h
+++ b/include/linux/sunrpc/stats.h
@@ -43,22 +43,6 @@ struct net;
 #ifdef CONFIG_PROC_FS
 int			rpc_proc_init(struct net *);
 void			rpc_proc_exit(struct net *);
-#else
-static inline int rpc_proc_init(struct net *net)
-{
-	return 0;
-}
-
-static inline void rpc_proc_exit(struct net *net)
-{
-}
-#endif
-
-#ifdef MODULE
-void			rpc_modcount(struct inode *, int);
-#endif
-
-#ifdef CONFIG_PROC_FS
 struct proc_dir_entry *	rpc_proc_register(struct net *,struct rpc_stat *);
 void			rpc_proc_unregister(struct net *,const char *);
 void			rpc_proc_zero(const struct rpc_program *);
@@ -69,7 +53,14 @@ void			svc_proc_unregister(struct net *, const char *);
 void			svc_seq_show(struct seq_file *,
 				     const struct svc_stat *);
 #else
+static inline int rpc_proc_init(struct net *net)
+{
+	return 0;
+}
 
+static inline void rpc_proc_exit(struct net *net)
+{
+}
 static inline struct proc_dir_entry *rpc_proc_register(struct net *net, struct rpc_stat *s) { return NULL; }
 static inline void rpc_proc_unregister(struct net *net, const char *p) {}
 static inline void rpc_proc_zero(const struct rpc_program *p) {}
-- 
2.34.1

