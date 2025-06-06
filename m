Return-Path: <linux-nfs+bounces-12144-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE97ACFB51
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 04:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352EE164542
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 02:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9F53B1A4;
	Fri,  6 Jun 2025 02:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDfztA19"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF05A79B
	for <linux-nfs@vger.kernel.org>; Fri,  6 Jun 2025 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749177508; cv=none; b=lR66vOYIj17Swhzk2znN6QPpa/sgUuqsMmYqzaH6pC/YqIUu7+R6lCX3RvMpVhyxhHjb3KGmIQNXx8uDZAPQBCnR0JU+KYnrlHRZAyhkhTwdn2pjx+QH2HqGVh69WK6yMgTTLfPuqr+g5o8lH+iu9e+zdEGOkRLaFL+oA/bXSB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749177508; c=relaxed/simple;
	bh=hB62lvCSJQjgmQ9NuVDe+JpJ/kgaMnCJGqRag5k3/FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRvysJXbkmDTxO5Z9JfaMGrdmwdS2Ew9XXbZNW+gmIQkiOXIRSr0he7/+64YJcY8tcRRgyJLePU9nQDlKehHsKa/ROXsW5aG0IJSjsGY08rqKrxaipVenVfzZ/WS/423FqdlKUmux1T9o8aRdw3hatVSsRWkQkQm+pM5NC6fHkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDfztA19; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749177505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJyxducGQPZbDb6m39kp2SGhRPysciVsTiSAzvfAZJY=;
	b=HDfztA19bVp7P8dargDVs1QatU+2tc0zJ5B5qw0Ci3P5plOjcqSPwoKq9lQKmQLMeTGuiO
	m6WZpTgR7vYOyXsXmIbG9zfOS9hJi/WcXp0jJYH4AodbIc8Y2kRmf+cAiyemowNL0C9TyJ
	Cq8v0P3g7ltC2rF7k2KBUjFBooHD6uc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-ZoR_3kXaOXSvQb7kAxAGkg-1; Thu, 05 Jun 2025 22:38:23 -0400
X-MC-Unique: ZoR_3kXaOXSvQb7kAxAGkg-1
X-Mimecast-MFC-AGG-ID: ZoR_3kXaOXSvQb7kAxAGkg_1749177502
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-747fa83d81dso1458622b3a.3
        for <linux-nfs@vger.kernel.org>; Thu, 05 Jun 2025 19:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749177502; x=1749782302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJyxducGQPZbDb6m39kp2SGhRPysciVsTiSAzvfAZJY=;
        b=f2WGRQducuYtqe2llyCp6PkN6VCN8lgA8/hPL7d7M9Oukicsi/DUhvG4Nf/4AZTNkT
         lD0/Mv0VUjuMmiVUflU/qK8Mw7ZRLrZYPHVnNXHGWxINz1NVXziE/tOW21AKYmumnDxz
         4bqHpsKpBNeoyNNBgGstJ6zF9N6/hC/RxFmmUoVdeJSGSFpEXNi3uo/iyOQdVrjXKqNz
         ItxAuRds51aKOu4iwTB6StOq2ZDxvandfq71ikrG6+d1TQmbVe58utb1jSnugv6lQQmq
         x/BrEzw8wY7LrcOjcOyRHHgBGBpFSDDEog7JQLDStpoPjfxnI1aCp+xAVyrtWORW3PLl
         dlQw==
X-Gm-Message-State: AOJu0YzLrw28JhRqwGKKMaslUaT6YAyZSa+aPDSAEQ4vMd0e18g2w8/6
	5rp1ODVvR4fpAVjRK0aB/TtYxt/mpt60g6DzySR48TOzrk13YUdWAHo32g5sOQKmREILwWHkXDK
	UcFt0IjJFo4BNPH8RSm8LyMeUxWs/vB2DKSF6NzpcZ5/IA+ErnYPk3u6m+uOziHnjvPbgFw==
X-Gm-Gg: ASbGncvIu+RqEjfrkkEsrOLMiDIIZ8VdJ9LvFlXbXeJsqUC7AeV3tNCmwO4BC9pl6nb
	QQJv5yLrSapbbB9DpKaTrIAvlvMj4Sdt7YnZNwHuuSuoGD9SWAxeRCIUvdeRpTcssDGo+Q+gsWe
	tGKCwaErZpFqeuby7Y4pTTPxNtHKTlbFQ1Mgjao9cfuYi1R3K0f9BKtmv899Y8zew3RXjwWlsRm
	jaypxsBVoDXnLMK20jRj/XSSp+CX13hD+l/yD9YBtBSGmlgzPJoFz2UtI6kJcLm/oYDbHr+5Nu2
	NwlEF8CI/98tlSzDFg1h7aokMIdrAqJuSAmtFz+cHH/lck16jsh2VIxRcIbFxKc=
