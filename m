Return-Path: <linux-nfs+bounces-15384-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80273BEE258
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 11:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21544189F393
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Oct 2025 09:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D5A2E1F04;
	Sun, 19 Oct 2025 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJQSJoUf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAD12066DE
	for <linux-nfs@vger.kernel.org>; Sun, 19 Oct 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760866199; cv=none; b=jPFJ5akWE1QtEPnZhuOhrDZmnjDmPOy01hySp4jMn2fvUlAJ1gwrJu6fcAju3fIkVXC8vd0DoHKruEW1ZXDgBZ4QltDSjtA/yb0kywf00xFkKw+z5aesygQLErcOmSofa0w9IkYB7nROXKZELQ2ObDAKD/Ml/Tx7FtvbxMb+EJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760866199; c=relaxed/simple;
	bh=GAArhuD/ystMPCA/w4MoB4oNcpyFa0jLyYWuosVC8Hw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h1GYzrYEv9zcsl3FeLv2PLYposch7aKLlKOxfZTPag0J/DvGczaX/TG8mObIdUSYBvlsqGRUL9LQdpeuGbgjVkoEqWy1GgLILBXyDet8gaSFwWmqAzCz7pc98Y1ZeQVZxMtCrUBXOpoXRo/7cDKrE7kopHabynzGewFnLpNSvfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJQSJoUf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760866196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=vY6P4kKU9rHuzFSaGtBoXbZsgODNoWkrXSmNXL+HUVw=;
	b=MJQSJoUfXZsjpxJNegb8DD+wv4rjGsYUlJq1TD6BySvwDXpTROVcD2uEAynmm1cH47plHk
	hU/37LOr6ddR5daO4n5m5apyWTYHLrARDSQNTe1XaR3plU1KnGDZo1t99POAht8PmW61ai
	MnDtbl/P35bptlSbcNLypqHOG2gKzAU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-Rx4wt8GQPPm_vuEoVW3_LA-1; Sun,
 19 Oct 2025 05:29:54 -0400
X-MC-Unique: Rx4wt8GQPPm_vuEoVW3_LA-1
X-Mimecast-MFC-AGG-ID: Rx4wt8GQPPm_vuEoVW3_LA_1760866193
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 761EB1956089
	for <linux-nfs@vger.kernel.org>; Sun, 19 Oct 2025 09:29:53 +0000 (UTC)
Received: from dell-per750-06-vm-07.rhts.eng.pek2.redhat.com (dell-per750-06-vm-07.rhts.eng.pek2.redhat.com [10.73.180.56])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F5E01800452
	for <linux-nfs@vger.kernel.org>; Sun, 19 Oct 2025 09:29:51 +0000 (UTC)
Date: Sun, 19 Oct 2025 17:29:47 +0800
From: Yongcheng Yang <yoyang@redhat.com>
To: linux-nfs@vger.kernel.org
Subject: [Bug report] xfstests generic/323 over NFS hit BUG: KASAN:
 slab-use-after-free in nfs_local_call_read on 6.18.0-rc1
Message-ID: <aPSvi5Yr2lGOh5Jh@dell-per750-06-vm-07.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi All,

There is a new nfs slab-use-after-free issue since 6.18.0-rc1.
It appears to be reliably reproducible on my side when running xfstests
generic/323 over NFSv4.2 in *debug* kernel mode:

[18265.311177] ==================================================================
[18265.315831] BUG: KASAN: slab-use-after-free in nfs_local_call_read+0x590/0x7f0 [nfs]
[18265.320135] Read of size 2 at addr ffff8881090556a2 by task kworker/u9:0/667366

[18265.325454] CPU: 0 UID: 0 PID: 667366 Comm: kworker/u9:0 Not tainted 6.18.0-rc1 #1 PREEMPT(full) 
[18265.325461] Hardware name: Red Hat KVM/RHEL, BIOS edk2-20241117-2.el9 11/17/2024
[18265.325465] Workqueue: nfslocaliod nfs_local_call_read [nfs]
[18265.325611] Call Trace:
[18265.325615]  <TASK>
[18265.325619]  dump_stack_lvl+0x77/0xa0
[18265.325629]  print_report+0x171/0x820
[18265.325637]  ? __virt_addr_valid+0x151/0x3a0
[18265.325644]  ? __virt_addr_valid+0x300/0x3a0
[18265.325650]  ? nfs_local_call_read+0x590/0x7f0 [nfs]
[18265.325770]  kasan_report+0x167/0x1a0
[18265.325777]  ? nfs_local_call_read+0x590/0x7f0 [nfs]
[18265.325900]  nfs_local_call_read+0x590/0x7f0 [nfs]
[18265.326027]  ? process_scheduled_works+0x7d3/0x11d0
[18265.326034]  process_scheduled_works+0x857/0x11d0
[18265.326050]  worker_thread+0x897/0xd00
[18265.326065]  kthread+0x51b/0x650
[18265.326071]  ? __pfx_worker_thread+0x10/0x10
[18265.326076]  ? __pfx_kthread+0x10/0x10
[18265.326082]  ret_from_fork+0x249/0x480
[18265.326087]  ? __pfx_kthread+0x10/0x10
[18265.326092]  ret_from_fork_asm+0x1a/0x30
[18265.326104]  </TASK>

