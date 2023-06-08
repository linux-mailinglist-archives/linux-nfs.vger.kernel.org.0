Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB51728A5C
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jun 2023 23:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjFHVm2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Jun 2023 17:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFHVm1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Jun 2023 17:42:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C705D2D7C
        for <linux-nfs@vger.kernel.org>; Thu,  8 Jun 2023 14:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686260500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gkXER8b7tlyAIoCC6U7LKpfJgf1PcreteHGOeKrXzqo=;
        b=be/Gm//9OqRmi4EDCGdxN2CxuqA0M6Je7L3ADbivC6uuxFQwmLGnKPxAaO71cXA/9cN/eW
        9fKWorFOGE0qM1sSQ/gWd3xp/4Ot62WXgdzmSTBlAKw/PoMFv6KPmjR43p4/EHPLKSTqeK
        8U71H1CRQ+kJMtA0dSH3WXOyOVRTzvc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-4Cz37dkOOQuc8uPr0cEwMw-1; Thu, 08 Jun 2023 17:41:39 -0400
X-MC-Unique: 4Cz37dkOOQuc8uPr0cEwMw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A609811E7C
        for <linux-nfs@vger.kernel.org>; Thu,  8 Jun 2023 21:41:39 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4369492B00;
        Thu,  8 Jun 2023 21:41:38 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH] netfs: Only call folio_start_fscache() one time for each folio
Date:   Thu,  8 Jun 2023 17:41:37 -0400
Message-Id: <20230608214137.856006-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If a network filesystem using netfs implements a clamp_length()
function, it can set subrequest lengths smaller than a page size.
When we loop through the folios in netfs_rreq_unlock_folios() to
set any folios to be written back, we need to make sure we only
call folio_start_fscache() once for each folio.  Otherwise,
this simple testcase:
  mount -o fsc,rsize=1024,wsize=1024 127.0.0.1:/export /mnt/nfs
  dd if=/dev/zero of=/mnt/nfs/file.bin bs=4096 count=1
  1+0 records in
  1+0 records out
  4096 bytes (4.1 kB, 4.0 KiB) copied, 0.0126359 s, 324 kB/s
  cat /mnt/nfs/file.bin > /dev/null

will trigger an oops similar to the following:
...
 page dumped because: VM_BUG_ON_FOLIO(folio_test_private_2(folio))
 ------------[ cut here ]------------
 kernel BUG at include/linux/netfs.h:44!
...
 CPU: 5 PID: 134 Comm: kworker/u16:5 Kdump: loaded Not tainted 6.4.0-rc5
...
 RIP: 0010:netfs_rreq_unlock_folios+0x68e/0x730 [netfs]
...
 Call Trace:
  <TASK>
  netfs_rreq_assess+0x497/0x660 [netfs]
  netfs_subreq_terminated+0x32b/0x610 [netfs]
  nfs_netfs_read_completion+0x14e/0x1a0 [nfs]
  nfs_read_completion+0x2f9/0x330 [nfs]
  rpc_free_task+0x72/0xa0 [sunrpc]
  rpc_async_release+0x46/0x70 [sunrpc]
  process_one_work+0x3bd/0x710
  worker_thread+0x89/0x610
  kthread+0x181/0x1c0
  ret_from_fork+0x29/0x50

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/netfs/buffered_read.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 3404707ddbe7..0dafd970c1b6 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -21,6 +21,7 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 	pgoff_t last_page = ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
 	size_t account = 0;
 	bool subreq_failed = false;
+	bool folio_started;
 
 	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
 
@@ -53,6 +54,7 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 
 		pg_end = folio_pos(folio) + folio_size(folio) - 1;
 
+		folio_started = false;
 		for (;;) {
 			loff_t sreq_end;
 
@@ -60,8 +62,10 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 				pg_failed = true;
 				break;
 			}
-			if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
+			if (!folio_started && test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)) {
 				folio_start_fscache(folio);
+				folio_started = true;
+			}
 			pg_failed |= subreq_failed;
 			sreq_end = subreq->start + subreq->len - 1;
 			if (pg_end < sreq_end)
-- 
2.31.1

