Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1968747DB0E
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Dec 2021 00:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbhLVX1m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Dec 2021 18:27:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238636AbhLVX1m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Dec 2021 18:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640215662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SWuJlHmNIoJyqJI4zoqAAmrL63HNDz1eDsYsOX96shI=;
        b=Ojkt0Cxvj0QTcfPZd0JEiUxtUY66l9pddb4wmrHBi+QUouM2uKEKicFQdx2+aDctKG8/Yr
        QRbKidcTifcqFYKf6F/ktPjf4tMQlA3TPCh9nlnY/LxEVBo68IHS357r7C/i2du1BRNaog
        mJH04spWIauNqQE0b7OfSHYCVFwBKzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-KLReNvG7M6m-r5BLWnePyQ-1; Wed, 22 Dec 2021 18:27:39 -0500
X-MC-Unique: KLReNvG7M6m-r5BLWnePyQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2E7280BCA8;
        Wed, 22 Dec 2021 23:27:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A75937ED7E;
        Wed, 22 Dec 2021 23:27:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 53/68] cachefiles: Allow cachefiles to actually function
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 22 Dec 2021 23:27:23 +0000
Message-ID: <164021564379.640689.7921380491176827442.stgit@warthog.procyon.org.uk>
In-Reply-To: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
References: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Remove the block that allowed cachefiles to be compiled but prevented it
from actually starting a cache.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819649497.215744.2872504990762846767.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163906956491.143852.4951522864793559189.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/163967165374.1823006.14248189932202373809.stgit@warthog.procyon.org.uk/ # v3
---

 fs/cachefiles/daemon.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 61e8740d01be..45af558a696e 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -703,9 +703,7 @@ static int cachefiles_daemon_bind(struct cachefiles_cache *cache, char *args)
 		return -EBUSY;
 	}
 
-	pr_warn("Cache is disabled for development\n");
-	return -ENOANO; // Don't allow the cache to operate yet
-	//return cachefiles_add_cache(cache);
+	return cachefiles_add_cache(cache);
 }
 
 /*


