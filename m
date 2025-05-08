Return-Path: <linux-nfs+bounces-11596-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E04AAF2C4
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 07:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B03318868B0
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 05:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A911F3BAC;
	Thu,  8 May 2025 05:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhYMpfhG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A46B661
	for <linux-nfs@vger.kernel.org>; Thu,  8 May 2025 05:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746681520; cv=none; b=UPdgYidcoQj43fa8WNhVDM8vfGLHDLLo2aEmlZzmeORcXoC4SpsnRowJzHP1pl2nvmb6H6E/2MDC3AeCTbKXBZUdcWxVsAhjAq0gMNf3ATetg7jEn0NzrP1MYuwzudOP8cNr6OIirZBmIcCj8+1krlrAtAIAtVWtEWA564CfSdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746681520; c=relaxed/simple;
	bh=IONc1NSOeNbSqwcm5rRLb1qpQ092WUsvqD2c8rXr/gQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ILRoXySYhMzhbeEvPIRgP+Y6vW0OWTJqvv0r6mGh4itz7LSl+pR6JdwbRAdhl4GFqxOr78yQ+UUm9bjPlwGj7kzKXh5tRQc/7gxXX5obTV5vX9VjpaUw+GaGR/uc/Ohcxi/PNdyEfIfn8KlddYpQSBWGjn3YWOnsrQ7oTLkkd6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhYMpfhG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746681516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=GeWAEIpGe3CSxdT8BoxcbfdcEKtUxeYydO2ozkAqcy4=;
	b=RhYMpfhGAyQNz6kDwpvjDja3xHjytK59Twh2hE1EjVUv8U+359I1MzKGF6xShZQnThytQv
	i7cnJzOh6/EMCkV6O+BuSjpVVuyK4vh7hZ7PdHaNGegFSmnZ/a1Yu0uXVbLuEbo6KWiJB/
	+fVD2jF+0P23j11XDwTG5hAzPI2nJWY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-imkyvJ6CMUeHUwKlKwjzrg-1; Thu, 08 May 2025 01:18:35 -0400
X-MC-Unique: imkyvJ6CMUeHUwKlKwjzrg-1
X-Mimecast-MFC-AGG-ID: imkyvJ6CMUeHUwKlKwjzrg_1746681514
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b090c7c2c6aso371308a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 07 May 2025 22:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746681514; x=1747286314;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GeWAEIpGe3CSxdT8BoxcbfdcEKtUxeYydO2ozkAqcy4=;
        b=NUB3sohp7vSgZCN7jeN8nqiCnou7PHBtlM1s5RLNy3jgrFLGSUitdjFS/TeCdNAHdU
         evrBTHa1j2AYu1IBsjGV79y9njUOQ1zh7HS+IgCALZ1E3McuPlQs6C2oMV55Q3GWcBJM
         uRXDGYg6NFXkLot6tWejs+XnsXwpmy06caqtFnuzIYmNJxykYXRZVfONWUnDOoBvflHD
         obn1RGgPx2UecaWmC5olnRQM7fbtIkP97yeqNn/8CQ4SW4XPdw4eBQ7BPrXHCPp/0DI2
         5EQhc4ts5Xzd25Rf/eN94Pi7Jkb4pMwSN7JrYwc39dLS9TQPBIIcElWK+jFwpPcFNNa1
         gavw==
X-Gm-Message-State: AOJu0YyGPKdFIu7VLEbiGypp8mBpII+2qnwB/50HvnhnJIkT/yGo09Ju
	bTrZ9Hk0C9a9krkCAJWVcLGoK+I0uqUEtV962u+jWvxJ1feKu+1N5mARR2ENHjq5wWCihh4YkN8
	gjg3m0KmmZeMWTcI6ivssCcxiYXIbyMrDLkrj5hq7aMeCvnPdxU1+3FhMiMQcX5CQL1rbt6NLA7
	iZNRLaM4Pt470iFw+le4/oSyJE+qHYC+vzbr+QWg==
X-Gm-Gg: ASbGncs1dc9XhEc8k84LcGU3UiFjkCzfFbFQdqbAwT9WL6ca60LMb/Cg+NjZq6xSBJ/
	X33wdnDsTg5vukXxEJvHGDrPAXws5ceZeUcc2TjEafcdHXrvASbdUtY4CVOOb1dIrjgZhvOIcaf
	quEB5j60iRHTwWt0s6xGMdruWBFJK9mr1lHoCfRPpJ4GoCeF0iFKFZ+SPg0qCxgkQnZ3F5RmBAc
	cYped4PVgXU3jAty7oCTv8AkjgwE/X1Xhi9ln8o4oBVHmhYu7JE6c5kqjxRfyKW97S6kVxBb0Un
	zKY2NW+mPms+YeMspyY9SvIxY7RP7WlUJBpwScCB9KfpSrx3IQWD
