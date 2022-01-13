Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1FB48DBA9
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jan 2022 17:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbiAMQZL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jan 2022 11:25:11 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:42176 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229533AbiAMQZL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jan 2022 11:25:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V1kwlhb_1642091102;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V1kwlhb_1642091102)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Jan 2022 00:25:09 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     trond.myklebust@hammerspace.com
Cc:     anna.schumaker@netapp.com, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] NFSv4: make nfs4_discover_trunking static
Date:   Fri, 14 Jan 2022 00:25:00 +0800
Message-Id: <20220113162500.8386-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This symbol is not used outside of nfs4proc.c, so marks it
static.

Fixes the following sparse warning:

fs/nfs/nfs4proc.c:4062:5: warning: no previous prototype for
‘nfs4_discover_trunking’ [-Wmissing-prototypes].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e6b49d6318bc..644ba8a02960 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4059,7 +4059,7 @@ static int _nfs4_discover_trunking(struct nfs_server *server,
 	return status;
 }
 
-int nfs4_discover_trunking(struct nfs_server *server, struct nfs_fh *fhandle)
+static int nfs4_discover_trunking(struct nfs_server *server, struct nfs_fh *fhandle)
 {
 	struct nfs4_exception exception = {
 		.interruptible = true,
-- 
2.20.1.7.g153144c

