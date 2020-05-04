Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3751C4150
	for <lists+linux-nfs@lfdr.de>; Mon,  4 May 2020 19:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbgEDRLS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 May 2020 13:11:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60516 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730289AbgEDRLR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 May 2020 13:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lNAduzzuKeSCLVJVxHq3/nFwBPqJuFagmogUvLzuLoA=;
        b=VJ7Hq40N79vNo7f6sDHOukg6mSM+I4ZNMFxtKCNglLiKXjlA3x2G13Wu/VpLAh+RV6aLUB
        FZNIoyfAn9aFQC7K5yjTNmFRMu7lDRgvDhccg1xPiKHlo9Uu+pB85MjH4zSg/pe/Ln1Z1V
        MYXC3hExcbimSVEfN0t4PobN5Z5Xocs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-uTxEv5ZLMWK6Wp-THpS_-A-1; Mon, 04 May 2020 13:11:13 -0400
X-MC-Unique: uTxEv5ZLMWK6Wp-THpS_-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7460C1005510;
        Mon,  4 May 2020 17:11:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E501E6FDAB;
        Mon,  4 May 2020 17:11:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 24/61] fscache: Remove fscache_wait_on_invalidate()
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:11:08 +0100
Message-ID: <158861226805.340223.17642402641089437416.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Remove fscache_wait_on_invalidate() as the invalidation wait is now built into
the I/O path.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/cookie.c     |   14 --------------
 include/linux/fscache.h |   17 -----------------
 2 files changed, 31 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 3a1b71e09c6b..38b8fcf33114 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -492,20 +492,6 @@ void __fscache_invalidate(struct fscache_cookie *cookie)
 }
 EXPORT_SYMBOL(__fscache_invalidate);
 
-/*
- * Wait for object invalidation to complete.
- */
-void __fscache_wait_on_invalidate(struct fscache_cookie *cookie)
-{
-	_enter("%p", cookie);
-
-	wait_on_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING,
-		    TASK_UNINTERRUPTIBLE);
-
-	_leave("");
-}
-EXPORT_SYMBOL(__fscache_wait_on_invalidate);
-
 /*
  * Update the index entries backing a cookie.  The writeback is done lazily.
  */
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 98a6bd668f48..607249ff1bc5 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -188,7 +188,6 @@ extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, const
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_invalidate(struct fscache_cookie *);
-extern void __fscache_wait_on_invalidate(struct fscache_cookie *);
 extern unsigned int __fscache_shape_extent(struct fscache_cookie *,
 					   struct fscache_extent *,
 					   loff_t, bool);
@@ -439,22 +438,6 @@ void fscache_invalidate(struct fscache_cookie *cookie)
 		__fscache_invalidate(cookie);
 }
 
-/**
- * fscache_wait_on_invalidate - Wait for invalidation to complete
- * @cookie: The cookie representing the cache object
- *
- * Wait for the invalidation of an object to complete.
- *
- * See Documentation/filesystems/caching/netfs-api.txt for a complete
- * description.
- */
-static inline
-void fscache_wait_on_invalidate(struct fscache_cookie *cookie)
-{
-	if (fscache_cookie_valid(cookie))
-		__fscache_wait_on_invalidate(cookie);
-}
-
 /**
  * fscache_init_io_request - Initialise an I/O request
  * @req: The I/O request to initialise


