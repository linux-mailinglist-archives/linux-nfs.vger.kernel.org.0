Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192AC26D112
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Sep 2020 04:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgIQCYW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 22:24:22 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:64313 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQCYV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Sep 2020 22:24:21 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 22:24:21 EDT
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.227])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 157C14E16DF;
        Thu, 17 Sep 2020 10:19:09 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] nfs: fix spellint typo in pnfs.c
Date:   Thu, 17 Sep 2020 10:19:00 +0800
Message-Id: <1600309143-5483-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZT0lIS0JPS09PGEkaVkpNS0tIS0JKT0JITE1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBw6Iio*NT8pDhQaFw0jHywf
        GiJPCwJVSlVKTUtLSEtCSk9CQk9DVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTFlXWQgBWUFKSE9INwY+
X-HM-Tid: 0a7499dbbe489376kuws157c14e16df
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Change the comment typo: "manger" -> "manager".

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 fs/nfs/pnfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 71f7741..0e50b9d
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -902,7 +902,7 @@ pnfs_destroy_layouts_byclid(struct nfs_client *clp,
 }
 
 /*
- * Called by the state manger to remove all layouts established under an
+ * Called by the state manager to remove all layouts established under an
  * expired lease.
  */
 void
-- 
2.7.4

