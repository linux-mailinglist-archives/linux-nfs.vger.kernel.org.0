Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D95B78F523
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Aug 2019 21:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbfHOTyE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Aug 2019 15:54:04 -0400
Received: from fieldses.org ([173.255.197.46]:34694 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729818AbfHOTyE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 15 Aug 2019 15:54:04 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 3B0CA63F; Thu, 15 Aug 2019 15:54:04 -0400 (EDT)
Date:   Thu, 15 Aug 2019 15:54:04 -0400
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: use i_wrlock instead of rcu for nfsdfs i_private
Message-ID: <20190815195404.GA19554@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

synchronize_rcu() gets called multiple times each time a client is
destroyed.  If the laundromat thread has a lot of clients to destroy,
the delay can be noticeable.  This was causing pynfs test RENEW3 to
fail.

We could embed an rcu_head in each inode and do the kref_put in an rcu
callback.  But simplest is just to take a lock here.

(I also wonder if the laundromat thread would be better replaced by a
bunch of scheduled work or timers or something.)

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfsctl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 928a0b2c05dc..b14f825c62fe 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1215,11 +1215,9 @@ static void clear_ncl(struct inode *inode)
 	struct nfsdfs_client *ncl = inode->i_private;
 
 	inode->i_private = NULL;
-	synchronize_rcu();
 	kref_put(&ncl->cl_ref, ncl->cl_release);
 }
 
-
 static struct nfsdfs_client *__get_nfsdfs_client(struct inode *inode)
 {
 	struct nfsdfs_client *nc = inode->i_private;
@@ -1233,9 +1231,9 @@ struct nfsdfs_client *get_nfsdfs_client(struct inode *inode)
 {
 	struct nfsdfs_client *nc;
 
-	rcu_read_lock();
+	inode_lock_shared(inode);
 	nc = __get_nfsdfs_client(inode);
-	rcu_read_unlock();
+	inode_unlock_shared(inode);
 	return nc;
 }
 /* from __rpc_unlink */
-- 
2.21.0

