Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E66F2AA0B6
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Nov 2020 00:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgKFXFv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Nov 2020 18:05:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729011AbgKFXFt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 6 Nov 2020 18:05:49 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACD1620B1F
        for <linux-nfs@vger.kernel.org>; Fri,  6 Nov 2020 23:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604703948;
        bh=Bqt7ukMSyaV+5Jju36VcwPoovmI4323HHX+1v4Rv5h4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vj+8WgV+3WfaB7Xy73SudzP4pz+DYOw45ZZhN0PaLp9sxHuJlg0Qg1Hae06NWv1dk
         j5YsVc+SdD3uqFddA5uAfeIrbkzDtHzZntrlE0Bd2usN1QssKyZ0iETT4qXmzd02Eu
         YN21x16Vg8YTcWDNMq7auJx+acdQ6sDgIonXU5v4=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] SUNRPC: xprt_load_transport() needs to support the netid "rdma6"
Date:   Fri,  6 Nov 2020 17:55:25 -0500
Message-Id: <20201106225527.19148-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106225527.19148-1-trondmy@kernel.org>
References: <20201106225527.19148-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

According to RFC5666, the correct netid for an IPv6 addressed RDMA
transport is "rdma6", which we've supported as a mount option since
Linux-4.7. The problem is when we try to load the module "xprtrdma6",
that will fail, since there is no modulealias of that name.

Fixes: 181342c5ebe8 ("xprtrdma: Add rdma6 option to support NFS/RDMA IPv6")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtrdma/module.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/xprtrdma/module.c b/net/sunrpc/xprtrdma/module.c
index 620327c01302..fb55983628b4 100644
--- a/net/sunrpc/xprtrdma/module.c
+++ b/net/sunrpc/xprtrdma/module.c
@@ -23,7 +23,9 @@ MODULE_AUTHOR("Open Grid Computing and Network Appliance, Inc.");
 MODULE_DESCRIPTION("RPC/RDMA Transport");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS("svcrdma");
+MODULE_ALIAS("svcrdma6");
 MODULE_ALIAS("xprtrdma");
+MODULE_ALIAS("xprtrdma6");
 
 static void __exit rpc_rdma_cleanup(void)
 {
-- 
2.28.0

