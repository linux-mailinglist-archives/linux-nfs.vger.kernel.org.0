Return-Path: <linux-nfs+bounces-9737-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33122A21DAA
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F74166E03
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 13:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F42DEEC5;
	Wed, 29 Jan 2025 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQq8CYm8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE57A2CA9
	for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2025 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156482; cv=none; b=KzJ5jiwZUTxZoJZ7+0/UaC3i32ar7tEc7c4d8AMcnRCZUMbMR+Nc/YJ3I60LTGFA2t62I3T0p5FtPVHqpwAwEtywb2TkCOTS9Idp8uBkNI+oTsQoITRCUqJSfvpUWegtkhzIxeNwmZWepq3Qe2lXIcT8cycYSKtc4gJx+en+5T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156482; c=relaxed/simple;
	bh=uzmSMH96Gv2Y5CrofTwgLcD0dtirnXWZN+7mRwopmBA=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=gQJWeYHwGDIJoPAqiPKNUKlHc0dN8b+hau6YuRKHHLatrTNEzVWAGhfRlZHcN3jL2w0JsliMu1DpdtXpWpwsRbw56ohoVx4G3U5UnfFhMfp4vnZDBIODIgaKVxtLEyEng+LlbeWHt0RV2rZyuQp/NZkB4bKq6JykLHYnqQI4KIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQq8CYm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57702C4CED3;
	Wed, 29 Jan 2025 13:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738156481;
	bh=uzmSMH96Gv2Y5CrofTwgLcD0dtirnXWZN+7mRwopmBA=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=pQq8CYm8TtiPJO6QW4Lc5dpjWSxl2OBYP804L/IXbhZKe5aO5M7/jvg2fNFy1JeFH
	 VHnEOb48mBUM7ticABX4TlLBbXDJBMVb6fFOkvmF69f0t6G6SbgtZaneWYxexJeGQi
	 RIUKokUrGT17tzYxuaNXFNB+5wLtlQ/A7X5BmSQp5rRDwk+rI7lFQEVp2uIOASzPB0
	 nmWoq3ZV9XagblDY0wupSz+qZeiS1coR9XdUGc7psCvgJRK3Q8pFJcCaPxwOvZZE6S
	 v3+sT88PQbQ6Jwtv351u1s04kXYb7PPd0bTqPBv4Q65K/tCKugVpMPOsSeQ3jTjrL1
	 V71YEXTQpfEoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74D53380AA66;
	Wed, 29 Jan 2025 13:15:08 +0000 (UTC)
From: "rik.theys via Bugspray Bot" <bugbot@kernel.org>
Date: Wed, 29 Jan 2025 13:15:28 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: tom@talpey.com, trondmy@kernel.org, chuck.lever@oracle.com, 
 cel@kernel.org, anna@kernel.org, baptiste.pellegrin@ac-grenoble.fr, 
 harald.dunkel@aixigo.com, linux-nfs@vger.kernel.org, 
 benoit.gschwind@minesparis.psl.eu, carnil@debian.org, jlayton@kernel.org, 
 herzog@phys.ethz.ch
Message-ID: <20250129-b219710c24-6f95a749b544@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

rik.theys writes via Kernel.org Bugzilla:

Hi,

We had similar tracing running as we observed a similar issue on our 6.11 kernel. Recently, we upgraded to 6.12.11 and this has resulted in the warning below.

I'm not 100% sure this is the same issue. If not, let me know and I'll open a different thread/bug.

Unfortunately the attachment is too large to upload as the trace.dat file is ~900MiB.

I've uploaded it here:

https://homes.esat.kuleuven.be/~rtheys/logs-6.12.11.tar.zst

This file contains the warning, trace.dat file and the output of "echo t" > /proc/sysrq-trigger.

The warning that was issued was:

