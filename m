Return-Path: <linux-nfs+bounces-12099-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B96ACE37C
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 19:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACD21734C1
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 17:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D49B1F4634;
	Wed,  4 Jun 2025 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBYX7Y5u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6938C1F12F8
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057538; cv=none; b=k7+Lrei/vzbLVU2ukAJ7PYys3nLPcVMbzGACrr5See0dLgEfc44VZsowwY8lye2HGDERaWZdGxK/hlEKZpbN6xS9foT2MZv+PYrnO5Lfr9BkT4MLwfpaLJeIpBcTUxe/uJRHm5hcBy0dSawdWG/JRjAgjVXsDEfIDlJUYhaJVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057538; c=relaxed/simple;
	bh=Vvx23ZY33CH8aAaBlP/9nsDhPLLDpo1CaueZc0uZ+eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ/V+4mbFhKJN3a93Q+cjHbiXcyS8JfhPF8nZxm8rH7YEMg+NeGoCU5sahCQGUmL5TbmnMuCfUUyYRf74FB/JemeVsMhmjOwKuqjbBu1ahPtYHilIvWHtqUGIlxNNEYUuSbnLBS4Kpa8C8TOeRtAd/PWHHxG98glElDj0vp/U48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBYX7Y5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7D2C4CEE4;
	Wed,  4 Jun 2025 17:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749057537;
	bh=Vvx23ZY33CH8aAaBlP/9nsDhPLLDpo1CaueZc0uZ+eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YBYX7Y5u3b2zHlTum0/mpz1QcO0YLVJgbIJds21mTtkceKNMQZFt/tuyLOVY04HcJ
	 ezSqmQ9IkZXcFGgzdLP2YSXq9hcACC43Jwl7IG9TQE7hOHEMASvcza5Wtizo2Uwt/+
	 xlVjdVMhYgRdSqhrYM+PyC2ARCpqdKI/zQwgKG1LDjgBBwUoo7K4lqHkDji3JS8lFb
	 c1Svzj9UOATx0e7wK6TaEbv/6tWebz4cEGKVeOfOHMnTVY2tKTvO0BkPnogCZvzWPK
	 WKAvfjhK62+vgUgslOwFr1YTDRbJ6+nQNuCoPVKyddorSwrMo56AL1BM28EJhEMX/Y
	 qdYR74/ZPL50w==
Date: Wed, 4 Jun 2025 13:18:56 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [Bug report] xfstests cause nfs crash, kernel BUG at
 kernel/cred.c:104!
Message-ID: <aECAAOYr9KTcoVac@kernel.org>
References: <20250508051829.bdv2r72l2o5rsbni@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508051829.bdv2r72l2o5rsbni@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

First I'm seeing this, I haven't hit it myself.

Can you elaborate on how you've configured xfstest?  I'll take a look
at generic/023 to understand how NFS is being used (but for it to be
hitting this with LOCALIO it must be doing loopback mount testing?)

neilbrown's localio patchset landed upstream yesterday via anna's 6.16
pull request, so it'd be useful to know if linus/master still has
this.  v6.15 should get neilb's localio patchset because it was marked
for stable@ backport.

Thanks,
Mike

