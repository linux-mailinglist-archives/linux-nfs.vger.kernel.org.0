Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4071320C94
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Feb 2021 19:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhBUS2J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Feb 2021 13:28:09 -0500
Received: from btbn.de ([5.9.118.179]:33286 "EHLO btbn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhBUS2E (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 21 Feb 2021 13:28:04 -0500
Received: from Kryux.localdomain (muedsl-82-207-216-212.citykom.de [82.207.216.212])
        by btbn.de (Postfix) with ESMTPSA id CE7192357A5;
        Sun, 21 Feb 2021 19:27:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothenpieler.org;
        s=mail; t=1613932042;
        bh=IZeSbpwtGr8+AATPo6EZDT5BW4LbIPwyi4s4MsgYLrk=;
        h=From:To:Cc:Subject:Date;
        b=f0j6HTW4yd+/kU9j2nBzGbnKCeyd08cNmn1fjqzEYKFxy+YprSo7cGCDou/tvQQXh
         cqPhLfgqkRweNrCXb+HsdS0p55oWGJuZXy0FFBZFrzt4LW7jgEuougW+r1PsN2cBTd
         0g246LVaV/ADDIZVxOmxBD/1ZSmv+m2HLcENQ/GUM3B66Z0dE/KLka+n4rKNFZ8mGg
         7twF+ewCOhc5+N0K6na7VKaDTn7anyNgzx+26b2IaMoy42OxX5aSs9Ow/A+2q2YAMK
         DzRqgIkEAbnh/GaOnued4TJgJjl7YaQnBo1eq7UHMtyU9LAyHIzTNvpbQ6nAqpnKFQ
         lULQaR1X+gvaQ==
From:   Timo Rothenpieler <timo@rothenpieler.org>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Timo Rothenpieler <timo@rothenpieler.org>
Subject: [PATCH] nfsd: set RPC_CLNT_CREATE_NO_IDLE_TIMEOUT on callback client
Date:   Sun, 21 Feb 2021 19:27:00 +0100
Message-Id: <20210221182700.1494-1-timo@rothenpieler.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This tackles an issue where the callback client times out from
inactivity, causing operations like server side copy to never return on
the client side.
I was observing that issue frequently on my RDMA connected clients, it
does not seem to manifest on tcp connected clients.

However, it does not fix the actual issue of the callback channel
not getting re-established and the client being stuck in the call
forever. It just makes it a lot less likely to occur, as long as no
other circumstances cause the callback channel to be disconnected.
---
 fs/nfsd/nfs4callback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 052be5bf9ef5..75dacb7878b8 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -897,7 +897,7 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 		.timeout	= &timeparms,
 		.program	= &cb_program,
 		.version	= 1,
-		.flags		= (RPC_CLNT_CREATE_NOPING | RPC_CLNT_CREATE_QUIET),
+		.flags		= (RPC_CLNT_CREATE_NOPING | RPC_CLNT_CREATE_QUIET | RPC_CLNT_CREATE_NO_IDLE_TIMEOUT),
 		.cred		= current_cred(),
 	};
 	struct rpc_clnt *client;
-- 
2.25.1

