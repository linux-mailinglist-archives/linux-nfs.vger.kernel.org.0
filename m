Return-Path: <linux-nfs+bounces-1631-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B25B8443C4
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 17:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC7C1C25C40
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Jan 2024 16:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D1484A3B;
	Wed, 31 Jan 2024 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQZjHeFG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145612A169
	for <linux-nfs@vger.kernel.org>; Wed, 31 Jan 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717416; cv=none; b=IUj6onOq+9mhjxi4pMZEBfmdB8PFzCWNIcL39mS0S/5c+hPZmRBkqyW0AS8nWPFrTEj01hk2Ux/UUdqddW9p+PL7PhTQ2EtnTzkNW8M3TkXbXejgpj/NxmoNQl5SL8wDvj8OaTHz5QC648yyMw4W3zmUThcNMzP23rQAfH9QR5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717416; c=relaxed/simple;
	bh=KIwu6QR8r5b8azkpBjVzwHeOJhLwEzV3M5sqyYZeugI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l2qHENpgek6XHaOcczOxXVd8eULlZ3IdDEu3tcnPsDMYpxxx2OiWsAyC5JVIXX7EOnhfn4JqlPmuORgGD4NW2uYOjrhPcIEVB3IyXZH/kJuosvXqU01Qaa/649/B9bQdXrwFwKHynRy2eWZryHdW3Sn6VeuISyCcQdgGMKTdcEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQZjHeFG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706717413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lt3sHrhpNk4V3mKbYLYm+tjlUNv9hVfDfiEkd/fQy0w=;
	b=PQZjHeFGLLuL/5MFj18ON1pKZpM5i47F1vD2QXw+mI0wDz6aKkz5SAIIPSuRYzJuoE7GZy
	F5bhg9e4r2KqC4nUGtStG7Ygj08o2JQdC4OxmDVdE8fTuSl0NPn1mrIvjNNd7BAibszaiq
	Fwr663B9Lik8n5s0aF6aHXfYmX30x/k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-R1GsC0IPMiuIwTcM94QHZg-1; Wed,
 31 Jan 2024 11:10:08 -0500
X-MC-Unique: R1GsC0IPMiuIwTcM94QHZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35E733C29A71;
	Wed, 31 Jan 2024 16:10:08 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.9.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BD6A63C2E;
	Wed, 31 Jan 2024 16:10:07 +0000 (UTC)
From: Dave Wysochanski <dwysocha@redhat.com>
To: Anna Schumaker <anna.schumaker@netapp.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-cachefs@redhat.com
Subject: [PATCH v2] NFS: Fix nfs_netfs_issue_read() xarray locking for writeback interrupt
Date: Wed, 31 Jan 2024 11:10:06 -0500
Message-Id: <20240131161006.1475094-1-dwysocha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

The loop inside nfs_netfs_issue_read() currently does not disable
interrupts while iterating through pages in the xarray to submit
for NFS read.  This is not safe though since after taking xa_lock,
another page in the mapping could be processed for writeback inside
an interrupt, and deadlock can occur.  The fix is simple and clean
if we use xa_for_each_range(), which handles the iteration with RCU
while reducing code complexity.

The problem is easily reproduced with the following test:
 mount -o vers=3,fsc 127.0.0.1:/export /mnt/nfs
 dd if=/dev/zero of=/mnt/nfs/file1.bin bs=4096 count=1
 echo 3 > /proc/sys/vm/drop_caches
 dd if=/mnt/nfs/file1.bin of=/dev/null
 umount /mnt/nfs

