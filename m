Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DD168FDEA
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Feb 2023 04:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjBIDZh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Feb 2023 22:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjBIDZF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Feb 2023 22:25:05 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57291527A;
        Wed,  8 Feb 2023 19:24:43 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VbEHOSS_1675913074;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VbEHOSS_1675913074)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 11:24:40 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] NFS: Remove duplicate include
Date:   Thu,  9 Feb 2023 11:24:32 +0800
Message-Id: <20230209032432.48440-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

./fs/nfs/dns_resolve.c: linux/module.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4009
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/nfs/dns_resolve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dns_resolve.c b/fs/nfs/dns_resolve.c
index 6603b5cee029..320441f10c01 100644
--- a/fs/nfs/dns_resolve.c
+++ b/fs/nfs/dns_resolve.c
@@ -7,9 +7,10 @@
  * Resolves DNS hostnames into valid ip addresses
  */
 
+#include <linux/module.h>
+
 #ifdef CONFIG_NFS_USE_KERNEL_DNS
 
-#include <linux/module.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/dns_resolver.h>
@@ -35,7 +36,6 @@ ssize_t nfs_dns_resolve_name(struct net *net, char *name, size_t namelen,
 
 #else
 
-#include <linux/module.h>
 #include <linux/hash.h>
 #include <linux/string.h>
 #include <linux/kmod.h>
-- 
2.20.1.7.g153144c

