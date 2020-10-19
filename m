Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FDD292F23
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Oct 2020 22:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgJSUHy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Oct 2020 16:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbgJSUHx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Oct 2020 16:07:53 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B1B1223C7;
        Mon, 19 Oct 2020 20:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603138073;
        bh=6N8Hxu3afRbi57PuucxfKaUlVcAEqbtue4UBZo8rmzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lHOKKM+IqlkmUvFyQX3eCyRTfHk1OqAfYWXCLU9r9mke5qksfGbJdTjTm3xPLPDTi
         ZgXySpYLeGPfugAfYkflPg6kKidXwcJNAzs1VIbR54l8CEJO+w2QW0k4qcwpn6YUt7
         fmQb5+Qh3Ec4JFQXcqefZLbXsqHWugaDYw5keE1U=
From:   trondmy@kernel.org
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] NFSv3: Add emulation of the lookupp() operation
Date:   Mon, 19 Oct 2020 16:05:43 -0400
Message-Id: <20201019200543.606847-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201019200543.606847-2-trondmy@kernel.org>
References: <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
 <20201019200543.606847-1-trondmy@kernel.org>
 <20201019200543.606847-2-trondmy@kernel.org>
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
 fs/nfs/nfs3proc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index acbdf7496d31..63d1979933f3 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -209,6 +209,15 @@ nfs3_proc_lookup(struct inode *dir, struct dentry *dentry,
 				  task_flags);
 }
 
+static int nfs3_proc_lookupp(struct inode *inode, struct nfs_fh *fhandle,
+			     struct nfs_fattr *fattr, struct nfs4_label *label)
+{
+	const char *dotdot = "..";
+	const size_t len = sizeof(dotdot) - 1;
+
+	return __nfs3_proc_lookup(inode, dotdot, len, fhandle, fattr, 0);
+}
+
 static int nfs3_proc_access(struct inode *inode, struct nfs_access_entry *entry)
 {
 	struct nfs3_accessargs	arg = {
@@ -1015,6 +1024,7 @@ const struct nfs_rpc_ops nfs_v3_clientops = {
 	.getattr	= nfs3_proc_getattr,
 	.setattr	= nfs3_proc_setattr,
 	.lookup		= nfs3_proc_lookup,
+	.lookupp	= nfs3_proc_lookupp,
 	.access		= nfs3_proc_access,
 	.readlink	= nfs3_proc_readlink,
 	.create		= nfs3_proc_create,
-- 
2.26.2

