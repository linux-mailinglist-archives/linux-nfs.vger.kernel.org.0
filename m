Return-Path: <linux-nfs+bounces-10600-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51015A5FF57
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 19:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85735171AEF
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 18:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65E51DDC3B;
	Thu, 13 Mar 2025 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAjn7rmx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A153B1CAA6E
	for <linux-nfs@vger.kernel.org>; Thu, 13 Mar 2025 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890877; cv=none; b=lia9g9i4mvRG5htvYEBQiG56LHZpEb34uTjX1K6WY3ulIO0LBWdNQFdplaP29DQI0sdSJpST4QeXTc+mpv1ZBLbrAbNCr7ES04ICWYfz3mGWu/dX0Df/u6Mmc2xe+QN9jDFbYUYgVyf69a7v54fcRUofk27pkO5+tKL6X9UbwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890877; c=relaxed/simple;
	bh=uYuZkkgMH5AxBuk4DeIgNGiIRmVtqKd1q0VSPh1szg4=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:Subject; b=CeFMIBKUVJ8+t3cEGo767XYqO5Y9079J7oeidY0m76/dzv4w/Ix7iZEfTEYYsnWN3BADaVX7iKGAKJF/x0qKANH0TSn68kbLNO8M+UVmhbOWwo7SND7bvxca4OB7uT//KQpKF7sx3sEiDglWyyAQUOPKliiABOceMXUvwpstRoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAjn7rmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F789C4CEDD;
	Thu, 13 Mar 2025 18:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741890877;
	bh=uYuZkkgMH5AxBuk4DeIgNGiIRmVtqKd1q0VSPh1szg4=;
	h=From:Date:To:Subject:From;
	b=cAjn7rmxCTcTyL137pljYoyQkOpupWN18nxZEc4Wpuj9Cz98UV3nWwxfrgB/m7P/E
	 jeuyR7cIQ/Q8CEhZphmnY0Vv687tGodVX4rZKSSWIp88IeXI09cif2WPKXFmIA3ked
	 CKkIEAy4bHg0mMISYDswhpFcp5I4ZeX1ADjAfW/tg7u0hfVIg69JEILqvljKTTTSTj
	 YJsTszSbsUe/DE60ewQVQMCLphUs0UpGJQUxPcR8LFzkM90y9e0YKcXKuwjaQOSBOF
	 /o5h9+YB0ax4cmq3VkkTHswyac5fnZ5Y+qbMJDxaNgVOo8BD3//QGKpt3BhmyTshgz
	 cdVb5G/Xjb73A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1DDF3806651;
	Thu, 13 Mar 2025 18:35:12 +0000 (UTC)
From: Lucas via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 13 Mar 2025 18:35:08 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jlayton@kernel.org, trondmy@kernel.org, anna@kernel.org, cel@kernel.org, 
 linux-nfs@vger.kernel.org
Message-ID: <20250313-b219865c0-2a34cbc6e249@bugzilla.kernel.org>
Subject: NFS Server Issues with RDMA in Kernel 6.13.6
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Lucas added an attachment on Kernel.org Bugzilla:

Created attachment 307819
NFS over RDMA - Watchdog detected hard LOCKUP on cpu

Hi

I am experiencing stability and performance issues when using NFS (kernel 6.13.6) over rdma protocol.
All what I need to do to trigger the issue is connect client and start read / write operations.

Fastest way to reproduce issue is by running fio job:

fio --name=test --rw=randwrite --bs=4k --filename=/mnt/nfs/test.io --size=40G --direct=1 --numjobs=18 --iodepth=24 --exitall --group_reporting --ioengine=libaio --time_based --runtime=300

Dmesg says: "watchdog: Watchdog detected hard LOCKUP on cpu "

