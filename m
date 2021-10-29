Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BA04403E0
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Oct 2021 22:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhJ2UNs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Oct 2021 16:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhJ2UNs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 29 Oct 2021 16:13:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFF776101E
        for <linux-nfs@vger.kernel.org>; Fri, 29 Oct 2021 20:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635538279;
        bh=rl5sSDqPg28APT6gH5GVDrRhQz1w+QKO1pxW8T8Zmgc=;
        h=From:To:Subject:Date:From;
        b=V1chCyeHisQIO8eYKiOYHj5R/d48mLG/TSEsXlUmH1PE/NBIYw4Eiz50tsemGQtwN
         KOwlW7Om4omC7PwJH9yXQJ4AS1wibREL0Wzp/ImUNMtSk2GpC+HRcpA8nRZhzgr80M
         PMYFdx0CRHkgB2P+swQZt5JBLCqgGzR6yhAVI80dqzk5IzOLCawyH0+lncoKUxRHWW
         stH1FoSILQunnt2Dx2Jr+EwS8dv1JUnLJZfs6gUU5bTO2HIhqc3nCxzkY4uSn8rRtX
         CRW/JOIIkKGNmac2offS/On5FOn47xE+GlFX5N+TVJXnzWr9pBBWBiLNTv0bd99GZB
         an9qn+UlK4Wkg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/4] SUNRPC: Fix races when closing the socket
Date:   Fri, 29 Oct 2021 16:04:18 -0400
Message-Id: <20211029200421.65090-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that we bump the xprt->connect_cookie when we set the
XPRT_CLOSE_WAIT flag so that another call to
xprt_conditional_disconnect() won't race with the reconnection.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprt.c     | 2 ++
 net/sunrpc/xprtsock.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 48560188e84d..691fe5a682b6 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -735,6 +735,8 @@ static void xprt_autoclose(struct work_struct *work)
 	unsigned int pflags = memalloc_nofs_save();
 
 	trace_xprt_disconnect_auto(xprt);
+	xprt->connect_cookie++;
+	smp_mb__before_atomic();
 	clear_bit(XPRT_CLOSE_WAIT, &xprt->state);
 	xprt->ops->close(xprt);
 	xprt_release_write(xprt, NULL);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 04f1b78bcbca..b18d13479104 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1134,6 +1134,7 @@ static void xs_run_error_worker(struct sock_xprt *transport, unsigned int nr)
 
 static void xs_sock_reset_connection_flags(struct rpc_xprt *xprt)
 {
+	xprt->connect_cookie++;
 	smp_mb__before_atomic();
 	clear_bit(XPRT_CLOSE_WAIT, &xprt->state);
 	clear_bit(XPRT_CLOSING, &xprt->state);
-- 
2.31.1

