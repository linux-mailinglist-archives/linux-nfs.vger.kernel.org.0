Return-Path: <linux-nfs+bounces-15406-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3041ABF1A0F
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 15:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B68254FAC1D
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 13:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D116B31D758;
	Mon, 20 Oct 2025 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKO9Y8An"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A802F8BCB
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967783; cv=none; b=QQQiG6GYiGX+2ISjAASfAFg4EDuNmaD/WfPAPDyzLqhX2E4IVkDIfYLyOA0FPEzjKARwyc4Ng0D6mTXFM6UwHh2gLElWAtwt7lRtcc1uoCSBaswW/IhHOINXWzMjxp8BihEY71SZPc3gaA0HdyLbe2nKbXW2FVHXkkQuW2QAloc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967783; c=relaxed/simple;
	bh=XFtIb+jIpIcppt38ZYXT006ODs7fDSbj2QGoSML1EKo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aZB2X7gw+2dkIIuZVAGi6r1nOaBZAvCpX0ySlQ21WjH25Uy/H/n481G2+asKCsZ+y78YfbiCnVES/ty8ZYHbq9aTS6qiHTqSIKIOc92qAi3RNemJPFyU8ma2zUmuDdwnJxrDf8mn9jXRs15eqyaZ29XFDALb05W6YHIDYKaCGRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKO9Y8An; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760967780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5STu/y8CVohq0kxoXbL+1uc9zvhgpsPgp2LqXcE7SlM=;
	b=ZKO9Y8An7RIqoXB9ljfSxkXa4MHdfoNJNVyd08F72CwC/jRzf5OCmde3HGuAk2D+D6jt18
	2ngOcad4SnBEBKDax32p17oZko+1hOlUPDXjjc/+ZiyY4RPMxkcy9iQOf3EAc4XOHlR4xM
	vEVzSTqPdUQC1iI4Kcl4v6sFTq/QPA8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-jTKNO3j3MOCSkQZsVyO-Rw-1; Mon, 20 Oct 2025 09:42:58 -0400
X-MC-Unique: jTKNO3j3MOCSkQZsVyO-Rw-1
X-Mimecast-MFC-AGG-ID: jTKNO3j3MOCSkQZsVyO-Rw_1760967777
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-27ee41e062cso56011445ad.1
        for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 06:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760967776; x=1761572576;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5STu/y8CVohq0kxoXbL+1uc9zvhgpsPgp2LqXcE7SlM=;
        b=wsXeYLunDEkA97b/uGARPV+2nMBqCRSVpcaAFqOAx1toHtSAJT3IRP8nef4H4+NnUS
         fHeM9l6zqakCBhPOuR3IUX2VgqJog3J5XzI1W9i1bcLbcxDNQ0lSnTV5OKBb08yF644C
         MAzH/Hc6AkWfFQROIMwfUU43/4SABgFZvFjhLseg/AZt9h57DXGoYXglSQ8Q1FJb+j7W
         Gk5VT1PMMA97hIWW1ja/TZo1hi3BAC+O0x3vK842hQO8SX6o3Mtk8WSxPyf9VwZijLh7
         VuLC2HUtMnNo/bMRHjNk3U/JqrFSlkt8WM/FlyoIRdLXoSfn6DhcoGvhB+EleVL2pVOr
         bZVg==
X-Gm-Message-State: AOJu0Ywj0S4cfj+A1GPBdPkFupAAmALvR4+xcPCehQS5BxcWKZGhu0TJ
	tvTaw4w9A8L15VtA+JdthvbhuKd41LWoi2uBK33De9ZDZeMZtXTFNJViztY7xV6gMRL5qRl1j1k
	uVmIinw3+Ggre0WYEi1WWtQcwNv2oH7xOAXX9tWofBFqh5ycqRCF4xvZ4VDrGjmkjF7Vv9Jjcq0
	yhGnQ+LHwJyYT22P6fjve85yRW+wryMC4e2cIzl4IjqsQ5