[Wed Jan 29 10:11:17 2025] cb_status=-521 tk_status=-10036
[Wed Jan 29 10:11:17 2025] WARNING: CPU: 16 PID: 1670626 at fs/nfsd/nfs4callback.c:1339 nfsd4_cb_done+0x171/0x180 [nfsd]
[Wed Jan 29 10:11:17 2025] Modules linked in: dm_snapshot(E) nfsv4(E) dns_resolver(E) nfs(E) netfs(E) binfmt_misc(E) rpcsec_gss_krb5(E) rpcrdma(E) rdma_cm(E) iw_cm(E) ib_cm(E) ib_core(E) bonding(E) tls(E) rfkill(E) nft_ct(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nf_tables(E) nfnetlink(E) vfat(E) fat(E) dm_thin_pool(E) dm_persistent_data(E) dm_bio_prison(E) dm_bufio(E) libcrc32c(E) dm_service_time(E) dm_multipath(E) intel_rapl_msr(E) intel_rapl_common(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) skx_edac_common(E) nfit(E) libnvdimm(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) mgag200(E) kvm(E) i2c_algo_bit(E) dell_pc(E) rapl(E) drm_shmem_helper(E) ipmi_ssif(E) intel_cstate(E) platform_profile(E) dell_smbios(E) dcdbas(E) dell_wmi_descriptor(E) intel_uncore(E) wmi_bmof(E) pcspkr(E) drm_kms_helper(E) i2c_i801(E) mei_me(E) mei(E) intel_pch_thermal(E) i
 2c_mux(E) lpc_ich(E) i2c_smbus(E) joydev(E)
[Wed Jan 29 10:11:17 2025]  acpi_power_meter(E) ipmi_si(E) acpi_ipmi(E) ipmi_devintf(E) ipmi_msghandler(E) nfsd(E) nfs_acl(E) lockd(E) auth_rpcgss(E) grace(E) fuse(E) drm(E) sunrpc(E) ext4(E) mbcache(E) jbd2(E) lpfc(E) sd_mod(E) sg(E) nvmet_fc(E) nvmet(E) nvme_fc(E) ahci(E) crct10dif_pclmul(E) nvme_fabrics(E) crc32_pclmul(E) libahci(E) crc32c_intel(E) polyval_clmulni(E) nvme_core(E) megaraid_sas(E) ixgbe(E) polyval_generic(E) ghash_clmulni_intel(E) mdio(E) libata(E) wdat_wdt(E) scsi_transport_fc(E) dca(E) wmi(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
[Wed Jan 29 10:11:17 2025] CPU: 16 UID: 0 PID: 1670626 Comm: kworker/u193:0 Kdump: loaded Tainted: G            E      6.12.11-1.el9.esat.x86_64 #1
[Wed Jan 29 10:11:17 2025] Tainted: [E]=UNSIGNED_MODULE
[Wed Jan 29 10:11:17 2025] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 2.20.1 09/13/2023
[Wed Jan 29 10:11:17 2025] Workqueue: rpciod rpc_async_schedule [sunrpc]
[Wed Jan 29 10:11:17 2025] RIP: 0010:nfsd4_cb_done+0x171/0x180 [nfsd]
[Wed Jan 29 10:11:17 2025] Code: 0f 1f 44 00 00 e9 1d ff ff ff 80 3d 1c a7 01 00 00 0f 85 d9 fe ff ff 48 c7 c7 e5 b2 06 c1 c6 05 08 a7 01 00 01 e8 1f 4f ef d4 <0f> 0b 8b 75 54 e9 bc fe ff ff 0f 0b 0f 1f 00 90 90 90 90 90 90 90
[Wed Jan 29 10:11:17 2025] RSP: 0018:ffffa469b58c7e08 EFLAGS: 00010282
[Wed Jan 29 10:11:17 2025] RAX: 0000000000000000 RBX: ffff8a8f13ef6400 RCX: 0000000000000000
[Wed Jan 29 10:11:17 2025] RDX: 0000000000000002 RSI: ffffffff97398443 RDI: 00000000ffffffff
[Wed Jan 29 10:11:17 2025] RBP: ffff8a8c574515b8 R08: 0000000000000000 R09: ffffa469b58c7cb0
[Wed Jan 29 10:11:17 2025] R10: ffffa469b58c7ca8 R11: ffffffff97fdf688 R12: ffff8a7548f73f60
[Wed Jan 29 10:11:17 2025] R13: ffff8a8f13ef6400 R14: 0000000004248060 R15: ffffffffc0d66a40
[Wed Jan 29 10:11:17 2025] FS:  0000000000000000(0000) GS:ffff8a8ae0a00000(0000) knlGS:0000000000000000
[Wed Jan 29 10:11:17 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Wed Jan 29 10:11:17 2025] CR2: 00007f8a14576160 CR3: 000000274fa20004 CR4: 00000000007726f0
[Wed Jan 29 10:11:17 2025] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[Wed Jan 29 10:11:17 2025] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[Wed Jan 29 10:11:17 2025] PKRU: 55555554
[Wed Jan 29 10:11:17 2025] Call Trace:
[Wed Jan 29 10:11:17 2025]  <TASK>
[Wed Jan 29 10:11:17 2025]  ? __warn+0x84/0x130
[Wed Jan 29 10:11:17 2025]  ? nfsd4_cb_done+0x171/0x180 [nfsd]
[Wed Jan 29 10:11:17 2025]  ? report_bug+0x1c3/0x1d0
[Wed Jan 29 10:11:17 2025]  ? handle_bug+0x5b/0xa0
[Wed Jan 29 10:11:17 2025]  ? exc_invalid_op+0x14/0x70
[Wed Jan 29 10:11:17 2025]  ? asm_exc_invalid_op+0x16/0x20
[Wed Jan 29 10:11:17 2025]  ? __pfx_rpc_exit_task+0x10/0x10 [sunrpc]
[Wed Jan 29 10:11:17 2025]  ? nfsd4_cb_done+0x171/0x180 [nfsd]
[Wed Jan 29 10:11:17 2025]  ? nfsd4_cb_done+0x171/0x180 [nfsd]
[Wed Jan 29 10:11:17 2025]  rpc_exit_task+0x5b/0x170 [sunrpc]
[Wed Jan 29 10:11:17 2025]  __rpc_execute+0x9f/0x370 [sunrpc]
[Wed Jan 29 10:11:17 2025]  rpc_async_schedule+0x2b/0x40 [sunrpc]
[Wed Jan 29 10:11:17 2025]  process_one_work+0x179/0x390
[Wed Jan 29 10:11:17 2025]  worker_thread+0x239/0x340
[Wed Jan 29 10:11:17 2025]  ? __pfx_worker_thread+0x10/0x10
[Wed Jan 29 10:11:17 2025]  kthread+0xdb/0x110
[Wed Jan 29 10:11:17 2025]  ? __pfx_kthread+0x10/0x10
[Wed Jan 29 10:11:17 2025]  ret_from_fork+0x2d/0x50
[Wed Jan 29 10:11:17 2025]  ? __pfx_kthread+0x10/0x10
[Wed Jan 29 10:11:17 2025]  ret_from_fork_asm+0x1a/0x30
[Wed Jan 29 10:11:17 2025]  </TASK>
[Wed Jan 29 10:11:17 2025] ---[ end trace 0000000000000000 ]---

It also seems to indicate an issue with nfsd4_cb_done in a workqueue.

The "echo t > /proc/sysrq-trigger" was taken after stopping the trace-cmd.

I hope the trace.dat file contains enough information to help find the root cause. It was started before the first client mounted something from this server.

Regards,
Rik

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c24
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


