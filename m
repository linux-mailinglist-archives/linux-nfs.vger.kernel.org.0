Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024BC35F52D
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244247AbhDNNog (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351592AbhDNNoU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 896D86120E
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407838;
        bh=Up2zpEHm3eli/sAPyZ2qpKG5xwTpwwC+z+gmRGTniDI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oosw/4Pjn+Y5rsa2eT8eVJXJtWr43wRIm47bZJw0TiyYR3Nx+I4nyq1kwY/3yoVPC
         ZBffHCP8MQRuNaX1L8sMUByaPvc871dvlX1HSGqKt416s1RAPlDIlokiJ0MRVjHBC6
         k3KxM54it6vBHAOwSW+HIt19/czJw0hbIvvj2CWrKxTecXx9eHXuUxvdQnJ0KhF6dP
         d1I5OY0ObPSBbglj3i+JrvOxCB2kR/lH6wF9cyXGuKz02dW4KNCYyK1gIFUcUbEbAm
         yIlDRMaBbFHBfg+Pykuy+3JU3/3N4Hc4u8tipK/FShCImLC1hO3PqKh97Zy6lGZy49
         yzmPZnYInGrFw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 08/26] NFS: nfs_setattr_update_inode() should clear the suid/sgid bits
Date:   Wed, 14 Apr 2021 09:43:35 -0400
Message-Id: <20210414134353.11860-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-8-trondmy@kernel.org>
References: <20210414134353.11860-1-trondmy@kernel.org>
 <20210414134353.11860-2-trondmy@kernel.org>
 <20210414134353.11860-3-trondmy@kernel.org>
 <20210414134353.11860-4-trondmy@kernel.org>
 <20210414134353.11860-5-trondmy@kernel.org>
 <20210414134353.11860-6-trondmy@kernel.org>
 <20210414134353.11860-7-trondmy@kernel.org>
 <20210414134353.11860-8-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When we do a 'chown' or 'chgrp', the server will clear the suid/sgid
bits. Ensure that we mirror that in nfs_setattr_update_inode().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 8c2d5f333e81..d34da63202cc 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -636,8 +636,7 @@ nfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	}
 
 	/* Optimization: if the end result is no change, don't RPC */
-	attr->ia_valid &= NFS_VALID_ATTRS;
-	if ((attr->ia_valid & ~(ATTR_FILE|ATTR_OPEN)) == 0)
+	if (((attr->ia_valid & NFS_VALID_ATTRS) & ~(ATTR_FILE|ATTR_OPEN)) == 0)
 		return 0;
 
 	trace_nfs_setattr_enter(inode);
@@ -719,6 +718,13 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 	}
 	if ((attr->ia_valid & (ATTR_MODE|ATTR_UID|ATTR_GID)) != 0) {
 		NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_CTIME;
+		if ((attr->ia_valid & ATTR_KILL_SUID) != 0 &&
+		    inode->i_mode & S_ISUID)
+			inode->i_mode &= ~S_ISUID;
+		if ((attr->ia_valid & ATTR_KILL_SGID) != 0 &&
+		    (inode->i_mode & (S_ISGID | S_IXGRP)) ==
+		     (S_ISGID | S_IXGRP))
+			inode->i_mode &= ~S_ISGID;
 		if ((attr->ia_valid & ATTR_MODE) != 0) {
 			int mode = attr->ia_mode & S_IALLUGO;
 			mode |= inode->i_mode & ~S_IALLUGO;
-- 
2.30.2

