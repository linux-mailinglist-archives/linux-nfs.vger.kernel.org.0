Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9370453336
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 14:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbhKPNwd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 08:52:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236886AbhKPNw2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 08:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637070571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tIobTtAZCjtmOI/qRv5wwg3I5p2Jl6FN5KtyMf+Okk=;
        b=h5o4EJZimyJNFJ+KjHp0cGTi/pJF+56jmtlh3Zas1lmXpBV9XVv/bRYZGimvFbeoSFZTuB
        pJmIpZMAkaxqcegzu1yEu5NI2HOUOsyOuPr3pJiH8uLr+17UvuxB5X5I05uU3eTZmPjG0/
        1bQDkYGXxiYBYd7zsXrWsV7sM5vew68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-zP5TpnwUOK2LqxVAbWl5lQ-1; Tue, 16 Nov 2021 08:49:26 -0500
X-MC-Unique: zP5TpnwUOK2LqxVAbWl5lQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D6C319200D3;
        Tue, 16 Nov 2021 13:49:25 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2DDA60C0F;
        Tue, 16 Nov 2021 13:49:24 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 6FED810C3101; Tue, 16 Nov 2021 08:49:24 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFSv42: Don't drop NFS_INO_INVALID_CHANGE if we hold a delegation
Date:   Tue, 16 Nov 2021 08:49:23 -0500
Message-Id: <c91e224b847e697e42b25cdc36cd164a61ad1ade.1637069577.git.bcodding@redhat.com>
In-Reply-To: <cover.1637069577.git.bcodding@redhat.com>
References: <cover.1637069577.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The nfs_set_cache_invalid() helper drops NFS_INO_INVALID_CHANGE if we hold
a delegation, but after a copy or clone the change attribute can be updated
on the server.  After commit b6f80a2ebb97 "NFS: Fix open coded versions of
nfs_set_cache_invalid() in NFSv4", the client stopped updating the change
attribute after copy or clone while holding a read delegation.

We can use NFS_INO_REVAL_PAGECACHE to help nfs_set_cache_invalid() know
when we really want to keep NFS_INO_INVALID_CHANGE, even if the client
holds a delegation.

Fixes: b6f80a2ebb97 ("NFS: Fix open coded versions of nfs_set_cache_invalid() in NFSv4")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/inode.c     | 4 +++-
 fs/nfs/nfs42proc.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 853213b3a209..296ed8ea3273 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -202,7 +202,9 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 			flags &= ~(NFS_INO_INVALID_MODE |
 				   NFS_INO_INVALID_OTHER |
 				   NFS_INO_INVALID_XATTR);
-		flags &= ~(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE);
+		if (!(flags & NFS_INO_REVAL_PAGECACHE))
+			flags &= ~NFS_INO_INVALID_CHANGE;
+		flags &= ~NFS_INO_INVALID_SIZE;
 	} else if (flags & NFS_INO_REVAL_PAGECACHE)
 		flags |= NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE;
 
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index bbcd4c80c5a6..fc3c36e1f656 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -292,7 +292,8 @@ static void nfs42_copy_dest_done(struct inode *inode, loff_t pos, loff_t len)
 	spin_lock(&inode->i_lock);
 	if (newsize > i_size_read(inode))
 		i_size_write(inode, newsize);
-	nfs_set_cache_invalid(inode, NFS_INO_INVALID_CHANGE |
+	nfs_set_cache_invalid(inode, NFS_INO_REVAL_PAGECACHE |
+					     NFS_INO_INVALID_CHANGE |
 					     NFS_INO_INVALID_CTIME |
 					     NFS_INO_INVALID_MTIME |
 					     NFS_INO_INVALID_BLOCKS);
-- 
2.31.1

