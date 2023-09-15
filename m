Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535637A26B5
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Sep 2023 20:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjIOS6l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Sep 2023 14:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbjIOS6c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Sep 2023 14:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A75B30E5
        for <linux-nfs@vger.kernel.org>; Fri, 15 Sep 2023 11:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694804226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y5Z6CVKH3lMmihuARi7BENc6i+HbhVs9+7j72TaugC4=;
        b=d9obGmMZ1jP57kBfKh8sAb8WRoVApv9Gff3xlhuyssAHsJoiJcK4RLKkst7xEWXgrd35Z/
        0BIT9XpJwuKLC4AJyvUdZ1aGZnfPwCXlsKNWq0wEI+ejUsphFNE8bJagVSqNz4OUZwt0JZ
        sYcgnTqoysgvWNjsNEsHq+BbfejmGHE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-gucIQATfPrKkMv-A3x-f2w-1; Fri, 15 Sep 2023 14:57:05 -0400
X-MC-Unique: gucIQATfPrKkMv-A3x-f2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FF8785829B
        for <linux-nfs@vger.kernel.org>; Fri, 15 Sep 2023 18:57:05 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.32.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DEDB240C2009;
        Fri, 15 Sep 2023 18:57:04 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH v2] netfs: Only call folio_start_fscache() one time for each folio
Date:   Fri, 15 Sep 2023 14:57:04 -0400
Message-Id: <20230915185704.1082982-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
  echo 3 > /proc/sys/vm/drop_caches
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

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2210612
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/netfs/buffered_read.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 3404707ddbe7..2cd3ccf4c439 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -47,12 +47,14 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 	xas_for_each(&xas, folio, last_page) {
 		loff_t pg_end;
 		bool pg_failed = false;
+		bool folio_started;
 
 		if (xas_retry(&xas, folio))
 			continue;
 
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
2.39.3

