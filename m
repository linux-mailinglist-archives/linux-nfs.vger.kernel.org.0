Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD536195A53
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2020 16:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgC0PxS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 11:53:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22966 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726900AbgC0PxS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 11:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585324397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ux9281k5ABNf6TBBZshoWzpO+bbygIq24q5khD5TiA=;
        b=UM1EawGzdFppvpq0ZaVgH8ryyOD5/vH9HbvIngz7b4tImklLxgU1cIsmsgrhehKcsnexgD
        qf9XCGcKeksi2orM56NTWFsMjxNTquWhYAt1sQXCUWUKXTyFpt/QSBeBQJIgtKPqLoysVn
        wH9Lx62qEYMAHBGuESydlLyhJxbQaXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-XdiGj_h6NCOK8aNdh-iUtw-1; Fri, 27 Mar 2020 11:53:12 -0400
X-MC-Unique: XdiGj_h6NCOK8aNdh-iUtw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B0181005514;
        Fri, 27 Mar 2020 15:53:11 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-119-7.rdu2.redhat.com [10.10.119.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE1EACFCC;
        Fri, 27 Mar 2020 15:53:10 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 851DE12023D; Fri, 27 Mar 2020 11:53:09 -0400 (EDT)
Date:   Fri, 27 Mar 2020 11:53:09 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "kinglongmee@gmail.com" <kinglongmee@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: [PATCH] SUNRPC/cache: don't allow invalid entries to be flushed
Message-ID: <20200327155309.GA135601@pick.fieldses.org>
References: <20200114165738.922961-1-trond.myklebust@hammerspace.com>
 <20200206163322.GB2244@fieldses.org>
 <8dc1ed17de98e4b59fb9e408692c152456863a20.camel@hammerspace.com>
 <20200207181817.GC17036@fieldses.org>
 <20200326204001.GA25053@fieldses.org>
 <1a0ce8bb1150835f7a25126df2524e8a8fb0e112.camel@hammerspace.com>
 <20200327015012.GA107036@pick.fieldses.org>
 <80c83f5543d7d758a165be167d3bf0b2175e57f8.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80c83f5543d7d758a165be167d3bf0b2175e57f8.camel@hammerspace.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Trond points out in 277f27e2f277 that we allow invalid cache entries to
persist indefinitely.  That fix, however, reintroduces the problem fixed
by Kinglong Mee's d6fc8821c2d2 "SUNRPC/Cache: Always treat the invalid
cache as unexpired", where an invalid cache entry is immediately removed
by a flush before mountd responds to it.  The result is that the server
thread that should be waiting for mountd to fill in that entry instead
gets an -ETIMEDOUT return from cache_check().  Symptoms are the server
becoming unresponsive after a restart, reproduceable by running pynfs
4.1 test REBT5.

Instead, take a compromise approach: allow invalid cache entries to be
removed after they expire, but not to be removed by a cache flush.

Fixes: 277f27e2f277 "SUNRPC/cache: Allow garbage collection..."
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 include/linux/sunrpc/cache.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index 532cdbda43da..10891b70fc7b 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -209,8 +209,11 @@ static inline void cache_put(struct cache_head *h, struct cache_detail *cd)
 
 static inline bool cache_is_expired(struct cache_detail *detail, struct cache_head *h)
 {
-	return  (h->expiry_time < seconds_since_boot()) ||
-		(detail->flush_time >= h->last_refresh);
+	if (h->expiry_time < seconds_since_boot())
+		return true;
+	if (!test_bit(CACHE_VALID, &h->flags))
+		return false;
+	return detail->flush_time >= h->last_refresh;
 }
 
 extern int cache_check(struct cache_detail *detail,
-- 
2.25.1

