Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705AF3512DC
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Apr 2021 11:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbhDAJ5f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Apr 2021 05:57:35 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:25584 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbhDAJ5X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Apr 2021 05:57:23 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id A3C349802C1;
        Thu,  1 Apr 2021 17:57:21 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     bfields@fieldses.org, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] sunrpc: xprtrdma: Remove repeated struct declaration
Date:   Thu,  1 Apr 2021 17:56:58 +0800
Message-Id: <20210401095658.1006341-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTRlKTR9NHU9KSk1CVkpNSkxJTEpLT0pDT0lVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhA6PBw6Mz8LQysQFzMCLyMv
        FRkKCzRVSlVKTUpMSUxKS09JSklKVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKSENINwY+
X-HM-Tid: 0a788cddaee2d992kuwsa3c349802c1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

struct rpcrdma_req is declared twice. One is declared at 216th line.
The blew one is not needed. Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 net/sunrpc/xprtrdma/xprt_rdma.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index fe3be985e239..11e5fbfc642c 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -239,7 +239,6 @@ struct rpcrdma_frwr {
 	};
 };
 
-struct rpcrdma_req;
 struct rpcrdma_mr {
 	struct list_head	mr_list;
 	struct rpcrdma_req	*mr_req;
-- 
2.25.1

