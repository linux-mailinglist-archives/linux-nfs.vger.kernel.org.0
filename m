Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E368D428414
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Oct 2021 00:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhJJWZU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 10 Oct 2021 18:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231136AbhJJWZT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 10 Oct 2021 18:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633904599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=t8I/MK4ywe4ID3E69CL86HY1rXr3jW3Ydb9W0MBbBro=;
        b=hBbP7wkn7vPkTaK1+1o2MsWGpvUqaUJABQgb/V4y01J06eRhImrfOFQEv+xGgbOXohfv7y
        a1atxZMkc1OrqFGAbA8Vvnsy8ZNEFEQsr2g3JtTNYWPmqn2UygN4n0JbajDDA6QgeaCt8l
        8p2lCJzXy2CQ/pTCbcMR1Zs+S54OLVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-ajvggn0EMEODST9VUpWm8A-1; Sun, 10 Oct 2021 18:23:16 -0400
X-MC-Unique: ajvggn0EMEODST9VUpWm8A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B1EE100C673;
        Sun, 10 Oct 2021 22:23:15 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 282A118A50;
        Sun, 10 Oct 2021 22:23:15 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Fix WARN_ON due to unionization of nfs_inode.nrequests
Date:   Sun, 10 Oct 2021 18:23:13 -0400
Message-Id: <1633904593-31940-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fixes the following WARN_ON
WARNING: CPU: 2 PID: 18678 at fs/nfs/inode.c:123 nfs_clear_inode+0x3b/0x50 [nfs]
...
Call Trace:
  nfs4_evict_inode+0x57/0x70 [nfsv4]
  evict+0xd1/0x180
  dispose_list+0x48/0x60
  evict_inodes+0x156/0x190
  generic_shutdown_super+0x37/0x110
  nfs_kill_super+0x1d/0x40 [nfs]
  deactivate_locked_super+0x36/0xa0

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 include/linux/nfs_fs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index a5aef2cbe4ee..5a110ecf2d85 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -579,7 +579,9 @@ extern int nfs_access_get_cached(struct inode *inode, const struct cred *cred, s
 static inline int
 nfs_have_writebacks(struct inode *inode)
 {
-	return atomic_long_read(&NFS_I(inode)->nrequests) != 0;
+	if (S_ISREG(inode->i_mode))
+		return atomic_long_read(&NFS_I(inode)->nrequests) != 0;
+	return 0;
 }
 
 /*
-- 
1.8.3.1

