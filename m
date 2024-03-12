Return-Path: <linux-nfs+bounces-2276-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B81A4879B46
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Mar 2024 19:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD48E1C22799
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Mar 2024 18:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4A7139566;
	Tue, 12 Mar 2024 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="kHmZjAj+";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="7JYGRDiy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [134.58.240.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED24273FC
	for <linux-nfs@vger.kernel.org>; Tue, 12 Mar 2024 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267802; cv=none; b=gIA6KVGhZcpAcQZgx+n0g0VBA/coa3d5J7TP4s6vK752DcANFEu2gkXsGh8eI6Bloydf4obN4tIIvmS88hfrm+3zhDR5ow63tMEhlyR+5hKY3XkPLoEnwWT09yXg+xSTSzrB6sRPftfDta8v3UT+QP8u80aWHXHOM73AyE5K26w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267802; c=relaxed/simple;
	bh=RMvRrYmAvx+VwqBK20+qerc4dd1mtm/3nXGYDRe0NqI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=rI77A5HizjFQEYpOSfRwyFGR9EejHoxD+oXv19nWWTgbBw9Y2fyu1mVkGEPAZ1cScMIr6HqAetqJuYiTf7+vBkLzE3BzsP1ESSPwEEhmrw8E4Hdu/Yx/WO8AmULv4qF3wXIMZrK8Y+C0GV1/D3rJjWiU+duztr90TRZUY2AU53M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=kHmZjAj+; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=7JYGRDiy; arc=none smtp.client-ip=134.58.240.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: AF6BC5E.A6523
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:139:242:ac11:8])
	by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id AF6BC5E;
	Tue, 12 Mar 2024 19:23:14 +0100 (CET)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1710267794;
	bh=RkiKfu6dYBg0gJO3RMl3z6Y5Mv5gJ7v/OfYK8AsAqp4=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=kHmZjAj+xv8hskjwypwboCKhRKLlotob0xd4BwcBYBaKvELiEBImzfzPWEgAqhFQU
	 mcjESgtsQ6q/E69DT2J5O4SWAn/JwHDmefkE0sQvjx5VSX5XtFg4W79rIUCVoom9jp
	 onsgfKKR2D+Myq3KRy+gab8O+zvRkfja4LLHKL6ZqHxQ7g3B41zTW8PNNTdTOm5QpF
	 d0d2yymuNd12ZFpPctxQ6tRCWmUTUkZ8IcJmZnPCUmB3Tnelm+Y8TxluNvfWH1loVA
	 P56N2AcEJwU/oNvB8EPBpWsO1mn80tzxyQuT7EkM/9RKI1HS3Bd7gBFqb7poVnwjT7
	 DPj4HuRABydWw==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPS id 3C1A0D4F6782B;
	Tue, 12 Mar 2024 19:23:14 +0100 (CET)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1710267794;
	bh=RkiKfu6dYBg0gJO3RMl3z6Y5Mv5gJ7v/OfYK8AsAqp4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=7JYGRDiyKC+7qlA/EcHmdtpE6VwTmPPtey0UA13ettNCStUjFRelYdy7hwSiGzD1t
	 JQw0jfYAzTrw3caVZgyOgvQb5T27SimFH1HfCBBQpQ53Ogd9f1bMgXDyjYyuKJmxXj
	 9YIc+F+X3G8UaVlDSXzgjL2q0y3JJg5XbRVeudCc0CsJBK6lxB8znvqqufGmUmnvN2
	 hQh5ZWQWBbV4Nc9bWUVJRKul+2sFCD4hqZpZe/wEcUxw5IrHBfisWK1K7PDCsoVA1v
	 07gfUdPg7B9OwUXUrXhTOi6+207IfC3spMCgOSNAzU6so6I0fwmjVF4BruQ+r1Vhnu
	 7aRUmWOBKsAhQ==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [192.168.1.178] (d54C12615.access.telenet.be [84.193.38.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id EF2666000E;
	Tue, 12 Mar 2024 19:23:13 +0100 (CET)
Content-Type: multipart/mixed; boundary="------------mC6n08fGC3eLY6GbrEvYIvDe"
Message-ID: <80c412ac-ea74-4836-9dae-8be6e3aec0e6@esat.kuleuven.be>
Date: Tue, 12 Mar 2024 19:23:13 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd hangs and nfsd_break_deleg_cb+0x170/0x190 warning
Content-Language: en-US
To: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Linux Nfs <linux-nfs@vger.kernel.org>
References: <55366184-94bb-4054-8025-1125db3788ff@esat.kuleuven.be>
 <aeb9e7b96161ac247c247b90c143935e80c7faf8.camel@kernel.org>
 <df8cc19c-f12c-4f7b-947a-4e21f8b97685@oracle.com>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
In-Reply-To: <df8cc19c-f12c-4f7b-947a-4e21f8b97685@oracle.com>

This is a multi-part message in MIME format.
--------------mC6n08fGC3eLY6GbrEvYIvDe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 3/12/24 17:43, Dai Ngo wrote:
>
> On 3/12/24 4:37 AM, Jeff Layton wrote:
>> On Mon, 2024-03-11 at 19:43 +0100, Rik Theys wrote:
>>>
>>>
>>>
>>> Hi,
>>>
>>>
>>>
>>> Since a few weeks our Rocky Linux 9 NFS server has periodically 
>>> logged hung nfsd tasks. The initial effect was that some clients 
>>> could no longer access the NFS server. This got worse and worse 
>>> (probably as more nfsd threads got blocked) and we had to restart 
>>> the server. Restarting the server also failed as the NFS server 
>>> service could no longer be stopped.
>>>
>>>
>>>
>>> The initial kernel we noticed this behavior on was 
>>> kernel-5.14.0-362.18.1.el9_3.x86_64. Since then we've installed 
>>> kernel-5.14.0-419.el9.x86_64 from CentOS Stream 9. The same issue 
>>> happened again on this newer kernel version:
>>>
>>>
>>>
>>> [Mon Mar 11 14:10:08 2024]       Not tainted 5.14.0-419.el9.x86_64 #1
>>>   [Mon Mar 11 14:10:08 2024] "echo 0 > 
>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>   [Mon Mar 11 14:10:08 2024] task:nfsd            state:D stack:0 
>>>     pid:8865  ppid:2      flags:0x00004000
>>>   [Mon Mar 11 14:10:08 2024] Call Trace:
>>>   [Mon Mar 11 14:10:08 2024]  <TASK>
>>>   [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>>   [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>>   [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>>   [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>>   [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>>   [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>>   [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_shutdown_callback+0x49/0x120 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_cld_remove+0x54/0x1d0 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  ? 
>>> nfsd4_return_all_client_layouts+0xc4/0xf0 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_shutdown_copy+0x68/0xc0 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  __destroy_client+0x1f3/0x290 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_exchange_id+0x75f/0x770 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_decode_opaque+0x3a/0x90 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>   [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>>   [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>>   [Mon Mar 11 14:10:08 2024]  </TASK>
>>>   [Mon Mar 11 14:10:08 2024] INFO: task nfsd:8866 blocked for more 
>>> than 122 seconds.
>>>   [Mon Mar 11 14:10:08 2024]       Not tainted 5.14.0-419.el9.x86_64 #1
>>>   [Mon Mar 11 14:10:08 2024] "echo 0 > 
>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>   [Mon Mar 11 14:10:08 2024] task:nfsd            state:D stack:0 
>>>     pid:8866  ppid:2      flags:0x00004000
>>>   [Mon Mar 11 14:10:08 2024] Call Trace:
>>>   [Mon Mar 11 14:10:08 2024]  <TASK>
>>>   [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>>   [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>>   [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>>   [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>>   [Mon Mar 11 14:10:08 2024]  ? tcp_recvmsg+0x196/0x210
>>>   [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>>   [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>>   [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_destroy_session+0x1a4/0x240 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>   [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>>   [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>>   [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>>   [Mon Mar 11 14:10:08 2024]  </TASK>
>>>
>>>
>>>
>>>   The above is repeated a few times, and then this warning is also 
>>> logged:
>>>
>>>
>>>
>>> [Mon Mar 11 14:12:04 2024] ------------[ cut here ]------------
>>>   [Mon Mar 11 14:12:04 2024] WARNING: CPU: 39 PID: 8844 at 
>>> fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>   [Mon Mar 11 14:12:05 2024] Modules linked in: nfsv4 dns_resolver 
>>> nfs fscache netfs rpcsec_gss_krb5 rpcrdma rdma_cm iw_cm ib_cm 
>>> ib_core binfmt_misc bonding tls rfkill nft_counter nft_ct
>>>   nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_reject_inet 
>>> nf_reject_ipv4 nf_reject_ipv6 nft_reject nf_tables nfnetlink vfat 
>>> fat dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio l
>>>   ibcrc32c dm_service_time dm_multipath intel_rapl_msr 
>>> intel_rapl_common intel_uncore_frequency 
>>> intel_uncore_frequency_common isst_if_common skx_edac nfit libnvdimm 
>>> ipmi_ssif x86_pkg_temp
>>>   _thermal intel_powerclamp coretemp kvm_intel kvm irqbypass dcdbas 
>>> rapl intel_cstate mgag200 i2c_algo_bit drm_shmem_helper dell_smbios 
>>> drm_kms_helper dell_wmi_descriptor wmi_bmof intel_u
>>>   ncore syscopyarea pcspkr sysfillrect mei_me sysimgblt acpi_ipmi 
>>> mei fb_sys_fops i2c_i801 ipmi_si intel_pch_thermal lpc_ich 
>>> ipmi_devintf i2c_smbus ipmi_msghandler joydev acpi_power_meter
>>>   nfsd auth_rpcgss nfs_acl drm lockd grace fuse sunrpc ext4 mbcache 
>>> jbd2 sd_mod sg lpfc
>>>   [Mon Mar 11 14:12:05 2024]  nvmet_fc nvmet nvme_fc nvme_fabrics 
>>> crct10dif_pclmul ahci libahci crc32_pclmul nvme_core crc32c_intel 
>>> ixgbe megaraid_sas libata nvme_common ghash_clmulni_int
>>>   el t10_pi wdat_wdt scsi_transport_fc mdio wmi dca dm_mirror 
>>> dm_region_hash dm_log dm_mod
>>>   [Mon Mar 11 14:12:05 2024] CPU: 39 PID: 8844 Comm: nfsd Not 
>>> tainted 5.14.0-419.el9.x86_64 #1
>>>   [Mon Mar 11 14:12:05 2024] Hardware name: Dell Inc. PowerEdge 
>>> R740/00WGD1, BIOS 2.20.1 09/13/2023
>>>   [Mon Mar 11 14:12:05 2024] RIP: 
>>> 0010:nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>   [Mon Mar 11 14:12:05 2024] Code: a6 95 c5 f3 e9 ff fe ff ff 48 89 
>>> df be 01 00 00 00 e8 34 b5 13 f4 48 8d bb 98 00 00 00 e8 c8 f9 00 00 
>>> 84 c0 0f 85 2e ff ff ff <0f> 0b e9 27 ff ff ff be
>>>   02 00 00 00 48 89 df e8 0c b5 13 f4 e9 01
>>>   [Mon Mar 11 14:12:05 2024] RSP: 0018:ffff9929e0bb7b80 EFLAGS: 
>>> 00010246
>>>   [Mon Mar 11 14:12:05 2024] RAX: 0000000000000000 RBX: 
>>> ffff8ada51930900 RCX: 0000000000000024
>>>   [Mon Mar 11 14:12:05 2024] RDX: ffff8ada519309c8 RSI: 
>>> ffff8ad582933c00 RDI: 0000000000002000
>>>   [Mon Mar 11 14:12:05 2024] RBP: ffff8ad46bf21574 R08: 
>>> ffff9929e0bb7b48 R09: 0000000000000000
>>>   [Mon Mar 11 14:12:05 2024] R10: ffff8aec859a2948 R11: 
>>> 0000000000000000 R12: ffff8ad6f497c360
>>>   [Mon Mar 11 14:12:05 2024] R13: ffff8ad46bf21560 R14: 
>>> ffff8ae5942e0b10 R15: ffff8ad6f497c360
>>>   [Mon Mar 11 14:12:05 2024] FS:  0000000000000000(0000) 
>>> GS:ffff8b031fcc0000(0000) knlGS:0000000000000000
>>>   [Mon Mar 11 14:12:05 2024] CS:  0010 DS: 0000 ES: 0000 CR0: 
>>> 0000000080050033
>>>   [Mon Mar 11 14:12:05 2024] CR2: 00007fafe2060744 CR3: 
>>> 00000018e58de006 CR4: 00000000007706e0
>>>   [Mon Mar 11 14:12:05 2024] DR0: 0000000000000000 DR1: 
>>> 0000000000000000 DR2: 0000000000000000
>>>   [Mon Mar 11 14:12:05 2024] DR3: 0000000000000000 DR6: 
>>> 00000000fffe0ff0 DR7: 0000000000000400
>>>   [Mon Mar 11 14:12:05 2024] PKRU: 55555554
>>>   [Mon Mar 11 14:12:05 2024] Call Trace:
>>>   [Mon Mar 11 14:12:05 2024]  <TASK>
>>>   [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>>   [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>>   [Mon Mar 11 14:12:05 2024]  ? __break_lease+0x16f/0x5f0
>>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>   [Mon Mar 11 14:12:05 2024]  ? __warn+0x81/0x110
>>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>   [Mon Mar 11 14:12:05 2024]  ? report_bug+0x10a/0x140
>>>   [Mon Mar 11 14:12:05 2024]  ? handle_bug+0x3c/0x70
>>>   [Mon Mar 11 14:12:05 2024]  ? exc_invalid_op+0x14/0x70
>>>   [Mon Mar 11 14:12:05 2024]  ? asm_exc_invalid_op+0x16/0x20
>>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>   [Mon Mar 11 14:12:05 2024]  __break_lease+0x16f/0x5f0
>>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_file_lookup_locked+0x117/0x160 
>>> [nfsd]
>>>   [Mon Mar 11 14:12:05 2024]  ? list_lru_del+0x101/0x150
>>>   [Mon Mar 11 14:12:05 2024]  nfsd_file_do_acquire+0x790/0x830 [nfsd]
>>>   [Mon Mar 11 14:12:05 2024]  nfs4_get_vfs_file+0x315/0x3a0 [nfsd]
>>>   [Mon Mar 11 14:12:05 2024]  nfsd4_process_open2+0x430/0xa30 [nfsd]
>>>   [Mon Mar 11 14:12:05 2024]  ? fh_verify+0x297/0x2f0 [nfsd]
>>>   [Mon Mar 11 14:12:05 2024]  nfsd4_open+0x3ce/0x4b0 [nfsd]
>>>   [Mon Mar 11 14:12:05 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>   [Mon Mar 11 14:12:05 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>   [Mon Mar 11 14:12:05 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>   [Mon Mar 11 14:12:05 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>   [Mon Mar 11 14:12:05 2024]  nfsd+0x84/0xb0 [nfsd]
>>>   [Mon Mar 11 14:12:05 2024]  kthread+0xdd/0x100
>>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_kthread+0x10/0x10
>>>   [Mon Mar 11 14:12:05 2024]  ret_from_fork+0x29/0x50
>>>   [Mon Mar 11 14:12:05 2024]  </TASK>
>>>   [Mon Mar 11 14:12:05 2024] ---[ end trace 7a039e17443dc651 ]---
>> [Mon Mar 11 14:29:16 2024] task:kworker/u96:3   state:D stack:0     
>> pid:2451130 ppid:2      flags:0x00004000
>> [Mon Mar 11 14:29:16 2024] Workqueue: nfsd4_callbacks 
>> nfsd4_run_cb_work [nfsd]
>> [Mon Mar 11 14:29:16 2024] Call Trace:
>> [Mon Mar 11 14:29:16 2024]  <TASK>
>> [Mon Mar 11 14:29:16 2024]  __schedule+0x21b/0x550
>> [Mon Mar 11 14:29:16 2024]  schedule+0x2d/0x70
>> [Mon Mar 11 14:29:16 2024]  schedule_timeout+0x88/0x160
>> [Mon Mar 11 14:29:16 2024]  ? __pfx_process_timeout+0x10/0x10
>> [Mon Mar 11 14:29:16 2024]  rpc_shutdown_client+0xb3/0x150 [sunrpc]
>> [Mon Mar 11 14:29:16 2024]  ? __pfx_autoremove_wake_function+0x10/0x10
>> [Mon Mar 11 14:29:16 2024]  nfsd4_process_cb_update+0x3e/0x260 [nfsd]
>> [Mon Mar 11 14:29:16 2024]  ? sched_clock+0xc/0x30
>> [Mon Mar 11 14:29:16 2024]  ? raw_spin_rq_lock_nested+0x19/0x80
>> [Mon Mar 11 14:29:16 2024]  ? newidle_balance+0x26e/0x400
>> [Mon Mar 11 14:29:16 2024]  ? pick_next_task_fair+0x41/0x500
>> [Mon Mar 11 14:29:16 2024]  ? put_prev_task_fair+0x1e/0x40
>> [Mon Mar 11 14:29:16 2024]  ? pick_next_task+0x861/0x950
>> [Mon Mar 11 14:29:16 2024]  ? __update_idle_core+0x23/0xc0
>> [Mon Mar 11 14:29:16 2024]  ? __switch_to_asm+0x3a/0x80
>> [Mon Mar 11 14:29:16 2024]  ? finish_task_switch.isra.0+0x8c/0x2a0
>> [Mon Mar 11 14:29:16 2024]  nfsd4_run_cb_work+0x9f/0x150 [nfsd]
>> [Mon Mar 11 14:29:16 2024]  process_one_work+0x1e2/0x3b0
>> [Mon Mar 11 14:29:16 2024]  worker_thread+0x50/0x3a0
>> [Mon Mar 11 14:29:16 2024]  ? __pfx_worker_thread+0x10/0x10
>> [Mon Mar 11 14:29:16 2024]  kthread+0xdd/0x100
>> [Mon Mar 11 14:29:16 2024]  ? __pfx_kthread+0x10/0x10
>> [Mon Mar 11 14:29:16 2024]  ret_from_fork+0x29/0x50
>> [Mon Mar 11 14:29:16 2024]  </TASK>
>>
>> The above is the main task that I see in the cb workqueue. It's 
>> trying to call rpc_shutdown_client, which is waiting for this:
>>
>>                  wait_event_timeout(destroy_wait,
>>                          list_empty(&clnt->cl_tasks), 1*HZ);
>>
>> ...so basically waiting for the cl_tasks list to go empty. It repeatedly
>> does a rpc_killall_tasks though, so possibly trying to kill this task?
>>
>>      18423 2281      0 0x18 0x0     1354 nfsd4_cb_ops [nfsd] 
>> nfs4_cbv1 CB_RECALL_ANY a:call_start [sunrpc] q:delayq
>
> I wonder why this task is on delayq. Could it be related to memory
> shortage issue, or connection related problems?
> Output of /proc/meminfo on the nfs server at time of the problem
> would shed some light.

We don't have that anymore. I can check our monitoring host more closely 
for more fine grained stats tomorrow, but when I look at the sar 
statistics (see attachment) nothing special was going on memory or 
network wise.

We start to get the cpu stall messages and the system load starts to 
rise (starts around 2:10 PM). At 3:00 PM we restart the server as our 
users can no longer work.

Looking at the stats, the cpu's were ~idle. The only thing that may be 
related is that around 11:30 AM the write load (rx packets) starts to 
get a lot higher than the read load (tx packets). This goes on for hours 
(even after the server was restarted) and that workload was later 
identified. It was a workload that was constantly rewriting a statistics 
file.

Regards,

Rik


>
> Currently there is only 1 active task allowed for the nfsd callback
> workqueue at a time. If for some reasons a callback task is stuck in
> the workqueue it will block all other callback tasks which can effect
> multiple clients.
>
> -Dai
>
>>
>> Callbacks are soft RPC tasks though, so they should be easily killable.

-- 
Rik Theys
System Engineer
KU Leuven - Dept. Elektrotechniek (ESAT)
Kasteelpark Arenberg 10 bus 2440  - B-3001 Leuven-Heverlee
+32(0)16/32.11.07
----------------------------------------------------------------
<<Any errors in spelling, tact or fact are transmission errors>>

--------------mC6n08fGC3eLY6GbrEvYIvDe
Content-Type: text/plain; charset=UTF-8; name="sarstats.txt"
Content-Disposition: attachment; filename="sarstats.txt"
Content-Transfer-Encoding: base64

MTE6MjA6MDAgQU0gICBydW5xLXN6ICBwbGlzdC1zeiAgIGxkYXZnLTEgICBsZGF2Zy01ICBs
ZGF2Zy0xNSAgIGJsb2NrZWQKMTE6MzA6MDAgQU0gICAgICAgICAyICAgICAgMTE5OCAgICAg
IDMuNjMgICAgICAzLjMzICAgICAgMi43NyAgICAgICAgIDEKMTE6NDA6MDEgQU0gICAgICAg
ICA0ICAgICAgMTE5NyAgICAgIDMuMjkgICAgICAzLjg3ICAgICAgMy4zNiAgICAgICAgIDMK
MTE6NTA6MDAgQU0gICAgICAgICAwICAgICAgMTIwMyAgICAgIDIuMzQgICAgICAzLjMyICAg
ICAgMy41MCAgICAgICAgIDAKMTI6MDA6MDAgUE0gICAgICAgICAzICAgICAgMTE4NCAgICAg
IDIuMzEgICAgICAyLjY0ICAgICAgMy4wNiAgICAgICAgIDMKMTI6MTA6MDAgUE0gICAgICAg
ICA0ICAgICAgMTE5MiAgICAgIDUuNjYgICAgICA0LjI5ICAgICAgMy41OCAgICAgICAgIDEK
MTI6MjA6MDAgUE0gICAgICAgICAxICAgICAgMTE5NyAgICAgIDcuNDYgICAgICA0LjY5ICAg
ICAgMy44NiAgICAgICAgIDEKMTI6MzA6MDAgUE0gICAgICAgICAyICAgICAgMTIwMCAgICAg
IDMuNjUgICAgICAzLjg3ICAgICAgMy44MyAgICAgICAgIDAKMTI6NDA6MDAgUE0gICAgICAg
ICA0ICAgICAgMTIwOSAgICAgIDMuMTUgICAgICAzLjU3ICAgICAgMy43NyAgICAgICAgIDEK
MTI6NTA6MDAgUE0gICAgICAgICAwICAgICAgMTIwNCAgICAgIDUuMTUgICAgICA0LjMzICAg
ICAgMy45NSAgICAgICAgIDEKMDE6MDA6MDAgUE0gICAgICAgICA2ICAgICAgMTE5MiAgICAg
IDMuMjYgICAgICAzLjU3ICAgICAgMy43OCAgICAgICAgIDEKMDE6MTA6MDAgUE0gICAgICAg
ICAzICAgICAgMTIxNSAgICAgIDMuNTAgICAgICAzLjEyICAgICAgMy40MSAgICAgICAgIDAK
MDE6MjA6MDAgUE0gICAgICAgICAzICAgICAgMTE5NiAgICAgIDMuMTUgICAgICAzLjExICAg
ICAgMy4yNyAgICAgICAgIDUKMDE6MzA6MDAgUE0gICAgICAgICA0ICAgICAgMTE5NCAgICAg
IDQuMTMgICAgICAzLjcxICAgICAgMy41MiAgICAgICAgIDAKMDE6NDA6MDAgUE0gICAgICAg
ICAxICAgICAgMTIwMCAgICAgIDIuOTcgICAgICAyLjk5ICAgICAgMy4xOSAgICAgICAgIDAK
MDE6NTA6MDAgUE0gICAgICAgICAxICAgICAgMTIxMCAgICAgIDMuNTUgICAgICAzLjU0ICAg
ICAgMy40NCAgICAgICAgIDAKMDI6MDA6MDAgUE0gICAgICAgICAyICAgICAgMTIyMCAgICAg
IDQuNjEgICAgICA0LjU2ICAgICAgMy45MyAgICAgICAgIDAKMDI6MTA6MDAgUE0gICAgICAg
ICAxICAgICAgMTIyOSAgICAgMTYuOTQgICAgICA5Ljk2ICAgICAgNi40NCAgICAgICAgIDAK
MDI6MjA6MDAgUE0gICAgICAgICAxICAgICAgMTIwOCAgICAgNTcuMDMgICAgIDQ1LjQ3ICAg
ICAyNi4xNyAgICAgICAgIDAKMDI6MzA6MDAgUE0gICAgICAgICAzICAgICAgMTIxOCAgICAg
NjYuNDYgICAgIDU4LjQwICAgICA0MS44NSAgICAgICAgIDAKMDI6NDA6MDAgUE0gICAgICAg
ICAyICAgICAgMTIxOCAgICAgNzEuNDMgICAgIDY3LjE1ICAgICA1NC4wMyAgICAgICAgIDEK
MDI6NTA6MDAgUE0gICAgICAgICA0ICAgICAgMTIyMiAgICAgODcuNzEgICAgIDgxLjE1ICAg
ICA2Ny4yMSAgICAgICAgIDEKMDM6MDA6MDAgUE0gICAgICAgICA1ICAgICAgMTIyOCAgICAg
OTguNzQgICAgIDkzLjY4ICAgICA4MC4xMyAgICAgICAgIDIKQXZlcmFnZTogICAgICAgICAg
ICAyICAgICAgMTEyMCAgICAgIDYuMDAgICAgICA1LjQ2ICAgICAgNC41MyAgICAgICAgIDAK
CjAzOjExOjMzIFBNICBMSU5VWCBSRVNUQVJUICAgICAgKDQ4IENQVSkKCjExOjIwOjAwIEFN
ICAgICBDUFUgICAgICV1c2VyICAgICAlbmljZSAgICVzeXN0ZW0gICAlaW93YWl0ICAgICVz
dGVhbCAgICAgJWlkbGUKMTE6MjA6MDAgQU0gICAgIGFsbCAgICAgIDAuNTkgICAgICAwLjAw
ICAgICAgMi42MSAgICAgIDAuNDggICAgICAwLjAwICAgICA5Ni4zMQoxMTozMDowMCBBTSAg
ICAgYWxsICAgICAgMC41NSAgICAgIDAuMDAgICAgICAzLjc4ICAgICAgMy4wNSAgICAgIDAu
MDAgICAgIDkyLjYyCjExOjQwOjAxIEFNICAgICBhbGwgICAgICAwLjUyICAgICAgMC4wMCAg
ICAgIDQuNDggICAgICAyLjcxICAgICAgMC4wMCAgICAgOTIuMjkKMTE6NTA6MDAgQU0gICAg
IGFsbCAgICAgIDAuNTEgICAgICAwLjAwICAgICAgNC41NCAgICAgIDIuOTEgICAgICAwLjAw
ICAgICA5Mi4wNAoxMjowMDowMCBQTSAgICAgYWxsICAgICAgMC41MiAgICAgIDAuMDAgICAg
ICA0LjE3ICAgICAgMS4xMyAgICAgIDAuMDAgICAgIDk0LjE4CjEyOjEwOjAwIFBNICAgICBh
bGwgICAgICAwLjU5ICAgICAgMC4wMCAgICAgIDQuNTEgICAgICAyLjEwICAgICAgMC4wMCAg
ICAgOTIuNzkKMTI6MjA6MDAgUE0gICAgIGFsbCAgICAgIDAuNTQgICAgICAwLjAwICAgICAg
NC42NyAgICAgIDAuODcgICAgICAwLjAwICAgICA5My45MgoxMjozMDowMCBQTSAgICAgYWxs
ICAgICAgMC41MCAgICAgIDAuMDAgICAgICA1LjQwICAgICAgMS42MSAgICAgIDAuMDAgICAg
IDkyLjUwCjEyOjQwOjAwIFBNICAgICBhbGwgICAgICAwLjUwICAgICAgMC4wMCAgICAgIDYu
MDQgICAgICAxLjI3ICAgICAgMC4wMCAgICAgOTIuMjAKMTI6NTA6MDAgUE0gICAgIGFsbCAg
ICAgIDAuNTMgICAgICAwLjAwICAgICAgNS40MyAgICAgIDEuMzkgICAgICAwLjAwICAgICA5
Mi42NQowMTowMDowMCBQTSAgICAgYWxsICAgICAgMC42MSAgICAgIDAuMDAgICAgICA1LjU2
ICAgICAgMS45MCAgICAgIDAuMDAgICAgIDkxLjkzCjAxOjEwOjAwIFBNICAgICBhbGwgICAg
ICAwLjYwICAgICAgMC4wMCAgICAgIDUuMzggICAgICAwLjkxICAgICAgMC4wMCAgICAgOTMu
MTEKMDE6MjA6MDAgUE0gICAgIGFsbCAgICAgIDAuNTkgICAgICAwLjAwICAgICAgNS42OSAg
ICAgIDEuMTIgICAgICAwLjAwICAgICA5Mi41OQowMTozMDowMCBQTSAgICAgYWxsICAgICAg
MC42MCAgICAgIDAuMDAgICAgICA2LjA2ICAgICAgMS4zMCAgICAgIDAuMDAgICAgIDkyLjA0
CjAxOjQwOjAwIFBNICAgICBhbGwgICAgICAwLjU3ICAgICAgMC4wMCAgICAgIDUuMTUgICAg
ICAxLjMyICAgICAgMC4wMCAgICAgOTIuOTUKMDE6NTA6MDAgUE0gICAgIGFsbCAgICAgIDAu
NjIgICAgICAwLjAwICAgICAgNS41OCAgICAgIDEuODYgICAgICAwLjAwICAgICA5MS45NAow
MjowMDowMCBQTSAgICAgYWxsICAgICAgMC42MiAgICAgIDAuMDAgICAgICA2LjAxICAgICAg
Mi40NSAgICAgIDAuMDAgICAgIDkwLjkzCjAyOjEwOjAwIFBNICAgICBhbGwgICAgICAwLjY1
ICAgICAgMC4wMCAgICAgIDkuMTYgICAgICAyLjk1ICAgICAgMC4wMCAgICAgODcuMjMKMDI6
MjA6MDAgUE0gICAgIGFsbCAgICAgIDAuNjIgICAgICAwLjAwICAgICAgOS42OCAgICAgIDQu
NTUgICAgICAwLjAwICAgICA4NS4xNQowMjozMDowMCBQTSAgICAgYWxsICAgICAgMC42OCAg
ICAgIDAuMDAgICAgICA3LjA1ICAgICAgMi4yNCAgICAgIDAuMDAgICAgIDkwLjAzCjAyOjQw
OjAwIFBNICAgICBhbGwgICAgICAxLjAwICAgICAgMC4wMCAgICAgIDUuOTIgICAgICAyLjE5
ICAgICAgMC4wMCAgICAgOTAuODkKMDI6NTA6MDAgUE0gICAgIGFsbCAgICAgIDIuMDAgICAg
ICAwLjAwICAgICAgNi40OSAgICAgIDMuMjMgICAgICAwLjAwICAgICA4OC4yNwowMzowMDow
MCBQTSAgICAgYWxsICAgICAgMS4zNyAgICAgIDAuMDAgICAgICA1LjkwICAgICAgMy4wMSAg
ICAgIDAuMDAgICAgIDg5LjcyCkF2ZXJhZ2U6ICAgICAgICBhbGwgICAgICAwLjMyICAgICAg
MC4wMCAgICAgIDIuODQgICAgICAwLjgxICAgICAgMC4wMCAgICAgOTYuMDMKCjAzOjExOjMz
IFBNICBMSU5VWCBSRVNUQVJUICAgICAgKDQ4IENQVSkKCgoxMToyMDowMCBBTSAgcGdwZ2lu
L3MgcGdwZ291dC9zICAgZmF1bHQvcyAgbWFqZmx0L3MgIHBnZnJlZS9zIHBnc2NhbmsvcyBw
Z3NjYW5kL3MgcGdzdGVhbC9zICAgICV2bWVmZgoxMToyMDowMCBBTSAgIDQwMjAuMTEgICA4
NjA1LjA2ICAgMjE1Ny42MiAgICAgIDAuMDAgMTkxOTMzLjAzICAgMTIxNy45OCAgICAgIDAu
MDAgICAyNDQyLjgyICAgIDIwMC41NgoxMTozMDowMCBBTSAgNTUyNjguOTAgIDUwNTQwLjgw
ICAgMjA5Ni4wMiAgICAgIDAuMDQgNjM3ODk3LjU3ICAxNzY0OC4zOSAgICAgIDAuMDAgIDM1
Mjk2LjQ3ICAgIDIwMC4wMAoxMTo0MDowMSBBTSAgNzk5NDMuMTEgMTE2MjMxLjkwICAgMTg1
OS4wMCAgICAgIDAuMDAgNzYwODQ4LjY4ICAyMzAwOC41NCAgICAgIDAuMDAgIDQ2MDIwLjM5
ICAgIDIwMC4wMQoxMTo1MDowMCBBTSAgMjI1OTQuMjkgMTczOTU5LjkxICAgMTY3Ni44NCAg
ICAgIDAuMDAgMTA4NDM3MS41NSAgMTQxODIuNTcgICAgICAwLjAwICAyODM2NC45OSAgICAy
MDAuMDAKMTI6MDA6MDAgUE0gICAyNzY5LjU2IDE2NDI4Ni45MSAgIDE0NTAuNTEgICAgICAw
LjAwIDg5Njk2OS4xMiAgIDE0MTYuNzUgICAgICAwLjAwICAgMjgzNi44NiAgICAyMDAuMjQK
MTI6MTA6MDAgUE0gICA4ODIyLjAxIDE1NTI5Ni4yMiAgIDE0MzEuMjUgICAgICAwLjAwIDkz
MTczNC4yMSAgIDI2ODcuMzMgICAgICAwLjAwICAgNTM3OC4wNyAgICAyMDAuMTMKMTI6MjA6
MDAgUE0gICAyNTc3LjkxIDE3ODYyNS4yNCAgIDEzNzkuNzcgICAgICAwLjAwIDExODA1NDUu
MzAgICAzNDk3LjEyICAgICAgMC4wMCAgIDY5OTQuMjIgICAgMjAwLjAwCjEyOjMwOjAwIFBN
ICAgNTk1NC44NSAyMjY3NDQuMjEgICAxMjUzLjMwICAgICAgMC4wMCAxOTE4ODYzLjg5ICAg
NzE0Ny4yNCAgICAgIDAuMDAgIDE0Mjk3Ljg4ICAgIDIwMC4wNQoxMjo0MDowMCBQTSAgIDIz
NzcuMjQgMjg5MTE2LjUyICAgMTE5NC45OCAgICAgIDAuMDAgMjU4MDY2Mi44MSAgIDY3NTYu
MjUgICAgICAwLjAwICAxMzUxMi41MCAgICAyMDAuMDAKMTI6NTA6MDAgUE0gICAxOTM5Ljk0
IDI3MDU5NS4xMiAgIDE1NzkuMDggICAgICAwLjAwIDIxODk3NjYuNzQgICAyNzg1Ljg5ICAg
ICAgMC4wMCAgIDU1NzEuNzcgICAgMjAwLjAwCjAxOjAwOjAwIFBNICAgMzk3NS42NSAyODA2
NDcuODUgICAxOTYwLjI1ICAgICAgMC4wMCAyNDIxNzMwLjY2ICAgMjkwNC4yNCAgICAgIDAu
MDAgICA1ODA4LjQ5ICAgIDIwMC4wMAowMToxMDowMCBQTSAgIDMwNjEuNDYgMjg1NjE0Ljg5
ICAgMjA3Ny44MSAgICAgIDAuMDAgMjI1NjE3MS4zMyAgIDI2NTUuODAgICAgICAwLjAwICAg
NTMxMS41NyAgICAyMDAuMDAKMDE6MjA6MDAgUE0gICAxNTIyLjk4IDI4OTAxNC4yNiAgIDE4
NzguNTEgICAgICAwLjAwIDI1MTQ0NTAuMjUgICAxMjEzLjcwICAgICAgMC4wMCAgIDI0Mjcu
NDAgICAgMjAwLjAwCjAxOjMwOjAwIFBNICAgNDk3OS41NiAyNzIxNTguNzEgICAxNjIyLjUy
ICAgICAgMC4wMCAyMjUyNzgxLjIwICAgMjE4My43OSAgICAgIDAuMDAgICA0MzY3LjU4ICAg
IDIwMC4wMAowMTo0MDowMCBQTSAgIDQzNjQuODIgMjY2MjcwLjEyICAgMTQxMS40NiAgICAg
IDAuMDAgMjAxMzM3MS4xMiAgIDIxNjQuNjQgICAgICAwLjAwICAgNDMyOS4yOCAgICAyMDAu
MDAKMDE6NTA6MDAgUE0gICA5MDQ1Ljk4IDI3NDM5Ny43NyAgIDE5NTguNDQgICAgICAwLjAx
IDE5NzA3NDkuMTIgICAzOTk2LjEyICAgICAgMC4wMCAgIDc5OTUuNjUgICAgMjAwLjA5CjAy
OjAwOjAwIFBNICAgNjQ3Mi40NiAyODA2MzEuOTUgICAxNDUzLjQyICAgICAgMC4wMCAyMDk4
NDY2LjEwICAgMzkyMS42NSAgICAgIDAuMDAgICA3ODQzLjI3ICAgIDIwMC4wMAowMjoxMDow
MCBQTSAgIDI1NzcuNjcgNDkxMjUxLjA5ICAgMjI0Ny4wMSAgICAgIDAuMDAgMjQxNTAyOS42
MSAgNzUxMzEuODAgICAgICAwLjAwIDE1MDI3Ni4yOCAgICAyMDAuMDIKMDI6MjA6MDAgUE0g
ICA4Mjc5Ljg4IDUyMzQ2NC43OSAgIDIyMTYuMjIgICAgICAwLjAwIDI1NTQ1ODAuODAgIDg1
Mjc3LjY4ICAgICAgMC4wMCAxNzA1NTQuNzggICAgMjAwLjAwCjAyOjMwOjAwIFBNICAgNDAx
Ni4wMCAzNzg0MjYuNTAgICAyNzA0LjgxICAgICAgMC4zMiAyMTU1NzA2LjI3ICAzNjE5NS40
OCAgICAgIDAuMDAgIDcyNDAwLjk2ICAgIDIwMC4wMwowMjo0MDowMCBQTSAgMTA5MzkuMTIg
MjY4OTY1LjI1ICAgMjI3OS43OSAgICAgIDAuMDEgMTkyMDk4Mi4yNiAgIDQzMzEuMjAgICAg
ICAwLjAwICAgODY3Ni4wMSAgICAyMDAuMzEKMDI6NTA6MDAgUE0gIDM1OTA2LjM4IDI4NjY5
OC42OSAgIDE5NTEuMDMgICAgICAwLjAwIDE5OTQ4MjcuNzIgIDEzMzg1LjAxICAgICAgMC4w
MCAgMjY3NzYuOTkgICAgMjAwLjA1CjAzOjAwOjAwIFBNICAzMDMwNy44MyAyODQwMzguMTkg
ICAxODczLjk3ICAgICAgMC4wMiAyMDQxMTc0LjUxICAxMjE3NC42NiAgICAgIDAuMDAgIDI0
MzUyLjY5ICAgIDIwMC4wMwpBdmVyYWdlOiAgICAgMTEyMTQuMDMgIDg0NzU0Ljc0ICAgMTA1
Mi4zNyAgICAgIDAuMDEgNjQxMjI0LjUwICAgNzA2OC4yNyAgICAgIDAuMDYgIDE0MTM5LjA2
ICAgIDIwMC4wMwoKMDM6MTE6MzMgUE0gIExJTlVYIFJFU1RBUlQgICAgICAoNDggQ1BVKQoK
CjExOjIwOjAwIEFNIGtibWVtZnJlZSAgIGtiYXZhaWwga2JtZW11c2VkICAlbWVtdXNlZCBr
YmJ1ZmZlcnMgIGtiY2FjaGVkICBrYmNvbW1pdCAgICVjb21taXQgIGtiYWN0aXZlICAga2Jp
bmFjdCAgIGtiZGlydHkgIGtiYW5vbnBnICAgIGtic2xhYiAga2Jrc3RhY2sgICBrYnBndGJs
ICBrYnZtdXNlZAoxMToyMDowMCBBTSAgIDE4NjU0MjAgMTcxMTg3MzQ4ICAgMTk5ODM2OCAg
ICAgIDEuMDIgIDE0Mjg1NjIwIDEzODk1NDk2MCAgIDQ0NjQ1ODggICAgICAxLjcwICAgMTE1
Nzc4OCAxNTI3MDI5NTYgICAgMTYzNDY0ICAgIDY3MjUxNiAgMzkwMDY0OTIgICAgIDE5NjAw
ICAgICA0NjExMiAgICAzMDU5NjAKMTE6MzA6MDAgQU0gICAzNjg3MTU2IDE3MTE1MjMxMiAg
IDIwMzcyMTYgICAgICAxLjA0ICAxMzc2NjU2MCAxMzgwNzExMTIgICA0NTMyNTU2ICAgICAg
MS43MiAgIDEyMDk1NzIgMTUxMjc1Njg0ICAgIDQ4MzU1NiAgICA3MDAyMjAgIDM4NTQ4ODE2
ICAgICAxOTkwNCAgICAgNDg1MDQgICAgMzA2MjAwCjExOjQwOjAxIEFNICAgMTc2NjU1MiAx
NzAzMzY2NDAgICAyMTQzNDUyICAgICAgMS4wOSAgMTI5NzA2MDggMTQxMTYwODg0ICAgNDQ3
ODQ2NCAgICAgIDEuNzAgICAxMTcxMTI0IDE1MzU5MjEwOCAgICA1NDI0NDAgICAgNjgzOTky
ICAzODA2OTM2NCAgICAgMTk4ODggICAgIDQ3NDI4ICAgIDMwNjIwMAoxMTo1MDowMCBBTSAg
IDcyODEzODQgMTcxMDkxODAwICAgMjA5NjIzNiAgICAgIDEuMDcgIDEyNTY1MDI4IDEzNjE5
MTc0MCAgIDQ1MjcyNzIgICAgICAxLjcyICAgMTE4NTE0OCAxNDgyMTczMjQgICAgIDU3NzQ0
ICAgIDY5Nzc3MiAgMzc5NzY0NzIgICAgIDIwMDAwICAgICA0ODI2OCAgICAzMDYyMTYKMTI6
MDA6MDAgUE0gICA4Mjc2NjkyIDE3MTAyNjM2NCAgIDIxNTEyMTYgICAgICAxLjEwICAxMjc1
NDM2MCAxMzQ5NDU1NjQgICA0NTIxMzI4ICAgICAgMS43MiAgIDExNzU1MjAgMTQ3MTU1OTQ4
ICAgMTA0MTgwMCAgICA2ODk0MjQgIDM3OTgzMDI4ICAgICAxOTY2NCAgICAgNDgwNTYgICAg
MzA1ODAwCjEyOjEwOjAwIFBNICAgMjU3MTk0OCAxNzExMDc3MDggICAyMDUyNjM2ICAgICAg
MS4wNSAgMTI4ODYxODQgMTQwNjEyMjQ4ICAgNDU0NjU3NiAgICAgIDEuNzMgICAxMTgyNzky
IDE1Mjk1ODcyNCAgICA0NzU0MDggICAgNzAwMTcyICAzNzk4Nzg0NCAgICAgMTk4MDggICAg
IDQ4MTQ0ICAgIDMwNjA3MgoxMjoyMDowMCBQTSAgIDQzOTczODggMTcxMTAxNjI4ICAgMjAz
NjQ1MiAgICAgIDEuMDQgIDEyOTc1MzUyIDEzODQ1OTIyMCAgIDQ1Mzk4NzYgICAgICAxLjcy
ICAgMTE3MTkzNiAxNTA4OTQ2MTYgICAgNzk2MzI0ICAgIDY4NzM4NCAgMzgyNDI0NDggICAg
IDE5OTA0ICAgICA0NzQ5NiAgICAzMDYxMDQKMTI6MzA6MDAgUE0gICA3MDg3MzUyIDE3MDcx
NjEwOCAgIDIxMzMzODQgICAgICAxLjA5ICAxMzAyMTY5MiAxMzUzMjU4MjQgICA0NTg2MDQw
ICAgICAgMS43NCAgIDExNzgyODggMTQ3ODA3MzA4ICAgMTcyMjk1MiAgICA2OTMyNDAgIDM4
NTQyNjA4ICAgICAxOTk2OCAgICAgNDg0MDQgICAgMzA2MjE2CjEyOjQwOjAwIFBNICAgNzUy
NDEyOCAxNzA5NTQ0MTYgICAyMTY1NTIwICAgICAgMS4xMCAgMTMwOTc4OTYgMTM0NTcwOTMy
ICAgNDYxMzM5NiAgICAgIDEuNzUgICAxMTg5MzQ0IDE0NzEyODc3MiAgICA3MDEwODAgICAg
NzA0NDA0ICAzODc1MjM4NCAgICAgMjAxNDQgICAgIDQ5MDgwICAgIDMwNjMxMgoxMjo1MDow
MCBQTSAgIDYwNTE1MDggMTcwOTEwNjY4ICAgMjE5OTg3MiAgICAgIDEuMTIgIDEzMjYzNDYw
IDEzNTgwMzMwNCAgIDQ2MTI0ODQgICAgICAxLjc1ICAgMTE4NjIzMiAxNDg1Mjg4MDAgICAg
MzczNzMyICAgIDcwNTkxNiAgMzg3OTI3MTYgICAgIDIwMDAwICAgICA0OTA2OCAgICAzMDYx
MDQKMDE6MDA6MDAgUE0gIDEwOTkyMzMyIDE3MDcyNjQ2NCAgIDIxMzg4MjAgICAgICAxLjA5
ICAxMzI4ODE2NCAxMzA4MDQ2NzIgICA0NjI0NjEyICAgICAgMS43NiAgIDExNzc3NDQgMTQz
NTU0NTU2ICAgMjk1NjgwOCAgICA2OTczMDggIDM4ODg2ODcyICAgICAxOTgyNCAgICAgNDkw
NzYgICAgMzA2MjAwCjAxOjEwOjAwIFBNICAgMzc4Mjk3NiAxNzA3MzgzNDAgICAyMTE3MDA0
ICAgICAgMS4wOCAgMTMzMTQ4MzIgMTM3ODcyNTg0ICAgNDY0MTIwMCAgICAgIDEuNzYgICAx
MTkzOTEyIDE1MDY0MjcwMCAgICA0MDQwNzIgICAgNzA0MTE2ICAzOTAyMzQ2NCAgICAgMjAx
NjAgICAgIDUwMDI4ICAgIDMwNjQwOAowMToyMDowMCBQTSAgIDY2NTk0NDQgMTcwOTAwMjM2
ICAgMjE2NzA4OCAgICAgIDEuMTEgIDEzMzc2NDgwIDEzNDkyNjA2MCAgIDQ2NTMxMDAgICAg
ICAxLjc3ICAgMTE4NDU1NiAxNDc3NTc3MjAgICAgMzg4NDMyICAgIDY5Nzg3NiAgMzg5ODE3
ODggICAgIDE5ODg4ICAgICA0OTg4OCAgICAzMDYyNDgKMDE6MzA6MDAgUE0gIDEzMTcyNzY4
IDE3MDg4NTYxNiAgIDIxNzIyMTYgICAgICAxLjExICAxMzM5Mzc4NCAxMjgzNzMwODggICA0
NjUzNzA4ICAgICAgMS43NyAgIDExODYwMDggMTQxMjI0NzM2ICAgNDA3MTc2MCAgICA3MDA5
NjQgIDM4OTk5MDA0ICAgICAxOTg0MCAgICAgNDk4ODAgICAgMzA2MTIwCjAxOjQwOjAwIFBN
ICAxMDY4Mjk3MiAxNzA4OTMyODggICAyMTQ0NDY0ICAgICAgMS4wOSAgMTM1MTc2NzYgMTMw
NzIzMTQ4ICAgNDcwMTExNiAgICAgIDEuNzkgICAxMTkzNzAwIDE0MzY5ODQ4OCAgIDE0MTUw
MTIgICAgNzA2NDQwICAzOTA0MjYwMCAgICAgMTk5NTIgICAgIDUwODQ0ICAgIDMwNjI5Ngow
MTo1MDowMCBQTSAgIDYwODU0MDQgMTcwODI0OTY4ICAgMjIwMDU5NiAgICAgIDEuMTIgIDEz
MjIxODM2IDEzNTUyODU1MiAgIDQ3MzY1MzIgICAgICAxLjgwICAgMTIwMTYzMiAxNDgyMDM5
MjAgICAyNDEwNjEyICAgIDcxMjA4OCAgMzkwNzQ0NzIgICAgIDIwMTc2ICAgICA1MTk5MiAg
ICAzMDYzNDQKMDI6MDA6MDAgUE0gICA1NTU1NDQ4IDE3MDgxMDA3MiAgIDIyMDE2NDAgICAg
ICAxLjEyICAxMzY1ODM0OCAxMzU0NzA1NTIgICA0NzU4OTk2ICAgICAgMS44MSAgIDEyMjM4
NjAgMTQ4NTgyODg4ICAgIDMwNzQ2NCAgICA3MzE4NTYgIDM5MjI0ODcyICAgICAyMDE5MiAg
ICAgNTMxNDQgICAgMzA2NDU2CjAyOjEwOjAwIFBNICAgMTAxNDg4MCAxNzA4MzYzNjggICAy
MTYwMDI4ICAgICAgMS4xMCAgMTI3Mjg3MDggMTQwMTUxMjg4ICAgNDgyMzYxNiAgICAgIDEu
ODMgICAxMjI3MDcyIDE1MjMyOTg4NCAgIDk2NDUzMDQgICAgNzMxNzQ4ICA0MDA1NTk1NiAg
ICAgMjA0MzIgICAgIDUzNTE2ICAgIDMwNjY2NAowMjoyMDowMCBQTSAgIDI4MjMwNjggMTcw
ODI4Mjg4ICAgMjE1MjEwOCAgICAgIDEuMTAgIDEzMTk5MzE2IDEzNzg0MzUxMiAgIDQ4MDEz
OTIgICAgICAxLjgyICAgMTIxNzg3NiAxNTA0OTIwMzYgICA4NDg4MDg0ICAgIDcyMTgxMiAg
NDAwOTI4NTYgICAgIDIwMDY0ICAgICA1MzIyNCAgICAzMDY0MDgKMDI6MzA6MDAgUE0gICA3
MDA1NDA0IDE3MDY3ODU4MCAgIDIyNjE3OTIgICAgICAxLjE1ICAxMzM1ODc2OCAxMzM0Mjk5
MzYgICA0ODkzMzQ0ICAgICAgMS44NiAgIDEyNzE2ODggMTQ2MjI2OTI0ICAgMTYyNTQ4MCAg
ICA3NTI3NTIgIDQwMDU0OTYwICAgICAyMDIyNCAgICAgNTY0MDggICAgMzA2NDU2CjAyOjQw
OjAwIFBNICAgNDAxNjY3NiAxNzA2OTcwNDQgICAyMjMyODI0ICAgICAgMS4xNCAgMTM3Mjcw
MjAgMTM2MTQwNDA0ICAgNDkxMTk3MiAgICAgIDEuODcgICAxMjU4Mjc2IDE0OTMwMjc4NCAg
ICAxNjc1ODQgICAgNzQwODkyICAzOTk5MzkzNiAgICAgMjAyNDAgICAgIDU0NDcyICAgIDMw
NjU4MAowMjo1MDowMCBQTSAgIDk5NzYzOTIgMTcwNjgzNDI4ICAgMjE5MjM4NCAgICAgIDEu
MTIgIDEzNzA2OTI0IDEzMDQ1MDUwOCAgIDQ5MzExMjQgICAgICAxLjg3ICAgMTI2MTY0MCAx
NDM2MDczMDQgICAxNTIwNDU2ICAgIDc2MDMwNCAgMzk3ODQ2NTIgICAgIDIwMzA0ICAgICA1
NTkxMiAgICAzMDQ2NDgKMDM6MDA6MDAgUE0gICA4MTY1MDM2IDE3MDYzNzkyNCAgIDIyMzUy
MjggICAgICAxLjE0ICAxMzk2OTkzMiAxMzIxMjg1NjggICA0OTU2MDA4ICAgICAgMS44OCAg
IDEyNDkzNzYgMTQ1NTQ5MjE2ICAgMTUwMzQ3MiAgICA3NTE2MzYgIDM5NjEyMDk2ICAgICAy
MDM4NCAgICAgNTUyMTYgICAgMzA0NTg4CkF2ZXJhZ2U6ICAgICAgODAwMzI3NCAxNzEzNTQ0
MjcgICAxOTk3MDg0ICAgICAgMS4wMiAgMTc5NzgyMzMgMTI4MTUzNDAyICAgNDAwOTg2NCAg
ICAgIDEuNTIgICAyOTQ4NzMyIDE0Mzc0NDIzNCAgICA4MDI2OTggICAgNjE4OTI4ICAzOTk3
ODg2NyAgICAgMTg2NTggICAgIDM1MDc4ICAgIDMwMzUxMQoKMDM6MTE6MzMgUE0gIExJTlVY
IFJFU1RBUlQgICAgICAoNDggQ1BVKQoKCjEyOjAwOjAxIEFNICAgICBJRkFDRSAgIHJ4cGNr
L3MgICB0eHBjay9zICAgIHJ4a0IvcyAgICB0eGtCL3MgICByeGNtcC9zICAgdHhjbXAvcyAg
cnhtY3N0L3MgICAlaWZ1dGlsCjEwOjIwOjAxIEFNICAgICBib25kMCAgMTkzNDEuNTUgIDE2
NjEzLjUyICAxNDg1Mi44MCAgMTAwNjMuMDMgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcu
NTkgICAgICAwLjYxCjEwOjMwOjAwIEFNICAgICBib25kMCAgMjI2MTIuNzcgIDIzODAyLjkz
ICAxNzA2NC4zMiAgMTgwMjEuMTAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcuNTQgICAg
ICAwLjc0CjEwOjQwOjAwIEFNICAgICBib25kMCAgMzYwNzIuODQgIDI4NjUwLjY4ICAzNjQz
Ni42NiAgMjM4MzguNTYgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcuNTQgICAgICAxLjQ5
CjEwOjUwOjAwIEFNICAgICBib25kMCAgMzAyOTcuOTcgIDI2NDc2Ljk4ICAyODg5Ni4xMCAg
MjE4NTEuODAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcuNTkgICAgICAxLjE4CjExOjAw
OjAwIEFNICAgICBib25kMCAgMjQ0MjIuNzcgIDIyNjUwLjcwICAxNzc3MS42NCAgMTQ2NTUu
NjggICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcuNTcgICAgICAwLjczCjExOjEwOjAwIEFN
ICAgICBib25kMCAgMzI2NDguNjEgIDU1Mzg5LjQ4ICAyNzM1MC4zMCAgNjMyMDAuMzkgICAg
ICAwLjAwICAgICAgMC4wMCAgICAgIDcuNjEgICAgICAyLjU5CjExOjIwOjAwIEFNICAgICBi
b25kMCAgMjA5NjYuNzEgIDIwNjMxLjEyICAxNTA0OS4xMyAgMTQyMzkuMzYgICAgICAwLjAw
ICAgICAgMC4wMCAgICAgIDcuNTkgICAgICAwLjYyCjExOjMwOjAwIEFNICAgICBib25kMCAg
NTkwMzguNjAgIDg1NTIyLjQ1ICA2MjA2NS4wMyAxMDQwMTYuODIgICAgICAwLjAwICAgICAg
MC4wMCAgICAgIDcuNTQgICAgICA0LjI2CjExOjQwOjAxIEFNICAgICBib25kMCAxMDk5OTEu
ODIgIDk3MDUxLjU0IDEyOTc5OS40OCAxMTcwMDguMDEgICAgICAwLjAwICAgICAgMC4wMCAg
ICAgIDcuNTQgICAgICA1LjMyCjExOjUwOjAwIEFNICAgICBib25kMCAxNDI4ODQuNDMgIDQ1
MzA2Ljc3IDE4ODI4Ny45MSAgMzQ2NzIuMzcgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcu
NjAgICAgICA3LjcxCjEyOjAwOjAwIFBNICAgICBib25kMCAxMzUyNzAuNjQgIDI5MjAyLjMx
IDE4MDEwNS40NyAgMTUwNDMuMDkgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcuNTQgICAg
ICA3LjM4CjEyOjEwOjAwIFBNICAgICBib25kMCAxMjg2ODIuOTIgIDM4MjYzLjc2IDE2Nzg1
OS42NCAgMjY1MTcuODAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcuNjUgICAgICA2Ljg4
CjEyOjIwOjAwIFBNICAgICBib25kMCAxNDcxMjguMDUgIDQxMTkwLjI2IDE5NTk3NC40OSAg
Mjg0MTkuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcuNTkgICAgICA4LjAzCjEyOjMw
OjAwIFBNICAgICBib25kMCAxODM0NTIuMjEgIDU5NTQwLjY0IDI0ODQ5Ny40NCAgNDE2OTgu
ODIgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcuNTQgICAgIDEwLjE4CjEyOjQwOjAwIFBN
ICAgICBib25kMCAyMjMwNDUuNTEgIDQ5NjMxLjU2IDMwODk5NC43NCAgMjA4OTIuMTYgICAg
ICAwLjAwICAgICAgMC4wMCAgICAgIDcuNTYgICAgIDEyLjY2CjEyOjUwOjAwIFBNICAgICBi
b25kMCAyMTEzNTYuNDIgIDQwMjQyLjU0IDI5Mjc5NC4zMiAgMTU3NTMuMzggICAgICAwLjAw
ICAgICAgMC4wMCAgICAgIDcuNTUgICAgIDExLjk5CjAxOjAwOjAwIFBNICAgICBib25kMCAy
MjEzNDUuNjAgIDQzMDEwLjE4IDMwNzg2MS42NCAgMTc3NDguNjQgICAgICAwLjAwICAgICAg
MC4wMCAgICAgIDcuNTUgICAgIDEyLjYxCjAxOjEwOjAwIFBNICAgICBib25kMCAyMjMxNDcu
MjYgIDQwOTQxLjkyIDMxMTA3MS4wOSAgMTcwOTIuNjUgICAgICAwLjAwICAgICAgMC4wMCAg
ICAgIDcuNTggICAgIDEyLjc0CjAxOjIwOjAwIFBNICAgICBib25kMCAyMjY3MzIuODIgIDQz
NDUyLjI3IDMxNTM3MC43OSAgMTYwODIuMjUgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcu
NjEgICAgIDEyLjkyCjAxOjMwOjAwIFBNICAgICBib25kMCAyMjI3MjUuMzggIDcyNzY1LjU5
IDMwMzUyOS43OCAgNTk4OTEuOTEgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcuNTIgICAg
IDEyLjQzCjAxOjQwOjAwIFBNICAgICBib25kMCAyMDYzNDIuMzYgIDQwOTc3LjA2IDI4NjE2
NC45NCAgMjAxNjUuMDQgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcuNTQgICAgIDExLjcy
CjAxOjUwOjAwIFBNICAgICBib25kMCAyMTgzMjcuMzkgIDQ5OTQyLjQ2IDMwMDYzOC41NiAg
MzA3NTcuNjkgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcuNjAgICAgIDEyLjMxCjAyOjAw
OjAwIFBNICAgICBib25kMCAyMTg4NTEuODcgIDU0MTk2LjQ3IDI5OTM2Ny45OCAgMzMwNDQu
OTggICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcuNTcgICAgIDEyLjI2CjAyOjEwOjAwIFBN
ICAgICBib25kMCAzNzg4MDcuNzkgIDUzNDU4LjIyIDUzODYxMS4xMCAgMTk5NDQuMjEgICAg
ICAwLjAwICAgICAgMC4wMCAgICAgIDcuNTggICAgIDIyLjA2CjAyOjIwOjAwIFBNICAgICBi
b25kMCAzODcyODUuOTkgIDU1NDYwLjAyIDU1NTE0Ny42OCAgMjI5NzUuMjMgICAgICAwLjAw
ICAgICAgMC4wMCAgICAgIDcuNTggICAgIDIyLjc0CjAyOjMwOjAwIFBNICAgICBib25kMCAy
NzQ1OTMuOTggIDM3ODg1LjI5IDM5MDU3OC4xOSAgMTE2NTguNjIgICAgICAwLjAwICAgICAg
MC4wMCAgICAgIDcuNTYgICAgIDE2LjAwCjAyOjQwOjAwIFBNICAgICBib25kMCAyMDI3MjEu
MTQgIDQxOTgwLjY1IDI4MjU0MS44NiAgMTk0NjIuODUgICAgICAwLjAwICAgICAgMC4wMCAg
ICAgIDcuNTYgICAgIDExLjU3CjAyOjUwOjAwIFBNICAgICBib25kMCAyMTgwNzIuNDEgIDUy
NzE4Ljk4IDMwMTYwMi44NSAgMzY5NjMuMzEgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcu
NTkgICAgIDEyLjM1CjAzOjAwOjAwIFBNICAgICBib25kMCAyMTQ2MDAuMDggIDUxNjk4LjE1
IDI5OTg5MC42NyAgMzYxODEuNjYgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcuNTggICAg
IDEyLjI4CkF2ZXJhZ2U6ICAgICAgICBib25kMCAgNzA4OTIuNTYgIDI3NDk0LjUxICA4OTM5
NC4wMiAgMTkyNjAuNjcgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDcuNTcgICAgICAzLjY2
CjAzOjExOjMzIFBNICBMSU5VWCBSRVNUQVJUICAgICAgKDQ4IENQVSkKCjEyOjAwOjAxIEFN
ICAgICBJRkFDRSAgIHJ4ZXJyL3MgICB0eGVyci9zICAgIGNvbGwvcyAgcnhkcm9wL3MgIHR4
ZHJvcC9zICB0eGNhcnIvcyAgcnhmcmFtL3MgIHJ4Zmlmby9zICB0eGZpZm8vcwoxMToyMDow
MCBBTSAgICAgYm9uZDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAw
ICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAKMTE6
MzA6MDAgQU0gICAgIGJvbmQwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAg
MC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAw
CjExOjQwOjAxIEFNICAgICBib25kMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAg
ICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAg
MC4wMAoxMTo1MDowMCBBTSAgICAgYm9uZDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAu
MDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAg
ICAgIDAuMDAKMTI6MDA6MDAgUE0gICAgIGJvbmQwICAgICAgMC4wMCAgICAgIDAuMDAgICAg
ICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAu
MDAgICAgICAwLjAwCjEyOjEwOjAwIFBNICAgICBib25kMCAgICAgIDAuMDAgICAgICAwLjAw
ICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAg
ICAwLjAwICAgICAgMC4wMAoxMjoyMDowMCBQTSAgICAgYm9uZDAgICAgICAwLjAwICAgICAg
MC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAw
ICAgICAgMC4wMCAgICAgIDAuMDAKMTI6MzA6MDAgUE0gICAgIGJvbmQwICAgICAgMC4wMCAg
ICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAg
MC4wMCAgICAgIDAuMDAgICAgICAwLjAwCjEyOjQwOjAwIFBNICAgICBib25kMCAgICAgIDAu
MDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAg
ICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMAoxMjo1MDowMCBQTSAgICAgYm9uZDAgICAg
ICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAu
MDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAKMDE6MDA6MDAgUE0gICAgIGJvbmQw
ICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAg
ICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwCjAxOjEwOjAwIFBNICAgICBi
b25kMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAw
ICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMAowMToyMDowMCBQTSAg
ICAgYm9uZDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAg
MC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAKMDE6MzA6MDAg
UE0gICAgIGJvbmQwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAg
ICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwCjAxOjQw
OjAwIFBNICAgICBib25kMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAu
MDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMAow
MTo1MDowMCBQTSAgICAgYm9uZDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAg
ICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAu
MDAKMDI6MDA6MDAgUE0gICAgIGJvbmQwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAw
ICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAg
ICAwLjAwCjAyOjEwOjAwIFBNICAgICBib25kMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAg
MC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAw
ICAgICAgMC4wMAowMjoyMDowMCBQTSAgICAgYm9uZDAgICAgICAwLjAwICAgICAgMC4wMCAg
ICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAg
MC4wMCAgICAgIDAuMDAKMDI6MzA6MDAgUE0gICAgIGJvbmQwICAgICAgMC4wMCAgICAgIDAu
MDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAg
ICAgIDAuMDAgICAgICAwLjAwCjAyOjQwOjAwIFBNICAgICBib25kMCAgICAgIDAuMDAgICAg
ICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAu
MDAgICAgICAwLjAwICAgICAgMC4wMAowMjo1MDowMCBQTSAgICAgYm9uZDAgICAgICAwLjAw
ICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAg
ICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAKMDM6MDA6MDAgUE0gICAgIGJvbmQwICAgICAg
MC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAw
ICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwCkF2ZXJhZ2U6ICAgICAgICBib25kMCAg
ICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAg
MC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMAowMzoxMTozMyBQTSAgTElOVVgg
UkVTVEFSVCAgICAgICg0OCBDUFUpCgo=

--------------mC6n08fGC3eLY6GbrEvYIvDe--

