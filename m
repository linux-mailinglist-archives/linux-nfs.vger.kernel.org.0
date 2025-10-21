Return-Path: <linux-nfs+bounces-15455-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED26BF6A84
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 15:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A8519A4996
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Oct 2025 13:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5C81096F;
	Tue, 21 Oct 2025 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlXuOrXP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1913117C211
	for <linux-nfs@vger.kernel.org>; Tue, 21 Oct 2025 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051920; cv=none; b=mYnxIsBu4L+wtrr1o4HIHiyhGI/SxvmSeAEykL5BkBIY16yadkgQyaabOiKTb0fQCDSZgpkVcuN/Y1gS6uTpcwyLq4hbytJ0beHWDdE1BJ2ebXGRk4zUZxsy8GJuyVc9dHfVt2B5eHLO2rnVp8TAMWNvnrJYj1BMddrE7pNUir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051920; c=relaxed/simple;
	bh=nG3TXPPRoQa+Tyx5oHhdA9a85sTUtgye4B+jDoC+HIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mEi1RMWt/Xwor5/qAdSpCMhbA5ZOpUkc56TyBZpZtQMYI8vQaSqh9u2BECPSsaN3Gd8QzYtBLQdUodkwr+cEf4pYbgCL10IB+EhPkBteXz+WzRfX0gj0ioAcna8Ml3UPCeBqMXmf+A5Oboph1dzBlk7FMDvqUcv2t7Y6supxXbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlXuOrXP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i5rTLIE0MisiMsnpzWQpVTeM1/FJeqRtkBSzSLou1Cg=;
	b=QlXuOrXPdpM5FmQh+pxseCVgETgFWKhrnOwJTlHG5j2QmcQL+IcuFUhBweBBGKeC+Iz010
	bq2JzshbueaiinR13rRL82RxLdEz8qqqJ6R8698/2E3Xk8X/GqwiSBOtGS+wSZ8xgAB3Gp
	V7D6HF/U1lGMor6izt73T5JtvN2/lc0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-s5E4mAhZOhK6Lngm77RYzQ-1; Tue,
 21 Oct 2025 09:05:12 -0400
X-MC-Unique: s5E4mAhZOhK6Lngm77RYzQ-1
X-Mimecast-MFC-AGG-ID: s5E4mAhZOhK6Lngm77RYzQ_1761051910
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39E6218600DA;
	Tue, 21 Oct 2025 13:05:09 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.65.178])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C937E19560B2;
	Tue, 21 Oct 2025 13:05:07 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [RFC PATCH 1/1] lockd: prevent UAF in nlm4svc_proc_test in reexport NLM
Date: Tue, 21 Oct 2025 09:05:06 -0400
Message-ID: <20251021130506.45065-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When knfsd is a reexport nfs server, it nlm4svc_proc_test() in
calling nlmsvc_testlock() with a lock conflict lock_release_private()
call would end up calling nlmsvc_put_lockowner() and then back in
nlm4svc_proc_test() function there will be another call to
nlmsvc_put_lockowner() for the same owner leading to use-after-free
violation (below).

The problem only arises when the underlying file system has been
re-exported as different paths are taken in vfs_test_lock().
When it's reexport, filp->f_op->lock is set and when vfs_test_lock()
is done fl_lmops pointer is non-null. When it's regular export,
vfs_test_lock() calls posix_test_lock() which ends up calling
locks_copy_conflock() and it copies NULL into fl_lmops and then
calling into lock_release_private() does not call
nlmsvc_put_lockowner().

The proposed solution is to intentionally clear fl_lmops pointer to
make sure that if there is a conflict (be it a local file system
or reexport), lock_release_private() would not call
nlmsvc_put_lockowner().

