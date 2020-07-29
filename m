Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAFD231FFB
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jul 2020 16:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgG2OMr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jul 2020 10:12:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43933 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726365AbgG2OMq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jul 2020 10:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596031965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=TmUm+FqsWNSGezib7++Wn5qxVEto0VOC87DhDKJ5c38=;
        b=akSfiNAywGZyxtlouVOEFinpDXslg7yk0TlzUe0lQkI+K9kR4R/DX4nYc2GjJHjwnsAzAA
        WScr9X7jR5wOd+eahx1fxBJWom1ie3tyrRLJLgD9gG5bAQ9skcNZ0uWCfl58d72c1eA0K3
        8g8WybVXAH5iPqN6n3RYadEle2Koey4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-jALQDIdRMKayYvNL_gUXWg-1; Wed, 29 Jul 2020 10:12:43 -0400
X-MC-Unique: jALQDIdRMKayYvNL_gUXWg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7990E59;
        Wed, 29 Jul 2020 14:12:42 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-23.rdu2.redhat.com [10.10.113.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0169D71906;
        Wed, 29 Jul 2020 14:12:41 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH v2 02/14] NFS: In nfs_readpage() only increment NFSIOS_READPAGES when read succeeds
Date:   Wed, 29 Jul 2020 10:12:17 -0400
Message-Id: <1596031949-26793-3-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
References: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There is a small inconsistency with nfs_readpage() vs nfs_readpages() with
regards to NFSIOS_READPAGES.  In readpage we unconditionally increment
NFSIOS_READPAGES at the top, which means even if the read fails.  In
readpages, we increment NFSIOS_READPAGES at the bottom based on how
many pages were successfully read.  Change readpage to be consistent with
readpages and so NFSIOS_READPAGES only reflects successful, non-fscache
reads.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/read.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index a05fb3904ddf..1153c4e0a155 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -319,7 +319,6 @@ int nfs_readpage(struct file *filp, struct page *page)
 	dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
 		page, PAGE_SIZE, page_index(page));
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
-	nfs_add_stats(inode, NFSIOS_READPAGES, 1);
 
 	/*
 	 * Try to flush any pending writes to the file..
@@ -359,6 +358,7 @@ int nfs_readpage(struct file *filp, struct page *page)
 		if (!PageUptodate(page) && !ret)
 			ret = xchg(&ctx->error, 0);
 	}
+	nfs_add_stats(inode, NFSIOS_READPAGES, 1);
 out:
 	put_nfs_open_context(ctx);
 	return ret;
-- 
1.8.3.1

