Return-Path: <linux-nfs+bounces-2387-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F6487F89B
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 08:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5435EB213C7
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 07:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077191E536;
	Tue, 19 Mar 2024 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="hdU4jM7M";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="gGlknl0L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [134.58.240.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24104535D2
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835111; cv=none; b=rljFU9EkUZJTvuIMkOFbyZ2l5NIX0DcFdnZSFwh/PCmrwPn9lHkZlwUP/7kiEPwoieb5sRWqeYHZQvwH9go6buPoIFRtGVI5xHu/O4N/0R/convHt7mh7Qspre0oE0ztHBQO/odyt11tsHCOuKTZdSo5ZMk1H+TeLfA6tAR9rDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835111; c=relaxed/simple;
	bh=dnpJxsJfOfid2Y0Vjn6YMlqzLTYc0QwkVhjteRG2NaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bFc4UzTt4ZswseIDmLY/zSKmQOLPqPsD9CsOHDOlayErrSeRN2Dj5fL7+fMQ5W9afrvR50J5HJnyhA3VAcfnjikMWY/q1Ij8Pti4vKcPESjTG4lwy4bONt29IqiwxXRjWijFB5xuHDORiRcjkfmjsAvuTTswTXQAJ0YJ5VJDJkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=hdU4jM7M; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=gGlknl0L; arc=none smtp.client-ip=134.58.240.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: A2B9C33.A6E42
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:133:242:ac11:1c])
	by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id A2B9C33;
	Tue, 19 Mar 2024 08:58:16 +0100 (CET)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#EXTORTION_39_BITCOINADDRESS#2.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1710835096;
	bh=UkYW0fHCIVRBRXC3eBwKj+UB5+8XgNNjYmpJkhtx5Z4=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=hdU4jM7M1HJs05po48kADukCLkVLRDGwNpM+A8NdTcG9/g88n5uXZv6RW25H3CxU9
	 Byz2ZNIHM7mcWmFcrwjla6Nzu0NETsrsNLpNkF4KKkRNCkx8L4dx6902lahAld0jKv
	 3TapexOtC4AK7M4nPXZPRuwfE46zEnv163AeD3vlredDf6XovsCkORfZdRdVRqfMOD
	 7TeagcKporcejo7Ky0UgUbD2x5s8TLi4/Ufc5lLKVMctfXp1kCd6i5ibp+c06snwBG
	 3EGuwv/X4eRk4ZYKFJDaMSZEpAu3d08iy0KYiA1gB4mZ9sswuJC5aM/X5RGxi8TiYD
	 xjoJ2aWCI+0eQ==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPS id 2FF62D4F4D4F1;
	Tue, 19 Mar 2024 08:58:16 +0100 (CET)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1710835096;
	bh=UkYW0fHCIVRBRXC3eBwKj+UB5+8XgNNjYmpJkhtx5Z4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=gGlknl0LykckZstIONbP25peR5B390hKx8K08TRgkdNPPdreZbsLVfo/wSrW1PV/N
	 XJdcE1NfJg1CjEceWoyMvdoyYsR6L71aYvrZoDRcxlCe8T806ZmZAmRawtbg05o1z5
	 bteVsavVoHcZmzy4PIm+3nHQe1fX77FolnhmD0qTzdWqfyjoLZ8voLo21ST/f0HXqS
	 URSZUy93BGuKE/XBreatxc5eJxI+NLU/GdGmSKIFuwwgGvI0mAK6xf6FqAhYg/Uthj
	 PKFN1FyhRmAkcxEStXRtIEWzNRaQKXaVb9YG57SBI94a79M+uvZrJ4lcbccOZshmUU
	 z1qiSnY0Kl2dA==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [192.168.1.178] (d54C12615.access.telenet.be [84.193.38.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id 125F56000E;
	Tue, 19 Mar 2024 08:58:16 +0100 (CET)
Message-ID: <c7dbc796-7e7d-4041-ac71-eea02a701b12@esat.kuleuven.be>
Date: Tue, 19 Mar 2024 08:58:15 +0100
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
References: <66c98f4c-5e52-4fa3-8a2c-9379cfec2a9a@esat.kuleuven.be>
 <44c2101e756f7c3b876fb9c58da3ebd089dc14d5.camel@kernel.org>
 <e3ba6e04-ea06-4035-8546-639f11d6b79c@esat.kuleuven.be>
 <41325088-aa6d-4dcf-b105-8994350168c3@esat.kuleuven.be>
 <7d244882d769e377b06f39234bd5ee7dddb72a55.camel@kernel.org>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
In-Reply-To: <7d244882d769e377b06f39234bd5ee7dddb72a55.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 3/18/24 22:54, Jeff Layton wrote:
> On Mon, 2024-03-18 at 22:15 +0100, Rik Theys wrote:
>> Hi,
>>
>> On 3/18/24 21:21, Rik Theys wrote:
>>> Hi Jeff,
>>>
>>> On 3/12/24 13:47, Jeff Layton wrote:
>>>> On Tue, 2024-03-12 at 13:24 +0100, Rik Theys wrote:
>>>>> Hi Jeff,
>>>>>
>>>>> On 3/12/24 12:22, Jeff Layton wrote:
>>>>>> On Mon, 2024-03-11 at 19:43 +0100, Rik Theys wrote:
>>>>>>> Since a few weeks our Rocky Linux 9 NFS server has periodically
>>>>>>> logged hung nfsd tasks. The initial effect was that some clients
>>>>>>> could no longer access the NFS server. This got worse and worse
>>>>>>> (probably as more nfsd threads got blocked) and we had to restart
>>>>>>> the server. Restarting the server also failed as the NFS server
>>>>>>> service could no longer be stopped.
>>>>>>>
>>>>>>> The initial kernel we noticed this behavior on was
>>>>>>> kernel-5.14.0-362.18.1.el9_3.x86_64. Since then we've installed
>>>>>>> kernel-5.14.0-419.el9.x86_64 from CentOS Stream 9. The same issue
>>>>>>> happened again on this newer kernel version:
>>>> 419 is fairly up to date with nfsd changes. There are some known bugs
>>>> around callbacks, and there is a draft MR in flight to fix it.
>>>>
>>>> What kernel were you on prior to 5.14.0-362.18.1.el9_3.x86_64 ? If we
>>>> can bracket the changes around a particular version, then that might
>>>> help identify the problem.
>>>>
>>>>>>> [Mon Mar 11 14:10:08 2024]       Not tainted 5.14.0-419.el9.x86_64 #1
>>>>>>>     [Mon Mar 11 14:10:08 2024] "echo 0 >
>>>>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>>>     [Mon Mar 11 14:10:08 2024]task:nfsd             state:D stack:0
>>>>>>>      pid:8865  ppid:2      flags:0x00004000
>>>>>>>     [Mon Mar 11 14:10:08 2024] Call Trace:
>>>>>>>     [Mon Mar 11 14:10:08 2024]  <TASK>
>>>>>>>     [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>>>>>>     [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>>>>>>     [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>>>>>>     [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>>>>>>     [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd4_shutdown_callback+0x49/0x120
>>>>>>> [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? nfsd4_cld_remove+0x54/0x1d0 [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ?
>>>>>>> nfsd4_return_all_client_layouts+0xc4/0xf0 [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? nfsd4_shutdown_copy+0x68/0xc0 [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  __destroy_client+0x1f3/0x290 [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd4_exchange_id+0x75f/0x770 [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? nfsd4_decode_opaque+0x3a/0x90 [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660
>>>>>>> [sunrpc]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>>>>>>     [Mon Mar 11 14:10:08 2024]  </TASK>
>>>>>>>     [Mon Mar 11 14:10:08 2024] INFO: task nfsd:8866 blocked for
>>>>>>> more than 122 seconds.
>>>>>>>     [Mon Mar 11 14:10:08 2024]       Not tainted
>>>>>>> 5.14.0-419.el9.x86_64 #1
>>>>>>>     [Mon Mar 11 14:10:08 2024] "echo 0 >
>>>>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>>>     [Mon Mar 11 14:10:08 2024]task:nfsd             state:D stack:0
>>>>>>>      pid:8866  ppid:2      flags:0x00004000
>>>>>>>     [Mon Mar 11 14:10:08 2024] Call Trace:
>>>>>>>     [Mon Mar 11 14:10:08 2024]  <TASK>
>>>>>>>     [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>>>>>>     [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>>>>>>     [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? tcp_recvmsg+0x196/0x210
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>>>>>>     [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>>>>>>     [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd4_destroy_session+0x1a4/0x240
>>>>>>> [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660
>>>>>>> [sunrpc]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>>>>     [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>>>>>>     [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>>>>>>     [Mon Mar 11 14:10:08 2024]  </TASK>
>>>>>>>
>>>>>> The above threads are trying to flush the workqueue, so that probably
>>>>>> means that they are stuck waiting on a workqueue job to finish.
>>>>>>>     The above is repeated a few times, and then this warning is
>>>>>>> also logged:
>>>>>>>     [Mon Mar 11 14:12:04 2024] ------------[ cut here ]------------
>>>>>>>     [Mon Mar 11 14:12:04 2024] WARNING: CPU: 39 PID: 8844 at
>>>>>>> fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>>>>     [Mon Mar 11 14:12:05 2024] Modules linked in: nfsv4
>>>>>>> dns_resolver nfs fscache netfs rpcsec_gss_krb5 rpcrdma rdma_cm
>>>>>>> iw_cm ib_cm ib_core binfmt_misc bonding tls rfkill nft_counter nft_ct
>>>>>>>     nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_reject_inet
>>>>>>> nf_reject_ipv4 nf_reject_ipv6 nft_reject nf_tables nfnetlink vfat
>>>>>>> fat dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio l
>>>>>>>     ibcrc32c dm_service_time dm_multipath intel_rapl_msr
>>>>>>> intel_rapl_common intel_uncore_frequency
>>>>>>> intel_uncore_frequency_common isst_if_common skx_edac nfit
>>>>>>> libnvdimm ipmi_ssif x86_pkg_temp
>>>>>>>     _thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
>>>>>>> dcdbas rapl intel_cstate mgag200 i2c_algo_bit drm_shmem_helper
>>>>>>> dell_smbios drm_kms_helper dell_wmi_descriptor wmi_bmof intel_u
>>>>>>>     ncore syscopyarea pcspkr sysfillrect mei_me sysimgblt acpi_ipmi
>>>>>>> mei fb_sys_fops i2c_i801 ipmi_si intel_pch_thermal lpc_ich
>>>>>>> ipmi_devintf i2c_smbus ipmi_msghandler joydev acpi_power_meter
>>>>>>>     nfsd auth_rpcgss nfs_acl drm lockd grace fuse sunrpc ext4
>>>>>>> mbcache jbd2 sd_mod sg lpfc
>>>>>>>     [Mon Mar 11 14:12:05 2024]  nvmet_fc nvmet nvme_fc nvme_fabrics
>>>>>>> crct10dif_pclmul ahci libahci crc32_pclmul nvme_core crc32c_intel
>>>>>>> ixgbe megaraid_sas libata nvme_common ghash_clmulni_int
>>>>>>>     el t10_pi wdat_wdt scsi_transport_fc mdio wmi dca dm_mirror
>>>>>>> dm_region_hash dm_log dm_mod
>>>>>>>     [Mon Mar 11 14:12:05 2024] CPU: 39 PID: 8844 Comm: nfsd Not
>>>>>>> tainted 5.14.0-419.el9.x86_64 #1
>>>>>>>     [Mon Mar 11 14:12:05 2024] Hardware name: Dell Inc. PowerEdge
>>>>>>> R740/00WGD1, BIOS 2.20.1 09/13/2023
>>>>>>>     [Mon Mar 11 14:12:05 2024] RIP:
>>>>>>> 0010:nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>>>>>>     [Mon Mar 11 14:12:05 2024] Code: a6 95 c5 f3 e9 ff fe ff ff 48
>>>>>>> 89 df be 01 00 00 00 e8 34 b5 13 f4 48 8d bb 98 00 00 00 e8 c8 f9
>>>>>>> 00 00 84 c0 0f 85 2e ff ff ff <0f> 0b e9 27 ff ff ff be
>>>>>>>     02 00 00 00 48 89 df e8 0c b5 13 f4 e9 01
>>>>>>>     [Mon Mar 11 14:12:05 2024] RSP: 0018:ffff9929e0bb7b80 EFLAGS:
>>>>>>> 00010246
>>>>>>>     [Mon Mar 11 14:12:05 2024] RAX: 0000000000000000 RBX:
>>>>>>> ffff8ada51930900 RCX: 0000000000000024
>>>>>>>     [Mon Mar 11 14:12:05 2024] RDX: ffff8ada519309c8 RSI:
>>>>>>> ffff8ad582933c00 RDI: 0000000000002000
>>>>>>>     [Mon Mar 11 14:12:05 2024] RBP: ffff8ad46bf21574 R08:
>>>>>>> ffff9929e0bb7b48 R09: 0000000000000000
>>>>>>>     [Mon Mar 11 14:12:05 2024] R10: ffff8aec859a2948 R11:
>>>>>>> 0000000000000000 R12: ffff8ad6f497c360
>>>>>>>     [Mon Mar 11 14:12:05 2024] R13: ffff8ad46bf21560 R14:
>>>>>>> ffff8ae5942e0b10 R15: ffff8ad6f497c360
>>>>>>>     [Mon Mar 11 14:12:05 2024] FS:  0000000000000000(0000)
>>>>>>> GS:ffff8b031fcc0000(0000) knlGS:0000000000000000
>>>>>>>     [Mon Mar 11 14:12:05 2024] CS:  0010 DS: 0000 ES: 0000 CR0:
>>>>>>> 0000000080050033
>>>>>>>     [Mon Mar 11 14:12:05 2024] CR2: 00007fafe2060744 CR3:
>>>>>>> 00000018e58de006 CR4: 00000000007706e0
>>>>>>>     [Mon Mar 11 14:12:05 2024] DR0: 0000000000000000 DR1:
>>>>>>> 0000000000000000 DR2: 0000000000000000
>>>>>>>     [Mon Mar 11 14:12:05 2024] DR3: 0000000000000000 DR6:
>>>>>>> 00000000fffe0ff0 DR7: 0000000000000400
>>>>>>>     [Mon Mar 11 14:12:05 2024] PKRU: 55555554
>>>>>>>     [Mon Mar 11 14:12:05 2024] Call Trace:
>>>>>>>     [Mon Mar 11 14:12:05 2024]  <TASK>
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? __break_lease+0x16f/0x5f0
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190
>>>>>>> [nfsd]
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? __warn+0x81/0x110
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190
>>>>>>> [nfsd]
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? report_bug+0x10a/0x140
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? handle_bug+0x3c/0x70
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? exc_invalid_op+0x14/0x70
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? asm_exc_invalid_op+0x16/0x20
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190
>>>>>>> [nfsd]
>>>>>>>     [Mon Mar 11 14:12:05 2024]  __break_lease+0x16f/0x5f0
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ?
>>>>>>> nfsd_file_lookup_locked+0x117/0x160 [nfsd]
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? list_lru_del+0x101/0x150
>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfsd_file_do_acquire+0x790/0x830
>>>>>>> [nfsd]
>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfs4_get_vfs_file+0x315/0x3a0 [nfsd]
>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfsd4_process_open2+0x430/0xa30 [nfsd]
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? fh_verify+0x297/0x2f0 [nfsd]
>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfsd4_open+0x3ce/0x4b0 [nfsd]
>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>>>>>>     [Mon Mar 11 14:12:05 2024]  svc_process_common+0x2ec/0x660
>>>>>>> [sunrpc]
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>>>>     [Mon Mar 11 14:12:05 2024]  svc_process+0x12d/0x170 [sunrpc]
>>>>>>>     [Mon Mar 11 14:12:05 2024]  nfsd+0x84/0xb0 [nfsd]
>>>>>>>     [Mon Mar 11 14:12:05 2024]  kthread+0xdd/0x100
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ? __pfx_kthread+0x10/0x10
>>>>>>>     [Mon Mar 11 14:12:05 2024]  ret_from_fork+0x29/0x50
>>>>>>>     [Mon Mar 11 14:12:05 2024]  </TASK>
>>>>>>>     [Mon Mar 11 14:12:05 2024] ---[ end trace 7a039e17443dc651 ]---
>>>>>> This is probably this WARN in nfsd_break_one_deleg:
>>>>>>
>>>>>> WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
>>>>>>
>>>>>> It means that a delegation break callback to the client couldn't be
>>>>>> queued to the workqueue, and so it didn't run.
>>>>>>
>>>>>>> Could this be the same issue as described
>>>>>>> here:https://lore.kernel.org/linux-nfs/af0ec881-5ebf-4feb-98ae-3ed2a77f86f1@oracle.com/
>>>>>>> ?
>>>>>> Yes, most likely the same problem.
>>>>> If I read that thread correctly, this issue was introduced between
>>>>> 6.1.63 and 6.6.3? Is it possible the EL9 5.14.0-362.18.1.el9_3
>>>>> backported these changes, or were we hitting some other bug with that
>>>>> version? It seems the 6.1.x kernel is not affected? If so, that
>>>>> would be
>>>>> the recommended kernel to run?
>>>> Anything is possible. We have to identify the problem first.
>>>>>>> As described in that thread, I've tried to obtain the requested
>>>>>>> information.
>>>>>>>
>>>>>>> Is it possible this is the issue that was fixed by the patches
>>>>>>> described
>>>>>>> here?https://lore.kernel.org/linux-nfs/2024022054-cause-suffering-eae8@gregkh/
>>>>>>>
>>>>>> Doubtful. Those are targeted toward a different set of issues.
>>>>>>
>>>>>> If you're willing, I do have some patches queued up for CentOS here
>>>>>> that
>>>>>> fix some backchannel problems that could be related. I'm mainly
>>>>>> waiting
>>>>>> on Chuck to send these to Linus and then we'll likely merge them into
>>>>>> CentOS soon afterward:
>>>>>>
>>>>>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3689
>>>>>>
>>>>>>
>>>>> If you can send me a patch file, I can rebuild the C9S kernel with that
>>>>> patch and run it. It can take a while for the bug to trigger as I
>>>>> believe it seems to be very workload dependent (we were running very
>>>>> stable for months and now hit this bug every other week).
>>>>>
>>>>>
>>>> It's probably simpler to just pull down the build artifacts for that MR.
>>>> You have to drill down through the CI for it, but they are here:
>>>>
>>>> https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/index.html?prefix=trusted-artifacts/1194300175/publish_x86_64/6278921877/artifacts/
>>>>
>>>>
>>>> There's even a repo file you can install on the box to pull them down.
>>> We installed this kernel on the server 3 days ago. Today, a user
>>> informed us that their screen was black after logging in. Similar to
>>> other occurrences of this issue, the mount command on the client was
>>> hung. But in contrast to the other times, there were no messages in
>>> the logs kernel logs on the server. Even restarting the client does
>>> not resolve the issue.
>
> Ok, so you rebooted the client and it's still unable to mount? That
> sounds like a server problem if so.
>
> Are both client and server running the same kernel?
No, the server runs 5.14.0-427.3689_1194299994.el9 and the client 
5.14.0-362.18.1.el9_3.
>
>>> Something still seems to be wrong on the server though. When I look at
>>> the directories under /proc/fs/nfsd/clients, there's still a directory
>>> for the specific client, even though it's no longer running:
>>>
>>> # cat 155/info
>>> clientid: 0xc8edb7f65f4a9ad
>>> address: "10.87.31.152:819"
>>> status: confirmed
>>> seconds from last renew: 33163
>>> name: "Linux NFSv4.2 bersalis.esat.kuleuven.be"
>>> minor version: 2
>>> Implementation domain: "kernel.org"
>>> Implementation name: "Linux 5.14.0-362.18.1.el9_3.0.1.x86_64 #1 SMP
>>> PREEMPT_DYNAMIC Sun Feb 11 13:49:23 UTC 2024 x86_64"
>>> Implementation time: [0, 0]
>>> callback state: DOWN
>>> callback address: 10.87.31.152:0
>>>
> If you just shut down the client, the server won't immediately purge its
> record. In fact, assuming you're running the same kernel on the server,
> it won't purge the client record until there is a conflicting request
> for its state.
Is there a way to force such a conflicting request (to get the client 
record to purge)?
>
>
>> The nfsdclnts command for this client shows the following delegations:
>>
>> # nfsdclnts -f 155/states -t all
>> Inode number | Type   | Access | Deny | ip address            | Filename
>> 169346743    | open   | r-     | --   | 10.87.31.152:819      |
>> disconnected dentry
>> 169346743    | deleg  | r      |      | 10.87.31.152:819      |
>> disconnected dentry
>> 169346746    | open   | r-     | --   | 10.87.31.152:819      |
>> disconnected dentry
>> 169346746    | deleg  | r      |      | 10.87.31.152:819      |
>> disconnected dentry
>>
>> I see a lot of recent patches regarding directory delegations. Could
>> this be related to this?
>>
>> Will a 5.14.0-362.18.1.el9_3.0.1 kernel try to use a directory delegation?
>>
>>
> No. Directory delegations are a new feature that's still under
> development. They use some of the same machinery as file delegations,
> but they wouldn't be a factor here.
>
>>> The system seems to have identified that the client is no longer
>>> reachable, but the client entry does not go away. When a mount was
>>> hanging on the client, there would be two directories in clients for
>>> the same client. Killing the mount command clears up the second entry.
>>>
>>> Even after running conntrack -D on the server to remove the tcp
>>> connection from the conntrack table, the entry doesn't go away and the
>>> client still can not mount anything from the server.
>>>
>>> A tcpdump on the client while a mount was running logged the following
>>> messages over and over again:
>>>
>>> request:
>>>
>>> Frame 1: 378 bytes on wire (3024 bits), 378 bytes captured (3024 bits)
>>> Ethernet II, Src: HP_19:7d:4b (e0:73:e7:19:7d:4b), Dst:
>>> ArubaaHe_f9:8e:00 (88:3a:30:f9:8e:00)
>>> Internet Protocol Version 4, Src: 10.87.31.152, Dst: 10.86.18.14
>>> Transmission Control Protocol, Src Port: 932, Dst Port: 2049, Seq: 1,
>>> Ack: 1, Len: 312
>>> Remote Procedure Call, Type:Call XID:0x1d3220c4
>>> Network File System
>>>      [Program Version: 4]
>>>      [V4 Procedure: COMPOUND (1)]
>>>      GSS Data, Ops(1): CREATE_SESSION
>>>          Length: 152
>>>          GSS Sequence Number: 76
>>>          Tag: <EMPTY>
>>>          minorversion: 2
>>>          Operations (count: 1): CREATE_SESSION
>>>          [Main Opcode: CREATE_SESSION (43)]
>>>      GSS Checksum:
>>> 00000028040404ffffffffff000000002c19055f1f8d442d594c13849628affc2797cbb2…
>>>          GSS Token Length: 40
>>>          GSS-API Generic Security Service Application Program Interface
>>>              krb5_blob:
>>> 040404ffffffffff000000002c19055f1f8d442d594c13849628affc2797cbb23fa080b0…
>>>
>>> response:
>>>
>>> Frame 2: 206 bytes on wire (1648 bits), 206 bytes captured (1648 bits)
>>> Ethernet II, Src: ArubaaHe_f9:8e:00 (88:3a:30:f9:8e:00), Dst:
>>> HP_19:7d:4b (e0:73:e7:19:7d:4b)
>>> Internet Protocol Version 4, Src: 10.86.18.14, Dst: 10.87.31.152
>>> Transmission Control Protocol, Src Port: 2049, Dst Port: 932, Seq: 1,
>>> Ack: 313, Len: 140
>>> Remote Procedure Call, Type:Reply XID:0x1d3220c4
>>> Network File System
>>>      [Program Version: 4]
>>>      [V4 Procedure: COMPOUND (1)]
>>>      GSS Data, Ops(1): CREATE_SESSION(NFS4ERR_DELAY)
>>>          Length: 24
>>>          GSS Sequence Number: 76
>>>          Status: NFS4ERR_DELAY (10008)
>>>          Tag: <EMPTY>
>>>          Operations (count: 1)
>>>          [Main Opcode: CREATE_SESSION (43)]
>>>      GSS Checksum:
>>> 00000028040405ffffffffff000000000aa742d0798deaad1a8aa2d7c3a91bf4f6274222…
>>>          GSS Token Length: 40
>>>          GSS-API Generic Security Service Application Program Interface
>>>              krb5_blob:
>>> 040405ffffffffff000000000aa742d0798deaad1a8aa2d7c3a91bf4f627422226d74923…
>>>
>>> I was hoping that giving the client a different IP address would
>>> resolve the issue for this client, but it didn't. Even though the
>>> client had a new IP address (hostname was kept the same), it failed to
>>> mount anything from the server.
>>>
> Changing the IP address won't help. The client is probably using the
> same long-form client id as before, so the server still identifies the
> client even with the address change.
How is the client id determined? Will changing the hostname of the 
client trigger a change of the client id?
>
> Unfortunately, the cause of an NFS4ERR_DELAY error is tough to guess.
> The client is expected to back off and retry, so if the server keeps
> returning that repeatedly, then a hung mount command is expected.
>
> The question is why the server would keep returning DELAY. A lot of
> different problems ranging from memory allocation issues to protocol
> problems can result in that error. You may want to check the NFS server
> and see if anything was logged there.
There are no messages in the system logs that indicate any sort of 
memory issue. We also increased the min_kbytes_free sysctl to 2G on the 
server before we restarted it with the newer kernel.
>
> This is on a CREATE_SESSION call, so I wonder if the record held by the
> (courteous) server is somehow blocking the attempt to reestablish the
> session?
>
> Do you have a way to reproduce this? Since this is a centos kernel, you
> could follow the page here to open a bug:

Unfortunately we haven't found a reliable way to reproduce it. But we do 
seem to trigger it more and more lately.

Regards,

Rik

>
>      https://wiki.centos.org/ReportBugs.html
>
>
>>> I created another dump of the workqueues and worker pools on the server:
>>>
>>> [Mon Mar 18 14:59:33 2024] Showing busy workqueues and worker pools:
>>> [Mon Mar 18 14:59:33 2024] workqueue events: flags=0x0
>>> [Mon Mar 18 14:59:33 2024]   pwq 54: cpus=27 node=1 flags=0x0 nice=0
>>> active=1/256 refcnt=2
>>> [Mon Mar 18 14:59:33 2024]     pending: drm_fb_helper_damage_work
>>> [drm_kms_helper]
>>> [Mon Mar 18 14:59:33 2024] workqueue events_power_efficient: flags=0x80
>>> [Mon Mar 18 14:59:33 2024]   pwq 54: cpus=27 node=1 flags=0x0 nice=0
>>> active=1/256 refcnt=2
>>> [Mon Mar 18 14:59:33 2024]     pending: fb_flashcursor
>>> [Mon Mar 18 14:59:33 2024] workqueue mm_percpu_wq: flags=0x8
>>> [Mon Mar 18 14:59:33 2024]   pwq 54: cpus=27 node=1 flags=0x0 nice=0
>>> active=1/256 refcnt=3
>>> [Mon Mar 18 14:59:33 2024]     pending: lru_add_drain_per_cpu BAR(362)
>>> [Mon Mar 18 14:59:33 2024] workqueue kblockd: flags=0x18
>>> [Mon Mar 18 14:59:33 2024]   pwq 55: cpus=27 node=1 flags=0x0 nice=-20
>>> active=1/256 refcnt=2
>>> [Mon Mar 18 14:59:33 2024]     pending: blk_mq_timeout_work
>>>
>>>
>>> In contrast to last time, it doesn't show anything regarding nfs this
>>> time.
>>>
>>> I also tried the suggestion from Dai Ngo (echo 3 >
>>> /proc/sys/vm/drop_caches), but that didn't seem to make any difference.
>>>
>>> We haven't restarted the server yet as it seems the impact seems to
>>> affect fewer clients that before. Is there anything we can run on the
>>> server to further debug this?
>>>
>>> In the past, the issue seemed to deteriorate rapidly and resulted in
>>> issues for almost all clients after about 20 minutes. This time the
>>> impact seems to be less, but it's not gone.
>>>
>>> How can we force the NFS server to forget about a specific client? I
>>> haven't tried to restart the nfs service yet as I'm afraid it will
>>> fail to stop as before.
>>>
> Not with that kernel. There are some new administrative interfaces that
> might allow that in the future, but they were just merged upstream and
> aren't in that kernel.
>
> --
> Jeff Layton <jlayton@kernel.org>

-- 
Rik Theys
System Engineer
KU Leuven - Dept. Elektrotechniek (ESAT)
Kasteelpark Arenberg 10 bus 2440  - B-3001 Leuven-Heverlee
+32(0)16/32.11.07
----------------------------------------------------------------
<<Any errors in spelling, tact or fact are transmission errors>>


