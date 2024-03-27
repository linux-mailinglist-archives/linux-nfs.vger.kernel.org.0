Return-Path: <linux-nfs+bounces-2504-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065D888EFFB
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 21:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 385B7B2614E
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Mar 2024 20:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276CB2E405;
	Wed, 27 Mar 2024 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b="AHutjdpN";
	dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b="g2psxYnz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DBC14F102
	for <linux-nfs@vger.kernel.org>; Wed, 27 Mar 2024 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.58.240.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711570584; cv=none; b=BtoNr24kTD7QDYJTfXqOtScW63Fba72Oxm/YWzgam8vek37E2JoW+a0YrcYWMJFnhgP5Gtos67cPO6Cd2+Vs9EfsNmkGULAvzLCkzskHGCDNZLICD82XI3dQNKZJedOmjnYoWW4s0LlCeh/5V1q1kEmslzQiwJQD0kVLHwYlaLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711570584; c=relaxed/simple;
	bh=g34LIAQgstx5P0b+BuOdhWo7yVkmi0dTPim4iQzhGhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RSZMNpL52cIT/8tbyGFX1LEcdVRoNRBFBnmewyTfzfsld1B0BaIZ4qHMkV2AsavWEhb4x+S/ssLeSheFBtOhONFGHD+EVhN4kfJ+5tMcJt/SB3z2uGRVTlc4jpj+Ty2+KSxBzMLA5OszHNCqhGQApgwq9UUqVuOAqZc2LIAppRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be; spf=pass smtp.mailfrom=esat.kuleuven.be; dkim=pass (2048-bit key) header.d=kuleuven.be header.i=@kuleuven.be header.b=AHutjdpN; dkim=pass (2048-bit key) header.d=esat.kuleuven.be header.i=@esat.kuleuven.be header.b=g2psxYnz; arc=none smtp.client-ip=134.58.240.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esat.kuleuven.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esat.kuleuven.be
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:131])
	by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id 93119372B
	for <linux-nfs@vger.kernel.org>; Wed, 27 Mar 2024 21:09:48 +0100 (CET)
X-KULeuven-Envelope-From: rik.theys@esat.kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 3C6AC20164.A8782
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:142:242:ac11:59])
	by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id 3C6AC20164;
	Wed, 27 Mar 2024 21:09:40 +0100 (CET)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
	s=kuleuven-cav-1; t=1711570179;
	bh=F0UEQBhHNcLrsjnH+PCR2kTIb1Fefm7mqRTZuYd+fNk=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=AHutjdpNZ550X7eMYG50LIZim4tn3S2JHIqtkXCfbxvECaEnODmCvr1lzocycZzdE
	 1I9i/xIJF9J246UMshyonEz5/Y0zL7J0h21vFzMhLZVldJEhy3O0Cq6onOSX0emPme
	 7TLhdr62Xb6HaNUfajT04T+CD57SB1zqPtGwI2oxrlE8hntYD7olPDAGh8bKHTSqig
	 OEkDheEWK3Th7AAtqQrRmWPZ0fVW/HSmndvr4KSy4R+/dr5uBkXfCoXrevaK4wAjYv
	 RCtFeDkEK26AzqqANYPWP3HFKbUcZb6z6bv557IVQXC93vvgYi5oD6wmy45teR+7RY
	 SScLnZmXQHgPQ==
