Return-Path: <linux-nfs+bounces-2269-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9197E879422
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Mar 2024 13:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1C0286E74
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Mar 2024 12:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2A75B1E1;
	Tue, 12 Mar 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="R+2iItEK";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="yzUTjL8H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [134.58.240.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BA7A121
	for <linux-nfs@vger.kernel.org>; Tue, 12 Mar 2024 12:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710246305; cv=none; b=eQn4YMh6PqRHxdLTPaSE2GBqjX/hQ9x1VzjM5OkizGfKhmy1zL2JkVZf6G+Rsq9VLb3sD9i3oBqqgSz9VSTWLJMpTUv5wXIv1HBLOkIpHRg0kBfSsExftxzNoFcip6k9fNeX5lxy2fypFxXtpkrZ7W7Kzh3bwC7I9xnQY475WUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710246305; c=relaxed/simple;
	bh=St7D+Lgsj49GDx6xmPz4V/yQUcbwe1/m96+Z2LewvCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type; b=RdEMAAOGJ+0Cn+gy3OeVwuEhB5ybV5JZiRVycyHISQDb2zg4+tdGrkM5CeeyDsNsWd7YaIvldKFJCJEPd8+vkCbUjm8EUqijPJr6czyEWZ7X7X0vh23r3WsaWY5V/k/M+H0Wz+K18K87bG07rF1gbfhlbyzeDgjaMIICkv5eEVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=R+2iItEK; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=yzUTjL8H; arc=none smtp.client-ip=134.58.240.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 589A7201C4.A9247
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:133:242:ac11:1c])
	by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id 589A7201C4;
	Tue, 12 Mar 2024 13:24:55 +0100 (CET)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1710246295;
	bh=EDXZp51e/jRVSXZQRbPe0nnc/UqtKCH4YcB/Yi/1Oa0=;
	h=Date:Subject:To:From;
	b=R+2iItEKPzJ6/GUU4odiWKJcddI829a/Gx8UAY3WCy2evSAet5VTCZ5FASQerFnD0
	 v5rBa6jneSCxRrcAohCzCSsP9kN8EggTT9bXoXV8sQny3BErXGYOypQHSSNurmgxdR
	 sWTGUAe7mGvztEDRxz/OC/Ddd0ReI4OlFFyLXhISm2vfqhrx7qmR+zSjwNe5A4R2/N
	 L5QmMX8TTitri9wMu+NL7nFkeFPYGy6X0d0gsRgLVEX52wzYSq7jMw5MAL1a0ldBVA
	 iHseesFr3FQrF+3mxzWMbPGemy7iE6br3/LlPB0tzJ6l/entZl5pSAx/GvTdkrUrwN
	 cxVLIbvNrcx1Q==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPS id 0ADACD4EACDF4;
	Tue, 12 Mar 2024 13:24:55 +0100 (CET)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1710246290;
	bh=EDXZp51e/jRVSXZQRbPe0nnc/UqtKCH4YcB/Yi/1Oa0=;
	h=Date:Subject:To:From:From;
	b=yzUTjL8HX/ckO7FQshkfkL4WIzSAgf+njICHpvZ4sBMoIUL9MvEQpdHjnHNd0FtqO
	 QIpKV0mTrl6EB2xGltxgXM/pFy+2mwQqHaTB/pCE0aGLvI5iyy9JcShiIQRO+rFQ9n
	 tJKwDe3qThgQxZZR7wl+3MNuACLOMTL0eTIalXpmdATKy5BnTSNVf268Ej+8znN8af
	 Y2y+yrps0vgbNUf/TGOshiQ5tPpklINKpSqQ2V+8mv2SGJ9eL0mGNpdi90thLcVop/
	 gMI+Z3I8vOyweU3xHng6vDMKNjowPBrFq3p/fyvHVPkVAav8GU4zCMu7pucd0KIT3x
	 iu8BOidVjK+WA==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [10.87.19.1] (lucifer.esat.kuleuven.be [10.87.19.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id F10676000E;
	Tue, 12 Mar 2024 13:24:49 +0100 (CET)
Message-ID: <66c98f4c-5e52-4fa3-8a2c-9379cfec2a9a@esat.kuleuven.be>
Date: Tue, 12 Mar 2024 13:24:49 +0100
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

Hi Jeff,

On 3/12/24 12:22, Jeff Layton wrote:
> On Mon, 2024-03-11 at 19:43 +0100, Rik Theys wrote:
>> Since a few weeks our Rocky Linux 9 NFS server has periodically logged hung nfsd tasks. The initial effect was that some clients could no longer access the NFS server. This got worse and worse (probably as more nfsd threads got blocked) and we had to restart the server. Restarting the server also failed as the NFS server service could no longer be stopped.
>>   
>>
>> The initial kernel we noticed this behavior on was kernel-5.14.0-362.18.1.el9_3.x86_64. Since then we've installed kernel-5.14.0-419.el9.x86_64 from CentOS Stream 9. The same issue happened again on this newer kernel version:
>>   
>> [Mon Mar 11 14:10:08 2024]       Not tainted 5.14.0-419.el9.x86_64 #1
>>   [Mon Mar 11 14:10:08 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>   [Mon Mar 11 14:10:08 2024] task:nfsd            state:D stack:0     pid:8865  ppid:2      flags:0x00004000
>>   [Mon Mar 11 14:10:08 2024] Call Trace:
>>   [Mon Mar 11 14:10:08 2024]  <TASK>
>>   [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>   [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>   [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>   [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>   [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>   [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>   [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>   [Mon Mar 11 14:10:08 2024]  nfsd4_shutdown_callback+0x49/0x120 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_cld_remove+0x54/0x1d0 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_return_all_client_layouts+0xc4/0xf0 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_shutdown_copy+0x68/0xc0 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  __destroy_client+0x1f3/0x290 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  nfsd4_exchange_id+0x75f/0x770 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  ? nfsd4_decode_opaque+0x3a/0x90 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>   [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>   [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>   [Mon Mar 11 14:10:08 2024]  </TASK>
>>   [Mon Mar 11 14:10:08 2024] INFO: task nfsd:8866 blocked for more than 122 seconds.
>>   [Mon Mar 11 14:10:08 2024]       Not tainted 5.14.0-419.el9.x86_64 #1
>>   [Mon Mar 11 14:10:08 2024] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>   [Mon Mar 11 14:10:08 2024] task:nfsd            state:D stack:0     pid:8866  ppid:2      flags:0x00004000
>>   [Mon Mar 11 14:10:08 2024] Call Trace:
>>   [Mon Mar 11 14:10:08 2024]  <TASK>
>>   [Mon Mar 11 14:10:08 2024]  __schedule+0x21b/0x550
>>   [Mon Mar 11 14:10:08 2024]  schedule+0x2d/0x70
>>   [Mon Mar 11 14:10:08 2024]  schedule_timeout+0x11f/0x160
>>   [Mon Mar 11 14:10:08 2024]  ? select_idle_sibling+0x28/0x430
>>   [Mon Mar 11 14:10:08 2024]  ? tcp_recvmsg+0x196/0x210
>>   [Mon Mar 11 14:10:08 2024]  ? wake_affine+0x62/0x1f0
>>   [Mon Mar 11 14:10:08 2024]  __wait_for_common+0x90/0x1d0
>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_schedule_timeout+0x10/0x10
>>   [Mon Mar 11 14:10:08 2024]  __flush_workqueue+0x13a/0x3f0
>>   [Mon Mar 11 14:10:08 2024]  nfsd4_destroy_session+0x1a4/0x240 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  svc_process+0x12d/0x170 [sunrpc]
>>   [Mon Mar 11 14:10:08 2024]  nfsd+0x84/0xb0 [nfsd]
>>   [Mon Mar 11 14:10:08 2024]  kthread+0xdd/0x100
>>   [Mon Mar 11 14:10:08 2024]  ? __pfx_kthread+0x10/0x10
>>   [Mon Mar 11 14:10:08 2024]  ret_from_fork+0x29/0x50
>>   [Mon Mar 11 14:10:08 2024]  </TASK>
>>
> The above threads are trying to flush the workqueue, so that probably
> means that they are stuck waiting on a workqueue job to finish.
>>   The above is repeated a few times, and then this warning is also logged:
>>   
>> [Mon Mar 11 14:12:04 2024] ------------[ cut here ]------------
>>   [Mon Mar 11 14:12:04 2024] WARNING: CPU: 39 PID: 8844 at fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>   [Mon Mar 11 14:12:05 2024] Modules linked in: nfsv4 dns_resolver nfs fscache netfs rpcsec_gss_krb5 rpcrdma rdma_cm iw_cm ib_cm ib_core binfmt_misc bonding tls rfkill nft_counter nft_ct
>>   nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nf_tables nfnetlink vfat fat dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio l
>>   ibcrc32c dm_service_time dm_multipath intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common isst_if_common skx_edac nfit libnvdimm ipmi_ssif x86_pkg_temp
>>   _thermal intel_powerclamp coretemp kvm_intel kvm irqbypass dcdbas rapl intel_cstate mgag200 i2c_algo_bit drm_shmem_helper dell_smbios drm_kms_helper dell_wmi_descriptor wmi_bmof intel_u
>>   ncore syscopyarea pcspkr sysfillrect mei_me sysimgblt acpi_ipmi mei fb_sys_fops i2c_i801 ipmi_si intel_pch_thermal lpc_ich ipmi_devintf i2c_smbus ipmi_msghandler joydev acpi_power_meter
>>   nfsd auth_rpcgss nfs_acl drm lockd grace fuse sunrpc ext4 mbcache jbd2 sd_mod sg lpfc
>>   [Mon Mar 11 14:12:05 2024]  nvmet_fc nvmet nvme_fc nvme_fabrics crct10dif_pclmul ahci libahci crc32_pclmul nvme_core crc32c_intel ixgbe megaraid_sas libata nvme_common ghash_clmulni_int
>>   el t10_pi wdat_wdt scsi_transport_fc mdio wmi dca dm_mirror dm_region_hash dm_log dm_mod
>>   [Mon Mar 11 14:12:05 2024] CPU: 39 PID: 8844 Comm: nfsd Not tainted 5.14.0-419.el9.x86_64 #1
>>   [Mon Mar 11 14:12:05 2024] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 2.20.1 09/13/2023
>>   [Mon Mar 11 14:12:05 2024] RIP: 0010:nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>   [Mon Mar 11 14:12:05 2024] Code: a6 95 c5 f3 e9 ff fe ff ff 48 89 df be 01 00 00 00 e8 34 b5 13 f4 48 8d bb 98 00 00 00 e8 c8 f9 00 00 84 c0 0f 85 2e ff ff ff <0f> 0b e9 27 ff ff ff be
>>   02 00 00 00 48 89 df e8 0c b5 13 f4 e9 01
>>   [Mon Mar 11 14:12:05 2024] RSP: 0018:ffff9929e0bb7b80 EFLAGS: 00010246
>>   [Mon Mar 11 14:12:05 2024] RAX: 0000000000000000 RBX: ffff8ada51930900 RCX: 0000000000000024
>>   [Mon Mar 11 14:12:05 2024] RDX: ffff8ada519309c8 RSI: ffff8ad582933c00 RDI: 0000000000002000
>>   [Mon Mar 11 14:12:05 2024] RBP: ffff8ad46bf21574 R08: ffff9929e0bb7b48 R09: 0000000000000000
>>   [Mon Mar 11 14:12:05 2024] R10: ffff8aec859a2948 R11: 0000000000000000 R12: ffff8ad6f497c360
>>   [Mon Mar 11 14:12:05 2024] R13: ffff8ad46bf21560 R14: ffff8ae5942e0b10 R15: ffff8ad6f497c360
>>   [Mon Mar 11 14:12:05 2024] FS:  0000000000000000(0000) GS:ffff8b031fcc0000(0000) knlGS:0000000000000000
>>   [Mon Mar 11 14:12:05 2024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   [Mon Mar 11 14:12:05 2024] CR2: 00007fafe2060744 CR3: 00000018e58de006 CR4: 00000000007706e0
>>   [Mon Mar 11 14:12:05 2024] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>   [Mon Mar 11 14:12:05 2024] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>   [Mon Mar 11 14:12:05 2024] PKRU: 55555554
>>   [Mon Mar 11 14:12:05 2024] Call Trace:
>>   [Mon Mar 11 14:12:05 2024]  <TASK>
>>   [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>   [Mon Mar 11 14:12:05 2024]  ? show_trace_log_lvl+0x1c4/0x2df
>>   [Mon Mar 11 14:12:05 2024]  ? __break_lease+0x16f/0x5f0
>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  ? __warn+0x81/0x110
>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  ? report_bug+0x10a/0x140
>>   [Mon Mar 11 14:12:05 2024]  ? handle_bug+0x3c/0x70
>>   [Mon Mar 11 14:12:05 2024]  ? exc_invalid_op+0x14/0x70
>>   [Mon Mar 11 14:12:05 2024]  ? asm_exc_invalid_op+0x16/0x20
>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_break_deleg_cb+0x170/0x190 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  __break_lease+0x16f/0x5f0
>>   [Mon Mar 11 14:12:05 2024]  ? nfsd_file_lookup_locked+0x117/0x160 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  ? list_lru_del+0x101/0x150
>>   [Mon Mar 11 14:12:05 2024]  nfsd_file_do_acquire+0x790/0x830 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  nfs4_get_vfs_file+0x315/0x3a0 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  nfsd4_process_open2+0x430/0xa30 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  ? fh_verify+0x297/0x2f0 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  nfsd4_open+0x3ce/0x4b0 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  nfsd4_proc_compound+0x44b/0x700 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  nfsd_dispatch+0x94/0x1c0 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  svc_process_common+0x2ec/0x660 [sunrpc]
>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  svc_process+0x12d/0x170 [sunrpc]
>>   [Mon Mar 11 14:12:05 2024]  nfsd+0x84/0xb0 [nfsd]
>>   [Mon Mar 11 14:12:05 2024]  kthread+0xdd/0x100
>>   [Mon Mar 11 14:12:05 2024]  ? __pfx_kthread+0x10/0x10
>>   [Mon Mar 11 14:12:05 2024]  ret_from_fork+0x29/0x50
>>   [Mon Mar 11 14:12:05 2024]  </TASK>
>>   [Mon Mar 11 14:12:05 2024] ---[ end trace 7a039e17443dc651 ]---
> This is probably this WARN in nfsd_break_one_deleg:
>
>          WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall));
>
> It means that a delegation break callback to the client couldn't be
> queued to the workqueue, and so it didn't run.
>
>> Could this be the same issue as described here:https://lore.kernel.org/linux-nfs/af0ec881-5ebf-4feb-98ae-3ed2a77f86f1@oracle.com/ ?
>>   
> Yes, most likely the same problem.
If I read that thread correctly, this issue was introduced between 
6.1.63 and 6.6.3? Is it possible the EL9 5.14.0-362.18.1.el9_3 
backported these changes, or were we hitting some other bug with that 
version? It seems the 6.1.x kernel is not affected? If so, that would be 
the recommended kernel to run?
>
>
>> As described in that thread, I've tried to obtain the requested information.
>>   
>>
>> Is it possible this is the issue that was fixed by the patches described here? https://lore.kernel.org/linux-nfs/2024022054-cause-suffering-eae8@gregkh/
>>
> Doubtful. Those are targeted toward a different set of issues.
>
> If you're willing, I do have some patches queued up for CentOS here that
> fix some backchannel problems that could be related. I'm mainly waiting
> on Chuck to send these to Linus and then we'll likely merge them into
> CentOS soon afterward:
>
> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3689
>
If you can send me a patch file, I can rebuild the C9S kernel with that 
patch and run it. It can take a while for the bug to trigger as I 
believe it seems to be very workload dependent (we were running very 
stable for months and now hit this bug every other week).

So these patches are not yet upstream?

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