X-Received: by 2002:a05:6a00:885:b0:736:6ecd:8e34 with SMTP id d2e1a72fcca58-748280aca58mr2664125b3a.18.1749177502134;
        Thu, 05 Jun 2025 19:38:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj5n51NlDpKxu3ZshwweVAHz9ookTdK25hfXN8jhcUvGvnaWnHlHJ4TEXbCwu91P6vt6ETsQ==
X-Received: by 2002:a05:6a00:885:b0:736:6ecd:8e34 with SMTP id d2e1a72fcca58-748280aca58mr2664088b3a.18.1749177501626;
        Thu, 05 Jun 2025 19:38:21 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af7b2c7sm337047b3a.48.2025.06.05.19.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 19:38:21 -0700 (PDT)
Date: Fri, 6 Jun 2025 10:38:17 +0800
From: Zorro Lang <zlang@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [Bug report] xfstests cause nfs crash, kernel BUG at
 kernel/cred.c:104!
Message-ID: <20250606023817.anfg73jusif5uvfm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

On Wed, Jun 04, 2025 at 01:18:56PM -0400, Mike Snitzer wrote:
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

I just hit this bug[1] on latest upstream linux again
(HEAD=e271ed52b344ac02d4581286961d0c40acc54c03), so the bug is still there.

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
[  964.504249] run fstests generic/023 at 2025-06-05 21:35:27 
[  965.376924] ------------[ cut here ]------------ 
[  965.381641] kernel BUG at kernel/cred.c:104! 
[  965.385945] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI 
[  965.391534] CPU: 24 UID: 0 PID: 222 Comm: kworker/u128:14 Tainted: G S                  6.15.0+ #1 PREEMPT(voluntary)  
[  965.402237] Tainted: [S]=CPU_OUT_OF_SPEC 
[  965.406169] Hardware name: Dell Inc. PowerEdge R660/0R5JJC, BIOS 2.4.4 09/27/2024 
[  965.413648] Workqueue: nfslocaliod nfs_local_call_write [nfs] 
[  965.419480] RIP: 0010:__put_cred+0xea/0x120 
[  965.423684] Code: 2d 8b 83 a8 00 00 00 85 c0 74 0b 48 83 c4 08 5b 5d e9 fa fb ff ff 48 83 c4 08 48 c7 c6 80 b8 78 92 5b 5d e9 f8 b0 1d 00 0f 0b <0f> 0b 0f 0b 48 89 3c 24 e8 09 17 9b 00 48 8b 3c 24 eb c4 48 89 df 
[  965.442448] RSP: 0018:ffa000000156f790 EFLAGS: 00010246 
[  965.447693] RAX: dffffc0000000000 RBX: ff110001cb191b00 RCX: ffffffff9278bbcc 
[  965.454825] RDX: 1fe2200020620972 RSI: 0000000000000008 RDI: ff11000103104b90 
[  965.461958] RBP: ff11000103103ec0 R08: 0000000000000000 R09: ffe21c0039632360 
[  965.469089] R10: ff110001cb191b07 R11: 0000000000000001 R12: 0000000000000000 
[  965.476224] R13: ff11000170651208 R14: ff110001706511e8 R15: ff11000170651180 
[  965.483357] FS:  0000000000000000(0000) GS:ff11000887ef3000(0000) knlGS:0000000000000000 
[  965.491458] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
[  965.497205] CR2: 000056321a5700b8 CR3: 00000004a5c7a006 CR4: 0000000000f73ef0 
[  965.504339] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 
[  965.511469] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400 
[  965.518603] PKRU: 55555554 
[  965.521315] Call Trace: 
[  965.523770]  <TASK> 
[  965.525876]  __fput+0x61e/0xaa0 
[  965.529042]  nfsd_file_free+0x1a1/0x3e0 [nfsd] 
[  965.533580]  nfsd_file_put_local+0x4c/0x60 [nfsd] 
[  965.538357]  nfs_close_local_fh+0x278/0x9a0 [nfs_localio] 
[  965.543773]  ? __pfx_nfs_close_local_fh+0x10/0x10 [nfs_localio] 
[  965.549708]  ? rcu_is_watching+0x15/0xb0 
[  965.553651]  ? kfree+0x286/0x4b0 
[  965.556902]  __put_nfs_open_context+0x380/0x500 [nfs] 
[  965.562016]  ? nfs_write_completion+0x111/0x8a0 [nfs] 
[  965.567131]  nfs_pgio_header_free+0x41/0xe0 [nfs] 
[  965.571897]  nfs_write_completion+0x139/0x8a0 [nfs] 
[  965.576826]  ? rcu_is_watching+0x15/0xb0 
[  965.580770]  ? nfs_writeback_done.part.0+0x3dc/0x5e0 [nfs] 
[  965.586308]  ? __pfx_nfs_write_completion+0x10/0x10 [nfs] 
[  965.591759]  ? __pfx_nfs_writeback_done.part.0+0x10/0x10 [nfs] 
[  965.597645]  ? lockdep_hardirqs_on+0x78/0x100 
[  965.602023]  ? __pfx_nfs_writeback_result+0x10/0x10 [nfs] 
[  965.607472]  ? nfs_writeback_done+0xec/0x130 [nfs] 
[  965.612320]  nfs_local_pgio_release+0x261/0x3b0 [nfs] 
[  965.617421]  ? __pfx_nfs_local_pgio_release+0x10/0x10 [nfs] 
[  965.623048]  nfs_local_call_write+0x4fc/0xa50 [nfs] 
[  965.627981]  ? __pfx_nfs_local_call_write+0x10/0x10 [nfs] 
[  965.633430]  ? rcu_is_watching+0x15/0xb0 
[  965.637373]  ? rcu_is_watching+0x15/0xb0 
[  965.641299]  process_one_work+0xd88/0x1320 
[  965.645419]  ? __pfx_process_one_work+0x10/0x10 
[  965.649967]  ? assign_work+0x16c/0x240 
[  965.653736]  worker_thread+0x5f3/0xfe0 
[  965.657510]  ? __pfx_worker_thread+0x10/0x10 
[  965.661796]  kthread+0x3b1/0x770 
[  965.665028]  ? local_clock_noinstr+0x45/0xe0 
[  965.669320]  ? __pfx_kthread+0x10/0x10 
[  965.673071]  ? __lock_release.isra.0+0x1a4/0x2c0 
[  965.677707]  ? rcu_is_watching+0x15/0xb0 
[  965.681652]  ? __pfx_kthread+0x10/0x10 
[  965.685404]  ret_from_fork+0x390/0x480 
[  965.689173]  ? __pfx_kthread+0x10/0x10 
[  965.692927]  ? __pfx_kthread+0x10/0x10 
[  965.696681]  ret_from_fork_asm+0x1a/0x30 
[  965.700627]  </TASK> 
[  965.702833] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd grace nfs_localio rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common intel_ifs i10nm_edac skx_edac_common nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm sunrpc dax_hmem irqbypass iTCO_wdt pmt_telemetry rapl mgag200 iTCO_vendor_support pmt_class intel_sdsi intel_cstate platform_profile mei_me dell_smbios ses ipmi_ssif isst_if_mmio isst_if_mbox_pci dcdbas dell_wmi_descriptor wmi_bmof intel_uncore enclosure pcspkr isst_if_common intel_vsec i2c_algo_bit tg3 acpi_power_meter mei i2c_i801 i2c_ismt i2c_smbus ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler sg loop fuse dm_mod nfnetlink xfs sd_mod iaa_crypto mpt3sas ahci raid_class ghash_clmulni_intel idxd libahci scsi_transport_sas libata idxd_bus wmi pinctrl_emmitsburg 
[  965.783610] ---[ end trace 0000000000000000 ]--- 
[  965.810265] RIP: 0010:__put_cred+0xea/0x120 
[  965.814484] Code: 2d 8b 83 a8 00 00 00 85 c0 74 0b 48 83 c4 08 5b 5d e9 fa fb ff ff 48 83 c4 08 48 c7 c6 80 b8 78 92 5b 5d e9 f8 b0 1d 00 0f 0b <0f> 0b 0f 0b 48 89 3c 24 e8 09 17 9b 00 48 8b 3c 24 eb c4 48 89 df 
[  965.833245] RSP: 0018:ffa000000156f790 EFLAGS: 00010246 
[  965.838490] RAX: dffffc0000000000 RBX: ff110001cb191b00 RCX: ffffffff9278bbcc 
[  965.845644] RDX: 1fe2200020620972 RSI: 0000000000000008 RDI: ff11000103104b90 
[  965.852802] RBP: ff11000103103ec0 R08: 0000000000000000 R09: ffe21c0039632360 
[  965.859949] R10: ff110001cb191b07 R11: 0000000000000001 R12: 0000000000000000 
[  965.867089] R13: ff11000170651208 R14: ff110001706511e8 R15: ff11000170651180 
[  965.874239] FS:  0000000000000000(0000) GS:ff11000887ef3000(0000) knlGS:0000000000000000 
[  965.882344] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
[  965.888096] CR2: 000056321a5700b8 CR3: 00000004a5c7a006 CR4: 0000000000f73ef0 
[  965.895248] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 
[  965.902396] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400 
[  965.909549] PKRU: 55555554 
[  965.912278] Kernel panic - not syncing: Fatal exception 
[  965.917552] Kernel Offset: 0x11200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff) 
[  965.950419] ---[ end Kernel panic - not syncing: Fatal exception ]--- 
[-- MARK -- Fri Jun  6 01:40:00 2025] 

> 
> Thanks,
> Mike
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


