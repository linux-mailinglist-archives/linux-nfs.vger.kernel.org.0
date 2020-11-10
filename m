Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7ABA2AE205
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 22:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbgKJVry (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 16:47:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731867AbgKJVry (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 16:47:54 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7E12207D3
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 21:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605044874;
        bh=f/V+pMcJVWVuM+EFVJPh8o6cI0/wo4H6TYc1kzkDNmc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vFSrpAngs3Hopw+AZm97KNZeT3Ie/d2g5UUlOwrcUobuzzCa78Bl+7WXVY2ji77Qs
         OTNBELi2iY3mLylOPjQOjHIKuLB9fMM9oTqz+v6loN7xL6DETufJIoHvw8u1YjErGm
         eNsn0Id3Xc/mmcafwHRzqGDaGBf/lcOFh56Rzv5M=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 03/22] NFSv4.2: condition READDIR's mask for security label based on LSM state
Date:   Tue, 10 Nov 2020 16:37:22 -0500
Message-Id: <20201110213741.860745-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110213741.860745-3-trondmy@kernel.org>
References: <20201110213741.860745-1-trondmy@kernel.org>
 <20201110213741.860745-2-trondmy@kernel.org>
 <20201110213741.860745-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Currently, the client will always ask for security_labels if the server
returns that it supports that feature regardless of any LSM modules
(such as Selinux) enforcing security policy. This adds performance
penalty to the READDIR operation.

Client adjusts superblock's support of the security_label based on
the server's support but also current client's configuration of the
LSM modules. Thus, prior to using the default bitmask in READDIR,
this patch checks the server's capabilities and then instructs
READDIR to remove FATTR4_WORD2_SECURITY_LABEL from the bitmask.

v5: fixing silly mistakes of the rushed v4
v4: simplifying logic
v3: changing label's initialization per Ondrej's comment
v2: dropping selinux hook and using the sb cap.

Suggested-by: Ondrej Mosnacek <omosnace@redhat.com>
Suggested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Fixes: 2b0143b5c986 ("VFS: normal filesystems (and lustre): d_inode() annotations")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a5b9356bee6a..66f1f4a5c74c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4965,12 +4965,12 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
 		u64 cookie, struct page **pages, unsigned int count, bool plus)
 {
 	struct inode		*dir = d_inode(dentry);
+	struct nfs_server	*server = NFS_SERVER(dir);
 	struct nfs4_readdir_arg args = {
 		.fh = NFS_FH(dir),
 		.pages = pages,
 		.pgbase = 0,
 		.count = count,
-		.bitmask = NFS_SERVER(d_inode(dentry))->attr_bitmask,
 		.plus = plus,
 	};
 	struct nfs4_readdir_res res;
@@ -4985,9 +4985,15 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
 	dprintk("%s: dentry = %pd2, cookie = %Lu\n", __func__,
 			dentry,
 			(unsigned long long)cookie);
+	if (!(server->caps & NFS_CAP_SECURITY_LABEL))
+		args.bitmask = server->attr_bitmask_nl;
+	else
+		args.bitmask = server->attr_bitmask;
+
 	nfs4_setup_readdir(cookie, NFS_I(dir)->cookieverf, dentry, &args);
 	res.pgbase = args.pgbase;
-	status = nfs4_call_sync(NFS_SERVER(dir)->client, NFS_SERVER(dir), &msg, &args.seq_args, &res.seq_res, 0);
+	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args,
+			&res.seq_res, 0);
 	if (status >= 0) {
 		memcpy(NFS_I(dir)->cookieverf, res.verifier.data, NFS4_VERIFIER_SIZE);
 		status += args.pgbase;
-- 
2.28.0

