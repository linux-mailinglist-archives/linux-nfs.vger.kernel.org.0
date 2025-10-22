Return-Path: <linux-nfs+bounces-15493-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CA0BF9F79
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 06:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630D019C7A73
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 04:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F3A2D6E43;
	Wed, 22 Oct 2025 04:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="XKh3Fy1H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wWqWOArA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E319DFA2
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 04:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108074; cv=none; b=hkjC/8X2w8gbZhXnu4N9QcA2NUY5NzmLfW+rKfnq/id2acqG4sGrXAcq+fisbzum22yh8FlNIvDON4WGr112Q9csNQuEKj+7O+rGLBT3s/HzzNacH5olq9PNIRTR+dl7H5YIkST/Ita1wYh56CNtXinejyFv20xrvbKddWgCxGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108074; c=relaxed/simple;
	bh=NMIbMhCYodMtIhtmTiD9EN4w/TLHkhbRl+GBqmgnADo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=e8F+KFfZkWk2Rh1D2GvrQjTdHQfdJQeeRsFwnAvTxruwgu/yXiiWFnNbddSuFumXPObXU9TG/4JxMzW/DmOKmoc9Tma7n3eHQCSNQxluNksHqBK6BaX/cCFJPqnW3p/ZTY3zmWzUnSw2iMSH060kd14BmcR1K6yLhMa0mc5L/b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=XKh3Fy1H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wWqWOArA; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 3C82CEC0067;
	Wed, 22 Oct 2025 00:41:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 22 Oct 2025 00:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1761108069; x=1761194469; bh=34IDhnymUj5ZYAq7w2gn7afgsNJ4br7o/xL
	qeTFnnm8=; b=XKh3Fy1HNWAht795V7BXsUnMe+VlWU2Nc4PH3aMV9PoPuB4ebkQ
	Su+cmaFtHwIsX9YytLbupMC4wz28Wd/Khkjp+V+XFLe7XLVL9u97vUyhlBUObIre
	vbAaLU0VWgl+Lw7jITGx9dXAH/O4Jk7aJVKF7wt9XBer0ho6BHfkKO30nZL/bu4a
	UpPkdbMY7do5zGTbxpHF7wZHaf2LlbV2k0jUktq7yOBEl4s1pCp7KRWGxkAbJkjz
	5CvEJ6FmPAYI4ulRZvrA4WJBbnrR1v7wDXWy2HUwsGvxfG/IJl0VlboBRyal0k3Q
	ssrDu7wrXudqUl6tQhGHQl0CyhKel/IRzZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761108069; x=
	1761194469; bh=34IDhnymUj5ZYAq7w2gn7afgsNJ4br7o/xLqeTFnnm8=; b=w
	WqWOArAz1AUevLm7emsMfYijd12ICXifcy1WyY/FCBOUImBUSyWw2YgvRr+po7lf
	TV/i5NAnSO6QN74a5zXbQdSYiTgfWhNrFe1ucKzPHIF1j5zvGuDIKeKpJo9Dzhrk
	uEehk8hbUNX1vQd2fEdqMheQ51pYnEgiIGUqyWIrVySdynsZKcfSx9TwozYKywLf
	dC/IoCzGpGehZgVJv5720z3/VRymCQz+3IF5PGRVqBmiX5U1hvSrzPA6qVhQqvff
	dJp0E53seJ1SemCBh2Tlk32RTVGHh69OzG8YxPhpeAT/4DJa/EAtEpOYhL6SjjhC
	kPY8LQR42EeC64v8rm+CQ==
X-ME-Sender: <xms:ZGD4aKqCTqCuO-1x0cwgbcxJsxpw9UlqtnDw27NscDekQ1EF0LWelQ>
    <xme:ZGD4aK5iWKoWSq17TaBwqDg_lkc9wajxnIMUVSCukAJAD1kPYPRZ_WOZpTYtxRCbW
    m9RCDnD7FCatHp6-eW9P0wRa2WTPi8hoRF-jRLESzjvNaRySw>
X-ME-Received: <xmr:ZGD4aBc09rdPFP-NEcxNHqhHIyZMS8x57dpvky2tQBnj17Vy6wU3Z1oXJ2Y-0VxH10OzAFWMUqsGvFY3ePxzp3cPQlnLBoQCNc_pVO4dWuJT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnh
    gvihhlsgessghrohifnhdrnhgrmhgv
