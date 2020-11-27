Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3122C6BA8
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Nov 2020 19:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgK0Sih (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Nov 2020 13:38:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34943 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727833AbgK0Sih (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Nov 2020 13:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606502316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ezimstzGw2as5v8kBLCxQ7oLzT/ObSdEj0HvJLvgDYA=;
        b=ZfzpzAhLgQGZj2odtdvKnvYKyZz+JzjUwsvVluN0IW52SOwxOofeEwW/OOOT613ck2zaxP
        GD5mx8iV3h6Yb1VclhfWm9FgSQRMMKbAo4+GLznaK04mQVHJx3dVdqhRaiXl2D0l+Jd2l6
        gwGBS/y7oBb1REFtioQ18h1qqV/Avfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-CTKK2xTgP3y0Zy5Rw-Isng-1; Fri, 27 Nov 2020 13:38:34 -0500
X-MC-Unique: CTKK2xTgP3y0Zy5Rw-Isng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F85D3FD2;
        Fri, 27 Nov 2020 18:38:33 +0000 (UTC)
Received: from idlethread.redhat.com (unknown [10.40.193.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74EB45C1C2;
        Fri, 27 Nov 2020 18:38:32 +0000 (UTC)
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] sunrpc: clean-up cache downcall
Date:   Fri, 27 Nov 2020 19:38:31 +0100
Message-Id: <20201127183831.25012-1-rbergant@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We can simplify code around cache_downcall unifying memory
allocations using kvmalloc. This has the benefit of getting rid of
cache_slow_downcall (and queue_io_mutex), and also matches userland
allocation size and limits

Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
---
 net/sunrpc/cache.c | 41 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 20c93b68505e..1a2c1c44bb00 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -778,7 +778,6 @@ void cache_clean_deferred(void *owner)
  */
 
 static DEFINE_SPINLOCK(queue_lock);
-static DEFINE_MUTEX(queue_io_mutex);
 
 struct cache_queue {
 	struct list_head	list;
@@ -906,44 +905,26 @@ static ssize_t cache_do_downcall(char *kaddr, const char __user *buf,
 	return ret;
 }
 
-static ssize_t cache_slow_downcall(const char __user *buf,
-				   size_t count, struct cache_detail *cd)
-{
-	static char write_buf[32768]; /* protected by queue_io_mutex */
-	ssize_t ret = -EINVAL;
-
-	if (count >= sizeof(write_buf))
-		goto out;
-	mutex_lock(&queue_io_mutex);
-	ret = cache_do_downcall(write_buf, buf, count, cd);
-	mutex_unlock(&queue_io_mutex);
-out:
-	return ret;
-}
-
 static ssize_t cache_downcall(struct address_space *mapping,
 			      const char __user *buf,
 			      size_t count, struct cache_detail *cd)
 {
-	struct page *page;
-	char *kaddr;
+	char *write_buf;
 	ssize_t ret = -ENOMEM;
 
-	if (count >= PAGE_SIZE)
-		goto out_slow;
+	if (count >= 32768) { /* 32k is max userland buffer, lets check anyway */
+		ret = -EINVAL;
+		goto out;
+	}
 
-	page = find_or_create_page(mapping, 0, GFP_KERNEL);
-	if (!page)
-		goto out_slow;
+	write_buf = kvmalloc(count + 1, GFP_KERNEL);
+	if (!write_buf)
+		goto out;
 
-	kaddr = kmap(page);
-	ret = cache_do_downcall(kaddr, buf, count, cd);
-	kunmap(page);
-	unlock_page(page);
-	put_page(page);
+	ret = cache_do_downcall(write_buf, buf, count, cd);
+	kvfree(write_buf);
+out:
 	return ret;
-out_slow:
-	return cache_slow_downcall(buf, count, cd);
 }
 
 static ssize_t cache_write(struct file *filp, const char __user *buf,
-- 
2.21.0

