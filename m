Return-Path: <linux-nfs+bounces-13446-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE1DB1BCB1
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 00:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3C31886778
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 22:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41091254846;
	Tue,  5 Aug 2025 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3s905z9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7392021D5BF
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754433276; cv=none; b=krLcMzMpmLLG6q650wAHoLrbSWD4I+czprW5aoCfHtSBEdxDPbxwJX69XN+WQfQPgo3Z1MSqQipOzndz5jwn/hISOB7bJxpOnwGW5dflcquUXSiJdTF9nrzMfg4Razmex5Cu9QFB1DXz3EWzhDfKL7yLueJ/jPaNuQT3ZyT2+BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754433276; c=relaxed/simple;
	bh=du5QI9FWygSmoM11WJalBiDxBrko6cpH/HoJSHvSUvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7P9QSvUupnyW1+cg4nMWM8mWRUtUF/FvdBNR/5/8Cwkl1wMZvLnf47hbP1dqEUedEj5aNOCJfzbwVQscoeOA/EW0fqPQkTOl2JpLQiMSeEaQ1ZVWnqUfKn4xstljXuKQgumnQVDzR+QMXgM3wfzq5DCcDB0l1auimqhgq+pENo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3s905z9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754433273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z/2UAU4iBJpTnqzrcwgMMOfVBCM5BttQiAw9NNLpp+w=;
	b=a3s905z9JEOgVlXrMSW6qLy70i+TOCqokTA8J2CD9GryKJK/zKmcD/3JXWJrUqMUdqMK2w
	IUAKch130pF2EfiHdD/NZ4YUsqwNfbH/mJ485l4mBNzLKURvlXrX3cIrWkqzP0DgWDBjy+
	tGF7LkNve/FCM7UQvJEjaa8QgX9s9Ik=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-TktXMViCOou7Ce-yNPWpxw-1; Tue,
 05 Aug 2025 18:34:30 -0400
X-MC-Unique: TktXMViCOou7Ce-yNPWpxw-1
X-Mimecast-MFC-AGG-ID: TktXMViCOou7Ce-yNPWpxw_1754433269
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFCCE1956095;
	Tue,  5 Aug 2025 22:34:28 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.50])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D9F218003FC;
	Tue,  5 Aug 2025 22:34:28 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 7275535EF04; Tue, 05 Aug 2025 18:34:26 -0400 (EDT)
Date: Tue, 5 Aug 2025 18:34:26 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [Bug report] xfstests cause nfs crash, kernel BUG at
 kernel/cred.c:104!
Message-ID: <aJKG8jTt9Q3vRv9Q@aion>
References: <20250508051829.bdv2r72l2o5rsbni@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aECAAOYr9KTcoVac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aECAAOYr9KTcoVac@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, 04 Jun 2025, Mike Snitzer wrote:

> First I'm seeing this, I haven't hit it myself.
> 
> Can you elaborate on how you've configured xfstest?  I'll take a look
> at generic/023 to understand how NFS is being used (but for it to be
> hitting this with LOCALIO it must be doing loopback mount testing?)
> 
> neilbrown's localio patchset landed upstream yesterday via anna's 6.16
> pull request, so it'd be useful to know if linus/master still has
> this.  v6.15 should get neilb's localio patchset because it was marked
> for stable@ backport.
> 
> Thanks,
> Mike

I just hit a similar oops running cthon.  The first time I hit it I was
testing the xprtsec patch I was working on, but then I hit the panic on
a stock kernel on Fedora rawhide
(6.17.0-0.rc0.250804gd2eedaa3909b.10.fc43.x86_64).