X-ME-Proxy: <xmx:ZGD4aP5FhAwzLt7uX8L8ZrR2pBHzwwnXEfX82newCmmL2I1kadlduA>
    <xmx:ZGD4aIvVED3c_oH9zPAc3LafvMMUeoX6ZZHNEHpLZrWWNJ8n9D0MZQ>
    <xmx:ZGD4aPgtd9iZityX5_aSDl5c-2RStOeabGTd6EuwOvRVh6_kEezY9g>
    <xmx:ZGD4aDq-hSI5JTtMUxuK1FwdhIXDTSs5ZzMdanzzSn47YLLfpoDNbA>
    <xmx:ZWD4aAMCuoSaw1lH2d8M-b_fGWRNxslaj5q3b4fCTfxA5PC4MTkJzNcv>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 00:41:06 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, chuck.lever@oracle.com,
 linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com,
 tom@talpey.com
Subject:
 Re: [RFC PATCH 1/1] lockd: prevent UAF in nlm4svc_proc_test in reexport NLM
In-reply-to: <33ba39d2ff01eb0e52c80aa7015d27e34dde7fd2.camel@kernel.org>
References: <20251021130506.45065-1-okorniev@redhat.com>,
 <33ba39d2ff01eb0e52c80aa7015d27e34dde7fd2.camel@kernel.org>
Date: Wed, 22 Oct 2025 15:41:03 +1100
Message-id: <176110806382.1793333.17114849187803749121@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 22 Oct 2025, Jeff Layton wrote:
> On Tue, 2025-10-21 at 09:05 -0400, Olga Kornievskaia wrote:
> > When knfsd is a reexport nfs server, it nlm4svc_proc_test() in
> > calling nlmsvc_testlock() with a lock conflict lock_release_private()
> > call would end up calling nlmsvc_put_lockowner() and then back in
> > nlm4svc_proc_test() function there will be another call to
> > nlmsvc_put_lockowner() for the same owner leading to use-after-free
> > violation (below).
> >=20
> > The problem only arises when the underlying file system has been
> > re-exported as different paths are taken in vfs_test_lock().
> > When it's reexport, filp->f_op->lock is set and when vfs_test_lock()
> > is done fl_lmops pointer is non-null. When it's regular export,
> > vfs_test_lock() calls posix_test_lock() which ends up calling
> > locks_copy_conflock() and it copies NULL into fl_lmops and then
> > calling into lock_release_private() does not call
> > nlmsvc_put_lockowner().
> >=20
> > The proposed solution is to intentionally clear fl_lmops pointer to
> > make sure that if there is a conflict (be it a local file system
> > or reexport), lock_release_private() would not call
> > nlmsvc_put_lockowner().
> >=20
> > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > kernel: BUG: KASAN: slab-use-after-free in nlmsvc_put_lockowner+0x30/0x25=
0 [lockd]
> > kernel: Read of size 4 at addr ffff0000bf3bca10 by task lockd/6092
> > kernel:
> > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded Not tainted 6.1=
8.0-rc1+ #23 PREEMPT(voluntary)
> > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.2400=
6586.BA64.2406042154 06/04/2024
> > kernel: Call trace:
> > kernel:  show_stack+0x34/0x98 (C)
> > kernel:  dump_stack_lvl+0x80/0xa8
> > kernel:  print_address_description.constprop.0+0x90/0x310
> > kernel:  print_report+0x108/0x1f8
> > kernel:  kasan_report+0xc8/0x120
> > kernel:  kasan_check_range+0xe8/0x190
> > kernel:  __kasan_check_read+0x20/0x30
> > kernel:  nlmsvc_put_lockowner+0x30/0x250 [lockd]
> > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > kernel:  svc_process+0x414/0x900 [sunrpc]
> > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > kernel:  lockd+0x154/0x298 [lockd]
> > kernel:  kthread+0x2f8/0x398
> > kernel:  ret_from_fork+0x10/0x20
> > kernel:
> > kernel: Allocated by task 6092:
> > kernel:  kasan_save_stack+0x3c/0x70
> > kernel:  kasan_save_track+0x20/0x40
> > kernel:  kasan_save_alloc_info+0x40/0x58
> > kernel:  __kasan_kmalloc+0xd4/0xd8
> > kernel:  __kmalloc_cache_noprof+0x1a8/0x5c0
> > kernel:  nlmsvc_locks_init_private+0xe4/0x520 [lockd]
> > kernel:  nlm4svc_retrieve_args+0x38c/0x530 [lockd]
> > kernel:  __nlm4svc_proc_test+0x194/0x318 [lockd]
> > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > kernel:  svc_process+0x414/0x900 [sunrpc]
> > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > kernel:  lockd+0x154/0x298 [lockd]
> > kernel:  kthread+0x2f8/0x398
> > kernel:  ret_from_fork+0x10/0x20
> > kernel:
> > kernel: Freed by task 6092:
> > kernel:  kasan_save_stack+0x3c/0x70
> > kernel:  kasan_save_track+0x20/0x40
> > kernel:  __kasan_save_free_info+0x4c/0x80
> > kernel:  __kasan_slab_free+0x88/0xc0
> > kernel:  kfree+0x110/0x480
> > kernel:  nlmsvc_put_lockowner+0x1b4/0x250 [lockd]
> > kernel:  nlmsvc_put_owner+0x18/0x30 [lockd]
> > kernel:  locks_release_private+0x190/0x2a8
> > kernel:  nlmsvc_testlock+0x2e0/0x648 [lockd]
> > kernel:  __nlm4svc_proc_test+0x244/0x318 [lockd]
> > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > kernel:  svc_process+0x414/0x900 [sunrpc]
> > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > kernel:  lockd+0x154/0x298 [lockd]
> > kernel:  kthread+0x2f8/0x398
> > kernel:  ret_from_fork+0x10/0x20
> > kernel:
> > kernel: The buggy address belongs to the object at ffff0000bf3bca00
> >         which belongs to the cache kmalloc-64 of size 64
> > kernel: The buggy address is located 16 bytes inside of
> >         freed 64-byte region [ffff0000bf3bca00, ffff0000bf3bca40)
> > kernel:
> > kernel: The buggy address belongs to the physical page:
> > kernel: page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pf=
n:0x13f3bc
> > kernel: flags: 0x2fffff00000000(node=3D0|zone=3D2|lastcpupid=3D0xfffff)
> > kernel: page_type: f5(slab)
> > kernel: raw: 002fffff00000000 ffff0000800028c0 dead000000000122 000000000=
0000000
> > kernel: raw: 0000000000000000 0000000080200020 00000000f5000000 000000000=
0000000
> > kernel: page dumped because: kasan: bad access detected
> > kernel:
> > kernel: Memory state around the buggy address:
> > kernel:  ffff0000bf3bc900: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> > kernel:  ffff0000bf3bc980: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> > kernel: >ffff0000bf3bca00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> > kernel:                          ^
> > kernel:  ffff0000bf3bca80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> > kernel:  ffff0000bf3bcb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > kernel: Disabling lock debugging due to kernel taint
> > kernel: AGLO: nlmsvc_put_lockowner 00000000028055fb count=3D0
> > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded Tainted: G    B=
               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > kernel: Tainted: [B]=3DBAD_PAGE
> > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.2400=
6586.BA64.2406042154 06/04/2024
> > kernel: Call trace:
> > kernel:  show_stack+0x34/0x98 (C)
> > kernel:  dump_stack_lvl+0x80/0xa8
> > kernel:  dump_stack+0x1c/0x30
> > kernel:  nlmsvc_put_lockowner+0x7c/0x250 [lockd]
> > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > kernel:  svc_process+0x414/0x900 [sunrpc]
> > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > kernel:  lockd+0x154/0x298 [lockd]
> > kernel:  kthread+0x2f8/0x398
> > kernel:  ret_from_fork+0x10/0x20
> > kernel: ------------[ cut here ]------------
> > kernel: refcount_t: underflow; use-after-free.
> > kernel: WARNING: CPU: 0 PID: 6092 at lib/refcount.c:87 refcount_dec_not_o=
ne+0x198/0x1b0
> > kernel: Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd nfsv3=
 nfs_acl nfs lockd grace nfs_localio netfs ext4 crc16 mbcache jbd2 overlay ui=
nput snd_seq_dummy snd_hrtimer qrtr rfkill vfat fat uvcvideo snd_hda_codec_ge=
neric videobuf2_vmalloc videobuf2_memops uvc snd_hda_intel videobuf2_v4l2 vid=
eobuf2_common snd_intel_dspcfg videodev snd_hda_codec snd_hda_core mc snd_hwd=
ep snd_seq snd_seq_device snd_pcm snd_timer snd soundcore sg loop auth_rpcgss=
 vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vm=