[  976.676922] watchdog: Watchdog detected hard LOCKUP on cpu 182
[  976.676931] Modules linked in: xfs(E) brd(E) nft_chain_nat(E) xt_MASQUERADE(E) nf_nat(E) nf_conntrack_netlink(E) xfrm_user(E) xfrm_algo(E) br_netfilter(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) xt_recent(E) null_blk(E) nvme_fabrics(E) nvme(E) nvme_core(E) overlay(E) ip6t_REJECT(E) nf_reject_ipv6(E) xt_hl(E) ip6t_rt(E) ipt_REJECT(E) nf_reject_ipv4(E) xt_LOG(E) nf_log_syslog(E) xt_multiport(E) nft_limit(E) xt_limit(E) xt_addrtype(E) xt_tcpudp(E) xt_conntrack(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nft_compat(E) nf_tables(E) binfmt_misc(E) nfnetlink(E) nls_iso8859_1(E) rpcrdma(E) amd_atl(E) intel_rapl_msr(E) intel_rapl_common(E) amd64_edac(E) edac_mce_amd(E) sunrpc(E) rdma_ucm(E) ib_iser(E) libiscsi(E) ipmi_ssif(E) scsi_transport_iscsi(E) rdma_cm(E) ib_umad(E) kvm_amd(E) ib_ipoib(E) iw_cm(E) kvm(E) ib_cm(E) rapl(E) bridge(E) stp(E) llc(E) joydev(E) input_leds(E) ccp(E) ee1004(E) ptdma(E) k10temp(E) acpi_ipmi(E) ipmi_si(E) ipmi_devintf(E) ipmi_msghandler(E)
  mac_hid(E) sch_fq_codel(E) bonding(E)
[  976.677035]  efi_pstore(E) ip_tables(E) x_tables(E) autofs4(E) btrfs(E) blake2b_generic(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) async_tx(E) xor(E) raid6_pq(E) libcrc32c(E) raid1(E) raid0(E) mlx5_ib(E) ib_uverbs(E) ib_core(E) ast(E) drm_client_lib(E) drm_shmem_helper(E) hid_generic(E) mlx5_core(E) mpt3sas(E) rndis_host(E) igb(E) raid_class(E) drm_kms_helper(E) usbhid(E) cdc_ether(E) dca(E) mlxfw(E) crct10dif_pclmul(E) crc32_pclmul(E) polyval_clmulni(E) polyval_generic(E) ghash_clmulni_intel(E) sha512_ssse3(E) sha256_ssse3(E) sha1_ssse3(E) usbnet(E) psample(E) i2c_algo_bit(E) scsi_transport_sas(E) ahci(E) drm(E) mii(E) hid(E) libahci(E) i2c_piix4(E) tls(E) i2c_smbus(E) pci_hyperv_intf(E) aesni_intel(E) crypto_simd(E) cryptd(E)
[  976.677112] CPU: 182 UID: 0 PID: 20143 Comm: nfsd Kdump: loaded Tainted: G            E      6.13.6+ #1
[  976.677118] Tainted: [E]=UNSIGNED_MODULE
[  976.677120] Hardware name: Supermicro AS -4124GS-TNR/H12DSG-O-CPU, BIOS 2.8 01/26/2024
[  976.677123] RIP: 0010:native_queued_spin_lock_slowpath+0x244/0x320
[  976.677138] Code: ff ff 41 83 c6 01 41 c1 e5 10 41 c1 e6 12 45 09 ee 44 89 f0 c1 e8 10 66 41 87 44 24 02 89 c2 c1 e2 10 75 5f 31 d2 eb 02 f3 90 <41> 8b 04 24 66 85 c0 75 f5 89 c1 66 31 c9 44 39 f1 0f 84 97 00 00
[  976.677141] RSP: 0018:ffffa16f2de8b948 EFLAGS: 00000002
[  976.677145] RAX: 0000000001d00001 RBX: ffff8bfa8e937bc0 RCX: 0000000000000001
[  976.677147] RDX: ffff8bfa8bd37bc0 RSI: 0000000003340000 RDI: ffff8bfb9fffbe08
[  976.677149] RBP: ffffa16f2de8b970 R08: 0000000000000000 R09: 0000000000000000
[  976.677151] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8bfb9fffbe08
[  976.677153] R13: ffff8c3a8e037bc0 R14: 0000000002dc0000 R15: 00000000000000cc
[  976.677155] FS:  0000000000000000(0000) GS:ffff8bfa8e900000(0000) knlGS:0000000000000000
[  976.677158] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  976.677160] CR2: 00007fb9b1da66b0 CR3: 00000003e84bc000 CR4: 0000000000350ef0
[  976.677162] Call Trace:
[  976.677166]  <NMI>
[  976.677172]  ? show_regs+0x71/0x90
[  976.677182]  ? watchdog_hardlockup_check+0x1ac/0x380
[  976.677189]  ? srso_return_thunk+0x5/0x5f
[  976.677194]  ? watchdog_overflow_callback+0x69/0x80
[  976.677198]  ? __perf_event_overflow+0x153/0x450
[  976.677206]  ? srso_return_thunk+0x5/0x5f
[  976.677211]  ? perf_event_overflow+0x19/0x30
[  976.677215]  ? x86_pmu_handle_irq+0x189/0x210
[  976.677225]  ? srso_return_thunk+0x5/0x5f
[  976.677228]  ? flush_tlb_one_kernel+0xe/0x40
[  976.677234]  ? srso_return_thunk+0x5/0x5f
[  976.677237]  ? set_pte_vaddr_p4d+0x58/0x80
[  976.677244]  ? srso_return_thunk+0x5/0x5f
[  976.677247]  ? set_pte_vaddr+0x89/0xc0
[  976.677250]  ? cc_platform_has+0x30/0x40
[  976.677256]  ? srso_return_thunk+0x5/0x5f
[  976.677259]  ? native_set_fixmap+0x6b/0xa0
[  976.677262]  ? srso_return_thunk+0x5/0x5f
[  976.677265]  ? ghes_copy_tofrom_phys+0x7c/0x130
[  976.677274]  ? srso_return_thunk+0x5/0x5f
[  976.677277]  ? __ghes_peek_estatus.isra.0+0x4e/0xd0
[  976.677282]  ? amd_pmu_handle_irq+0x48/0xc0
[  976.677287]  ? perf_event_nmi_handler+0x2d/0x60
[  976.677290]  ? nmi_handle+0x67/0x190
[  976.677295]  ? default_do_nmi+0x45/0x150
[  976.677301]  ? exc_nmi+0x13e/0x1e0
[  976.677304]  ? end_repeat_nmi+0xf/0x53
[  976.677313]  ? native_queued_spin_lock_slowpath+0x244/0x320
[  976.677317]  ? native_queued_spin_lock_slowpath+0x244/0x320
[  976.677322]  ? native_queued_spin_lock_slowpath+0x244/0x320
[  976.677325]  </NMI>
[  976.677326]  <TASK>
[  976.677329]  _raw_spin_lock_irqsave+0x5c/0x80
[  976.677334]  alloc_iova+0x92/0x290
[  976.677341]  ? current_time+0x2d/0x120
[  976.677348]  alloc_iova_fast+0x1fb/0x400
[  976.677351]  ? srso_return_thunk+0x5/0x5f
[  976.677354]  ? touch_atime+0x1f/0x110
[  976.677360]  iommu_dma_alloc_iova+0xa2/0x190
[  976.677365]  iommu_dma_map_sg+0x447/0x4e0
[  976.677373]  __dma_map_sg_attrs+0x139/0x1b0
[  976.677380]  dma_map_sgtable+0x21/0x50
[  976.677386]  rdma_rw_ctx_init+0x6c/0x820 [ib_core]
[  976.677525]  ? common_perm_cond+0x4d/0x210
[  976.677532]  ? srso_return_thunk+0x5/0x5f
[  976.677538]  ? xfs_vn_getattr+0xe2/0x3c0 [xfs]
[  976.677700]  svc_rdma_rw_ctx_init+0x49/0xf0 [rpcrdma]
[  976.677725]  svc_rdma_build_writes+0xa5/0x210 [rpcrdma]
[  976.677746]  ? __pfx_svc_rdma_pagelist_to_sg+0x10/0x10 [rpcrdma]
[  976.677767]  ? svc_rdma_send_write_list+0xf4/0x290 [rpcrdma]
[  976.677790]  svc_rdma_xb_write+0x7d/0xb0 [rpcrdma]
[  976.677811]  svc_rdma_send_write_list+0x144/0x290 [rpcrdma]
[  976.677834]  ? nfsd_cache_update+0x57/0x2c0 [nfsd]
[  976.677889]  svc_rdma_sendto+0x99/0x510 [rpcrdma]
[  976.677912]  ? svcauth_unix_release+0x1e/0x80 [sunrpc]
[  976.677968]  svc_send+0x49/0x140 [sunrpc]
[  976.678013]  svc_process+0x166/0x200 [sunrpc]
[  976.678058]  svc_recv+0x8a1/0xaa0 [sunrpc]
[  976.678101]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[  976.678144]  nfsd+0xa7/0x110 [nfsd]
[  976.678183]  kthread+0xe4/0x120
[  976.678188]  ? __pfx_kthread+0x10/0x10
[  976.678192]  ret_from_fork+0x46/0x70
[  976.678197]  ? __pfx_kthread+0x10/0x10
[  976.678200]  ret_from_fork_asm+0x1a/0x30
[  976.678210]  </TASK>



Full log attached.

File: dmesg-6.13.6.log (text/plain)
Size: 407.10 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=307819
---
NFS over RDMA - Watchdog detected hard LOCKUP on cpu

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