kernel: ==================================================================
kernel: BUG: KASAN: slab-use-after-free in nlmsvc_put_lockowner+0x30/0x250 [lockd]
kernel: Read of size 4 at addr ffff0000bf3bca10 by task lockd/6092
kernel:
kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded Not tainted 6.18.0-rc1+ #23 PREEMPT(voluntary)
kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
kernel: Call trace:
kernel:  show_stack+0x34/0x98 (C)
kernel:  dump_stack_lvl+0x80/0xa8
kernel:  print_address_description.constprop.0+0x90/0x310
kernel:  print_report+0x108/0x1f8
kernel:  kasan_report+0xc8/0x120
kernel:  kasan_check_range+0xe8/0x190
kernel:  __kasan_check_read+0x20/0x30
kernel:  nlmsvc_put_lockowner+0x30/0x250 [lockd]
kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
kernel:  svc_process+0x414/0x900 [sunrpc]
kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
kernel:  svc_recv+0x1a4/0x520 [sunrpc]
kernel:  lockd+0x154/0x298 [lockd]
kernel:  kthread+0x2f8/0x398
kernel:  ret_from_fork+0x10/0x20
kernel:
kernel: Allocated by task 6092:
kernel:  kasan_save_stack+0x3c/0x70
kernel:  kasan_save_track+0x20/0x40
kernel:  kasan_save_alloc_info+0x40/0x58
kernel:  __kasan_kmalloc+0xd4/0xd8
kernel:  __kmalloc_cache_noprof+0x1a8/0x5c0
kernel:  nlmsvc_locks_init_private+0xe4/0x520 [lockd]
kernel:  nlm4svc_retrieve_args+0x38c/0x530 [lockd]
kernel:  __nlm4svc_proc_test+0x194/0x318 [lockd]
kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
kernel:  svc_process+0x414/0x900 [sunrpc]
kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
kernel:  svc_recv+0x1a4/0x520 [sunrpc]
kernel:  lockd+0x154/0x298 [lockd]
kernel:  kthread+0x2f8/0x398
kernel:  ret_from_fork+0x10/0x20
kernel:
kernel: Freed by task 6092:
kernel:  kasan_save_stack+0x3c/0x70
kernel:  kasan_save_track+0x20/0x40
kernel:  __kasan_save_free_info+0x4c/0x80
kernel:  __kasan_slab_free+0x88/0xc0
kernel:  kfree+0x110/0x480
kernel:  nlmsvc_put_lockowner+0x1b4/0x250 [lockd]
kernel:  nlmsvc_put_owner+0x18/0x30 [lockd]
kernel:  locks_release_private+0x190/0x2a8
kernel:  nlmsvc_testlock+0x2e0/0x648 [lockd]
kernel:  __nlm4svc_proc_test+0x244/0x318 [lockd]
kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
kernel:  svc_process+0x414/0x900 [sunrpc]
kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
kernel:  svc_recv+0x1a4/0x520 [sunrpc]
kernel:  lockd+0x154/0x298 [lockd]
kernel:  kthread+0x2f8/0x398
kernel:  ret_from_fork+0x10/0x20
kernel:
kernel: The buggy address belongs to the object at ffff0000bf3bca00
        which belongs to the cache kmalloc-64 of size 64
kernel: The buggy address is located 16 bytes inside of
        freed 64-byte region [ffff0000bf3bca00, ffff0000bf3bca40)