crash> bt
PID: 1909     TASK: ffff8b156f120000  CPU: 5    COMMAND: "kworker/u38:3"
 #0 [ffffcf5bc439fa18] machine_kexec at ffffffff91d6b3fb
 #1 [ffffcf5bc439fa38] __crash_kexec at ffffffff91ef40f0
 #2 [ffffcf5bc439faf8] crash_kexec at ffffffff91ef4604
 #3 [ffffcf5bc439fb00] oops_end at ffffffff91d1b999
 #4 [ffffcf5bc439fb20] do_trap at ffffffff91d15fea
 #5 [ffffcf5bc439fb60] do_error_trap at ffffffff91d1634a
 #6 [ffffcf5bc439fba0] exc_invalid_op at ffffffff92f55be2
 #7 [ffffcf5bc439fbc0] asm_exc_invalid_op at ffffffff91a0123a
    [exception RIP: __put_cred+0x56]
    RIP: ffffffff91df4306  RSP: ffffcf5bc439fc78  RFLAGS: 00010246
    RAX: ffff8b156f120000  RBX: ffff8b1566671900  RCX: ffffffff951eb530
    RDX: 0000000000000002  RSI: 0000000000000002  RDI: ffff8b1548ea5cc0
    RBP: 0000000000000000   R8: 0000000000000002   R9: 0000000000000020
    R10: ffffffffffffffff  R11: 0000000000000003  R12: ffff8b1550579538
    R13: ffff8b1548047520  R14: ffff8b15405b0480  R15: ffff8b1545956300
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #8 [ffffcf5bc439fc78] __fput at ffffffff921dfb37
 #9 [ffffcf5bc439fca8] nfsd_file_free at ffffffffc0c6f95c [nfsd]
#10 [ffffcf5bc439fcc0] nfsd_file_put_local at ffffffffc0c70e77 [nfsd]
#11 [ffffcf5bc439fcd0] nfs_close_local_fh at ffffffffc0c2aa15 [nfs_localio]
#12 [ffffcf5bc439fd40] __put_nfs_open_context at ffffffffc1323afc [nfs]
#13 [ffffcf5bc439fd78] nfs_pgio_header_free at ffffffffc132d14e [nfs]
#14 [ffffcf5bc439fd88] nfs_write_completion at ffffffffc1334584 [nfs]
#15 [ffffcf5bc439fde0] nfs_local_call_write at ffffffffc134808f [nfs]
#16 [ffffcf5bc439fe58] process_one_work at ffffffff91ddeb52
#17 [ffffcf5bc439fe98] worker_thread at ffffffff91ddf66a
#18 [ffffcf5bc439fee0] kthread at ffffffff91de9d29
#19 [ffffcf5bc439ff30] ret_from_fork at ffffffff91d2796f
#20 [ffffcf5bc439ff50] ret_from_fork_asm at ffffffff91cd670a

We hit this bug in __put_cred():

        BUG_ON(cred == current->cred);

The address of the nfsd_file is on the stack in __fput():

crash> bt -F
...
 #8 [ffffcf5bc439fc78] __fput at ffffffff921dfb37
    ffffcf5bc439fc80: [nfsd_file]      0000000000000000 
    ffffcf5bc439fc90: [kmalloc-rnd-08-2k] [nfs_write_data] 
    ffffcf5bc439fca0: 0000000000000000 nfsd_file_free+0x8c 
 #9 [ffffcf5bc439fca8] nfsd_file_free at ffffffffc0c6f95c [nfsd]
...

crash> rd ffffcf5bc439fc80
ffffcf5bc439fc80:  ffff8b1544477280                    .rGD....

crash> nfsd_file.nf_file ffff8b1544477280
  nf_file = 0xffff8b1566671900,

crash> file.f_cred 0xffff8b1566671900
  f_cred = 0xffff8b1548ea5cc0,

crash> task -R cred | grep ffff8b1548ea5cc0
  cred = 0xffff8b1548ea5cc0,

-Scott

