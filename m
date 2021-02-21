Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53E7320DD6
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Feb 2021 22:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhBUVOp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 21 Feb 2021 16:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhBUVOo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 21 Feb 2021 16:14:44 -0500
Received: from btbn.de (btbn.de [IPv6:2a01:4f8:162:63a9::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B88DC061574
        for <linux-nfs@vger.kernel.org>; Sun, 21 Feb 2021 13:14:04 -0800 (PST)
Received: from Kryux.localdomain (muedsl-82-207-216-212.citykom.de [82.207.216.212])
        by btbn.de (Postfix) with ESMTPSA id 2AF3623785F;
        Sun, 21 Feb 2021 22:14:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothenpieler.org;
        s=mail; t=1613942040;
        bh=VAZ1TmIANq/u0c9s/QFyK2fmVjECGm3flzOEfiwNkmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pLBFCsSNR8mmanDUiB2RmXQ0o3gzQZHsIomcfFjXmJ031g0imkV5DQTqLFQ67AUa/
         aNAGWvvyerOo/iOP6iVBokVna6cR+x2aJgZZ0BrZEXfDVlaJ0tYM9PmW+uFL9Mq/hT
         hTXPZrKC+YOmhUAfw8/6N+2up5D4pkd8RW4r8bqsqn4KDG4rQYTDumKgryKMbIbIE7
         vXY0UryoKqKnG4IMOePCDc38FB1uJp/nEQFwiMDEeu/qTQzWX+QlWKmDMqKwLo+xb2
         UEQ7qFGL0L1V7p74Ik/N3BOqL5xGWKuCB6fzfA8KpSGOf9aKXjo9jpsZA4fPjansyN
         gwpzgNBGlbqFg==
From:   Timo Rothenpieler <timo@rothenpieler.org>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Timo Rothenpieler <timo@rothenpieler.org>
Subject: [PATCH] nfsd: set RPC_CLNT_CREATE_NO_IDLE_TIMEOUT on callback client
Date:   Sun, 21 Feb 2021 22:13:47 +0100
Message-Id: <20210221211347.3429-1-timo@rothenpieler.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <EF096827-F543-429E-AC9B-1E93C6A35B02@oracle.com>
References: <EF096827-F543-429E-AC9B-1E93C6A35B02@oracle.com>
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

Signed-off-by: Timo Rothenpieler <timo@rothenpieler.org>
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