X-Gm-Gg: ASbGnctCo4zLzAZrtGKB06LM8ezAyZGxPnFsuAPGfV/5kZyuwI8rY1nKUpud9LxPkHb
	1GWVDK2Cb1zQcDPfJyf+gLCsvaVS6b3n+qqoU2YpwKqq0WZAGwB2i+74jltFInDgsKtIfXU5WaU
	b2eaRmpq/cqVooXJIZRxDaB1CbyBxCk1G4bF6VdhnjZiKljrYEgA0J/yzyed0nR88KgWBukGtVF
	u0y1eQofHc9uyfBCj5ZkBpxNFy/r91INFuCRCtO6rvXM8N26YjOTqFziGCzuFI9xP+mqWvJph7H
	1C3idcUbpY8vbo2+zRW8G/uOuhq2OZvP7Pn1sXROwhp5v2aFnS3tQnlY0Z48vuVtyLDkQp1kvyb
	ooGOL+Uw3FLoaXYeJJCxqKSxTU0mBxTb4Q84NysA=
X-Received: by 2002:a17:903:b48:b0:290:29ba:340f with SMTP id d9443c01a7336-290cb17c05fmr169767795ad.42.1760967775239;
        Mon, 20 Oct 2025 06:42:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTz3PiZ/UKRaY8moweZe+4eda+VQjhdOo2f4fnDY/t7Z0JbleUSjUL3IcHl6k8fEyWkjDn5g==
X-Received: by 2002:a17:903:b48:b0:290:29ba:340f with SMTP id d9443c01a7336-290cb17c05fmr169767355ad.42.1760967774556;
        Mon, 20 Oct 2025 06:42:54 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d594esm80978655ad.72.2025.10.20.06.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 06:42:53 -0700 (PDT)
Date: Mon, 20 Oct 2025 21:42:49 +0800
From: Zorro Lang <zlang@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>, Scott Mayhew <smayhew@redhat.com>
Subject: [Bug report][xfstests on nfs]BUG: KASAN: slab-use-after-free in
 nfs_local_call_write+0xba0/0xe20 [nfs]
Message-ID: <20251020134249.g3efj4otvzoy32ky@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Several months ago, I reported an nfs regression bug as:
https://lore.kernel.org/all/20250508051829.bdv2r72l2o5rsbni@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/

And looks like it's been fixed by:
https://lore.kernel.org/all/20250807164938.2395136-1-smayhew@redhat.com/

Thanks for fixing it:) But I still hit a KASAN bug report on
nfs_local_call_write/read too, as [1], [2]

The latest linux HEAD commit which I hit this bug is:

 commit 6f3b6e91f7201e248d83232538db14d30100e9c7
 Author: Linus Torvalds <torvalds@linux-foundation.org>
 Date:   Fri Oct 17 08:45:54 2025 -0700

     Merge tag 'io_uring-6.18-20251016' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux

My underlying test device isn't loopback device, it's general disk, and make
xfs on it:
  meta-data=/dev/sda5              isize=512    agcount=4, agsize=983040 blks
           =                       sectsz=4096  attr=2, projid32bit=1
           =                       crc=1        finobt=1, sparse=1, rmapbt=1
           =                       reflink=1    bigtime=1 inobtcount=1 nrext64=1
           =                       exchange=0   metadir=0
  data     =                       bsize=4096   blocks=3932160, imaxpct=25
           =                       sunit=0      swidth=0 blks
  naming   =version 2              bsize=4096   ascii-ci=0, ftype=1, parent=0
  log      =internal log           bsize=4096   blocks=54324, version=2
           =                       sectsz=4096  sunit=1 blks, lazy-count=1
  realtime =none                   extsz=4096   blocks=0, rtextents=0
           =                       rgcount=0    rgsize=0 extents
           =                       zoned=0      start=0 reserved=0

Two xfs are mounted on /mnt/xfstests/test and /mnt/xfstests/scratch seperately,
then export as:
  # cat /etc/exports
  /mnt/xfstests/test/nfs-server *(rw,insecure,no_root_squash)
  /mnt/xfstests/scratch/nfs-server *(rw,insecure,no_root_squash)

The nfs mount option is only "-o vers=4.2". BTW, nfs server and client are
in same machine/system.