> 
> On Thu, May 08, 2025 at 01:18:29PM +0800, Zorro Lang wrote:
> > Hi,
> > 
> > Recently I always hit nfs crash[1] on latest mainline upstream linux 6.15.0-rc5+,
> > which HEAD=707df3375124b51048233625a7e1c801e8c8a7fd . I've hit this bug on aarch64
> > and x86_64 several times, by running xfstests on nfsv4.2 [2].
> > 
> > Thanks,
> > Zorro
> > 
> > [1]
> > [ 1004.936621] run fstests generic/023 at 2025-05-07 11:06:07 
> > [ 1005.840825] ------------[ cut here ]------------ 
> > [ 1005.845547] kernel BUG at kernel/cred.c:104! 
> > [ 1005.849848] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI 
> > [ 1005.855440] CPU: 12 UID: 0 PID: 78471 Comm: kworker/u128:20 Not tainted 6.15.0-rc5+ #1 PREEMPT(voluntary)  
> > [ 1005.865104] Hardware name: Dell Inc. PowerEdge R660/0R5JJC, BIOS 2.1.5 03/14/2024 
> > [ 1005.872583] Workqueue: nfslocaliod nfs_local_call_write [nfs] 
> > [ 1005.878416] RIP: 0010:__put_cred+0xea/0x120 
> > [ 1005.882618] Code: 2d 8b 83 a8 00 00 00 85 c0 74 0b 48 83 c4 08 5b 5d e9 fa fb ff ff 48 83 c4 08 48 c7 c6 c0 af da 83 5b 5d e9 28 54 1d 00 0f 0b <0f> 0b 0f 0b 48 89 3c 24 e8 09 dc 99 00 48 8b 3c 24 eb c4 48 89 df 
> > [ 1005.901383] RSP: 0018:ffa00000247a78d8 EFLAGS: 00010246 
> > [ 1005.906626] RAX: dffffc0000000000 RBX: ff110001428ea000 RCX: ffffffff83dab30c 
> > [ 1005.913757] RDX: 1fe220004203d19a RSI: 0000000000000008 RDI: ff110002101e8cd0 
> > [ 1005.920892] RBP: ff110002101e8000 R08: 0000000000000000 R09: ffe21c002851d400 
> > [ 1005.928024] R10: ff110001428ea007 R11: 0000000000000001 R12: 0000000000000000 
> > [ 1005.935157] R13: ff110001f6c1ce88 R14: ff110001f6c1ce68 R15: ff110001f6c1ce00 
> > [ 1005.942289] FS:  0000000000000000(0000) GS:ff110008938c7000(0000) knlGS:0000000000000000 
> > [ 1005.950376] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
> > [ 1005.956122] CR2: 00007f619475fdc0 CR3: 00000003f6c76004 CR4: 0000000000f73ef0 
> > [ 1005.963256] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 
> > [ 1005.970388] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400 
> > [ 1005.977520] PKRU: 55555554 
> > [ 1005.980234] Call Trace: 
> > [ 1005.982685]  <TASK> 
> > [ 1005.984794]  __fput+0x61e/0xaa0 
> > [ 1005.987958]  nfsd_file_free+0x1a1/0x3e0 [nfsd] 
> > [ 1005.992505]  nfsd_file_put_local+0x35/0x50 [nfsd] 
> > [ 1005.997290]  nfs_close_local_fh+0x362/0x6f0 [nfs_localio] 
> > [ 1006.002709]  __put_nfs_open_context+0x380/0x500 [nfs] 
> > [ 1006.007813]  ? nfs_write_completion+0x111/0x8a0 [nfs] 
> > [ 1006.012926]  nfs_pgio_header_free+0x41/0xe0 [nfs] 
> > [ 1006.017693]  nfs_write_completion+0x139/0x8a0 [nfs] 
> > [ 1006.022631]  ? __pfx_nfs_writeback_done.part.0+0x10/0x10 [nfs] 
> > [ 1006.028517]  ? __pfx_nfs_write_completion+0x10/0x10 [nfs] 
> > [ 1006.033981]  nfs_local_call_write+0x4fc/0xa50 [nfs] 
> > [ 1006.038918]  ? __pfx_nfs_local_call_write+0x10/0x10 [nfs] 
> > [ 1006.044376]  ? rcu_is_watching+0x15/0xb0 
> > [ 1006.048320]  ? rcu_is_watching+0x15/0xb0 
> > [ 1006.052246]  process_one_work+0xd6e/0x1330 
> > [ 1006.056349]  ? __pfx_process_one_work+0x10/0x10 
> > [ 1006.060897]  ? assign_work+0x16c/0x240 
> > [ 1006.064668]  worker_thread+0x5f3/0xfe0 
> > [ 1006.068437]  ? __kthread_parkme+0xb4/0x200 
> > [ 1006.072553]  ? __pfx_worker_thread+0x10/0x10 
> > [ 1006.076842]  kthread+0x3b1/0x770 
> > [ 1006.080077]  ? local_clock_noinstr+0xd/0xe0 
> > [ 1006.084278]  ? __pfx_kthread+0x10/0x10 
> > [ 1006.088032]  ? __lock_release.isra.0+0x1a4/0x2c0 
> > [ 1006.092667]  ? rcu_is_watching+0x15/0xb0 
> > [ 1006.096611]  ? __pfx_kthread+0x10/0x10 
> > [ 1006.100382]  ret_from_fork+0x31/0x70 
> > [ 1006.103978]  ? __pfx_kthread+0x10/0x10 
> > [ 1006.107738]  ret_from_fork_asm+0x1a/0x30 
> > [ 1006.111687]  </TASK> 
> > [ 1006.113894] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd grace nfs_localio rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common intel_ifs sunrpc i10nm_edac skx_edac_common nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm dax_hmem irqbypass cxl_acpi iTCO_wdt igb mgag200 cxl_port rapl dell_pc pmt_telemetry iTCO_vendor_support pmt_class cxl_core intel_sdsi dell_smbios platform_profile intel_cstate ipmi_ssif ses isst_if_mmio dcdbas wmi_bmof dell_wmi_descriptor pcspkr intel_uncore enclosure einj isst_if_mbox_pci mei_me isst_if_common intel_vsec i2c_i801 i2c_algo_bit tg3 dca mei i2c_smbus i2c_ismt acpi_power_meter ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler sg fuse loop dm_mod nfnetlink xfs sd_mod iaa_crypto mpt3sas ahci raid_class ghash_clmulni_intel libahci scsi_transport_sas idxd libata idxd_bus wmi pinctrl_emmitsburg 
> > [ 1006.198764] ---[ end trace 0000000000000000 ]--- 
> > [ 1006.223531] RIP: 0010:__put_cred+0xea/0x120 
> > [ 1006.227744] Code: 2d 8b 83 a8 00 00 00 85 c0 74 0b 48 83 c4 08 5b 5d e9 fa fb ff ff 48 83 c4 08 48 c7 c6 c0 af da 83 5b 5d e9 28 54 1d 00 0f 0b <0f> 0b 0f 0b 48 89 3c 24 e8 09 dc 99 00 48 8b 3c 24 eb c4 48 89 df 
> > [ 1006.246509] RSP: 0018:ffa00000247a78d8 EFLAGS: 00010246 
> > [ 1006.251762] RAX: dffffc0000000000 RBX: ff110001428ea000 RCX: ffffffff83dab30c 
> > [ 1006.258911] RDX: 1fe220004203d19a RSI: 0000000000000008 RDI: ff110002101e8cd0 
> > [ 1006.266065] RBP: ff110002101e8000 R08: 0000000000000000 R09: ffe21c002851d400 
> > [ 1006.273218] R10: ff110001428ea007 R11: 0000000000000001 R12: 0000000000000000 
> > [ 1006.280368] R13: ff110001f6c1ce88 R14: ff110001f6c1ce68 R15: ff110001f6c1ce00 
> > [ 1006.287521] FS:  0000000000000000(0000) GS:ff110008938c7000(0000) knlGS:0000000000000000 
> > [ 1006.295623] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
> > [ 1006.301387] CR2: 00007f619475fdc0 CR3: 00000003f6c76004 CR4: 0000000000f73ef0 
> > [ 1006.308535] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 
> > [ 1006.315687] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400 
> > [ 1006.322836] PKRU: 55555554 
> > [ 1006.325569] Kernel panic - not syncing: Fatal exception 
> > [ 1006.330842] Kernel Offset: 0x2800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff) 
> > [ 1006.361714] ---[ end Kernel panic - not syncing: Fatal exception ]--- 
> > [-- MARK -- Wed May  7 15:10:00 2025] 
> > [-- MARK -- Wed May  7 15:15:00 2025] 
> > 
> > [2]
> > export FSTYP=nfs
> > export TEST_DEV=xxxxxxx.xxxxxxxxxx.xxxxxxxxxxxx:/mnt/xfstests/test/nfs-server
> > export TEST_DIR=/mnt/xfstests/test/nfs-client
> > export SCRATCH_DEV=xxxxxxx.xxxxxxxxxx.xxxxxxxxxxxx:/mnt/xfstests/scratch/nfs-server
> > export SCRATCH_MNT=/mnt/xfstests/scratch/nfs-client
> > export MOUNT_OPTIONS="-o vers=4.2"
> > export TEST_FS_MOUNT_OPTS="-o vers=4.2"
> > 
> > 
> 


