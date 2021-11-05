Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5D5446898
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Nov 2021 19:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbhKESrY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Nov 2021 14:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232619AbhKESrX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 5 Nov 2021 14:47:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77B4E61186
        for <linux-nfs@vger.kernel.org>; Fri,  5 Nov 2021 18:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636137883;
        bh=3RDqdN2G0nKzBtroGJ/k9ErFTzR2FTK+4I4zpSKH8vw=;
        h=From:To:Subject:Date:From;
        b=Me3ykOOtvI4tbGk6zPmtO0H9mwhHN0FztZPMIRCoCFfh2nP95fOcGm7hj4iDLQqQN
         d4xwWQzXWrIAYO3eHU6jnIO4n7DLgwD/n/XiUuHa8VmvVfahRWz4qgVLB8aNJ9Tbdx
         gsIhc+GKTWfdrFRFR/P4WdaaWmC0iSisOytu9sQignwjplg3QRPfqJGMZdYi3iMLJn
         bT0xrv2YzIoPjAolgHbAfjEA2Uo/ZwjNcojk+qXXxzJ2E+f9emtmKwO6EngKOWDMPv
         fpQSBAhkSFbdtMiGjsIfIVXXyOg6zclsE95oXR641XJZ0cQh/fNjuKhQ7qkwJv5ke+
         iuDZC4upxotvw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Don't allocate nfs_fattr on the stack in __nfs42_ssc_open()
Date:   Fri,  5 Nov 2021 14:38:14 -0400
Message-Id: <20211105183816.328639-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The preferred behaviour is always to allocate struct nfs_fattr from the
slab.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index c91565227ea2..f9f50fe1f3a4 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -317,7 +317,7 @@ static int read_name_gen = 1;
 static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
 		struct nfs_fh *src_fh, nfs4_stateid *stateid)
 {
-	struct nfs_fattr fattr;
+	struct nfs_fattr *fattr = nfs_alloc_fattr();
 	struct file *filep, *res;
 	struct nfs_server *server;
 	struct inode *r_ino = NULL;
@@ -328,9 +328,10 @@ static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
 
 	server = NFS_SERVER(ss_mnt->mnt_root->d_inode);
 
-	nfs_fattr_init(&fattr);
+	if (!fattr)
+		return ERR_PTR(-ENOMEM);
 
-	status = nfs4_proc_getattr(server, src_fh, &fattr, NULL, NULL);
+	status = nfs4_proc_getattr(server, src_fh, fattr, NULL, NULL);
 	if (status < 0) {
 		res = ERR_PTR(status);
 		goto out;
@@ -343,7 +344,7 @@ static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
 		goto out;
 	snprintf(read_name, len, SSC_READ_NAME_BODY, read_name_gen++);
 
-	r_ino = nfs_fhget(ss_mnt->mnt_root->d_inode->i_sb, src_fh, &fattr,
+	r_ino = nfs_fhget(ss_mnt->mnt_root->d_inode->i_sb, src_fh, fattr,
 			NULL);
 	if (IS_ERR(r_ino)) {
 		res = ERR_CAST(r_ino);
@@ -388,6 +389,7 @@ static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
 out_free_name:
 	kfree(read_name);
 out:
+	nfs_free_fattr(fattr);
 	return res;
 out_stateowner:
 	nfs4_put_state_owner(sp);
-- 
2.33.1

