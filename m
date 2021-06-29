Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307B53B740D
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Jun 2021 16:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhF2OS0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Jun 2021 10:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36862 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230461AbhF2OSZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Jun 2021 10:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624976158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=kwDqT18nz4r+3IeyQAo6P4FmDPRYCt+kZtBqJOcPzUs=;
        b=SxsJKl0Psmr6wVxYaAdBG0eseEggcztXpOo1E2ei8FyIAve6MFKTPOHgJHCsBi9AHvbC2D
        WX8/f+7n4JMXQfThvTH3Ii7ZnBvpCS3ZtxuJbeYF10ZwGmnqu6e/nEtybMXS1bn36ZrCLi
        vFAjmm8wDjfC856BAeutrig7c4vFiG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-v-5zFZoGO6SWGUVVXKMmBQ-1; Tue, 29 Jun 2021 10:15:57 -0400
X-MC-Unique: v-5zFZoGO6SWGUVVXKMmBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E528C9126F;
        Tue, 29 Jun 2021 14:15:55 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 413C75DD68;
        Tue, 29 Jun 2021 14:15:55 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFS: Fix fscache read from NFS after cache error
Date:   Tue, 29 Jun 2021 10:15:53 -0400
Message-Id: <1624976153-25317-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Earlier commits refactored some NFS read code and removed
nfs_readpage_async(), but neglected to properly fixup
nfs_readpage_from_fscache_complete().  The code path is
only hit when something unusual occurs with the cachefiles
backing filesystem, such as an IO error or while a cookie
is being invalidated.

Fixup this path by unconditionally unlocking the page
and letting the VM decide what to do based on PG_uptodate.
Note that the VM re-issue of the IO will likely go back
to fscache, so we may end up failing the read if fscache
has a permanent error (such as EIO).

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c | 7 +++----
 fs/nfs/read.c    | 5 +++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index c4c021c6ebbd..dca7ce676b1d 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -385,12 +385,11 @@ static void nfs_readpage_from_fscache_complete(struct page *page,
 		 "NFS: readpage_from_fscache_complete (0x%p/0x%p/%d)\n",
 		 page, context, error);
 
-	/* if the read completes with an error, we just unlock the page and let
+	/* if the read completes with an error, unlock the page and let
 	 * the VM reissue the readpage */
-	if (!error) {
+	if (!error)
 		SetPageUptodate(page);
-		unlock_page(page);
-	}
+	unlock_page(page);
 }
 
 /*
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index eb390eb618b3..9f39e0a1a38b 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -362,13 +362,13 @@ int nfs_readpage(struct file *file, struct page *page)
 	} else
 		desc.ctx = get_nfs_open_context(nfs_file_open_context(file));
 
+	xchg(&desc.ctx->error, 0);
 	if (!IS_SYNC(inode)) {
 		ret = nfs_readpage_from_fscache(desc.ctx, inode, page);
 		if (ret == 0)
-			goto out;
+			goto out_wait;
 	}
 
-	xchg(&desc.ctx->error, 0);
 	nfs_pageio_init_read(&desc.pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
@@ -378,6 +378,7 @@ int nfs_readpage(struct file *file, struct page *page)
 
 	nfs_pageio_complete_read(&desc.pgio);
 	ret = desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
+out_wait:
 	if (!ret) {
 		ret = wait_on_page_locked_killable(page);
 		if (!PageUptodate(page) && !ret)
-- 
1.8.3.1

