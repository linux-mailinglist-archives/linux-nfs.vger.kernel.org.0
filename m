Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751B22924AA
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Oct 2020 11:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgJSJeG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Oct 2020 05:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60207 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgJSJeG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Oct 2020 05:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603100045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1y0arW5wnpA4t/DZKMGDdX2hQ2fWQVeIfL02zg8aCKs=;
        b=du172YmuhavGxi4h33qS0jKKCiMipHpJwrk/N0SwtxOXy2TqbXT4FNGp/LsDIfQ4ferGEc
        b65jn5EA6jr4ohKSYCdCzYourXWREnoc8wTJbBrtDLNxdcuHqpmkwD9K/qDJGOpXJRogvD
        ncYl/aAowVoUszpNQBaIpErScvP94zI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-AHjXRvlPPUyussd3QMRbPA-1; Mon, 19 Oct 2020 05:34:00 -0400
X-MC-Unique: AHjXRvlPPUyussd3QMRbPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E631B835B48;
        Mon, 19 Oct 2020 09:33:58 +0000 (UTC)
Received: from idlethread.redhat.com (unknown [10.33.36.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ECA85576F;
        Mon, 19 Oct 2020 09:33:57 +0000 (UTC)
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] sunrpc: raise kernel RPC channel buffer size
Date:   Mon, 19 Oct 2020 11:33:56 +0200
Message-Id: <20201019093356.7395-1-rbergant@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Its possible that using AUTH_SYS and mountd manage-gids option a
user may hit the 8k RPC channel buffer limit. This have been observed
on field, causing unanswered RPCs on clients after mountd fails to
write on channel :

rpc.mountd[11231]: auth_unix_gid: error writing reply

Userland nfs-utils uses a buffer size of 32k (RPC_CHAN_BUF_SIZE), so
lets match those two.

Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
---
 net/sunrpc/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index baef5ee43dbb..08df4c599ab3 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -908,7 +908,7 @@ static ssize_t cache_do_downcall(char *kaddr, const char __user *buf,
 static ssize_t cache_slow_downcall(const char __user *buf,
 				   size_t count, struct cache_detail *cd)
 {
-	static char write_buf[8192]; /* protected by queue_io_mutex */
+	static char write_buf[32768]; /* protected by queue_io_mutex */
 	ssize_t ret = -EINVAL;
 
 	if (count >= sizeof(write_buf))
-- 
2.21.0

