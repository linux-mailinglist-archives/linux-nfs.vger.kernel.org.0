Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAAB35F53F
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351582AbhDNNok (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351619AbhDNNo1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94B8761139
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407845;
        bh=4r6aTggmVS+e4mbqWpv7peniTbxkdy4N32naX5aY3jo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=C+/sdkip+loSOK/jvjw/blIFZvnXj0DnWJKPeoUEZyxvoBQn5Vx7ZzD8TnOAG0afd
         8NO091NCJ7hvyn042atS0PZETWc6h3E2ct54e38da+zxWz9+3UDMjRKzRSR+l/OggY
         ZLOByH2GPIoke6e8AxWOoCsZCxRcyk5ZlBMeJd3duN/YU8lxO/27Nc0Qml9IrKz43y
         leGahIJCaktZMuaM1ZuakpLW/dc3C7Pbkv3VNf9FphCBHDKxGqWDVTDgKxNWwnz70A
         nYGTYz3I5DYuio7JTGguyJGJ4Lb5s3Oli8YF7pfwxDItPXbD21HDVQCjRIbnXDHBBK
         p9QwdHYeM6ziw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 24/26] NFSv4: link must update the inode nlink.
Date:   Wed, 14 Apr 2021 09:43:51 -0400
Message-Id: <20210414134353.11860-25-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-24-trondmy@kernel.org>
References: <20210414134353.11860-1-trondmy@kernel.org>
 <20210414134353.11860-2-trondmy@kernel.org>
 <20210414134353.11860-3-trondmy@kernel.org>
 <20210414134353.11860-4-trondmy@kernel.org>
 <20210414134353.11860-5-trondmy@kernel.org>
 <20210414134353.11860-6-trondmy@kernel.org>
 <20210414134353.11860-7-trondmy@kernel.org>
 <20210414134353.11860-8-trondmy@kernel.org>
 <20210414134353.11860-9-trondmy@kernel.org>
 <20210414134353.11860-10-trondmy@kernel.org>
 <20210414134353.11860-11-trondmy@kernel.org>
 <20210414134353.11860-12-trondmy@kernel.org>
 <20210414134353.11860-13-trondmy@kernel.org>
 <20210414134353.11860-14-trondmy@kernel.org>
 <20210414134353.11860-15-trondmy@kernel.org>
 <20210414134353.11860-16-trondmy@kernel.org>
 <20210414134353.11860-17-trondmy@kernel.org>
 <20210414134353.11860-18-trondmy@kernel.org>
 <20210414134353.11860-19-trondmy@kernel.org>
 <20210414134353.11860-20-trondmy@kernel.org>
 <20210414134353.11860-21-trondmy@kernel.org>
 <20210414134353.11860-22-trondmy@kernel.org>
 <20210414134353.11860-23-trondmy@kernel.org>
 <20210414134353.11860-24-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c      | 2 +-
 fs/nfs/nfs4proc.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index d2835d211a73..5c25c8cc037a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1711,7 +1711,7 @@ static void nfs_drop_nlink(struct inode *inode)
 	NFS_I(inode)->attr_gencount = nfs_inc_attr_generation_counter();
 	nfs_set_cache_invalid(
 		inode, NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME |
-			       NFS_INO_INVALID_NLINK | NFS_INO_REVAL_FORCED);
+			       NFS_INO_INVALID_NLINK);
 	spin_unlock(&inode->i_lock);
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d05f4ca5d9c0..2215f20e0e78 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1175,6 +1175,14 @@ nfs4_inc_nlink_locked(struct inode *inode)
 	inc_nlink(inode);
 }
 
+static void
+nfs4_inc_nlink(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	nfs4_inc_nlink_locked(inode);
+	spin_unlock(&inode->i_lock);
+}
+
 static void
 nfs4_dec_nlink_locked(struct inode *inode)
 {
@@ -4791,6 +4799,7 @@ static int _nfs4_proc_link(struct inode *inode, struct inode *dir, const struct
 	if (!status) {
 		nfs4_update_changeattr(dir, &res.cinfo, res.fattr->time_start,
 				       NFS_INO_INVALID_DATA);
+		nfs4_inc_nlink(inode);
 		status = nfs_post_op_update_inode(inode, res.fattr);
 		if (!status)
 			nfs_setsecurity(inode, res.fattr, res.label);
-- 
2.30.2