# cat local.config
export FSTYP=nfs
export TEST_DEV=xxxx-xxx-xxxx.xxxx.xxx.xxx:/mnt/xfstests/test/nfs-server
export TEST_DIR=/mnt/xfstests/test/nfs-client
export SCRATCH_DEV=xxxx-xxx-xxxx.xxxx.xxx.xxx:/mnt/xfstests/scratch/nfs-server
export SCRATCH_MNT=/mnt/xfstests/scratch/nfs-client
export MOUNT_OPTIONS="-o vers=4.2"
export TEST_FS_MOUNT_OPTS="-o vers=4.2"

Thanks,
Zorro

[1]
[ 3484.266654] run fstests generic/095 at 2025-10-18 14:01:08 
[ 3488.890009] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O! 
[ 3488.903150] File: /mnt/xfstests/scratch/nfs-server/file2 PID: 141053 Comm: kworker/8:1 
[ 3488.919168] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O! 
[ 3488.924287] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O! 
[ 3488.927871] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O! 
[ 3488.927876] File: /mnt/xfstests/scratch/nfs-server/file1 PID: 70948 Comm: kworker/34:44 
[ 3488.930730] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O! 
[ 3488.930737] File: /mnt/xfstests/scratch/nfs-server/file2 PID: 72281 Comm: kworker/13:9 
[ 3488.931390] File: /mnt/xfstests/scratch/nfs-server/file1 PID: 70856 Comm: kworker/14:5 
[ 3488.932178] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O! 
[ 3488.932184] File: /mnt/xfstests/scratch/nfs-server/file2 PID: 71538 Comm: kworker/6:0 
[ 3488.935095] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O! 
[ 3488.935102] File: /mnt/xfstests/scratch/nfs-server/file2 PID: 70948 Comm: kworker/34:44 
[ 3488.937206] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O! 
[ 3488.937212] File: /mnt/xfstests/scratch/nfs-server/file2 PID: 39158 Comm: kworker/39:206 
[ 3488.937529] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O! 
[ 3488.937538] File: /mnt/xfstests/scratch/nfs-server/file2 PID: 31327 Comm: kworker/36:3 
[ 3488.939139] Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O! 
[ 3488.939145] File: /mnt/xfstests/scratch/nfs-server/file2 PID: 7120 Comm: kworker/44:25 
[ 3488.943484] File: /mnt/xfstests/scratch/nfs-server/file1 PID: 6574 Comm: kworker/40:32 
[ 3489.953944] ==================================================================
[ 3489.962019] BUG: KASAN: slab-use-after-free in nfs_local_call_read+0x4cb/0x690 [nfs] 
[ 3489.970768] Read of size 2 at addr ffff88a104a058aa by task kworker/u194:14/123922 
[ 3489.979222]  
[ 3489.980887] CPU: 25 UID: 0 PID: 123922 Comm: kworker/u194:14 Kdump: loaded Tainted: G S                  6.18.0-rc1+ #1 PREEMPT(voluntary)  
[ 3489.980896] Tainted: [S]=CPU_OUT_OF_SPEC 
[ 3489.980898] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.6.0 10/26/2017 
[ 3489.980901] Workqueue: nfslocaliod nfs_local_call_read [nfs] 
[ 3489.980975] Call Trace: 
[ 3489.980978]  <TASK> 
[ 3489.980982]  ? nfs_local_call_read+0x4cb/0x690 [nfs] 
[ 3489.981053]  dump_stack_lvl+0x6f/0xb0 
[ 3489.981062]  print_address_description.constprop.0+0x88/0x320 
[ 3489.981071]  ? nfs_local_call_read+0x4cb/0x690 [nfs] 
[ 3489.981140]  print_report+0x108/0x209 
[ 3489.981145]  ? __virt_addr_valid+0x20c/0x430 
[ 3489.981153]  ? nfs_local_call_read+0x4cb/0x690 [nfs] 
[ 3489.981222]  kasan_report+0xb2/0x190 
[ 3489.981230]  ? nfs_local_call_read+0x4cb/0x690 [nfs] 
[ 3489.981303]  nfs_local_call_read+0x4cb/0x690 [nfs] 
[ 3489.981377]  process_one_work+0xd8b/0x1320 
[ 3489.981386]  ? __pfx_process_one_work+0x10/0x10 
[ 3489.981395]  ? assign_work+0x16c/0x240 
[ 3489.981403]  worker_thread+0x5f3/0xfe0 
[ 3489.981412]  ? __pfx_worker_thread+0x10/0x10 
[ 3489.981416]  kthread+0x3b4/0x770 
[ 3489.981420]  ? local_clock_noinstr+0xd/0xe0 
[ 3489.981426]  ? __pfx_kthread+0x10/0x10 
[ 3489.981429]  ? __lock_release.isra.0+0x1a4/0x2c0 
[ 3489.981434]  ? rcu_is_watching+0x15/0xb0 
[ 3489.981441]  ? __pfx_kthread+0x10/0x10 
[ 3489.981445]  ret_from_fork+0x393/0x480 
[ 3489.981452]  ? __pfx_kthread+0x10/0x10 
[ 3489.981457]  ? __pfx_kthread+0x10/0x10 
[ 3489.981465]  ret_from_fork_asm+0x1a/0x30 
[ 3489.981478]  </TASK> 
[ 3489.981480]  
[ 3490.140285] Allocated by task 143108: 
[ 3490.144374]  kasan_save_stack+0x30/0x50 
[ 3490.148658]  kasan_save_track+0x14/0x30 
[ 3490.152940]  __kasan_kmalloc+0x8f/0xa0 
[ 3490.157125]  nfs_local_iocb_alloc+0x53/0x4f0 [nfs] 
[ 3490.162543]  nfs_local_doio+0x1c4/0xda0 [nfs] 
[ 3490.167475]  nfs_initiate_pgio+0x334/0x4c0 [nfs] 
[ 3490.172693]  nfs_generic_pg_pgios+0x3dc/0x630 [nfs] 
[ 3490.178201]  nfs_pageio_doio+0x108/0x270 [nfs] 
[ 3490.183222]  nfs_pageio_complete+0x1a6/0x590 [nfs] 
[ 3490.188632]  nfs_direct_read_schedule_iovec+0x39c/0x610 [nfs] 
[ 3490.195108]  nfs_file_direct_read+0x689/0xaa0 [nfs] 
[ 3490.200613]  vfs_read+0x6cb/0xb70 
[ 3490.204316]  ksys_read+0xf9/0x1d0 
[ 3490.208017]  do_syscall_64+0x94/0x760 
[ 3490.212107]  entry_SYSCALL_64_after_hwframe+0x76/0x7e 
[ 3490.217746]  
[ 3490.219409] Freed by task 123845: 
[ 3490.223100]  kasan_save_stack+0x30/0x50 
[ 3490.227382]  kasan_save_track+0x14/0x30 
[ 3490.231655]  __kasan_save_free_info+0x3b/0x70 
[ 3490.236519]  __kasan_slab_free+0x43/0x70 
[ 3490.240899]  kfree+0x151/0x6b0 
[ 3490.244310]  nfs_local_pgio_release+0x1de/0x3b0 [nfs] 
[ 3490.250015]  process_one_work+0xd8b/0x1320 
[ 3490.254580]  worker_thread+0x5f3/0xfe0 
[ 3490.258756]  kthread+0x3b4/0x770 
[ 3490.262359]  ret_from_fork+0x393/0x480 
[ 3490.266545]  ret_from_fork_asm+0x1a/0x30 
[ 3490.270924]  
[ 3490.272586] Last potentially related work creation: 
[ 3490.278029]  kasan_save_stack+0x30/0x50 
[ 3490.282302]  kasan_record_aux_stack+0x8c/0xa0 
[ 3490.287157]  insert_work+0x36/0x310 
[ 3490.291050]  __queue_work+0x5d1/0xa80 
[ 3490.295138]  queue_work_on+0xb9/0xf0 
[ 3490.299120]  iomap_dio_bio_end_io+0x108/0x170 
[ 3490.303985]  blk_update_request+0x448/0xf00 
[ 3490.308657]  scsi_end_request+0x74/0x770 
[ 3490.313037]  scsi_io_completion+0xe9/0x7d0 
[ 3490.317610]  complete_cmd_fusion+0xf2f/0x1da0 [megaraid_sas] 
[ 3490.323958]  megasas_isr_fusion+0x1f9/0x270 [megaraid_sas] 
[ 3490.330104]  __handle_irq_event_percpu+0x1f0/0x6f0 
[ 3490.335453]  handle_irq_event+0xa9/0x1c0 
[ 3490.339834]  handle_edge_irq+0x2ef/0x8a0 
[ 3490.344205]  __common_interrupt+0xa2/0x1e0 
[ 3490.348780]  common_interrupt+0x5f/0xe0 
[ 3490.353062]  asm_common_interrupt+0x26/0x40 
[ 3490.357734]  
[ 3490.359396] Second to last potentially related work creation: 
[ 3490.365810]  kasan_save_stack+0x30/0x50 
[ 3490.370092]  kasan_record_aux_stack+0x8c/0xa0 
[ 3490.374956]  insert_work+0x36/0x310 
[ 3490.378850]  __queue_work+0x5d1/0xa80 
[ 3490.382937]  queue_work_on+0xda/0xf0 
[ 3490.386927]  nfs_local_doio+0x7b8/0xda0 [nfs] 
[ 3490.391858]  nfs_initiate_pgio+0x334/0x4c0 [nfs] 
[ 3490.397074]  nfs_generic_pg_pgios+0x3dc/0x630 [nfs] 
[ 3490.402581]  nfs_pageio_doio+0x108/0x270 [nfs] 
[ 3490.407593]  nfs_pageio_complete+0x1a6/0x590 [nfs] 
[ 3490.413004]  nfs_direct_read_schedule_iovec+0x39c/0x610 [nfs] 
[ 3490.419471]  nfs_file_direct_read+0x689/0xaa0 [nfs] 
[ 3490.424976]  vfs_read+0x6cb/0xb70 
[ 3490.428677]  ksys_read+0xf9/0x1d0 
[ 3490.432369]  do_syscall_64+0x94/0x760 
[ 3490.436458]  entry_SYSCALL_64_after_hwframe+0x76/0x7e 
[ 3490.442100]  
[ 3490.443761] The buggy address belongs to the object at ffff88a104a05800 
[ 3490.443761]  which belongs to the cache kmalloc-512 of size 512 
[ 3490.457731] The buggy address is located 170 bytes inside of 
[ 3490.457731]  freed 512-byte region [ffff88a104a05800, ffff88a104a05a00) 
[ 3490.471420]  
[ 3490.473081] The buggy address belongs to the physical page: 
[ 3490.479300] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2104a00 
[ 3490.488336] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0 
[ 3490.496884] flags: 0x57ffffc0000040(head|node=1|zone=2|lastcpupid=0x1fffff) 
[ 3490.504657] page_type: f5(slab) 
[ 3490.508164] raw: 0057ffffc0000040 ffff888100048f00 dead000000000100 dead000000000122 
[ 3490.516809] raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000 
[ 3490.525457] head: 0057ffffc0000040 ffff888100048f00 dead000000000100 dead000000000122 
[ 3490.534199] head: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000 
[ 3490.542939] head: 0057ffffc0000003 ffffea0084128001 00000000ffffffff 00000000ffffffff 
[ 3490.551681] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008 
[ 3490.560414] page dumped because: kasan: bad access detected 
[ 3490.566634]  
[ 3490.568297] Memory state around the buggy address: 
[ 3490.573645]  ffff88a104a05780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc 
[ 3490.581698]  ffff88a104a05800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb 
[ 3490.589762] >ffff88a104a05880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb 
[ 3490.597814]                                   ^ 
[ 3490.602872]  ffff88a104a05900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb 
[ 3490.610934]  ffff88a104a05980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb 
[ 3490.618997] ================================================================== 
[ 3490.627089] Disabling lock debugging due to kernel taint 