[18265.378345] Allocated by task 681242:
[18265.380068]  kasan_save_track+0x3e/0x80
[18265.381838]  __kasan_kmalloc+0x93/0xb0
[18265.383587]  __kmalloc_cache_noprof+0x3eb/0x6e0
[18265.385532]  nfs_local_doio+0x1cb/0xeb0 [nfs]
[18265.387630]  nfs_initiate_pgio+0x284/0x400 [nfs]
[18265.389815]  nfs_generic_pg_pgios+0x6e2/0x810 [nfs]
[18265.391998]  nfs_pageio_complete+0x278/0x750 [nfs]
[18265.394146]  nfs_file_direct_read+0x78c/0x9e0 [nfs]
[18265.396386]  vfs_read+0x5d0/0x770
[18265.398043]  __x64_sys_pread64+0xed/0x160
[18265.399837]  do_syscall_64+0xad/0x7d0
[18265.401561]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[18265.404687] Freed by task 596986:
[18265.406245]  kasan_save_track+0x3e/0x80
[18265.408013]  __kasan_save_free_info+0x46/0x50
[18265.409884]  __kasan_slab_free+0x58/0x80
[18265.411613]  kfree+0x1c1/0x620
[18265.413075]  nfs_local_read_aio_complete_work+0x86/0x100 [nfs]
[18265.415486]  process_scheduled_works+0x857/0x11d0
[18265.417437]  worker_thread+0x897/0xd00
[18265.419177]  kthread+0x51b/0x650
[18265.420689]  ret_from_fork+0x249/0x480
[18265.422331]  ret_from_fork_asm+0x1a/0x30

[18265.424989] Last potentially related work creation:
[18265.426949]  kasan_save_stack+0x3e/0x60
[18265.428639]  kasan_record_aux_stack+0xbd/0xd0
[18265.430423]  insert_work+0x2d/0x230
[18265.431968]  __queue_work+0x8ec/0xb50
[18265.433555]  queue_work_on+0xaf/0xe0
[18265.435126]  iomap_dio_bio_end_io+0xb5/0x160
[18265.436902]  blk_update_request+0x3d1/0x1000
[18265.438699]  blk_mq_end_request+0x3c/0x70
[18265.440379]  virtblk_done+0x148/0x250
[18265.441973]  vring_interrupt+0x159/0x300
[18265.443642]  __handle_irq_event_percpu+0x1c3/0x700
[18265.445556]  handle_irq_event+0x8b/0x1c0
[18265.447219]  handle_edge_irq+0x1b5/0x760
[18265.448881]  __common_interrupt+0xba/0x140
[18265.450588]  common_interrupt+0x45/0xa0
[18265.452258]  asm_common_interrupt+0x26/0x40

[18265.454941] Second to last potentially related work creation:
[18265.457141]  kasan_save_stack+0x3e/0x60
[18265.458790]  kasan_record_aux_stack+0xbd/0xd0
[18265.460597]  insert_work+0x2d/0x230
[18265.462129]  __queue_work+0x8ec/0xb50
[18265.463725]  queue_work_on+0xaf/0xe0
[18265.465289]  nfs_local_doio+0xa75/0xeb0 [nfs]
[18265.467220]  nfs_initiate_pgio+0x284/0x400 [nfs]
[18265.469226]  nfs_generic_pg_pgios+0x6e2/0x810 [nfs]
[18265.471310]  nfs_pageio_complete+0x278/0x750 [nfs]
[18265.473363]  nfs_file_direct_read+0x78c/0x9e0 [nfs]
[18265.475432]  vfs_read+0x5d0/0x770
[18265.476941]  __x64_sys_pread64+0xed/0x160
[18265.478648]  do_syscall_64+0xad/0x7d0
[18265.480240]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[18265.483211] The buggy address belongs to the object at ffff888109055600
                which belongs to the cache kmalloc-rnd-14-512 of size 512
[18265.488048] The buggy address is located 162 bytes inside of
                freed 512-byte region [ffff888109055600, ffff888109055800)

[18265.493827] The buggy address belongs to the physical page:
[18265.496033] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888109050e00 pfn:0x109050
[18265.499353] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[18265.502198] flags: 0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
[18265.505105] page_type: f5(slab)
[18265.506675] raw: 0017ffffc0000240 ffff88810006d540 ffffea0004151c10 ffff88810006e088
[18265.509537] raw: ffff888109050e00 000000000015000f 00000000f5000000 0000000000000000
[18265.512418] head: 0017ffffc0000240 ffff88810006d540 ffffea0004151c10 ffff88810006e088
[18265.515326] head: ffff888109050e00 000000000015000f 00000000f5000000 0000000000000000
[18265.518244] head: 0017ffffc0000003 ffffea0004241401 00000000ffffffff 00000000ffffffff
[18265.521168] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
[18265.524113] page dumped because: kasan: bad access detected

[18265.527455] Memory state around the buggy address:
[18265.529505]  ffff888109055580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[18265.532292]  ffff888109055600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[18265.535149] >ffff888109055680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[18265.537930]                                ^
[18265.539899]  ffff888109055700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[18265.542713]  ffff888109055780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[18265.545507] ==================================================================
[18265.554665] Disabling lock debugging due to kernel taint


