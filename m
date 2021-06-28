Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663DF3B67C9
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 19:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhF1Rli (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 13:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232740AbhF1Rlh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Jun 2021 13:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624901951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=su5GztBQePce6b61ombayzZCx/qD/RatOy3s66bb9PM=;
        b=fatwR2Ig3JsPEyMbfRRe2RUbnpYQ6/Vyx1XL1Ht9E4oLKDrG2UXqoAnWJoi0HcP6pl0g0j
        Jk4UgVQDPKOokDfKat/+vbk6GLMkaHw94W6r28J+zUg22Odw7YIFCykM+dAHQTrSRcF/PT
        WsfDDFkhqeIEygI20aKuoC5/o63mvag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-EuwHlo5-OouLwOUq6e2hYA-1; Mon, 28 Jun 2021 13:39:10 -0400
X-MC-Unique: EuwHlo5-OouLwOUq6e2hYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 276E81084F58;
        Mon, 28 Jun 2021 17:39:09 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB3345D9F0;
        Mon, 28 Jun 2021 17:39:08 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] NFS: Fix fscache read from NFS after cache error
Date:   Mon, 28 Jun 2021 13:39:03 -0400
Message-Id: <1624901943-20027-5-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
References: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
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

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index c4c021c6ebbd..d308cb7e1dd4 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -381,15 +381,25 @@ static void nfs_readpage_from_fscache_complete(struct page *page,
 					       void *context,
 					       int error)
 {
+	struct nfs_readdesc desc;
+	struct inode *inode = page->mapping->host;
+
 	dfprintk(FSCACHE,
 		 "NFS: readpage_from_fscache_complete (0x%p/0x%p/%d)\n",
 		 page, context, error);
 
-	/* if the read completes with an error, we just unlock the page and let
-	 * the VM reissue the readpage */
 	if (!error) {
 		SetPageUptodate(page);
 		unlock_page(page);
+	} else {
+		desc.ctx = context;
+		nfs_pageio_init_read(&desc.pgio, inode, false,
+				     &nfs_async_read_completion_ops);
+		error = readpage_async_filler(&desc, page);
+		if (error)
+			return;
+
+		nfs_pageio_complete_read(&desc.pgio);
 	}
 }
 
-- 
1.8.3.1

