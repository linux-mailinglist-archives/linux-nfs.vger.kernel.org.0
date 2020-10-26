Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97B3299075
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 16:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783062AbgJZPFh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 11:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403968AbgJZPFh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 11:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603724736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZH1AbaUNoIFiiF2HbJepWq664il8WWobUCRiDkdhzq8=;
        b=HqBoXNhXsDVY04yeoh/DXXDT6bx5mKg0DIcHdtFDIWbjRAJng9GR4A52pr1Jh4Buqh76SJ
        E/chZTUzlKscRLjr/FeazEmZMwHII1LL8K86NEEr9xxHi1qVD8i5b6qTZxRf7MltyZbkhK
        SMDeS7cibLyji03SFk2hf5N9PHBLrTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413--fRyDzxvMNqb516DZ05PBw-1; Mon, 26 Oct 2020 11:05:34 -0400
X-MC-Unique: -fRyDzxvMNqb516DZ05PBw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D06C101F7A6;
        Mon, 26 Oct 2020 15:05:33 +0000 (UTC)
Received: from idlethread.redhat.com (unknown [10.40.192.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56C7E19728;
        Mon, 26 Oct 2020 15:05:31 +0000 (UTC)
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] sunrpc : make RPC channel buffer dynamic for slow case
Date:   Mon, 26 Oct 2020 16:05:30 +0100
Message-Id: <20201026150530.29019-1-rbergant@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

RPC channel buffer size for slow case (user buffer bigger than
one page) can be converted into dymanic and also allows us to
prescind from queue_io_mutex

Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
---
 net/sunrpc/cache.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index baef5ee43dbb..325393f75e17 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -777,7 +777,6 @@ void cache_clean_deferred(void *owner)
  */
 
 static DEFINE_SPINLOCK(queue_lock);
-static DEFINE_MUTEX(queue_io_mutex);
 
 struct cache_queue {
 	struct list_head	list;
@@ -908,14 +907,18 @@ static ssize_t cache_do_downcall(char *kaddr, const char __user *buf,
 static ssize_t cache_slow_downcall(const char __user *buf,
 				   size_t count, struct cache_detail *cd)
 {
-	static char write_buf[8192]; /* protected by queue_io_mutex */
+	char *write_buf;
 	ssize_t ret = -EINVAL;
 
-	if (count >= sizeof(write_buf))
+	if (count >= 32768) /* 32k is max userland buffer, lets check anyway */
 		goto out;
-	mutex_lock(&queue_io_mutex);
+
+	write_buf = kvmalloc(count + 1, GFP_KERNEL);
+	if (!write_buf)
+		return -ENOMEM;
+
 	ret = cache_do_downcall(write_buf, buf, count, cd);
-	mutex_unlock(&queue_io_mutex);
+	kvfree(write_buf);
 out:
 	return ret;
 }
-- 
2.21.0