On the console with a lockdep-enabled kernel a message similar to
the following will be seen:

 ================================
 WARNING: inconsistent lock state
 6.7.0-lockdbg+ #10 Not tainted
 --------------------------------
 inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
 test5/1708 [HC0[0]:SC0[0]:HE1:SE1] takes:
 ffff888127baa598 (&xa->xa_lock#4){+.?.}-{3:3}, at:
nfs_netfs_issue_read+0x1b2/0x4b0 [nfs]
 {IN-SOFTIRQ-W} state was registered at:
   lock_acquire+0x144/0x380
   _raw_spin_lock_irqsave+0x4e/0xa0
   __folio_end_writeback+0x17e/0x5c0
   folio_end_writeback+0x93/0x1b0
   iomap_finish_ioend+0xeb/0x6a0
   blk_update_request+0x204/0x7f0
   blk_mq_end_request+0x30/0x1c0
   blk_complete_reqs+0x7e/0xa0
   __do_softirq+0x113/0x544
   __irq_exit_rcu+0xfe/0x120
   irq_exit_rcu+0xe/0x20
   sysvec_call_function_single+0x6f/0x90
   asm_sysvec_call_function_single+0x1a/0x20
   pv_native_safe_halt+0xf/0x20
   default_idle+0x9/0x20
   default_idle_call+0x67/0xa0
   do_idle+0x2b5/0x300
   cpu_startup_entry+0x34/0x40
   start_secondary+0x19d/0x1c0
   secondary_startup_64_no_verify+0x18f/0x19b
 irq event stamp: 176891
 hardirqs last  enabled at (176891): [<ffffffffa67a0be4>]
_raw_spin_unlock_irqrestore+0x44/0x60
 hardirqs last disabled at (176890): [<ffffffffa67a0899>]
_raw_spin_lock_irqsave+0x79/0xa0
 softirqs last  enabled at (176646): [<ffffffffa515d91e>]
__irq_exit_rcu+0xfe/0x120
 softirqs last disabled at (176633): [<ffffffffa515d91e>]
__irq_exit_rcu+0xfe/0x120

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&xa->xa_lock#4);
   <Interrupt>
     lock(&xa->xa_lock#4);

  *** DEADLOCK ***

 2 locks held by test5/1708:
  #0: ffff888127baa498 (&sb->s_type->i_mutex_key#22){++++}-{4:4}, at:
      nfs_start_io_read+0x28/0x90 [nfs]
  #1: ffff888127baa650 (mapping.invalidate_lock#3){.+.+}-{4:4}, at:
      page_cache_ra_unbounded+0xa4/0x280

 stack backtrace:
 CPU: 6 PID: 1708 Comm: test5 Kdump: loaded Not tainted 6.7.0-lockdbg+
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39
04/01/2014
 Call Trace:
  dump_stack_lvl+0x5b/0x90
  mark_lock+0xb3f/0xd20
  __lock_acquire+0x77b/0x3360
  _raw_spin_lock+0x34/0x80
  nfs_netfs_issue_read+0x1b2/0x4b0 [nfs]
  netfs_begin_read+0x77f/0x980 [netfs]
  nfs_netfs_readahead+0x45/0x60 [nfs]
  nfs_readahead+0x323/0x5a0 [nfs]
  read_pages+0xf3/0x5c0
  page_cache_ra_unbounded+0x1c8/0x280
  filemap_get_pages+0x38c/0xae0
  filemap_read+0x206/0x5e0
  nfs_file_read+0xb7/0x140 [nfs]
  vfs_read+0x2a9/0x460
  ksys_read+0xb7/0x140

Fixes: 000dbe0bec05 ("NFS: Convert buffered read paths to use netfs when
fscache is enabled")
Suggested-by: Jeff Layton <jlayton@redhat.com>
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index b05717fe0d4e..60a3c28784e0 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -307,11 +307,11 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 	struct inode *inode = sreq->rreq->inode;
 	struct nfs_open_context *ctx = sreq->rreq->netfs_priv;
 	struct page *page;
+	unsigned long idx;
 	int err;
 	pgoff_t start = (sreq->start + sreq->transferred) >> PAGE_SHIFT;
 	pgoff_t last = ((sreq->start + sreq->len -
 			 sreq->transferred - 1) >> PAGE_SHIFT);
-	XA_STATE(xas, &sreq->rreq->mapping->i_pages, start);
 
 	nfs_pageio_init_read(&pgio, inode, false,
 			     &nfs_async_read_completion_ops);
@@ -322,19 +322,14 @@ static void nfs_netfs_issue_read(struct netfs_io_subrequest *sreq)
 
 	pgio.pg_netfs = netfs; /* used in completion */
 
-	xas_lock(&xas);
-	xas_for_each(&xas, page, last) {
+	xa_for_each_range(&sreq->rreq->mapping->i_pages, idx, page, start, last) {
 		/* nfs_read_add_folio() may schedule() due to pNFS layout and other RPCs  */
-		xas_pause(&xas);
-		xas_unlock(&xas);
 		err = nfs_read_add_folio(&pgio, ctx, page_folio(page));
 		if (err < 0) {
 			netfs->error = err;
 			goto out;
 		}
-		xas_lock(&xas);
 	}
-	xas_unlock(&xas);
 out:
 	nfs_pageio_complete_read(&pgio);
 	nfs_netfs_put(netfs);
-- 
2.39.3