X-Received: by 2002:a05:6a20:d526:b0:1f5:8479:dfe2 with SMTP id adf61e73a8af0-2148b526853mr8666935637.6.1746681513683;
        Wed, 07 May 2025 22:18:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBIFWJpnk2p+jhFWNk9hT7V6CwfhiBAfGw91RBEW1JvN2UPMNHtefsFqwpwDqczE42uqzefw==
X-Received: by 2002:a05:6a20:d526:b0:1f5:8479:dfe2 with SMTP id adf61e73a8af0-2148b526853mr8666907637.6.1746681513073;
        Wed, 07 May 2025 22:18:33 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3b831d0sm8898386a12.44.2025.05.07.22.18.31
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 22:18:32 -0700 (PDT)
Date: Thu, 8 May 2025 13:18:29 +0800
From: Zorro Lang <zlang@redhat.com>
To: linux-nfs@vger.kernel.org
Subject: [Bug report] xfstests cause nfs crash, kernel BUG at
 kernel/cred.c:104!
Message-ID: <20250508051829.bdv2r72l2o5rsbni@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Recently I always hit nfs crash[1] on latest mainline upstream linux 6.15.0-rc5+,
which HEAD=707df3375124b51048233625a7e1c801e8c8a7fd . I've hit this bug on aarch64
and x86_64 several times, by running xfstests on nfsv4.2 [2].

Thanks,
Zorro