[2]
[ 2739.599573] run fstests generic/133 at 2025-10-18 13:26:31 
[ 2752.572198] ================================================================== 
[ 2752.572209] BUG: KASAN: slab-use-after-free in nfs_local_call_write+0xba0/0xe20 [nfs] 
[ 2752.572342] Read of size 2 at addr ffff00025f7108aa by task kworker/u783:39/178486 
[ 2752.572346]  
[ 2752.572351] CPU: 117 UID: 0 PID: 178486 Comm: kworker/u783:39 Kdump: loaded Not tainted 6.18.0-rc1+ #1 PREEMPT(voluntary)  
[ 2752.572356] Hardware name: Inspur NF5280R7/Mitchell MB, BIOS 04.04.00003001 2024-11-05 21:37:53 11/05/2024 
[ 2752.572359] Workqueue: nfslocaliod nfs_local_call_write [nfs] 
[ 2752.572412] Call trace: 
[ 2752.572414]  show_stack+0x34/0x98 (C) 
[ 2752.572423]  dump_stack_lvl+0xa8/0xe8 
[ 2752.572430]  print_address_description.constprop.0+0x90/0x310 
[ 2752.572437]  print_report+0x108/0x1f8 
[ 2752.572440]  kasan_report+0x8c/0x1b0 
[ 2752.572446]  __asan_report_load2_noabort+0x20/0x30 
[ 2752.572450]  nfs_local_call_write+0xba0/0xe20 [nfs] 
[ 2752.572499]  process_one_work+0x774/0x12d0 
[ 2752.572505]  worker_thread+0x434/0xca0 
[ 2752.572508]  kthread+0x2ec/0x390 
[ 2752.572512]  ret_from_fork+0x10/0x20 
[ 2752.572516]  
[ 2752.572517] Allocated by task 192524: 
[ 2752.572520]  kasan_save_stack+0x3c/0x68 
[ 2752.572523]  kasan_save_track+0x20/0x40 
[ 2752.572525]  kasan_save_alloc_info+0x40/0x58 
[ 2752.572527]  __kasan_kmalloc+0xb8/0xc0 
[ 2752.572530]  __kmalloc_cache_noprof+0x218/0x620 
[ 2752.572535]  nfs_local_iocb_alloc+0x58/0x510 [nfs] 
[ 2752.572582]  nfs_local_doio+0x478/0xcb0 [nfs] 
[ 2752.572629]  nfs_initiate_pgio+0x29c/0x460 [nfs] 
[ 2752.572677]  nfs_generic_pg_pgios+0x320/0x520 [nfs] 
[ 2752.572724]  nfs_pageio_doio+0xec/0x250 [nfs] 
[ 2752.572771]  nfs_pageio_complete+0x168/0x488 [nfs] 
[ 2752.572818]  nfs_direct_write_schedule_iovec+0x4b4/0x800 [nfs] 
[ 2752.572864]  nfs_file_direct_write+0x988/0xf48 [nfs] 
[ 2752.572911]  nfs_file_write+0x370/0x868 [nfs] 
[ 2752.572958]  new_sync_write+0x214/0x4d0 
[ 2752.572962]  vfs_write+0x440/0x5b0 
[ 2752.572965]  __arm64_sys_pwrite64+0x18c/0x1f0 
[ 2752.572968]  invoke_syscall.constprop.0+0xdc/0x1e8 
[ 2752.572972]  do_el0_svc+0x154/0x1d0 
[ 2752.572976]  el0_svc+0x54/0x250 
[ 2752.572981]  el0t_64_sync_handler+0xa0/0xe8 
[ 2752.572984]  el0t_64_sync+0x1ac/0x1b0 
[ 2752.572986]  
[ 2752.572987] Freed by task 180156: 
[ 2752.572989]  kasan_save_stack+0x3c/0x68 
[ 2752.572991]  kasan_save_track+0x20/0x40 
[ 2752.572993]  __kasan_save_free_info+0x4c/0x78 
[ 2752.572996]  __kasan_slab_free+0x5c/0x90 
[ 2752.572998]  kfree+0x10c/0x4a8 
[ 2752.573001]  nfs_local_pgio_release+0x1bc/0x350 [nfs] 
[ 2752.573047]  nfs_local_write_aio_complete_work+0x68/0x98 [nfs] 
[ 2752.573093]  process_one_work+0x774/0x12d0 
[ 2752.573096]  worker_thread+0x434/0xca0 
[ 2752.573098]  kthread+0x2ec/0x390 
[ 2752.573100]  ret_from_fork+0x10/0x20 
[ 2752.573102]  
[ 2752.573103] Last potentially related work creation: 
[ 2752.573105]  kasan_save_stack+0x3c/0x68 
[ 2752.573107]  kasan_record_aux_stack+0x98/0xb0 
[ 2752.573110]  insert_work+0x50/0x1d8 
[ 2752.573112]  __queue_work+0x704/0xb78 
[ 2752.573115]  queue_work_on+0x150/0x160 
[ 2752.573117]  nfs_local_write_aio_complete+0x190/0x2e0 [nfs] 
[ 2752.573163]  iomap_dio_complete_work+0x6c/0xa0 
[ 2752.573170]  process_one_work+0x774/0x12d0 
[ 2752.573172]  worker_thread+0x434/0xca0 
[ 2752.573174]  kthread+0x2ec/0x390 
[ 2752.573176]  ret_from_fork+0x10/0x20 
[ 2752.573178]  
[ 2752.573179] Second to last potentially related work creation: 
[ 2752.573181]  kasan_save_stack+0x3c/0x68 
[ 2752.573183]  kasan_record_aux_stack+0x98/0xb0 
[ 2752.573185]  insert_work+0x50/0x1d8 
[ 2752.573187]  __queue_work+0x704/0xb78 
[ 2752.573190]  queue_work_on+0x150/0x160 
[ 2752.573192]  nfs_local_doio+0x6a8/0xcb0 [nfs] 
[ 2752.573238]  nfs_initiate_pgio+0x29c/0x460 [nfs] 
[ 2752.573284]  nfs_generic_pg_pgios+0x320/0x520 [nfs] 
[ 2752.573330]  nfs_pageio_doio+0xec/0x250 [nfs] 
[ 2752.573376]  nfs_pageio_complete+0x168/0x488 [nfs] 
[ 2752.573421]  nfs_direct_write_schedule_iovec+0x4b4/0x800 [nfs] 
[ 2752.573467]  nfs_file_direct_write+0x988/0xf48 [nfs] 
[ 2752.573513]  nfs_file_write+0x370/0x868 [nfs] 
[ 2752.573559]  new_sync_write+0x214/0x4d0 
[ 2752.573561]  vfs_write+0x440/0x5b0 
[ 2752.573563]  __arm64_sys_pwrite64+0x18c/0x1f0 
[ 2752.573566]  invoke_syscall.constprop.0+0xdc/0x1e8 
[ 2752.573569]  do_el0_svc+0x154/0x1d0 
[ 2752.573572]  el0_svc+0x54/0x250 
[ 2752.573574]  el0t_64_sync_handler+0xa0/0xe8 
[ 2752.573577]  el0t_64_sync+0x1ac/0x1b0 
[ 2752.573579]  
[ 2752.573580] The buggy address belongs to the object at ffff00025f710800 
[ 2752.573580]  which belongs to the cache kmalloc-512 of size 512 
[ 2752.573582] The buggy address is located 170 bytes inside of 
[ 2752.573582]  freed 512-byte region [ffff00025f710800, ffff00025f710a00) 
[ 2752.573585]  
[ 2752.573586] The buggy address belongs to the physical page: 
[ 2752.573589] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25f710 
[ 2752.573593] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0 
[ 2752.573595] flags: 0x2fffff00000040(head|node=0|zone=2|lastcpupid=0xfffff) 
[ 2752.573601] page_type: f5(slab) 
[ 2752.573605] raw: 002fffff00000040 ffff000100008c80 dead000000000100 dead000000000122 
[ 2752.573607] raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000 
[ 2752.573609] head: 002fffff00000040 ffff000100008c80 dead000000000100 dead000000000122 
[ 2752.573612] head: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000 
[ 2752.573614] head: 002fffff00000003 fffffdffc97dc401 00000000ffffffff 00000000ffffffff 
[ 2752.573616] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008 
[ 2752.573617] page dumped because: kasan: bad access detected 
[ 2752.573619]  
[ 2752.573620] Memory state around the buggy address: 
[ 2752.573622]  ffff00025f710780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc 
[ 2752.573624]  ffff00025f710800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb 
[ 2752.573626] >ffff00025f710880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb 
[ 2752.573627]                                   ^ 
[ 2752.573629]  ffff00025f710900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb 
[ 2752.573631]  ffff00025f710980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb 
[ 2752.573632] ==================================================================


