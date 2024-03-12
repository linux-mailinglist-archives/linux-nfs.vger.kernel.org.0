Return-Path: <linux-nfs+bounces-2271-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303A9879520
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Mar 2024 14:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99ADA1F23690
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Mar 2024 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BFE7A146;
	Tue, 12 Mar 2024 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="eUk3X2q3";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="WWa/grHs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4817A135
	for <linux-nfs@vger.kernel.org>; Tue, 12 Mar 2024 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710250224; cv=none; b=ms+GnN7ZpK48Ucg5G78vPVNDeI6FJg535kECy5LEGxqFixEmLHh02j8ANYGNy1oQLCoYOMrR6DbfhdnrMVO7LX9o9apbb50guVpJK1TysZAySQrerg3bx2ktgfsKgXMYOR42sBGOfKPwiswWEQiH/wgAas9TJ/xI9LR8eltbpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710250224; c=relaxed/simple;
	bh=2muGCact80AqlGd+bAwQge/NBkhtFJklDzxtlHLhb0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type; b=keeS95w4Zj34VEdIfsgLHSHEsxSSLQld5cdXnEyMTtySnIeXyEBsddswnD+myS6TGPElI0inPfXiCEOjK2hoa2YyumizSXV2qiUGl/bkXHLTsncVS6p+AsxDV1q2sc9dhDsDAuRhIbCLyW6t9Kcwh0+GysdICv3C/L8iWZ9Kz7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=eUk3X2q3; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=WWa/grHs; arc=none smtp.client-ip=134.58.240.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [134.58.240.134])
	by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id 666093625
	for <linux-nfs@vger.kernel.org>; Tue, 12 Mar 2024 14:30:16 +0100 (CET)
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 301BB88.A2EAD
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:139:242:ac11:8])
	by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id 301BB88;
	Tue, 12 Mar 2024 14:30:07 +0100 (CET)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1710250206;
	bh=Ql/zTeRsS1hikJZ9Lw4IChY2WVHkP3okNeV4MXT7DAg=;
	h=Date:Subject:To:From;
	b=eUk3X2q3LgjKfas3bxdZWqMbVXo4G3N1NqZWj4OTsWvDM+Krj9uQWKFeBEkWCmWtK
	 yGlaRUJoRDVM30g8LdHauyQFXfs329ofPRgkIrEv5w0QuqWG39lKGxfyEeb5ywQjre
	 8qWiD1JF01+z/NqnMDQ1SkYmSlu1u/Z1ovFVr3mGINORfdh2jPGxqpx8u7NMXlWaHC
	 wZx3V7HYQqiYkdpa6vp76tSCy2YUjDdenmGA/Ifez0khotHt5jiMegA+z8pPjGKlcd
	 m4UuaOhwG8493yKZPYpDMWn0s28c+sDuC7QvoBDpXOgMUB4SwWCWSgweqrygoCMtpI
	 RrdH0FnS7TJLw==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPS id C350CD4F386A1;
	Tue, 12 Mar 2024 14:30:06 +0100 (CET)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1710250206;
	bh=Ql/zTeRsS1hikJZ9Lw4IChY2WVHkP3okNeV4MXT7DAg=;
	h=Date:Subject:To:From:From;
	b=WWa/grHstDgLiBr46EW41zNDjw2vk6jmpGd844oYQebceDXtAJgTFpPhWmpI6lgmz
	 STl2bDm7FCo3ex33w910pP4MOllUQ/i67uXd3xDBaI2qeBpnH5KikaOXZdcIG+3dDS
	 xbc1BtYvSD89UXHmwbTCcNOaN4i5pOFWafJT+T+YzOdRgtFD+w62ObRNwiwmIbh4My
	 lxNKsTOjlqE2GQdwFv63g6EupN3jM/TRVv3nJwfy/wWjqxmk+yyCmhC3rF/3CMWFoa
	 RJ8ZBh7lOAIqWaFujpOdMt3xK6eKU5sGb1m38wv2VgWQIW2/Kddk+rb+0fC9Yg94Y2
	 Lqm1MU8rTOyHA==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [10.87.19.1] (lucifer.esat.kuleuven.be [10.87.19.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id B6C336000E;
	Tue, 12 Mar 2024 14:30:06 +0100 (CET)
Message-ID: <59409f8d-6856-4907-9706-8db4fb57a93b@esat.kuleuven.be>
Date: Tue, 12 Mar 2024 14:30:06 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd hangs and nfsd_break_deleg_cb+0x170/0x190 warning
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>, Linux Nfs <linux-nfs@vger.kernel.org>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
Organization: KU Leuven - ESAT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 3/12/24 13:47, Jeff Layton wrote:
> On Tue, 2024-03-12 at 13:24 +0100, Rik Theys wrote:
>> On 3/12/24 12:22, Jeff Layton wrote:
>>> On Mon, 2024-03-11 at 19:43 +0100, Rik Theys wrote:
>>>> Since a few weeks our Rocky Linux 9 NFS server has periodically logged hung nfsd tasks. The initial effect was that some clients could no longer access the NFS server. This got worse and worse (probably as more nfsd threads got blocked) and we had to restart the server. Restarting the server also failed as the NFS server service could no longer be stopped.
>>>>    
>>>>
>>>> The initial kernel we noticed this behavior on was kernel-5.14.0-362.18.1.el9_3.x86_64. Since then we've installed kernel-5.14.0-419.el9.x86_64 from CentOS Stream 9. The same issue happened again on this newer kernel version:
>>>>    
> 419 is fairly up to date with nfsd changes. There are some known bugs
> around callbacks, and there is a draft MR in flight to fix it.
>
> What kernel were you on prior to 5.14.0-362.18.1.el9_3.x86_64 ? If we
> can bracket the changes around a particular version, then that might
> help identify the problem.
The server on which we are experiencing this the most was upgraded from 
CentOS 7 recently and only ran 5.14.0-362.18.1 (and now 419). Another 
server on which we (less frequently) have this issue is running EL9 for 
much longer (kernels 5.14.0-162.23.1, 5.14.0-284.11.1, 5.14.0-284.18.1, 
5.14.0-284.30.1, 5.14.0-362.8.1), but we only started to experience the 
issue on 5.14.0-362.18.1. It could be the bug was also present in older 
versions and that we never triggered it there.
>
>>>> [Mon Mar 11 14:10:08 2024]       Not tainted 5.14.0-419.el9.x86_64 #1
>>>>    [Mon Mar 11 14:10:08 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>    [Mon Mar 11 14:10:08 2024] task:nfsd            state:D stack:0     pid:8865  ppid:2      flags:0x00004000
>>>>    [Mon Mar 11 14:10:08 2024] Call Trace:
>>>>    [Mon Mar 11 14:10:08 2024]  <TASK>
>>>>    [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>>>    [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>>>    [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>>>    [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>>>    [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>>>    [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>>>    [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>>>    [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>>>    [Mon Mar 11 14:10:08 2024]  nfsd4_shutdown_callback+0x49/0x120 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  ? nfsd4_cld_remove+0x54/0x1d0 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  ? nfsd4_return_all_client_layouts+0xc4/0xf0 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  ? nfsd4_shutdown_copy+0x68/0xc0 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  __destroy_client+0x1f3/0x290 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  nfsd4_exchange_id+0x75f/0x770 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  ? nfsd4_decode_opaque+0x3a/0x90 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>>>    [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>    [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>>>    [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>>>    [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>>>    [Mon Mar 11 14:10:08 2024]  </TASK>
>>>>    [Mon Mar 11 14:10:08 2024] INFO: task nfsd:8866 blocked for more than 122 seconds.
>>>>    [Mon Mar 11 14:10:08 2024]       Not tainted 5.14.0-419.el9.x86_64 #1
>>>>    [Mon Mar 11 14:10:08 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>    [Mon Mar 11 14:10:08 2024] task:nfsd            state:D stack:0     pid:8866  ppid:2      flags:0x00004000
>>>>    [Mon Mar 11 14:10:08 2024] Call Trace:
>>>>    [Mon Mar 11 14:10:08 2024]  <TASK>
>>>>    [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>>>    [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>>>    [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>>>    [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>>>    [Mon Mar 11 14:10:08 2024]  ? tcp_recvmsg+0x196/0x210
>>>>    [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>>>    [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>>>    [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>>>    [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>>>    [Mon Mar 11 14:10:08 2024]  nfsd4_destroy_session+0x1a4/0x240 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>>>    [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>    [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>    [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>>>    [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>>>    [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>>>    [Mon Mar 11 14:10:08 2024]  </TASK>
>>>>
>>> The above threads are trying to flush the workqueue, so that probably
>>> means that they are stuck waiting on a workqueue job to finish.
>>>>    The above is repeated a few times, and then this warning is also logged:
>>>>    
>>>> [Mon Mar 11 14:12:04 2024] ------------[ cut here ]------------
>>>>    [Mon Mar 11 14:12:04 2024] WARNING: CPU: 39 PID: 8844 at fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>    [Mon Mar 11 14:12:05 2024] Modules linked in: nfsv4 dns_resolver nfs fscache netfs rpcsec_gss_krb5 rpcrdma rdma_cm iw_cm ib_cm ib_core binfmt_misc bonding tls rfkill nft_counter nft_ct
>>>>    nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nf_tables nfnetlink vfat fat dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio l
>>>>    ibcrc32c dm_service_time dm_multipath intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common isst_if_common skx_edac nfit libnvdimm ipmi_ssif x86_pkg_temp
>>>>    _thermal intel_powerclamp coretemp kvm_intel kvm irqbypass dcdbas rapl intel_cstate mgag200 i2c_algo_bit drm_shmem_helper dell_smbios drm_kms_helper dell_wmi_descriptor wmi_bmof intel_u
>>>>    ncore syscopyarea pcspkr sysfillrect mei_me sysimgblt acpi_ipmi mei fb_sys_fops i2c_i801 ipmi_si intel_pch_thermal lpc_ich ipmi_devintf i2c_smbus ipmi_msghandler joydev acpi_power_meter
>>>>    nfsd auth_rpcgss nfs_acl drm lockd grace fuse sunrpc ext4 mbcache jbd2 sd_mod sg lpfc
>>>>    [Mon Mar 11 14:12:05 2024]  nvmet_fc nvmet nvme_fc nvme_fabrics crct10dif_pclmul ahci libahci crc32_pclmul nvme_core crc32c_intel ixgbe megaraid_sas libata nvme_common ghash_clmulni_int
>>>>    el t10_pi wdat_wdt scsi_transport_fc mdio wmi dca dm_mirror dm_region_hash dm_log dm_mod
>>>>    [Mon Mar 11 14:12:05 2024] CPU: 39 PID: 8844 Comm: nfsd Not tainted 5.14.0-419.el9.x86_64 #1
>>>>    [Mon Mar 11 14:12:05 2024] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 2.20.1 09/13/2023
>>>>    [Mon Mar 11 14:12:05 2024] RIP: 0010:nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>    [Mon Mar 11 14:12:05 2024] Code: a6 95 c5 f3 e9 ff fe ff ff 48 89 df be 01 00 00 00 e8 34 b5 13 f4 48 8d bb 98 00 00 00 e8 c8 f9 00 00 84 c0 0f 85 2e ff ff ff <0f> 0b e9 27 ff ff ff be
>>>>    02 00 00 00 48 89 df e8 0c b5 13 f4 e9 01
>>>>    [Mon Mar 11 14:12:05 2024] RSP: 0018:ffff9929e0bb7b80 EFLAGS: 00010246
>>>>    [Mon Mar 11 14:12:05 2024] RAX: 0000000000000000 RBX: ffff8ada51930900 RCX: 0000000000000024
>>>>    [Mon Mar 11 14:12:05 2024] RDX: ffff8ada519309c8 RSI: ffff8ad582933c00 RDI: 0000000000002000
>>>>    [Mon Mar 11 14:12:05 2024] RBP: ffff8ad46bf21574 R08: ffff9929e0bb7b48 R09: 0000000000000000
>>>>    [Mon Mar 11 14:12:05 2024] R10: ffff8aec859a2948 R11: 0000000000000000 R12: ffff8ad6f497c360
>>>>    [Mon Mar 11 14:12:05 2024] R13: ffff8ad46bf21560 R14: ffff8ae5942e0b10 R15: ffff8ad6f497c360
>>>>    [Mon Mar 11 14:12:05 2024] FS:  0000000000000000(0000) GS:ffff8b031fcc0000(0000) knlGS:0000000000000000
>>>>    [Mon Mar 11 14:12:05 2024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>    [Mon Mar 11 14:12:05 2024] CR2: 00007fafe2060744 CR3: 00000018e58de006 CR4: 00000000007706e0
>>>>    [Mon Mar 11 14:12:05 2024] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>    [Mon Mar 11 14:12:05 2024] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>    [Mon Mar 11 14:12:05 2024] PKRU: 55555554
>>>>    [Mon Mar 11 14:12:05 2024] Call Trace:
>>>>    [Mon Mar 11 14:12:05 2024]  <TASK>
>>>>    [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>>>    [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>>>    [Mon Mar 11 14:12:05 2024]  ? __break_lease+0x16f/0x5f0
>>>>    [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>    [Mon Mar 11 14:12:05 2024]  ? __warn+0x81/0x110
>>>>    [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>    [Mon Mar 11 14:12:05 2024]  ? report_bug+0x10a/0x140
>>>>    [Mon Mar 11 14:12:05 2024]  ? handle_bug+0x3c/0x70
>>>>    [Mon Mar 11 14:12:05 2024]  ? exc_invalid_op+0x14/0x70
>>>>    [Mon Mar 11 14:12:05 2024]  ? asm_exc_invalid_op+0x16/0x20
>>>>    [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>    [Mon Mar 11 14:12:05 2024]  __break_lease+0x16f/0x5f0
>>>>    [Mon Mar 11 14:12:05 2024]  ? nfsd_file_lookup_locked+0x117/0x160 [nfsd]
>>>>    [Mon Mar 11 14:12:05 2024]  ? list_lru_del+0x101/0x150
>>>>    [Mon Mar 11 14:12:05 2024]  nfsd_file_do_acquire+0x790/0x830 [nfsd]
>>>>    [Mon Mar 11 14:12:05 2024]  nfs4_get_vfs_file+0x315/0x3a0 [nfsd]
>>>>    [Mon Mar 11 14:12:05 2024]  nfsd4_process_open2+0x430/0xa30 [nfsd]
>>>>    [Mon Mar 11 14:12:05 2024]  ? fh_verify+0x297/0x2f0 [nfsd]
>>>>    [Mon Mar 11 14:12:05 2024]  nfsd4_open+0x3ce/0x4b0 [nfsd]
>>>>    [Mon Mar 11 14:12:05 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>    [Mon Mar 11 14:12:05 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>    [Mon Mar 11 14:12:05 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>>>    [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>    [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>    [Mon Mar 11 14:12:05 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>    [Mon Mar 11 14:12:05 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>    [Mon Mar 11 14:12:05 2024]  kthread+0xdd/0x100
>>>>    [Mon Mar 11 14:12:05 2024]  ? __pfx_kthread+0x10/0x10
>>>>    [Mon Mar 11 14:12:05 2024]  ret_from_fork+0x29/0x50
>>>>    [Mon Mar 11 14:12:05 2024]  </TASK>
>>>>    [Mon Mar 11 14:12:05 2024] ---[ end trace 7a039e17443dc651 ]---
>>> This is probably this WARN in nfsd_break_one_deleg:
>>>
>>>           WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
>>>
>>> It means that a delegation break callback to the client couldn't be
>>> queued to the workqueue, and so it didn't run.
>>>
>>>> Could this be the same issue as described here:https://lore.kernel.org/linux-nfs/af0ec881-5ebf-4feb-98ae-3ed2a77f86f1@oracle.com/ ?
>>>>    
>>> Yes, most likely the same problem.
>> If I read that thread correctly, this issue was introduced between
>> 6.1.63 and 6.6.3? Is it possible the EL9 5.14.0-362.18.1.el9_3
>> backported these changes, or were we hitting some other bug with that
>> version? It seems the 6.1.x kernel is not affected? If so, that would be
>> the recommended kernel to run?
> Anything is possible. We have to identify the problem first.
>
>>>> As described in that thread, I've tried to obtain the requested information.
>>>>    
>>>>
>>>> Is it possible this is the issue that was fixed by the patches described here? https://lore.kernel.org/linux-nfs/2024022054-cause-suffering-eae8@gregkh/
>>>>
>>> Doubtful. Those are targeted toward a different set of issues.
>>>
>>> If you're willing, I do have some patches queued up for CentOS here that
>>> fix some backchannel problems that could be related. I'm mainly waiting
>>> on Chuck to send these to Linus and then we'll likely merge them into
>>> CentOS soon afterward:
>>>
>>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3689
>>>
>> If you can send me a patch file, I can rebuild the C9S kernel with that
>> patch and run it. It can take a while for the bug to trigger as I
>> believe it seems to be very workload dependent (we were running very
>> stable for months and now hit this bug every other week).
>>
>>
> It's probably simpler to just pull down the build artifacts for that MR.
> You have to drill down through the CI for it, but they are here:
>
> https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/index.html?prefix=trusted-artifacts/1194300175/publish_x86_64/6278921877/artifacts/
>
> There's even a repo file you can install on the box to pull them down.

Ok, I will try these instead.

Regards,

Rik


-- 
Rik Theys
System Engineer
KU Leuven - Dept. Elektrotechniek (ESAT)
Kasteelpark Arenberg 10 bus 2440  - B-3001 Leuven-Heverlee
+32(0)16/32.11.07
----------------------------------------------------------------
<<Any errors in spelling, tact or fact are transmission errors>>


