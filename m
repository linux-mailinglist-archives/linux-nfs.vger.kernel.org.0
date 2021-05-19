Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6315E3896B1
	for <lists+linux-nfs@lfdr.de>; Wed, 19 May 2021 21:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhESTao (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 May 2021 15:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232036AbhESTan (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 19 May 2021 15:30:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D4FF6112F
        for <linux-nfs@vger.kernel.org>; Wed, 19 May 2021 19:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621452563;
        bh=4Iw2TywW103DL03gD+EAReUQbzFGyoq5tKCeunNjdpw=;
        h=From:To:Subject:Date:From;
        b=dlpFcZ4LGpuk8zQRrDQxvo8MH8OM9Z9IY+sWUHKcJ82wtldwlXsFGrYVN838GxOuH
         z3R5sU89vGKzGjb0MvZYbBb7nZuYTwwsLg5BDCgr6aN3LFm2Wtuxh5EUQ1YINHYnF7
         C9OXk6jj6yDp4oawHlD8HsxGPYqakBRM4jRqqGS9ky+4ezVTPdH7UUTmAarJJAmntu
         ufytoLhb8rVgLjZUHtn6quAY7u2CDUyuB772WrZqmcIkNCXHlpHRHlv4MW1NG1bVDY
         S2IZaporQEC9FNfvVEYVDnGdUFU5qubwqy4rKF7mXuu6HbWv8QvHOg63Ct6ApkKDem
         WDbeDXzg+x18g==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Fix Oops in xs_tcp_send_request() when transport is disconnected
Date:   Wed, 19 May 2021 15:29:22 -0400
Message-Id: <20210519192922.7219-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If a disconnection occurs while we're trying to reply to a server
callback, then we may end up calling xs_tcp_send_request() with a NULL
value for transport->inet, which trips up the call to
tcp_sock_set_cork().

Fixes: d737e5d41870 ("SUNRPC: Set TCP_CORK until the transmit queue is empty")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 47aa47a2b07c..316d04945587 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1010,6 +1010,8 @@ static int xs_tcp_send_request(struct rpc_rqst *req)
 			kernel_sock_shutdown(transport->sock, SHUT_RDWR);
 		return -ENOTCONN;
 	}
+	if (!transport->inet)
+		return -ENOTCONN;
 
 	xs_pktdump("packet data:",
 				req->rq_svec->iov_base,
-- 
2.31.1

