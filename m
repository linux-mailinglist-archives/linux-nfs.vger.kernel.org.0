Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E32294240
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Oct 2020 20:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389145AbgJTSjk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Oct 2020 14:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389212AbgJTSjk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 20 Oct 2020 14:39:40 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BA012223C;
        Tue, 20 Oct 2020 18:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603219179;
        bh=7IrIMMQkcopHIXh1Zf2vGRw26VOb596iexSYLcJNyhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pUJ5yt+0KQU2zjd/q74cn0dQ+JapBaHZ3bYPBU5kQ+NCE+g+8Li7vvsiy8vIo93vY
         bg1PfLmrFR/6c1GHhOYOT5GH7ORIOuY4rJWuBk41TG7w7/S1G3a1oXUvrLNHuq/5XC
         iIQNgzZ1sVD8h8vT1zyiXIP8NazVECb+fDy5Aa5M=
From:   trondmy@kernel.org
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/3] NFSv3: Add emulation of the lookupp() operation
Date:   Tue, 20 Oct 2020 14:37:17 -0400
Message-Id: <20201020183718.14618-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201020183718.14618-2-trondmy@kernel.org>
References: <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
 <20201020183718.14618-1-trondmy@kernel.org>
 <20201020183718.14618-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

In order to use the open_by_filehandle() operations on NFSv3, we need
to be able to emulate lookupp() so that nfs_get_parent() can be used
to convert disconnected dentries into connected ones.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs3proc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index acbdf7496d31..6b66b73a50eb 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -209,6 +209,20 @@ nfs3_proc_lookup(struct inode *dir, struct dentry *dentry,
 				  task_flags);
 }
 
+static int nfs3_proc_lookupp(struct inode *inode, struct nfs_fh *fhandle,
+			     struct nfs_fattr *fattr, struct nfs4_label *label)
+{
+	const char dotdot[] = "..";
+	const size_t len = strlen(dotdot);
+	unsigned short task_flags = 0;
+
+	if (NFS_SERVER(inode)->flags & NFS_MOUNT_SOFTREVAL)
+		task_flags |= RPC_TASK_TIMEOUT;
+
+	return __nfs3_proc_lookup(inode, dotdot, len, fhandle, fattr,
+				  task_flags);
+}
+
 static int nfs3_proc_access(struct inode *inode, struct nfs_access_entry *entry)
 {
 	struct nfs3_accessargs	arg = {
@@ -1015,6 +1029,7 @@ const struct nfs_rpc_ops nfs_v3_clientops = {
 	.getattr	= nfs3_proc_getattr,
 	.setattr	= nfs3_proc_setattr,
 	.lookup		= nfs3_proc_lookup,
+	.lookupp	= nfs3_proc_lookupp,
 	.access		= nfs3_proc_access,
 	.readlink	= nfs3_proc_readlink,
 	.create		= nfs3_proc_create,
-- 
2.26.2

