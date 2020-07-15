Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DE6221091
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2020 17:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgGOPL5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jul 2020 11:11:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20909 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726785AbgGOPLz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jul 2020 11:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594825914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=TmUm+FqsWNSGezib7++Wn5qxVEto0VOC87DhDKJ5c38=;
        b=ipU8i2Qv99Ye04tboqzFKqa9234KBr71FnDU5m2ZqgTMIJCLjURmRg1Ky1/J2J1xRbPeju
        Nx15+VZ6KS8K1JJlXzRtbcxrCD9EOakq6ibFWcGogKkkRgmDFe18KCNoGnXoUO5RSNWtN2
        dflgvtbsttImvZzcm6gxt9FWAxBT25A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-aqZVDPOjOuqDrpSEp9RRMA-1; Wed, 15 Jul 2020 11:11:52 -0400
X-MC-Unique: aqZVDPOjOuqDrpSEp9RRMA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB41418C8992;
        Wed, 15 Jul 2020 15:10:52 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-118-79.rdu2.redhat.com [10.10.118.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FCE460BF1;
        Wed, 15 Jul 2020 15:10:52 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH v1 02/13] NFS: In nfs_readpage() only increment NFSIOS_READPAGES when read succeeds
Date:   Wed, 15 Jul 2020 11:10:38 -0400
Message-Id: <1594825849-24991-3-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1594825849-24991-1-git-send-email-dwysocha@redhat.com>
References: <1594825849-24991-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

