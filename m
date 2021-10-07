Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DE4425FDF
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Oct 2021 00:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbhJGWcl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 18:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237789AbhJGWcl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 18:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633645846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=V45i+FwReE6kj3/yFzuyX5hCruxHTg+35FI4Ypm3l6I=;
        b=YRoquI+6sqJ0KjTD3A5dFkPSveaSeVi5hzNVuDr7iHR20d4R2VP0BQy5vGcebMKOmPBOLe
        7YzdSdoGnKveo79h4z4KafIrKuzP/L3AAgZmuseh7hjn4lXO1QLyG5hoaLiuEpspBJIxvT
        yjLNsQF3/fg4EueBH9G/SAKVU3n1gx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-ZHRRVDZrPcSmxYE6wX_CXA-1; Thu, 07 Oct 2021 18:30:45 -0400
X-MC-Unique: ZHRRVDZrPcSmxYE6wX_CXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91E52801AC3;
        Thu,  7 Oct 2021 22:30:44 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F36CE5D9C6;
        Thu,  7 Oct 2021 22:30:43 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH v2  1/7] NFS: Use nfs_i_fscache() consistently within NFS fscache code
Date:   Thu,  7 Oct 2021 18:30:17 -0400
Message-Id: <1633645823-31235-2-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1633645823-31235-1-git-send-email-dwysocha@redhat.com>
References: <1633645823-31235-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The nfs_i_fscache() is the API defined to check whether fscache
is enabled on an NFS inode or not, so use it consistently through
the code.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 679055720dae..f4deea2908e9 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -105,7 +105,7 @@ extern void __nfs_read_completion_to_fscache(struct nfs_pgio_header *hdr,
 static inline int nfs_readpage_from_fscache(struct inode *inode,
 					    struct page *page)
 {
-	if (NFS_I(inode)->fscache)
+	if (nfs_i_fscache(inode))
 		return __nfs_readpage_from_fscache(inode, page);
 	return -ENOBUFS;
 }
@@ -117,7 +117,7 @@ static inline int nfs_readpage_from_fscache(struct inode *inode,
 static inline void nfs_readpage_to_fscache(struct inode *inode,
 					   struct page *page)
 {
-	if (NFS_I(inode)->fscache)
+	if (nfs_i_fscache(inode))
 		__nfs_readpage_to_fscache(inode, page);
 }
 
@@ -126,7 +126,7 @@ static inline void nfs_readpage_to_fscache(struct inode *inode,
  */
 static inline void nfs_fscache_invalidate(struct inode *inode)
 {
-	fscache_invalidate(NFS_I(inode)->fscache);
+	fscache_invalidate(nfs_i_fscache(inode));
 }
 
 /*
@@ -134,7 +134,7 @@ static inline void nfs_fscache_invalidate(struct inode *inode)
  */
 static inline void nfs_fscache_wait_on_invalidate(struct inode *inode)
 {
-	fscache_wait_on_invalidate(NFS_I(inode)->fscache);
+	fscache_wait_on_invalidate(nfs_i_fscache(inode));
 }
 
 /*
-- 
1.8.3.1

