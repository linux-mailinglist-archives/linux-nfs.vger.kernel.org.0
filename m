Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70991221092
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2020 17:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgGOPL6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jul 2020 11:11:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43725 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726836AbgGOPL5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jul 2020 11:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594825916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=9vzrF9DYO8/Vke/xhESeilqtaXbRpIiCH5BQ5xCzPQk=;
        b=OIprBR1q11eVh+VWpdFI+qHh55wodAUwJqvGCvwJ0abkPBYsMRCFlXGtXi6TYLxq5WiTPK
        S9BpoBqXS5T1kipqmpxdyFhlGMV4tv28NjazQvOtL6ZxrgW4mGoRr9LWiBXMBDVctE8aLo
        2Os1vIq7JZ1xwbS6dzxOxuSMlX9t9Ks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-0ETNQ5qMOq2QYtuAvkmBzQ-1; Wed, 15 Jul 2020 11:11:54 -0400
X-MC-Unique: 0ETNQ5qMOq2QYtuAvkmBzQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F062F106B1CF;
        Wed, 15 Jul 2020 15:10:58 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-118-79.rdu2.redhat.com [10.10.118.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 84B4860BF1;
        Wed, 15 Jul 2020 15:10:58 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH v1 13/13] NFS: Call nfs_fscache_invalidate() when write extends the size of the file
Date:   Wed, 15 Jul 2020 11:10:49 -0400
Message-Id: <1594825849-24991-14-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1594825849-24991-1-git-send-email-dwysocha@redhat.com>
References: <1594825849-24991-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a write extends the size of the file and fscache is enabled, we
need to invalidate the object with the new size.  Otherwise, the next
read from the cache may fail inside cachefiles_shape_extent() due to
cookie->zero_point being smaller than the size of the file.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/write.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 005eea29e0ec..0f2f15da27f0 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -277,6 +277,7 @@ static struct nfs_page *nfs_find_and_lock_page_request(struct page *page)
 static void nfs_grow_file(struct page *page, unsigned int offset, unsigned int count)
 {
 	struct inode *inode = page_file_mapping(page)->host;
+	struct nfs_inode *nfsi = NFS_I(inode);
 	loff_t end, i_size;
 	pgoff_t end_index;
 
@@ -289,10 +290,14 @@ static void nfs_grow_file(struct page *page, unsigned int offset, unsigned int c
 	if (i_size >= end)
 		goto out;
 	i_size_write(inode, end);
-	NFS_I(inode)->cache_validity &= ~NFS_INO_INVALID_SIZE;
+	nfsi->cache_validity &= ~NFS_INO_INVALID_SIZE;
+	if (nfsi->fscache)
+		nfs_fscache_invalidate(inode);
 	nfs_inc_stats(inode, NFSIOS_EXTENDWRITE);
 out:
 	spin_unlock(&inode->i_lock);
+	dprintk("NFS:       nfs_grow_file (0x%p/0x%p) i_size=%lld\n",
+		  nfsi, nfsi->fscache, end);
 }
 
 /* A writeback failed: mark the page as bad, and invalidate the page cache */
-- 
1.8.3.1

