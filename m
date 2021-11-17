Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10105455037
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Nov 2021 23:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbhKQWUa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Nov 2021 17:20:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241081AbhKQWU1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Nov 2021 17:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637187448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=s9u1t3Pc+ywLlB9c+W1H/XcmtQZKHQES2jKr+Nu6rU8=;
        b=azmpwOoiyYItp+9ySwB6QRGlCEhfCiPmk511X2QaG6ASIJFgHnaZJRofU5X8YEsbd8RqH9
        kJXYXZ+TCWDrSY6uJUAnuiq3estXZUXdsbSEjbEIP19Rj3qCW/L1iwQd3O6JYotLJCqi46
        8SCNwmgkgHrdPirjXY16r0NnZFyloPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-weY4SGQCNaGuuY4WUVXxGw-1; Wed, 17 Nov 2021 17:17:26 -0500
X-MC-Unique: weY4SGQCNaGuuY4WUVXxGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86775100C663;
        Wed, 17 Nov 2021 22:17:25 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.32.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04C0D604CC;
        Wed, 17 Nov 2021 22:17:24 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [PATCH 1/7] NFS: Use nfs_i_fscache() consistently within NFS fscache code
Date:   Wed, 17 Nov 2021 17:17:12 -0500
Message-Id: <1637187438-18858-2-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1637187438-18858-1-git-send-email-dwysocha@redhat.com>
References: <1637187438-18858-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
index 6754c8607230..840608a38713 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -131,7 +131,7 @@ static inline int nfs_readpage_from_fscache(struct nfs_open_context *ctx,
 					    struct inode *inode,
 					    struct page *page)
 {
-	if (NFS_I(inode)->fscache)
+	if (nfs_i_fscache(inode))
 		return __nfs_readpage_from_fscache(ctx, inode, page);
 	return -ENOBUFS;
 }
@@ -145,7 +145,7 @@ static inline int nfs_readpages_from_fscache(struct nfs_open_context *ctx,
 					     struct list_head *pages,
 					     unsigned *nr_pages)
 {
-	if (NFS_I(inode)->fscache)
+	if (nfs_i_fscache(inode))
 		return __nfs_readpages_from_fscache(ctx, inode, mapping, pages,
 						    nr_pages);
 	return -ENOBUFS;
@@ -168,7 +168,7 @@ static inline void nfs_readpage_to_fscache(struct inode *inode,
  */
 static inline void nfs_fscache_invalidate(struct inode *inode)
 {
-	fscache_invalidate(NFS_I(inode)->fscache);
+	fscache_invalidate(nfs_i_fscache(inode));
 }
 
 /*
@@ -176,7 +176,7 @@ static inline void nfs_fscache_invalidate(struct inode *inode)
  */
 static inline void nfs_fscache_wait_on_invalidate(struct inode *inode)
 {
-	fscache_wait_on_invalidate(NFS_I(inode)->fscache);
+	fscache_wait_on_invalidate(nfs_i_fscache(inode));
 }
 
 /*
-- 
1.8.3.1

