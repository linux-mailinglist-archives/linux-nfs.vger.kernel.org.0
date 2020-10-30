Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CAA2A10AC
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Oct 2020 23:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgJ3WHm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Oct 2020 18:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgJ3WHm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 30 Oct 2020 18:07:42 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2B8322227
        for <linux-nfs@vger.kernel.org>; Fri, 30 Oct 2020 22:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604095662;
        bh=MOBmL2uL4txSencAZUUeyuOlu/ZATH07W1xk5scpDbw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SR1kYCq4JgZuWtsceH5oAI/VbgCf4DMaX1P3n4E08iexNHd1Bwl6DUF5lUrMbc3BS
         sgKPgNYH4KTtMrbdn3O/99MPWSt8ys0C9O0TS7LU/cosQO2NAGrYd2gsMbN5iCGI5g
         aIXSyfaoL2C4SIIaArvBJ1pS7kz6ENIbJ/ddAlbE=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS: Remove unnecessary inode lock in nfs_fsync_dir()
Date:   Fri, 30 Oct 2020 17:57:30 -0400
Message-Id: <20201030215730.85147-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030215730.85147-1-trondmy@kernel.org>
References: <20201030215730.85147-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

nfs_inc_stats() is already thread-safe, and there are no other reasons
to hold the inode lock here.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e56b1bd99537..4e011adaf967 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -997,13 +997,9 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 static int nfs_fsync_dir(struct file *filp, loff_t start, loff_t end,
 			 int datasync)
 {
-	struct inode *inode = file_inode(filp);
-
 	dfprintk(FILE, "NFS: fsync dir(%pD2) datasync %d\n", filp, datasync);
 
-	inode_lock(inode);
-	nfs_inc_stats(inode, NFSIOS_VFSFSYNC);
-	inode_unlock(inode);
+	nfs_inc_stats(file_inode(filp), NFSIOS_VFSFSYNC);
 	return 0;
 }
 
-- 
2.28.0