Received: from hydrogen.esat.kuleuven.be (hydrogen.esat.kuleuven.be [134.58.56.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPS id DE46ED4F4C68D;
	Wed, 27 Mar 2024 21:09:39 +0100 (CET)
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esat.kuleuven.be;
	s=esat20220324; t=1711570179;
	bh=F0UEQBhHNcLrsjnH+PCR2kTIb1Fefm7mqRTZuYd+fNk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=g2psxYnzXHyx9Iy0+Ls+f4vjiKcR5ngDKVcezrF008NEA1EVdl85Rt4EZwk7nwLF1
	 vjUUCuFVekwU6UawuPBpN1TbjULqoNV9HIStHNTLrTYL0AjxhakhJ1SuDtzvKw5PwH
	 X0CM9YztyTvyDbIR/gSCi444thL3VrT5FuDYhuh0TWZcANs5H2IIM32VsohrupfraJ
	 +VEQkfwF3YNX6vIUusfgAQlYD9jCEApL2La9pirmo1P4is9XqPJYl1TaTW8Bx6lBC7
	 0KJi4PJGhxjAq/IKYyKU8VBbaxg5pVveyXlCDg7681ZEBMab+QZC77vh02tB8opSkA
	 HOx7JmGfnbvOg==
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
X-KULeuven-ESAT-Envelope-Sender: rik.theys@esat.kuleuven.be
Received: from [192.168.1.178] (d54c12615.access.telenet.be [84.193.38.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by hydrogen.esat.kuleuven.be (Postfix) with ESMTPSA id B72D96000E;
	Wed, 27 Mar 2024 21:09:39 +0100 (CET)
Message-ID: <863281de-5c42-493f-8168-fd6eb556d125@esat.kuleuven.be>
Date: Wed, 27 Mar 2024 21:09:33 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARN_ONCE from nfsd_break_one_deleg
To: Donald Buczek <buczek@molgen.mpg.de>, Jeff Layton <jlayton@kernel.org>,
 Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>,
 linux-nfs@vger.kernel.org, it+linux@molgen.mpg.de
References: <5b63ad24-1967-4e0c-b52b-f3a853b613ff@molgen.mpg.de>
 <39c143cd-c84b-47b8-945f-bd0bbe8babfc@oracle.com>
 <530ec24d-c22d-4fea-a9f7-7a462ab1af9d@oracle.com>
 <474380e6098676a95f38dbaffcaeb633fe602167.camel@kernel.org>
 <c45674af-b8e3-4e5a-b577-9628ebb7db29@molgen.mpg.de>
Content-Language: en-US
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Rik Theys <Rik.Theys@esat.kuleuven.be>
In-Reply-To: <c45674af-b8e3-4e5a-b577-9628ebb7db29@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 3/27/24 13:31, Donald Buczek wrote:
> On 3/27/24 12:07, Jeff Layton wrote:
>> On Tue, 2024-03-26 at 18:59 -0700, Dai Ngo wrote:
>>> On 3/26/24 9:42 AM, Chuck Lever wrote:
>>>> On 3/26/24 11:04 AM, Donald Buczek wrote:
>>>>> Hi,
>>>>>
>>>>> we just got this on a nfs file server on 6.6.12 :
>>>>>
>>>>> [2719554.674554] receive_cb_reply: Got unrecognized reply: calldir
>>>>> 0x1 xpt_bc_xprt 00000000432042d3 xid c369f54d
>>>>> [2719555.391416] receive_cb_reply: Got unrecognized reply: calldir
>>>>> 0x1 xpt_bc_xprt 0000000017cc0507 xid d6018727
>>>>> [2719555.742118] receive_cb_reply: Got unrecognized reply: calldir
>>>>> 0x1 xpt_bc_xprt 000000008f2509ff xid 83d0248e
>>>>> [2719555.742566] receive_cb_reply: Got unrecognized reply: calldir
>>>>> 0x1 xpt_bc_xprt 00000000637a135a xid 7064546d
>>>>> [2719555.742803] receive_cb_reply: Got unrecognized reply: calldir
>>>>> 0x1 xpt_bc_xprt 0000000044ea3c51 xid a184bbe5
>>>>> [2719555.742836] receive_cb_reply: Got unrecognized reply: calldir
>>>>> 0x1 xpt_bc_xprt 00000000b6992e65 xid ed3fe82e
>>>>> [2719555.785358] receive_cb_reply: Got unrecognized reply: calldir
>>>>> 0x1 xpt_bc_xprt 0000000044ea3c51 xid a384bbe5
>>>>> [2719588.733414] receive_cb_reply: Got unrecognized reply: calldir
>>>>> 0x1 xpt_bc_xprt 000000008f2509ff xid 89d0248e
>>>>> [2719592.067221] receive_cb_reply: Got unrecognized reply: calldir
>>>>> 0x1 xpt_bc_xprt 00000000b6992e65 xid f33fe82e
>>>>> [2719807.431344] receive_cb_reply: Got unrecognized reply: calldir
>>>>> 0x1 xpt_bc_xprt 00000000fd87f88f xid 28b51379
>>>>> [2719838.510792] receive_cb_reply: Got unrecognized reply: calldir
>>>>> 0x1 xpt_bc_xprt 00000000432042d3 xid fa69f54d
>>>>> [2719852.493779] receive_cb_reply: Got unrecognized reply: calldir
>>>>> 0x1 xpt_bc_xprt 00000000ac1e99fe xid a16378bb
>>>>> [2719852.494853] receive_cb_reply: Got unrecognized reply: calldir
>>>>> 0x1 xpt_bc_xprt 0000000017cc0507 xid 0f028727
>>>>> [2719852.515457] receive_cb_reply: Got unrecognized reply: calldir
>>>>> 0x1 xpt_bc_xprt 0000000017cc0507 xid 10028727
>>>> These clients are sending NFSv4 callback replies that the server does
>>>> not have a waiting XID for. It's a sign of a significant communication
>>>> mix-up between the server and client.
>>>>
>>>> It would help us to get some details about your clients, the NFS
>>>> version in use, and how long you've been using this kernel. Also, a
>>>> raw packet capture might shed a little more light on the issue.

I believe this might be the same issue we're experiencing and was also 
discussed on the linux-nfs mailing list:

https://lore.kernel.org/linux-nfs/10d43fc9-fe74-451d-9bd6-51f9f2de837b@esat.kuleuven.be/T/#t

> This specific file server has been running 6.6 for about a month. It has been running 5.15 for over a year before.
> All nfs clients are on 5.15 or 6.6.
>
> Sorry for not providing enough information. The problem had strong user impact so we needed to resolve the situation quickly by rebooting the server to a 5.15 kernel. This in fact unblocked the hanging mounts on a client.
>
> A user later reported, that he might have overloaded the file server from parallel writing jobs.

Looking at our traffic statistics, this is also the case in situation. 
When we experienced the issues, the server was processing a lot more 
concurrent writes than read operations. But that situation was already 
present for hours (and sometimes days) before we triggered the issue. In 
our case the high write load was mostly caused by HPC jobs rewriting the 
same checkpoint files over and over.

We also noticed that once the situation happened, clients could no 
longer mount the server after a reboot. Looking at recent messages in 
this list, this could be fixed by the patch discussed in 
https://lore.kernel.org/linux-nfs/171156001280.1469.15703028652039429964.stgit@klimt.1015granger.net/T/#u 
?

Regards,

Rik

>
>>> This warning has has no effect on the server operation and was remove.
>>> See commit 05a4b58301c3.
> Ok.
>
>> Yes. It usually just means the job is already scheduled or is running,
>> which is harmless. That said, that can be indicative of the workqueue
>> job being stuck.
>>
>> Typically, backchannel jobs should run quickly, but lease breaks can
>> come in quick succession too, so this warning never meant much.
> Before we rebooted, I was able to run a script which takes some system data, including the stack traces of all tasks.
>
> http://owww.molgen.mpg.de/~buczek/2024-03-26_sauterelles
>
> Is the blocker
>
> 1 D root        11     2  0  80   0 -     0 rpc_sh Feb23 ?        00:00:18  \_ [kworker/u32:0+nfsd4_callbacks]
>
> ?
>
> # cat /proc/11/task/11/stack
>
> [<0>] rpc_shutdown_client+0xff/0x160 [sunrpc]
> [<0>] nfsd4_process_cb_update+0x4c/0x280 [nfsd]
> [<0>] nfsd4_run_cb_work+0xa3/0x160 [nfsd]
> [<0>] process_one_work+0x13f/0x300
> [<0>] worker_thread+0x2f5/0x410
> [<0>] kthread+0xe5/0x120
> [<0>] ret_from_fork+0x31/0x50
> [<0>] ret_from_fork_asm+0x1b/0x30
>
> rpc_shutdown_client+0xff is behind 'call schedule_timeout' in the expansion of `wait_event_timeout(destroy_wait, list_empty(&clnt->cl_tasks), 1*HZ);`.
>
> So it is waiting for the second to pass, possibly in a loop waiting for list_empty(&clnt->cl_tasks).
>
> I don't know if any guesses could be made out of this, though.
>
> Thanks
>
>    Donald
>
>>>>> [2719917.753429] ------------[ cut here ]------------
>>>>> [2719917.758951] WARNING: CPU: 1 PID: 1448 at
>>>>> fs/nfsd/nfs4state.c:4939 nfsd_break_deleg_cb+0x115/0x190 [nfsd]
>>>>> [2719917.769208] Modules linked in: af_packet xt_nat xt_tcpudp
>>>>> iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
>>>>> rpcsec_gss_krb5 nfsv4 nfs i915 iosf_mbi drm_buddy drm_display_helper
>>>>> ttm intel_gtt video 8021q garp stp mrp llc input_leds
>>>>> x86_pkg_temp_thermal led_class hid_generic usbhid coretemp kvm_intel
>>>>> kvm irqbypass tg3 libphy smartpqi mgag200 i2c_algo_bit efi_pstore
>>>>> iTCO_wdt i40e crc32c_intel wmi_bmof pstore iTCO_vendor_support wmi
>>>>> ipmi_si nfsd auth_rpcgss oid_registry nfs_acl lockd grace sunrpc
>>>>> efivarfs ip_tables x_tables ipv6 autofs4
>>>>> [2719917.818740] CPU: 1 PID: 1448 Comm: nfsd Not tainted
>>>>> 6.6.12.mx64.461 #1
>>>>> [2719917.825777] Hardware name: Dell Inc. PowerEdge T440/021KCD, BIOS
>>>>> 2.12.2 07/09/2021
>>>>> [2719917.833781] RIP: 0010:nfsd_break_deleg_cb+0x115/0x190 [nfsd]
>>>>> [2719917.839911] Code: 00 00 00 e8 3d ae e8 e0 e9 5f ff ff ff 48 89
>>>>> df be 01 00 00 00 e8 8b 1f 3d e1 48 8d bb 98 00 00 00 e8 ef 10 01 00
>>>>> 84 c0 75 8a <0f> 0b eb 86 65 8b 05 0c 66 e0 5f 89 c0 48 0f a3 05 d6
>>>>> 1a 75 e2 0f
>>>>> [2719917.859303] RSP: 0018:ffffc9000bae7b70 EFLAGS: 00010246
>>>>> [2719917.864962] RAX: 0000000000000000 RBX: ffff8881e2fd6000 RCX:
>>>>> 0000000000000024
>>>>> [2719917.872520] RDX: ffff8881e2fd60c8 RSI: ffff889086d5de00 RDI:
>>>>> 0000000000000200
>>>>> [2719917.880050] RBP: ffff889301aa812c R08: 0000000000033580 R09:
>>>>> 0000000000000000
>>>>> [2719917.887575] R10: ffff889ef63b20d8 R11: 0000000000000000 R12:
>>>>> ffff888104cfb290
>>>>> [2719917.895095] R13: ffff889301aa8118 R14: ffff88989c8ace00 R15:
>>>>> ffff888104cfb290
>>>>> [2719917.902625] FS:  0000000000000000(0000)
>>>>> GS:ffff88a03fc00000(0000) knlGS:0000000000000000
>>>>> [2719917.911094] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [2719917.917236] CR2: 00007fb8a1cfc418 CR3: 000000000262c006 CR4:
>>>>> 00000000007706e0
>>>>> [2719917.924760] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>>>> 0000000000000000
>>>>> [2719917.932285] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>>>> 0000000000000400
>>>>> [2719917.939833] PKRU: 55555554
>>>>> [2719917.942971] Call Trace:
>>>>> [2719917.945834]  <TASK>
>>>>> [2719917.948344]  ? __warn+0x81/0x140
>>>>> [2719917.951983]  ? nfsd_break_deleg_cb+0x115/0x190 [nfsd]
>>>>> [2719917.957470]  ? report_bug+0x171/0x1a0
>>>>> [2719917.961562]  ? handle_bug+0x3c/0x70
>>>>> [2719917.965459]  ? exc_invalid_op+0x17/0x70
>>>>> [2719917.969715]  ? asm_exc_invalid_op+0x1a/0x20
>>>>> [2719917.974317]  ? nfsd_break_deleg_cb+0x115/0x190 [nfsd]
>>>>> [2719917.979820]  __break_lease+0x24b/0x7c0
>>>>> [2719917.983991]  ? __pfx_nfsd_acceptable+0x10/0x10 [nfsd]
>>>>> [2719917.989495]  nfs4_get_vfs_file+0x195/0x380 [nfsd]
>>>>> [2719917.994740]  ? prepare_creds+0x14c/0x240
>>>>> [2719917.999164]  nfsd4_process_open2+0x3ed/0x16b0 [nfsd]
>>>>> [2719918.004570]  ? nfsd_permission+0x4e/0x100 [nfsd]
>>>>> [2719918.009618]  ? fh_verify+0x17b/0x8a0 [nfsd]
>>>>> [2719918.014243]  nfsd4_open+0x6ae/0xcd0 [nfsd]
>>>>> [2719918.018777]  ? nfsd4_encode_operation+0xa6/0x290 [nfsd]
>>>>> [2719918.024524]  nfsd4_proc_compound+0x2f2/0x6a0 [nfsd]
>>>>> [2719918.029922]  nfsd_dispatch+0xee/0x220 [nfsd]
>>>>> [2719918.034619]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>> [2719918.039144]  svc_process_common+0x307/0x730 [sunrpc]
>>>>> [2719918.044551]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>>>> [2719918.049883]  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>>>> [2719918.054404]  svc_process+0x131/0x180 [sunrpc]
>>>>> [2719918.059171]  nfsd+0x84/0xd0 [nfsd]
>>>>> [2719918.063012]  kthread+0xe5/0x120
>>>>> [2719918.066539]  ? __pfx_kthread+0x10/0x10
>>>>> [2719918.070664]  ret_from_fork+0x31/0x50
>>>>> [2719918.074611]  ? __pfx_kthread+0x10/0x10
>>>>> [2719918.078735]  ret_from_fork_asm+0x1b/0x30
>>>>> [2719918.083018]  </TASK>
>>>>> [2719918.085563] ---[ end trace 0000000000000000 ]---
>>>>>
>>>>> nfsd_break_deleg_cb+0x115 is the
>>>>> `WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall))` in
>>>>> nfsd_break_one_deleg() in our compilation
>>>>>
>>>>> I think that means, that the callback is already scheduled?
>>>>>
>>>>> One nfs client hung trying to mount something from that server.
>>>>>
>>>>> Best
>>>>>
>>>>>     Donald
>>>>>
-- 
Rik Theys
System Engineer
KU Leuven - Dept. Elektrotechniek (ESAT)
Kasteelpark Arenberg 10 bus 2440  - B-3001 Leuven-Heverlee
+32(0)16/32.11.07
----------------------------------------------------------------
<<Any errors in spelling, tact or fact are transmission errors>>