On Thu, May 08, 2025 at 01:18:29PM +0800, Zorro Lang wrote:
> Hi,
> 
> Recently I always hit nfs crash[1] on latest mainline upstream linux 6.15.0-rc5+,
> which HEAD=707df3375124b51048233625a7e1c801e8c8a7fd . I've hit this bug on aarch64
> and x86_64 several times, by running xfstests on nfsv4.2 [2].
> 
> Thanks,
> Zorro
> 
> [1]
> [ 1004.936621] run fstests generic/023 at 2025-05-07 11:06:07 
> [ 1005.840825] ------------[ cut here ]------------ 
> [ 1005.845547] kernel BUG at kernel/cred.c:104! 
> [ 1005.849848] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI 
> [ 1005.855440] CPU: 12 UID: 0 PID: 78471 Comm: kworker/u128:20 Not tainted 6.15.0-rc5+ #1 PREEMPT(voluntary)  
> [ 1005.865104] Hardware name: Dell Inc. PowerEdge R660/0R5JJC, BIOS 2.1.5 03/14/2024 
> [ 1005.872583] Workqueue: nfslocaliod nfs_local_call_write [nfs] 
> [ 1005.878416] RIP: 0010:__put_cred+0xea/0x120 
> [ 1005.882618] Code: 2d 8b 83 a8 00 00 00 85 c0 74 0b 48 83 c4 08 5b 5d e9 fa fb ff ff 48 83 c4 08 48 c7 c6 c0 af da 83 5b 5d e9 28 54 1d 00 0f 0b <0f> 0b 0f 0b 48 89 3c 24 e8 09 dc 99 00 48 8b 3c 24 eb c4 48 89 df 
> [ 1005.901383] RSP: 0018:ffa00000247a78d8 EFLAGS: 00010246 
> [ 1005.906626] RAX: dffffc0000000000 RBX: ff110001428ea000 RCX: ffffffff83dab30c 
> [ 1005.913757] RDX: 1fe220004203d19a RSI: 0000000000000008 RDI: ff110002101e8cd0 
> [ 1005.920892] RBP: ff110002101e8000 R08: 0000000000000000 R09: ffe21c002851d400 
> [ 1005.928024] R10: ff110001428ea007 R11: 0000000000000001 R12: 0000000000000000 
> [ 1005.935157] R13: ff110001f6c1ce88 R14: ff110001f6c1ce68 R15: ff110001f6c1ce00 
> [ 1005.942289] FS:  0000000000000000(0000) GS:ff110008938c7000(0000) knlGS:0000000000000000 
> [ 1005.950376] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
> [ 1005.956122] CR2: 00007f619475fdc0 CR3: 00000003f6c76004 CR4: 0000000000f73ef0 
> [ 1005.963256] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 
> [ 1005.970388] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400 
> [ 1005.977520] PKRU: 55555554 
> [ 1005.980234] Call Trace: 
> [ 1005.982685]  <TASK> 
> [ 1005.984794]  __fput+0x61e/0xaa0 
> [ 1005.987958]  nfsd_file_free+0x1a1/0x3e0 [nfsd] 
> [ 1005.992505]  nfsd_file_put_local+0x35/0x50 [nfsd] 
> [ 1005.997290]  nfs_close_local_fh+0x362/0x6f0 [nfs_localio] 
> [ 1006.002709]  __put_nfs_open_context+0x380/0x500 [nfs] 
> [ 1006.007813]  ? nfs_write_completion+0x111/0x8a0 [nfs] 
> [ 1006.012926]  nfs_pgio_header_free+0x41/0xe0 [nfs] 
> [ 1006.017693]  nfs_write_completion+0x139/0x8a0 [nfs] 
> [ 1006.022631]  ? __pfx_nfs_writeback_done.part.0+0x10/0x10 [nfs] 
> [ 1006.028517]  ? __pfx_nfs_write_completion+0x10/0x10 [nfs] 
> [ 1006.033981]  nfs_local_call_write+0x4fc/0xa50 [nfs] 
> [ 1006.038918]  ? __pfx_nfs_local_call_write+0x10/0x10 [nfs] 
> [ 1006.044376]  ? rcu_is_watching+0x15/0xb0 
> [ 1006.048320]  ? rcu_is_watching+0x15/0xb0 
> [ 1006.052246]  process_one_work+0xd6e/0x1330 
> [ 1006.056349]  ? __pfx_process_one_work+0x10/0x10 
> [ 1006.060897]  ? assign_work+0x16c/0x240 
> [ 1006.064668]  worker_thread+0x5f3/0xfe0 
> [ 1006.068437]  ? __kthread_parkme+0xb4/0x200 
> [ 1006.072553]  ? __pfx_worker_thread+0x10/0x10 
> [ 1006.076842]  kthread+0x3b1/0x770 
> [ 1006.080077]  ? local_clock_noinstr+0xd/0xe0 
> [ 1006.084278]  ? __pfx_kthread+0x10/0x10 
> [ 1006.088032]  ? __lock_release.isra.0+0x1a4/0x2c0 
> [ 1006.092667]  ? rcu_is_watching+0x15/0xb0 
> [ 1006.096611]  ? __pfx_kthread+0x10/0x10 
> [ 1006.100382]  ret_from_fork+0x31/0x70 
> [ 1006.103978]  ? __pfx_kthread+0x10/0x10 
> [ 1006.107738]  ret_from_fork_asm+0x1a/0x30 
> [ 1006.111687]  </TASK> 
> [ 1006.113894] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd grace nfs_localio rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common intel_ifs sunrpc i10nm_edac skx_edac_common nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm dax_hmem irqbypass cxl_acpi iTCO_wdt igb mgag200 cxl_port rapl dell_pc pmt_telemetry iTCO_vendor_support pmt_class cxl_core intel_sdsi dell_smbios platform_profile intel_cstate ipmi_ssif ses isst_if_mmio dcdbas wmi_bmof dell_wmi_descriptor pcspkr intel_uncore enclosure einj isst_if_mbox_pci mei_me isst_if_common intel_vsec i2c_i801 i2c_algo_bit tg3 dca mei i2c_smbus i2c_ismt acpi_power_meter ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler sg fuse loop dm_mod nfnetlink xfs sd_mod iaa_crypto mpt3sas ahci raid_class ghash_clmulni_intel libahci scsi_transport_sas idxd libata idxd_bus wmi pinctrl_emmitsburg 
> [ 1006.198764] ---[ end trace 0000000000000000 ]--- 
> [ 1006.223531] RIP: 0010:__put_cred+0xea/0x120 
> [ 1006.227744] Code: 2d 8b 83 a8 00 00 00 85 c0 74 0b 48 83 c4 08 5b 5d e9 fa fb ff ff 48 83 c4 08 48 c7 c6 c0 af da 83 5b 5d e9 28 54 1d 00 0f 0b <0f> 0b 0f 0b 48 89 3c 24 e8 09 dc 99 00 48 8b 3c 24 eb c4 48 89 df 
> [ 1006.246509] RSP: 0018:ffa00000247a78d8 EFLAGS: 00010246 
> [ 1006.251762] RAX: dffffc0000000000 RBX: ff110001428ea000 RCX: ffffffff83dab30c 
> [ 1006.258911] RDX: 1fe220004203d19a RSI: 0000000000000008 RDI: ff110002101e8cd0 
> [ 1006.266065] RBP: ff110002101e8000 R08: 0000000000000000 R09: ffe21c002851d400 
> [ 1006.273218] R10: ff110001428ea007 R11: 0000000000000001 R12: 0000000000000000 
> [ 1006.280368] R13: ff110001f6c1ce88 R14: ff110001f6c1ce68 R15: ff110001f6c1ce00 
> [ 1006.287521] FS:  0000000000000000(0000) GS:ff110008938c7000(0000) knlGS:0000000000000000 
> [ 1006.295623] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
> [ 1006.301387] CR2: 00007f619475fdc0 CR3: 00000003f6c76004 CR4: 0000000000f73ef0 
> [ 1006.308535] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 
> [ 1006.315687] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400 
> [ 1006.322836] PKRU: 55555554 
> [ 1006.325569] Kernel panic - not syncing: Fatal exception 
> [ 1006.330842] Kernel Offset: 0x2800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff) 
> [ 1006.361714] ---[ end Kernel panic - not syncing: Fatal exception ]--- 
> [-- MARK -- Wed May  7 15:10:00 2025] 
> [-- MARK -- Wed May  7 15:15:00 2025] 
> 
> [2]
> export FSTYP=nfs
> export TEST_DEV=xxxxxxx.xxxxxxxxxx.xxxxxxxxxxxx:/mnt/xfstests/test/nfs-server
> export TEST_DIR=/mnt/xfstests/test/nfs-client
> export SCRATCH_DEV=xxxxxxx.xxxxxxxxxx.xxxxxxxxxxxx:/mnt/xfstests/scratch/nfs-server
> export SCRATCH_MNT=/mnt/xfstests/scratch/nfs-client
> export MOUNT_OPTIONS="-o vers=4.2"
> export TEST_FS_MOUNT_OPTS="-o vers=4.2"
> 
> 

