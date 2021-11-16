Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7598B453657
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 16:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhKPPvn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 10:51:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238493AbhKPPvW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 10:51:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637077704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T16BH5nFa+bMbSxLOZU5hskSHcRcL3nuu/8aRiFiYwA=;
        b=Vg0S3ltCrAzlUEQNouKDj4EmKvF1++BsG3lUsoKPoFvqHhOFKAIKjn3/lIWsBcWqeHeGHb
        3ESIimJ+NqmjV/W6MouvWvYrRiA6XrlD5XbHd4jQwRnSwQtLcdvRGsx3gA0z3izn9UWVxJ
        26o9xf5m4LgrLocXGKmXyq19eO/6jWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-z_uTpuW_ONyO0exfdG-Qkw-1; Tue, 16 Nov 2021 10:48:21 -0500
X-MC-Unique: z_uTpuW_ONyO0exfdG-Qkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A5C815725;
        Tue, 16 Nov 2021 15:48:17 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9CA460C4A;
        Tue, 16 Nov 2021 15:48:13 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 590DF10C30F0; Tue, 16 Nov 2021 10:48:13 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFSv42: Fix pagecache invalidation after COPY/CLONE
Date:   Tue, 16 Nov 2021 10:48:13 -0500
Message-Id: <09207f3b0e8e77e6026fde636d78044e44ecc436.1637077284.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The mechanism in use to allow the client to see the results of COPY/CLONE
is to drop those pages from the pagecache.  This forces the client to read
those pages once more from the server.  However, truncate_pagecache_range()
zeros out partial pages instead of dropping them.  Let us instead use
invalidate_inode_pages2_range() with full-page offsets to ensure the client
properly sees the results of COPY/CLONE operations.

Cc: <stable@vger.kernel.org> # v4.7+
Fixes: 2e72448b07dc ("NFS: Add COPY nfs operation")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/nfs42proc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index a24349512ffe..9865b5c37d88 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -285,7 +285,9 @@ static void nfs42_copy_dest_done(struct inode *inode, loff_t pos, loff_t len)
 	loff_t newsize = pos + len;
 	loff_t end = newsize - 1;
 
-	truncate_pagecache_range(inode, pos, end);
+	WARN_ON_ONCE(invalidate_inode_pages2_range(inode->i_mapping,
+				pos >> PAGE_SHIFT, end >> PAGE_SHIFT));
+
 	spin_lock(&inode->i_lock);
 	if (newsize > i_size_read(inode))
 		i_size_write(inode, newsize);
-- 
2.31.1

