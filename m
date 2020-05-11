Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2911CDDA3
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2020 16:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgEKOtH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 May 2020 10:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbgEKOtH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 11 May 2020 10:49:07 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25E5C20720
        for <linux-nfs@vger.kernel.org>; Mon, 11 May 2020 14:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589208547;
        bh=ijJaBhKrYv9tMV5LOxfVEVmJZl1TjUbTXIUSKCvB6HI=;
        h=From:To:Subject:Date:From;
        b=jICLmG9/SxbihKZhbhEtJL75heeKcB5Sjnmmaahr4JYW4s68wYXnZ3/CJh2xB+Rhp
         g8LRXY3ZR4PQgK0VIIVBDkBiN06bvbhc2LylokvjQqjfp5zORRoTckwIsoDGPnKhT8
         0PrsVctJjoEODvLWUQvwhvIfG8jItC7NhcacnRFU=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Don't use RPC_TASK_CRED_NOREF with delegreturn
Date:   Mon, 11 May 2020 10:46:58 -0400
Message-Id: <20200511144658.341754-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We are not guaranteed that the credential will remain pinned.

Fixes: 612965072020 ("NFSv4: Avoid referencing the cred unnecessarily during NFSv4 I/O")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a0c1e653a935..9056f3dd380e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6347,7 +6347,7 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 		.rpc_client = server->client,
 		.rpc_message = &msg,
 		.callback_ops = &nfs4_delegreturn_ops,
-		.flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF | RPC_TASK_TIMEOUT,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT,
 	};
 	int status = 0;
 
-- 
2.26.2