kernel:
kernel: The buggy address belongs to the physical page:
kernel: page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13f3bc
kernel: flags: 0x2fffff00000000(node=0|zone=2|lastcpupid=0xfffff)
kernel: page_type: f5(slab)
kernel: raw: 002fffff00000000 ffff0000800028c0 dead000000000122 0000000000000000
kernel: raw: 0000000000000000 0000000080200020 00000000f5000000 0000000000000000
kernel: page dumped because: kasan: bad access detected
kernel:
kernel: Memory state around the buggy address:
kernel:  ffff0000bf3bc900: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
kernel:  ffff0000bf3bc980: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
kernel: >ffff0000bf3bca00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
kernel:                          ^
kernel:  ffff0000bf3bca80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
kernel:  ffff0000bf3bcb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
kernel: ==================================================================
kernel: Disabling lock debugging due to kernel taint
kernel: AGLO: nlmsvc_put_lockowner 00000000028055fb count=0
kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded Tainted: G    B               6.18.0-rc1+ #23 PREEMPT(voluntary)
kernel: Tainted: [B]=BAD_PAGE
kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
kernel: Call trace:
kernel:  show_stack+0x34/0x98 (C)
kernel:  dump_stack_lvl+0x80/0xa8
kernel:  dump_stack+0x1c/0x30
kernel:  nlmsvc_put_lockowner+0x7c/0x250 [lockd]
kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
kernel:  svc_process+0x414/0x900 [sunrpc]
kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
kernel:  svc_recv+0x1a4/0x520 [sunrpc]
kernel:  lockd+0x154/0x298 [lockd]
kernel:  kthread+0x2f8/0x398
kernel:  ret_from_fork+0x10/0x20
kernel: ------------[ cut here ]------------
kernel: refcount_t: underflow; use-after-free.
kernel: WARNING: CPU: 0 PID: 6092 at lib/refcount.c:87 refcount_dec_not_one+0x198/0x1b0
kernel: Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd nfsv3 nfs_acl nfs lockd grace nfs_localio netfs ext4 crc16 mbcache jbd2 overlay uinput snd_seq_dummy snd_hrtimer qrtr rfkill vfat fat uvcvideo snd_hda_codec_generic videobuf2_vmalloc videobuf2_memops uvc snd_hda_intel videobuf2_v4l2 videobuf2_common snd_intel_dspcfg videodev snd_hda_codec snd_hda_core mc snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore sg loop auth_rpcgss vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs 8021q garp stp llc mrp nvme nvme_core nvme_keyring nvme_auth ghash_ce hkdf e1000e sr_mod cdrom vmwgfx drm_ttm_helper ttm sunrpc dm_mirror dm_region_hash dm_log iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi fuse dm_multipath dm_mod nfnetlink
kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded Tainted: G    B               6.18.0-rc1+ #23 PREEMPT(voluntary)
kernel: Tainted: [B]=BAD_PAGE
kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
kernel: pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
kernel: pc : refcount_dec_not_one+0x198/0x1b0
kernel: lr : refcount_dec_not_one+0x198/0x1b0
kernel: sp : ffff80008a627930
kernel: x29: ffff80008a627990 x28: ffff0000bf3bca00 x27: ffff0000ba5c7000
kernel: x26: 1fffe000191eeb84 x25: 1ffff000114c4f48 x24: ffff0000c8f75c24
kernel: x23: 0000000000000007 x22: ffff80008a627950 x21: 1ffff000114c4f26
kernel: x20: 00000000ffffffff x19: ffff0000bf3bca10 x18: 0000000000000310
kernel: x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
kernel: x14: 0000000000000000 x13: 0000000000000001 x12: ffff60004fd90aa3
kernel: x11: 1fffe0004fd90aa2 x10: ffff60004fd90aa2 x9 : dfff800000000000
kernel: x8 : 00009fffb026f55e x7 : ffff00027ec85513 x6 : 0000000000000001
kernel: x5 : ffff00027ec85510 x4 : ffff60004fd90aa3 x3 : ffff800080787bc0
kernel: x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000a75a8000
kernel: Call trace:
kernel:  refcount_dec_not_one+0x198/0x1b0 (P)
kernel:  refcount_dec_and_lock+0x1c/0xb8
kernel:  nlmsvc_put_lockowner+0x9c/0x250 [lockd]
kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
kernel:  svc_process+0x414/0x900 [sunrpc]
kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
kernel:  svc_recv+0x1a4/0x520 [sunrpc]
kernel:  lockd+0x154/0x298 [lockd]
kernel:  kthread+0x2f8/0x398
kernel:  ret_from_fork+0x10/0x20
kernel: ---[ end trace 0000000000000000 ]---

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 fs/lockd/svclock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index a31dc9588eb8..1dd0fec186de 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -652,6 +652,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 	conflock->fl.c.flc_type = lock->fl.c.flc_type;
 	conflock->fl.fl_start = lock->fl.fl_start;
 	conflock->fl.fl_end = lock->fl.fl_end;
+	conflock->fl.fl_lmops = NULL;
 	locks_release_private(&lock->fl);
 
 	ret = nlm_lck_denied;
-- 
2.47.3


