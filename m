Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BC87804BA
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 05:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357691AbjHRDdM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 23:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357765AbjHRDdB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 23:33:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A932711
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 20:32:28 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRnPW65DfztS3t;
        Fri, 18 Aug 2023 11:27:43 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 11:31:22 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>
CC:     <linux-nfs@vger.kernel.org>
Subject: [PATCH -next] NFS: Move common includes outside ifdef
Date:   Fri, 18 Aug 2023 11:31:02 +0800
Message-ID: <20230818033102.7756-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

module.h, clnt.h, addr.h and dns_resolve.h is always included whether
CONFIG_NFS_USE_KERNEL_DNS is set or not and their order does not seems
to matter.

Move them outside the ifdef to simplify code and avoid checkincludes
message.

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 fs/nfs/dns_resolve.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/dns_resolve.c b/fs/nfs/dns_resolve.c
index 6603b5cee029..714975e5c0db 100644
--- a/fs/nfs/dns_resolve.c
+++ b/fs/nfs/dns_resolve.c
@@ -7,14 +7,16 @@
  * Resolves DNS hostnames into valid ip addresses
  */
 
-#ifdef CONFIG_NFS_USE_KERNEL_DNS
-
 #include <linux/module.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/addr.h>
-#include <linux/dns_resolver.h>
+
 #include "dns_resolve.h"
 
+#ifdef CONFIG_NFS_USE_KERNEL_DNS
+
+#include <linux/dns_resolver.h>
+
 ssize_t nfs_dns_resolve_name(struct net *net, char *name, size_t namelen,
 		struct sockaddr_storage *ss, size_t salen)
 {
@@ -35,7 +37,6 @@ ssize_t nfs_dns_resolve_name(struct net *net, char *name, size_t namelen,
 
 #else
 
-#include <linux/module.h>
 #include <linux/hash.h>
 #include <linux/string.h>
 #include <linux/kmod.h>
@@ -43,15 +44,12 @@ ssize_t nfs_dns_resolve_name(struct net *net, char *name, size_t namelen,
 #include <linux/socket.h>
 #include <linux/seq_file.h>
 #include <linux/inet.h>
-#include <linux/sunrpc/clnt.h>
-#include <linux/sunrpc/addr.h>
 #include <linux/sunrpc/cache.h>
 #include <linux/sunrpc/svcauth.h>
 #include <linux/sunrpc/rpc_pipe_fs.h>
 #include <linux/nfs_fs.h>
 
 #include "nfs4_fs.h"
-#include "dns_resolve.h"
 #include "cache_lib.h"
 #include "netns.h"
 
-- 
2.17.1

