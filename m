Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E25294241
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Oct 2020 20:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437496AbgJTSjl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Oct 2020 14:39:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389212AbgJTSjk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 20 Oct 2020 14:39:40 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7B8922247;
        Tue, 20 Oct 2020 18:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603219180;
        bh=y1GZHeyFiLzYGhfnTxlC1KUcazwO2ji8I77P8rOG2Qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GH3yjRxHX5xXBwDCYn6O4FSWYK+zZb6e+TvYCJ1xrkRlIOhyo7pFi9Fqwgf3QTPd4
         Q3bfU4WlkZ6X0z4qZr8WKxdsKLbqcOCxvDJ8/AFPunjNBJRU3lWwFYgXYyFId1d8Mk
         BsTBK+ukEAAXLGcC+co5jmwk/cwvaGOox+u96LSE=
From:   trondmy@kernel.org
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 3/3] NFSv4: Observe the NFS_MOUNT_SOFTREVAL flag in _nfs4_proc_lookupp
Date:   Tue, 20 Oct 2020 14:37:18 -0400
Message-Id: <20201020183718.14618-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201020183718.14618-3-trondmy@kernel.org>
References: <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
 <20201020183718.14618-1-trondmy@kernel.org>
 <20201020183718.14618-2-trondmy@kernel.org>
 <20201020183718.14618-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We need to respect the NFS_MOUNT_SOFTREVAL flag in _nfs4_proc_lookupp,
by timing out if the server is unavailable.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index bdf33e18fc54..c306c97c1ed0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4376,6 +4376,10 @@ static int _nfs4_proc_lookupp(struct inode *inode,
 		.rpc_argp = &args,
 		.rpc_resp = &res,
 	};
+	unsigned short task_flags = 0;
+
+	if (NFS_SERVER(inode)->flags & NFS_MOUNT_SOFTREVAL)
+		task_flags |= RPC_TASK_TIMEOUT;
 
 	args.bitmask = nfs4_bitmask(server, label);
 
@@ -4383,7 +4387,7 @@ static int _nfs4_proc_lookupp(struct inode *inode,
 
 	dprintk("NFS call  lookupp ino=0x%lx\n", inode->i_ino);
 	status = nfs4_call_sync(clnt, server, &msg, &args.seq_args,
-				&res.seq_res, 0);
+				&res.seq_res, task_flags);
 	dprintk("NFS reply lookupp: %d\n", status);
 	return status;
 }
-- 
2.26.2

