Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED66B2BBF35
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Nov 2020 14:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbgKUN3V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Nov 2020 08:29:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727702AbgKUN3T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Nov 2020 08:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605965358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=TmUm+FqsWNSGezib7++Wn5qxVEto0VOC87DhDKJ5c38=;
        b=TZzJoqIJ5/5W2MU35dPepxQAidjzFejcjwHba/Lfow3aK0qv8UHqSLswT5UYAWA0+yTWUH
        cax4CjrBk+JCkj2tMsOjDvwYiN7B/J5JuRgPu9QS9twUIfltRtlV8D0xYx1Zud47qAvGyh
        EX9BiRysfRifiStXj1Z0aNra3jFpSeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-7kPhSD1tP7mATZB1MMSQgA-1; Sat, 21 Nov 2020 08:29:17 -0500
X-MC-Unique: 7kPhSD1tP7mATZB1MMSQgA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8FF71DDE7;
        Sat, 21 Nov 2020 13:29:15 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-41.rdu2.redhat.com [10.10.112.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 700AA1002C10;
        Sat, 21 Nov 2020 13:29:15 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, dhowells@redhat.com
Subject: [PATCH v1 02/13] NFS: In nfs_readpage() only increment NFSIOS_READPAGES when read succeeds
Date:   Sat, 21 Nov 2020 08:29:14 -0500
Message-Id: <1605965354-24538-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