w_vmci vsock xfs 8021q garp stp llc mrp nvme nvme_core nvme_keyring nvme_auth=
 ghash_ce hkdf e1000e sr_mod cdrom vmwgfx drm_ttm_helper ttm sunrpc dm_mirror=
 dm_region_hash dm_log iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi f=
use dm_multipath dm_mod nfnetlink
> > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: loaded Tainted: G    B=
               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > kernel: Tainted: [B]=3DBAD_PAGE
> > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.2400=
6586.BA64.2406042154 06/04/2024
> > kernel: pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=3D--)
> > kernel: pc : refcount_dec_not_one+0x198/0x1b0
> > kernel: lr : refcount_dec_not_one+0x198/0x1b0
> > kernel: sp : ffff80008a627930
> > kernel: x29: ffff80008a627990 x28: ffff0000bf3bca00 x27: ffff0000ba5c7000
> > kernel: x26: 1fffe000191eeb84 x25: 1ffff000114c4f48 x24: ffff0000c8f75c24
> > kernel: x23: 0000000000000007 x22: ffff80008a627950 x21: 1ffff000114c4f26
> > kernel: x20: 00000000ffffffff x19: ffff0000bf3bca10 x18: 0000000000000310
> > kernel: x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > kernel: x14: 0000000000000000 x13: 0000000000000001 x12: ffff60004fd90aa3
> > kernel: x11: 1fffe0004fd90aa2 x10: ffff60004fd90aa2 x9 : dfff800000000000
> > kernel: x8 : 00009fffb026f55e x7 : ffff00027ec85513 x6 : 0000000000000001
> > kernel: x5 : ffff00027ec85510 x4 : ffff60004fd90aa3 x3 : ffff800080787bc0
> > kernel: x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000a75a8000
> > kernel: Call trace:
> > kernel:  refcount_dec_not_one+0x198/0x1b0 (P)
> > kernel:  refcount_dec_and_lock+0x1c/0xb8
> > kernel:  nlmsvc_put_lockowner+0x9c/0x250 [lockd]
> > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > kernel:  svc_process+0x414/0x900 [sunrpc]
> > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > kernel:  lockd+0x154/0x298 [lockd]
> > kernel:  kthread+0x2f8/0x398
> > kernel:  ret_from_fork+0x10/0x20
> > kernel: ---[ end trace 0000000000000000 ]---
> >=20
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/lockd/svclock.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > index a31dc9588eb8..1dd0fec186de 100644
> > --- a/fs/lockd/svclock.c
> > +++ b/fs/lockd/svclock.c
> > @@ -652,6 +652,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> >  	conflock->fl.c.flc_type =3D lock->fl.c.flc_type;
> >  	conflock->fl.fl_start =3D lock->fl.fl_start;
> >  	conflock->fl.fl_end =3D lock->fl.fl_end;
> > +	conflock->fl.fl_lmops =3D NULL;
> >  	locks_release_private(&lock->fl);
> > =20
> >  	ret =3D nlm_lck_denied;
>=20
> The problem sounds real, but I'm not sure I like this solution.
>=20
> It seems like this is gaming the refcounting such that we take a
> reference in locks_copy_conflock() but then you zero out fl_lmops
> before that reference can be put.
>=20
> Doesn't that mean that the real bug is that we're missing taking an
> owner reference in some case?

I had a bit of a look and ....  and first it looked really strange that
vfs_test_lock() uses the "fl" arg as both an "in" and an "out" - that is
bound to cause refcounting issues.

But then I thought ...  "no, wait" As an "in" parameter, "fl" is just a
byte-range.  fl_start and fl_end are all that matter.  locks_overlap()
uses these and nothing else of significance matters.  In particular
fl_owner doesn't and can't matter.

So why, e.g., does nfsd4_lockt() set file_lock->c.flc_owner at all?

And nlm4svc_retrieve_args() shouldn't be setting up "the missing parts
of the file_lock structure" for TEST_LOCK - should it?

I think we need to treat get-lock quite differently from set-lock.
After all vfs_lock_file() does have a separate "conf" arg, while
vfs_test_lock() doesn't.  That is an important difference.

Maybe we should change vfs_test_lock() to be passed
   filp, start, len, *conf

and not pretend that we are passing in a lock description??

Thanks,
NeilBrown

