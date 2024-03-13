Return-Path: <linux-nfs+bounces-2284-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E010487B246
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Mar 2024 20:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B501F243A5
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Mar 2024 19:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE277487A7;
	Wed, 13 Mar 2024 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="UjLrnTLw";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="c/jOW/bp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [134.58.240.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10E64C624
	for <linux-nfs@vger.kernel.org>; Wed, 13 Mar 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359417; cv=none; b=YOfT54aA86GtQnJsoKwODt8VKQ+a6E49Fajm0+iaIwhuEGK6h1JMh0PM/0E5a+Dm1amKRoC++i3PmW9SvHpDLgJHB1D2sokLOe3VVL+I4dC36UuPLDyaqkcwwKOkn+8ku0nDiThRmexN4q78HccHphA5gvcayBtHcOh184VhMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359417; c=relaxed/simple;
	bh=GIbzTUo2LE10Oqjfm2eaQtGqQ1Mo5kWmozjLA+vZt4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M12gI5C9U3AtB1c6uBzg3er4AlOpVn5qI75/FFTHD5hymcDNhdVvP+49a9Oc81F1VVlzYyDJntQaGnB6tRENtBmZnvKJLkk9heVDkRbgpD8OHms86oZGImzHZ2K+LTPP0zDN6pIIP2kdnN0TLPuuYGn6J9tNiE6JxsWnz+3FOOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=UjLrnTLw; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=c/jOW/bp; arc=none smtp.client-ip=134.58.240.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: F35232017B.A3B4D
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:139:242:ac11:8])
	by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id F35232017B;
	Wed, 13 Mar 2024 20:50:02 +0100 (CET)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1710359402;
	bh=QC50yrmxLlLoTqZE8gjl6kUaue1bXIuSxzNvVTLf4Xk=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=UjLrnTLwC4cOKBnmtuhf051kXWEDDOVLmjMV1l/lppX7CZwFuIZUKQpUzQk8DlPV1
	 OGK4/3K7MDhGEusUlRDT7wxZ3hXjU0605GrPM7IY9YK8Cyhj7tOc8n1/chtRYQ5jLW
	 8OM62Q4Xa5TVyPRPCEQGHN8R1WQc94CXby8QHxtrL1MCvrLRFOiDFmqmeClQOdpjcq
	 X3H+9zPxRZgyj1MdB1pd7UZbZ0Beh37WnW7up6URvbvY+wG/WO0kNTDOeGFAAmqPkz
	 LEkMvVD5yNUuNoI3zjofyfDrsDDkKoS/gX/2G/QQ3SPPGN8FN5VLFatCQKgxR4mynC
	 dzyVg3hLmkk7A==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPS id 80AB6D4F4D411;
	Wed, 13 Mar 2024 20:50:02 +0100 (CET)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1710359402;
	bh=QC50yrmxLlLoTqZE8gjl6kUaue1bXIuSxzNvVTLf4Xk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=c/jOW/bpZ4OJZy1MP4n7QtzYJ4ekfNNCqCcQ5YFvEPsDzv4Yx8DHatUTyNYz8+O/z
	 zy8wOPln20GArxDN5n6xW5SabcbfhxVMuQ6SYxZeqUmb1cr+AWTTFTZl58C3COGFlC
	 /n0MGqkRtGRIIij6ZVc5qrPtL+0ne408l9slyUoXOnK8hAD5q1e2Kuxx6Ly386R+tF
	 k/70z3f/NsXcrK5FLGr0kmaS3JIUBiA1mKbmmbJpUG4JrhjpJiPPrLY/7XLlTarxNa
	 m4Ek+gFBTyXa9Is/70k+/I60MdwMeToo+5tONNylPw9bCZ3uTRAvDsxXkYcsCHtqxp
	 2IZ7duUOGEDOA==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [192.168.1.113] (d54c12615.access.telenet.be [84.193.38.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id 4FD986000E;
	Wed, 13 Mar 2024 20:50:02 +0100 (CET)
Message-ID: <ffebc235-c0a2-4d9d-8428-9592811994eb@esat.kuleuven.be>
Date: Wed, 13 Mar 2024 20:50:01 +0100
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
 <80c412ac-ea74-4836-9dae-8be6e3aec0e6@esat.kuleuven.be>
 <63a2600a-b916-4bb2-967a-4eaa8a143e35@oracle.com>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
In-Reply-To: <63a2600a-b916-4bb2-967a-4eaa8a143e35@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 3/13/24 19:44, Dai Ngo wrote:
>
> On 3/12/24 11:23 AM, Rik Theys wrote:
>> Hi,
>>
>> On 3/12/24 17:43, Dai Ngo wrote:
>>>
>>> On 3/12/24 4:37 AM, Jeff Layton wrote:
>>>> On Mon, 2024-03-11 at 19:43 +0100, Rik Theys wrote:
>>>>>
>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>>
>>>>>
>>>>> Since a few weeks our Rocky Linux 9 NFS server has periodically 
>>>>> logged hung nfsd tasks. The initial effect was that some clients 
>>>>> could no longer access the NFS server. This got worse and worse 
>>>>> (probably as more nfsd threads got blocked) and we had to restart 
>>>>> the server. Restarting the server also failed as the NFS server 
>>>>> service could no longer be stopped.
>>>>>
>>>>>
>>>>>
>>>>> The initial kernel we noticed this behavior on was 
>>>>> kernel-5.14.0-362.18.1.el9_3.x86_64. Since then we've installed 
>>>>> kernel-5.14.0-419.el9.x86_64 from CentOS Stream 9. The same issue 
>>>>> happened again on this newer kernel version:
>>>>>
>>>>>
>>>>>
>>>>> [Mon Mar 11 14:10:08 2024]       Not tainted 5.14.0-419.el9.x86_64 #1
>>>>>   [Mon Mar 11 14:10:08 2024] "echo 0 > 
>>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>   [Mon Mar 11 14:10:08 2024] task:nfsd            state:D stack:0 
>>>>>     pid:8865  ppid:2      flags:0x00004000
>>>>>   [Mon Mar 11 14:10:08 2024] Call Trace:
>>>>>   [Mon Mar 11 14:10:08 2024]  <TASK>
>>>>>   [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>>>>   [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>>>>   [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>>>>   [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>>>>   [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>>>>   [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>>>>   [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_shutdown_callback+0x49/0x120 
>>>>> [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_cld_remove+0x54/0x1d0 [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  ? 
>>>>> nfsd4_return_all_client_layouts+0xc4/0xf0 [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_shutdown_copy+0x68/0xc0 [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  __destroy_client+0x1f3/0x290 [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_exchange_id+0x75f/0x770 [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_decode_opaque+0x3a/0x90 [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>>>>   [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>>>>   [Mon Mar 11 14:10:08 2024]  </TASK>
>>>>>   [Mon Mar 11 14:10:08 2024] INFO: task nfsd:8866 blocked for more 
>>>>> than 122 seconds.
>>>>>   [Mon Mar 11 14:10:08 2024]       Not tainted 
>>>>> 5.14.0-419.el9.x86_64 #1
>>>>>   [Mon Mar 11 14:10:08 2024] "echo 0 > 
>>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>   [Mon Mar 11 14:10:08 2024] task:nfsd            state:D stack:0 
>>>>>     pid:8866  ppid:2      flags:0x00004000
>>>>>   [Mon Mar 11 14:10:08 2024] Call Trace:
>>>>>   [Mon Mar 11 14:10:08 2024]  <TASK>
>>>>>   [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>>>>   [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>>>>   [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>>>>   [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>>>>   [Mon Mar 11 14:10:08 2024]  ? tcp_recvmsg+0x196/0x210
>>>>>   [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>>>>   [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>>>>   [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_destroy_session+0x1a4/0x240 
>>>>> [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>>   [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>>   [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>>>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>>>>   [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>>>>   [Mon Mar 11 14:10:08 2024]  </TASK>
>>>>>
>>>>>
>>>>>
>>>>>   The above is repeated a few times, and then this warning is also 
>>>>> logged:
>>>>>
>>>>>
>>>>>
>>>>> [Mon Mar 11 14:12:04 2024] ------------[ cut here ]------------
>>>>>   [Mon Mar 11 14:12:04 2024] WARNING: CPU: 39 PID: 8844 at 
>>>>> fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>>   [Mon Mar 11 14:12:05 2024] Modules linked in: nfsv4 dns_resolver 
>>>>> nfs fscache netfs rpcsec_gss_krb5 rpcrdma rdma_cm iw_cm ib_cm 
>>>>> ib_core binfmt_misc bonding tls rfkill nft_counter nft_ct
>>>>>   nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_reject_inet 
>>>>> nf_reject_ipv4 nf_reject_ipv6 nft_reject nf_tables nfnetlink vfat 
>>>>> fat dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio l
>>>>>   ibcrc32c dm_service_time dm_multipath intel_rapl_msr 
>>>>> intel_rapl_common intel_uncore_frequency 
>>>>> intel_uncore_frequency_common isst_if_common skx_edac nfit 
>>>>> libnvdimm ipmi_ssif x86_pkg_temp
>>>>>   _thermal intel_powerclamp coretemp kvm_intel kvm irqbypass 
>>>>> dcdbas rapl intel_cstate mgag200 i2c_algo_bit drm_shmem_helper 
>>>>> dell_smbios drm_kms_helper dell_wmi_descriptor wmi_bmof intel_u
>>>>>   ncore syscopyarea pcspkr sysfillrect mei_me sysimgblt acpi_ipmi 
>>>>> mei fb_sys_fops i2c_i801 ipmi_si intel_pch_thermal lpc_ich 
>>>>> ipmi_devintf i2c_smbus ipmi_msghandler joydev acpi_power_meter
>>>>>   nfsd auth_rpcgss nfs_acl drm lockd grace fuse sunrpc ext4 
>>>>> mbcache jbd2 sd_mod sg lpfc
>>>>>   [Mon Mar 11 14:12:05 2024]  nvmet_fc nvmet nvme_fc nvme_fabrics 
>>>>> crct10dif_pclmul ahci libahci crc32_pclmul nvme_core crc32c_intel 
>>>>> ixgbe megaraid_sas libata nvme_common ghash_clmulni_int
>>>>>   el t10_pi wdat_wdt scsi_transport_fc mdio wmi dca dm_mirror 
>>>>> dm_region_hash dm_log dm_mod
>>>>>   [Mon Mar 11 14:12:05 2024] CPU: 39 PID: 8844 Comm: nfsd Not 
>>>>> tainted 5.14.0-419.el9.x86_64 #1
>>>>>   [Mon Mar 11 14:12:05 2024] Hardware name: Dell Inc. PowerEdge 
>>>>> R740/00WGD1, BIOS 2.20.1 09/13/2023
>>>>>   [Mon Mar 11 14:12:05 2024] RIP: 
>>>>> 0010:nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>>   [Mon Mar 11 14:12:05 2024] Code: a6 95 c5 f3 e9 ff fe ff ff 48 
>>>>> 89 df be 01 00 00 00 e8 34 b5 13 f4 48 8d bb 98 00 00 00 e8 c8 f9 
>>>>> 00 00 84 c0 0f 85 2e ff ff ff <0f> 0b e9 27 ff ff ff be
>>>>>   02 00 00 00 48 89 df e8 0c b5 13 f4 e9 01
>>>>>   [Mon Mar 11 14:12:05 2024] RSP: 0018:ffff9929e0bb7b80 EFLAGS: 
>>>>> 00010246
>>>>>   [Mon Mar 11 14:12:05 2024] RAX: 0000000000000000 RBX: 
>>>>> ffff8ada51930900 RCX: 0000000000000024
>>>>>   [Mon Mar 11 14:12:05 2024] RDX: ffff8ada519309c8 RSI: 
>>>>> ffff8ad582933c00 RDI: 0000000000002000
>>>>>   [Mon Mar 11 14:12:05 2024] RBP: ffff8ad46bf21574 R08: 
>>>>> ffff9929e0bb7b48 R09: 0000000000000000
>>>>>   [Mon Mar 11 14:12:05 2024] R10: ffff8aec859a2948 R11: 
>>>>> 0000000000000000 R12: ffff8ad6f497c360
>>>>>   [Mon Mar 11 14:12:05 2024] R13: ffff8ad46bf21560 R14: 
>>>>> ffff8ae5942e0b10 R15: ffff8ad6f497c360
>>>>>   [Mon Mar 11 14:12:05 2024] FS:  0000000000000000(0000) 
>>>>> GS:ffff8b031fcc0000(0000) knlGS:0000000000000000
>>>>>   [Mon Mar 11 14:12:05 2024] CS:  0010 DS: 0000 ES: 0000 CR0: 
>>>>> 0000000080050033
>>>>>   [Mon Mar 11 14:12:05 2024] CR2: 00007fafe2060744 CR3: 
>>>>> 00000018e58de006 CR4: 00000000007706e0
>>>>>   [Mon Mar 11 14:12:05 2024] DR0: 0000000000000000 DR1: 
>>>>> 0000000000000000 DR2: 0000000000000000
>>>>>   [Mon Mar 11 14:12:05 2024] DR3: 0000000000000000 DR6: 
>>>>> 00000000fffe0ff0 DR7: 0000000000000400
>>>>>   [Mon Mar 11 14:12:05 2024] PKRU: 55555554
>>>>>   [Mon Mar 11 14:12:05 2024] Call Trace:
>>>>>   [Mon Mar 11 14:12:05 2024]  <TASK>
>>>>>   [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>>>>   [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>>>>   [Mon Mar 11 14:12:05 2024]  ? __break_lease+0x16f/0x5f0
>>>>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 
>>>>> [nfsd]
>>>>>   [Mon Mar 11 14:12:05 2024]  ? __warn+0x81/0x110
>>>>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 
>>>>> [nfsd]
>>>>>   [Mon Mar 11 14:12:05 2024]  ? report_bug+0x10a/0x140
>>>>>   [Mon Mar 11 14:12:05 2024]  ? handle_bug+0x3c/0x70
>>>>>   [Mon Mar 11 14:12:05 2024]  ? exc_invalid_op+0x14/0x70
>>>>>   [Mon Mar 11 14:12:05 2024]  ? asm_exc_invalid_op+0x16/0x20
>>>>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 
>>>>> [nfsd]
>>>>>   [Mon Mar 11 14:12:05 2024]  __break_lease+0x16f/0x5f0
>>>>>   [Mon Mar 11 14:12:05 2024]  ? 
>>>>> nfsd_file_lookup_locked+0x117/0x160 [nfsd]
>>>>>   [Mon Mar 11 14:12:05 2024]  ? list_lru_del+0x101/0x150
>>>>>   [Mon Mar 11 14:12:05 2024]  nfsd_file_do_acquire+0x790/0x830 [nfsd]
>>>>>   [Mon Mar 11 14:12:05 2024]  nfs4_get_vfs_file+0x315/0x3a0 [nfsd]
>>>>>   [Mon Mar 11 14:12:05 2024]  nfsd4_process_open2+0x430/0xa30 [nfsd]
>>>>>   [Mon Mar 11 14:12:05 2024]  ? fh_verify+0x297/0x2f0 [nfsd]
>>>>>   [Mon Mar 11 14:12:05 2024]  nfsd4_open+0x3ce/0x4b0 [nfsd]
>>>>>   [Mon Mar 11 14:12:05 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>>   [Mon Mar 11 14:12:05 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>>   [Mon Mar 11 14:12:05 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>>>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>>   [Mon Mar 11 14:12:05 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>>   [Mon Mar 11 14:12:05 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>>   [Mon Mar 11 14:12:05 2024]  kthread+0xdd/0x100
>>>>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_kthread+0x10/0x10
>>>>>   [Mon Mar 11 14:12:05 2024]  ret_from_fork+0x29/0x50
>>>>>   [Mon Mar 11 14:12:05 2024]  </TASK>
>>>>>   [Mon Mar 11 14:12:05 2024] ---[ end trace 7a039e17443dc651 ]---
>>>> [Mon Mar 11 14:29:16 2024] task:kworker/u96:3   state:D stack:0     
>>>> pid:2451130 ppid:2      flags:0x00004000
>>>> [Mon Mar 11 14:29:16 2024] Workqueue: nfsd4_callbacks 
>>>> nfsd4_run_cb_work [nfsd]
>>>> [Mon Mar 11 14:29:16 2024] Call Trace:
>>>> [Mon Mar 11 14:29:16 2024]  <TASK>
>>>> [Mon Mar 11 14:29:16 2024]  __schedule+0x21b/0x550
>>>> [Mon Mar 11 14:29:16 2024]  schedule+0x2d/0x70
>>>> [Mon Mar 11 14:29:16 2024]  schedule_timeout+0x88/0x160
>>>> [Mon Mar 11 14:29:16 2024]  ? __pfx_process_timeout+0x10/0x10
>>>> [Mon Mar 11 14:29:16 2024]  rpc_shutdown_client+0xb3/0x150 [sunrpc]
>>>> [Mon Mar 11 14:29:16 2024]  ? __pfx_autoremove_wake_function+0x10/0x10
>>>> [Mon Mar 11 14:29:16 2024] nfsd4_process_cb_update+0x3e/0x260 [nfsd]
>>>> [Mon Mar 11 14:29:16 2024]  ? sched_clock+0xc/0x30
>>>> [Mon Mar 11 14:29:16 2024]  ? raw_spin_rq_lock_nested+0x19/0x80
>>>> [Mon Mar 11 14:29:16 2024]  ? newidle_balance+0x26e/0x400
>>>> [Mon Mar 11 14:29:16 2024]  ? pick_next_task_fair+0x41/0x500
>>>> [Mon Mar 11 14:29:16 2024]  ? put_prev_task_fair+0x1e/0x40
>>>> [Mon Mar 11 14:29:16 2024]  ? pick_next_task+0x861/0x950
>>>> [Mon Mar 11 14:29:16 2024]  ? __update_idle_core+0x23/0xc0
>>>> [Mon Mar 11 14:29:16 2024]  ? __switch_to_asm+0x3a/0x80
>>>> [Mon Mar 11 14:29:16 2024]  ? finish_task_switch.isra.0+0x8c/0x2a0
>>>> [Mon Mar 11 14:29:16 2024]  nfsd4_run_cb_work+0x9f/0x150 [nfsd]
>>>> [Mon Mar 11 14:29:16 2024]  process_one_work+0x1e2/0x3b0
>>>> [Mon Mar 11 14:29:16 2024]  worker_thread+0x50/0x3a0
>>>> [Mon Mar 11 14:29:16 2024]  ? __pfx_worker_thread+0x10/0x10
>>>> [Mon Mar 11 14:29:16 2024]  kthread+0xdd/0x100
>>>> [Mon Mar 11 14:29:16 2024]  ? __pfx_kthread+0x10/0x10
>>>> [Mon Mar 11 14:29:16 2024]  ret_from_fork+0x29/0x50
>>>> [Mon Mar 11 14:29:16 2024]  </TASK>
>>>>
>>>> The above is the main task that I see in the cb workqueue. It's 
>>>> trying to call rpc_shutdown_client, which is waiting for this:
>>>>
>>>>                  wait_event_timeout(destroy_wait,
>>>>                          list_empty(&clnt->cl_tasks), 1*HZ);
>>>>
>>>> ...so basically waiting for the cl_tasks list to go empty. It 
>>>> repeatedly
>>>> does a rpc_killall_tasks though, so possibly trying to kill this task?
>>>>
>>>>      18423 2281      0 0x18 0x0     1354 nfsd4_cb_ops [nfsd] 
>>>> nfs4_cbv1 CB_RECALL_ANY a:call_start [sunrpc] q:delayq
>>>
>>> I wonder why this task is on delayq. Could it be related to memory
>>> shortage issue, or connection related problems?
>>> Output of /proc/meminfo on the nfs server at time of the problem
>>> would shed some light.
>>
>> We don't have that anymore. I can check our monitoring host more 
>> closely for more fine grained stats tomorrow, but when I look at the 
>> sar statistics (see attachment) nothing special was going on memory 
>> or network wise.
>
> Thanks Rik for the info.
>
> At 2:10 PM sar statistics shows:
> kbmemfree:  1014880
> kbavail:    170836368
> kbmemused:  2160028
> %memused:   1.10
> kbcached:   140151288
>
> Paging stats:
>               pgpgin/s pgpgout/s   fault/s  majflt/s  pgfree/s 
> pgscank/s pgscand/s pgsteal/s    %vmeff
> 02:10:00 PM   2577.67 491251.09   2247.01      0.00 2415029.61 
> 75131.80      0.00 150276.28    200.02
>
> The kbmemfree is pretty low and the caches consume large amount of 
> memory.
> The paging statistics also show lots of paging activities, 150276.28/s.
>
The workload at that time was a write-heavy workload. The writes were 
probably all going to memory until the buffers filled up (or the ext4 
commit interval?) and was then written out to disk. And then the process 
repeated itself as a large part of the writes were rewriting the same 
files over and over again.
> In the previous rpc_tasks.txt, it shows a RPC task is on the delayq 
> waiting
> to send the CB_RECALL_ANY. With this version of the kernel, the only time
> CB_RECALL_ANY is sent is when the system is under memory pressure and the
> nfsd shrinker task runs to free unused delegations.

Would it help to increase /proc/sys/vm/min_free_kbytes in this case?


> Next time when this problem happens again, you can try to reclaim some
> memory from the caches to see if it helps:
>
> # echo 3 > /proc/sys/vm/drop_caches

Do you think this could help the system recover at that point?

Regards,

Rik

>
> -Dai
>
>
>
>
>>
>> We start to get the cpu stall messages and the system load starts to 
>> rise (starts around 2:10 PM). At 3:00 PM we restart the server as our 
>> users can no longer work.
>>
>> Looking at the stats, the cpu's were ~idle. The only thing that may 
>> be related is that around 11:30 AM the write load (rx packets) starts 
>> to get a lot higher than the read load (tx packets). This goes on for 
>> hours (even after the server was restarted) and that workload was 
>> later identified. It was a workload that was constantly rewriting a 
>> statistics file.
>>
>> Regards,
>>
>> Rik
>>
>>
>>>
>>> Currently there is only 1 active task allowed for the nfsd callback
>>> workqueue at a time. If for some reasons a callback task is stuck in
>>> the workqueue it will block all other callback tasks which can effect
>>> multiple clients.
>>>
>>> -Dai
>>>
>>>>
>>>> Callbacks are soft RPC tasks though, so they should be easily 
>>>> killable.
>>
-- 
Rik Theys
System Engineer
KU Leuven - Dept. Elektrotechniek (ESAT)
Kasteelpark Arenberg 10 bus 2440  - B-3001 Leuven-Heverlee
+32(0)16/32.11.07
----------------------------------------------------------------
<<Any errors in spelling, tact or fact are transmission errors>>


