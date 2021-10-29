Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8EE4403E3
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Oct 2021 22:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhJ2UNt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Oct 2021 16:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230313AbhJ2UNt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 29 Oct 2021 16:13:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6595B6101E
        for <linux-nfs@vger.kernel.org>; Fri, 29 Oct 2021 20:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635538280;
        bh=i9UcOgdjH4k8J6GDr4ryir1Zi0f/eZpnYKcMfHznV24=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GMB/ahr7m/TUp8Zqyp48CMxBLRkNcDXZzTwXJROyaHJ2ijd0UIswYMMwLmP/BtPKD
         UgrefCWMeE7vfqASf5qx/QHBVRIUXlMG+rZ4Bc0dM3oOGJrQKoaRfWl8Oc7aK6bNZi
         wMtnSeexAq+H3pfIJPSQb+KGy+q97ecfc2Z+6D4LK063lMuT1odXEdUfmyWz0yfB8p
         cflEof9019Kjm02kDR230uzlZLXIHedGGi616mNcPIGHohqbq75QNmctXMtpTrpHsp
         r1CzMzRwvhMGhv/gfiwv7Pj7zKYPrSR9GPdQDfmemgaScBilgfmlnCwYtOrbfnZufs
         k/SlTJ+TZJAWQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] SUNRPC: Prevent immediate close+reconnect
Date:   Fri, 29 Oct 2021 16:04:21 -0400
Message-Id: <20211029200421.65090-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211029200421.65090-3-trondmy@kernel.org>
References: <20211029200421.65090-1-trondmy@kernel.org>
 <20211029200421.65090-2-trondmy@kernel.org>
 <20211029200421.65090-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we have already set up the socket and are waiting for it to connect,
then don't immediately close and retry.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 7fb302e202bc..ae48c9c84ee1 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2314,7 +2314,7 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 
 	WARN_ON_ONCE(!xprt_lock_connect(xprt, task, transport));
 
-	if (transport->sock != NULL) {
+	if (transport->sock != NULL && !xprt_connecting(xprt)) {
 		dprintk("RPC:       xs_connect delayed xprt %p for %lu "
 				"seconds\n",
 				xprt, xprt->reestablish_timeout / HZ);
-- 
2.31.1