[1]
[ 1004.936621] run fstests generic/023 at 2025-05-07 11:06:07 
[ 1005.840825] ------------[ cut here ]------------ 
[ 1005.845547] kernel BUG at kernel/cred.c:104! 
[ 1005.849848] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI 
[ 1005.855440] CPU: 12 UID: 0 PID: 78471 Comm: kworker/u128:20 Not tainted 6.15.0-rc5+ #1 PREEMPT(voluntary)  
[ 1005.865104] Hardware name: Dell Inc. PowerEdge R660/0R5JJC, BIOS 2.1.5 03/14/2024 
[ 1005.872583] Workqueue: nfslocaliod nfs_local_call_write [nfs] 
[ 1005.878416] RIP: 0010:__put_cred+0xea/0x120 
[ 1005.882618] Code: 2d 8b 83 a8 00 00 00 85 c0 74 0b 48 83 c4 08 5b 5d e9 fa fb ff ff 48 83 c4 08 48 c7 c6 c0 af da 83 5b 5d e9 28 54 1d 00 0f 0b <0f> 0b 0f 0b 48 89 3c 24 e8 09 dc 99 00 48 8b 3c 24 eb c4 48 89 df 
[ 1005.901383] RSP: 0018:ffa00000247a78d8 EFLAGS: 00010246 
[ 1005.906626] RAX: dffffc0000000000 RBX: ff110001428ea000 RCX: ffffffff83dab30c 
[ 1005.913757] RDX: 1fe220004203d19a RSI: 0000000000000008 RDI: ff110002101e8cd0 
[ 1005.920892] RBP: ff110002101e8000 R08: 0000000000000000 R09: ffe21c002851d400 
[ 1005.928024] R10: ff110001428ea007 R11: 0000000000000001 R12: 0000000000000000 
[ 1005.935157] R13: ff110001f6c1ce88 R14: ff110001f6c1ce68 R15: ff110001f6c1ce00 
[ 1005.942289] FS:  0000000000000000(0000) GS:ff110008938c7000(0000) knlGS:0000000000000000 
[ 1005.950376] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
[ 1005.956122] CR2: 00007f619475fdc0 CR3: 00000003f6c76004 CR4: 0000000000f73ef0 
[ 1005.963256] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 
[ 1005.970388] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400 
[ 1005.977520] PKRU: 55555554 
[ 1005.980234] Call Trace: 
[ 1005.982685]  <TASK> 
[ 1005.984794]  __fput+0x61e/0xaa0 
[ 1005.987958]  nfsd_file_free+0x1a1/0x3e0 [nfsd] 
[ 1005.992505]  nfsd_file_put_local+0x35/0x50 [nfsd] 
[ 1005.997290]  nfs_close_local_fh+0x362/0x6f0 [nfs_localio] 
[ 1006.002709]  __put_nfs_open_context+0x380/0x500 [nfs] 
[ 1006.007813]  ? nfs_write_completion+0x111/0x8a0 [nfs] 
[ 1006.012926]  nfs_pgio_header_free+0x41/0xe0 [nfs] 
[ 1006.017693]  nfs_write_completion+0x139/0x8a0 [nfs] 
[ 1006.022631]  ? __pfx_nfs_writeback_done.part.0+0x10/0x10 [nfs] 
[ 1006.028517]  ? __pfx_nfs_write_completion+0x10/0x10 [nfs] 
[ 1006.033981]  nfs_local_call_write+0x4fc/0xa50 [nfs] 
[ 1006.038918]  ? __pfx_nfs_local_call_write+0x10/0x10 [nfs] 
[ 1006.044376]  ? rcu_is_watching+0x15/0xb0 
[ 1006.048320]  ? rcu_is_watching+0x15/0xb0 
[ 1006.052246]  process_one_work+0xd6e/0x1330 
[ 1006.056349]  ? __pfx_process_one_work+0x10/0x10 
[ 1006.060897]  ? assign_work+0x16c/0x240 
[ 1006.064668]  worker_thread+0x5f3/0xfe0 
[ 1006.068437]  ? __kthread_parkme+0xb4/0x200 
[ 1006.072553]  ? __pfx_worker_thread+0x10/0x10 
[ 1006.076842]  kthread+0x3b1/0x770 
[ 1006.080077]  ? local_clock_noinstr+0xd/0xe0 
[ 1006.084278]  ? __pfx_kthread+0x10/0x10 
[ 1006.088032]  ? __lock_release.isra.0+0x1a4/0x2c0 
[ 1006.092667]  ? rcu_is_watching+0x15/0xb0 
[ 1006.096611]  ? __pfx_kthread+0x10/0x10 
[ 1006.100382]  ret_from_fork+0x31/0x70 
[ 1006.103978]  ? __pfx_kthread+0x10/0x10 
[ 1006.107738]  ret_from_fork_asm+0x1a/0x30 
[ 1006.111687]  </TASK> 
[ 1006.113894] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd grace nfs_localio rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common intel_ifs sunrpc i10nm_edac skx_edac_common nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm dax_hmem irqbypass cxl_acpi iTCO_wdt igb mgag200 cxl_port rapl dell_pc pmt_telemetry iTCO_vendor_support pmt_class cxl_core intel_sdsi dell_smbios platform_profile intel_cstate ipmi_ssif ses isst_if_mmio dcdbas wmi_bmof dell_wmi_descriptor pcspkr intel_uncore enclosure einj isst_if_mbox_pci mei_me isst_if_common intel_vsec i2c_i801 i2c_algo_bit tg3 dca mei i2c_smbus i2c_ismt acpi_power_meter ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler sg fuse loop dm_mod nfnetlink xfs sd_mod iaa_crypto mpt3sas ahci raid_class ghash_clmulni_intel libahci scsi_transport_sas idxd libata idxd_bus wmi pinctrl_emmitsburg 
[ 1006.198764] ---[ end trace 0000000000000000 ]--- 
[ 1006.223531] RIP: 0010:__put_cred+0xea/0x120 
[ 1006.227744] Code: 2d 8b 83 a8 00 00 00 85 c0 74 0b 48 83 c4 08 5b 5d e9 fa fb ff ff 48 83 c4 08 48 c7 c6 c0 af da 83 5b 5d e9 28 54 1d 00 0f 0b <0f> 0b 0f 0b 48 89 3c 24 e8 09 dc 99 00 48 8b 3c 24 eb c4 48 89 df 
[ 1006.246509] RSP: 0018:ffa00000247a78d8 EFLAGS: 00010246 
[ 1006.251762] RAX: dffffc0000000000 RBX: ff110001428ea000 RCX: ffffffff83dab30c 
[ 1006.258911] RDX: 1fe220004203d19a RSI: 0000000000000008 RDI: ff110002101e8cd0 
[ 1006.266065] RBP: ff110002101e8000 R08: 0000000000000000 R09: ffe21c002851d400 
[ 1006.273218] R10: ff110001428ea007 R11: 0000000000000001 R12: 0000000000000000 
[ 1006.280368] R13: ff110001f6c1ce88 R14: ff110001f6c1ce68 R15: ff110001f6c1ce00 
[ 1006.287521] FS:  0000000000000000(0000) GS:ff110008938c7000(0000) knlGS:0000000000000000 
[ 1006.295623] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
[ 1006.301387] CR2: 00007f619475fdc0 CR3: 00000003f6c76004 CR4: 0000000000f73ef0 
[ 1006.308535] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 
[ 1006.315687] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400 
[ 1006.322836] PKRU: 55555554 
[ 1006.325569] Kernel panic - not syncing: Fatal exception 
[ 1006.330842] Kernel Offset: 0x2800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff) 
[ 1006.361714] ---[ end Kernel panic - not syncing: Fatal exception ]--- 
[-- MARK -- Wed May  7 15:10:00 2025] 
[-- MARK -- Wed May  7 15:15:00 2025] 

[2]
export FSTYP=nfs
export TEST_DEV=xxxxxxx.xxxxxxxxxx.xxxxxxxxxxxx:/mnt/xfstests/test/nfs-server
export TEST_DIR=/mnt/xfstests/test/nfs-client
export SCRATCH_DEV=xxxxxxx.xxxxxxxxxx.xxxxxxxxxxxx:/mnt/xfstests/scratch/nfs-server
export SCRATCH_MNT=/mnt/xfstests/scratch/nfs-client
export MOUNT_OPTIONS="-o vers=4.2"
export TEST_FS_MOUNT_OPTS="-o vers=4.2"


