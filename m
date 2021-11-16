Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B5F453335
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 14:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbhKPNwa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 08:52:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27283 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236836AbhKPNw1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 08:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637070569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y+74BZ/hTdQsopYcKf/aTVQhqL2n2BGtL9oyLeu+xNM=;
        b=goJBqsythYhodltCSR4hVSsGHySYIx7MXS9QRThUV5UE9d+S7oTUpBuErRURyVdVLtK6w+
        aSt6jQbxx67fH8TrmDzUD432E0usK1x18F9hVgWHtSbR32l83XhIfSiNXyiV8NhQWi9bMq
        1uv2skXLo+TQg/4UrVCPSX34JjeiXfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-NHJXiSdsN7-I1_ZG0TGAIw-1; Tue, 16 Nov 2021 08:49:26 -0500
X-MC-Unique: NHJXiSdsN7-I1_ZG0TGAIw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D71619200D8;
        Tue, 16 Nov 2021 13:49:25 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2D7C1017CE3;
        Tue, 16 Nov 2021 13:49:24 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 6B02510C30F1; Tue, 16 Nov 2021 08:49:24 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFSv42: Fix pagecache invalidation after COPY/CLONE
Date:   Tue, 16 Nov 2021 08:49:22 -0500
Message-Id: <8b8ccdb69af2473eef4a36968894e7aee34d5851.1637069577.git.bcodding@redhat.com>
In-Reply-To: <cover.1637069577.git.bcodding@redhat.com>
References: <cover.1637069577.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 fs/nfs/nfs42proc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index a24349512ffe..bbcd4c80c5a6 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -285,7 +285,10 @@ static void nfs42_copy_dest_done(struct inode *inode, loff_t pos, loff_t len)
 	loff_t newsize = pos + len;
 	loff_t end = newsize - 1;
 
-	truncate_pagecache_range(inode, pos, end);
+	int error = invalidate_inode_pages2_range(inode->i_mapping,
+				pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
+	WARN_ON_ONCE(error);
+
 	spin_lock(&inode->i_lock);
 	if (newsize > i_size_read(inode))
 		i_size_write(inode, newsize);
-- 
2.31.1

