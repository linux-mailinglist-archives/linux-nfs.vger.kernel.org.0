Return-Path: <linux-nfs+bounces-3415-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7006B8D0866
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 18:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931CB1C2286B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 May 2024 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D335361FFB;
	Mon, 27 May 2024 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="y5+covNx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F251640B;
	Mon, 27 May 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826649; cv=none; b=ZYHRw7EzVNPzWMnehzKfNVXwhq/Donyo6VPsNW7K7CAMrF/CR1r1F6C1OJyyzl8KAN9l5N45xDJrreBHvNSNwwk2dmdnw4WkLRBzkZnidR0NoM3YKJ0mK9DBekWjiHmrgwjp+tnizbQX0JlMeCce3zu0L/Eai1kYL8ICDf+DM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826649; c=relaxed/simple;
	bh=iSWRUmqOiPqtPPGm+a5ZldxebOLJrjKUDsbfRT+KKP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVfSPR56iQTcya5kJnq6Ne4TS0lwXtdzq0xaeLNuhwnzevQZM3vmC9i5h6/SNZasPL79srnNhEHgq3hAsjxWHH5+IniI8MfOXlI2x6d94HVVU7juMPUFbXwUigSSmWRDLs+fJOCPqFs+RrED+XFM4MteHdtmsNbwH3Hi8+oXx4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=y5+covNx; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=MCQy2kLdAjrxyskwoKDXL0HC2z1uOVlnYtYY9aeY4Vc=;
	t=1716826646; x=1717258646; b=y5+covNxO9j/sDZdSFfk/eaSo9Bh/HSlQipjd/Naha8Xzz0
	H9F9bhSow52HWI/e7MSXwQkE7fJCsM1fWk1Dt7aoIzVTpFaUthQPqKG5TRyQI+B6p0U4U+FeGDmQl
	//gULp1p471rp2VR9OihA/eWjxkfxYUEAHzqf6GlVATtGnqy9g8uJfUPrcupERT1TVp/jXVnGBRzM
	XT2Giw7xPD4p0mn7vdxhvYWU5mRNl+UZuOZ4ukS5aRjfBJB+kz6EbnCISC7dWw90spA6Ou2jTLUD0
	vUmK0By3ZLlY408ryn8MlubV3mFYoYpcziJHBSWEPrVsxkwQJGZ1UuCb/h0bWJxg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sBd2J-0003VF-Ma; Mon, 27 May 2024 18:17:23 +0200
Message-ID: <63fa6f5e-e366-42ea-9358-fd633e9bec44@leemhuis.info>
Date: Mon, 27 May 2024 18:17:23 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] nfsstat/nfsd crash system "general protection fault,
 probably for non-canonical address ..." after 6.8.9->6.8.10 update
To: Chuck Lever III <chuck.lever@oracle.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Igor Raits <igor@gooddata.com>, Jeff Layton <jlayton@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
References: <CAK8fFZ7rbh5o9XG1D5KAPSRyES-8W8AphxsLJXOWUFZK49i8fA@mail.gmail.com>
 <Zk39Sr6GmwQQ5NjS@tissot.1015granger.net>
 <CAK8fFZ4hPxecuCaV4T=bqZ39C0sJfXBn=rWdvPXVV_o037udfw@mail.gmail.com>
 <CAK8fFZ74tt0cC3_Jm=nA0gv6OH-QM9s08hFVOBfCM_V_FqyyqA@mail.gmail.com>
 <DF3F5FC0-6B52-43FE-8B4B-6725B8733B51@oracle.com>
 <bd32196b-5dbb-4226-9101-4949111d935a@leemhuis.info>
 <15D2C9FA-0B93-4C92-950F-2E0043BF7970@oracle.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <15D2C9FA-0B93-4C92-950F-2E0043BF7970@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716826646;562e25b4;
X-HE-SMSGID: 1sBd2J-0003VF-Ma

On 27.05.24 17:13, Chuck Lever III wrote:
> 
> I intend to send this to stable:
> https://lore.kernel.org/linux-nfs/CAK2bqV+WKFfXx8Au3iOt7CE2S6Om83haLUmkyuMKAm=KM+k2RA@mail.gmail.com/T/#t
> today or tomorrow.

Ahh, great, thx; and sorry, I had missed that patch.

I saw you send it in between, which is even better, as with a bit of
luck Greg will include this for the next release and this will be
history in a few days. :-D

Thx again.

Ciao, Thorsten

>> On May 27, 2024, at 1:51 AM, Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> [CCing Greg and stable and regressions list]
>>
>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>> for once, to make this easily accessible to everyone.
>>
>> Please correct me if I'm wrong, but since 6.8.10 we afaics have below
>> regression report about a general protection fault as well as two
>> reports about NFSd related NULL pointer dereferences[1] that got some
>> attention[2]. From a quick look I saw no fixes for those queued for the
>> next 6.8.y release. And the series might be EOL soon.
>>
>> Hmmm. That sounds not really good. Is there some easy way to fix this?
>>
>> Chuck, you earlier mentioned (see quote below) that Greg pulled in three
>> changes as dep into 6.8.10 that might be unneeded. Might reverting all
>> three be the best way forward?
>>
>> Ciao, Thorsten
>>
>> [1]
>> https://lore.kernel.org/all/CAK2bqVJoT3yy2m0OmTnqH9EAKkj6O1iTk42EyyMtvvxKh6YDKg@mail.gmail.com/
>> and https://lore.kernel.org/all/A8DQDS.ZXN0FMYZ3DIM1@gmail.com/
>>
>> [2] https://x.com/spendergrsec/status/1793489498443252143
>>
>> On 24.05.24 20:21, Chuck Lever III wrote:
>>>> On May 24, 2024, at 4:59 AM, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com> wrote:
>>>>
>>>>>
>>>>>>
>>>>>> On Wed, May 22, 2024 at 04:36:57AM -0400, Jaroslav Pulchart wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> I would like to report some issue causing a "general protection fault"
>>>>>>> crash (constantly) after we updated the kernel from 6.8.9 to 6.8.10.
>>>>>>> This is triggered when monitoring is using nfsstat on a server where
>>>>>>> nfsd is running.
>>>>>>>
>>>>>>> [ 3049.260633] general protection fault, probably for non-canonical
>>>>>>> address 0x66fb103e19e9cc89: 0000 [#1] PREEMPT SMP NOPTI
>>>>>>> [ 3049.261628] CPU: 22 PID: 74991 Comm: nfsstat Tainted: G
>>>>>>> E      6.8.10-1.gdc.el9.x86_64 #1
>>>>>>> [ 3049.262336] Hardware name: RDO OpenStack Compute/RHEL, BIOS
>>>>>>> edk2-20240214-2.el9 02/14/2024
>>>>>>> [ 3049.263003] RIP: 0010:_raw_spin_lock_irqsave+0x19/0x40
>>>>>>> [ 3049.263487] Code: cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
>>>>>>> 90 0f 1f 44 00 00 41 54 9c 41 5c fa 65 ff 05 a6 92 f5 42 31 c0 ba 01
>>>>>>> 00 00 00 <f0> 0f b1 17 75 0a 4c 89 e0 41 5c c3 cc cc cc cc 89 c6 e8 d0
>>>>>>> 07 00
>>>>>>> [ 3049.264882] RSP: 0018:ffffb1bca6b9bd00 EFLAGS: 00010046
>>>>>>> [ 3049.265365] RAX: 0000000000000000 RBX: 66fb103e19e9c989 RCX: 0000000000000001
>>>>>>> [ 3049.265953] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 66fb103e19e9cc89
>>>>>>> [ 3049.266542] RBP: ffffffffc15df280 R08: 0000000000000001 R09: ffffa049a1785cb8
>>>>>>> [ 3049.267112] R10: ffffb1bca6b9bd70 R11: ffffa04964e49000 R12: 0000000000000246
>>>>>>> [ 3049.267702] R13: 66fb103e19e9cc89 R14: ffffa048445590a0 R15: 0000000000000001
>>>>>>> [ 3049.268278] FS:  00007fa3ddf03740(0000) GS:ffffa05703d00000(0000)
>>>>>>> knlGS:0000000000000000
>>>>>>> [ 3049.268928] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>> [ 3049.269443] CR2: 00007fa3dddfca50 CR3: 0000000342d1e004 CR4: 0000000000770ef0
>>>>>>> [ 3049.270025] PKRU: 55555554
>>>>>>> [ 3049.270371] Call Trace:
>>>>>>> [ 3049.270723]  <TASK>
>>>>>>> [ 3049.271035]  ? die_addr+0x33/0x90
>>>>>>> [ 3049.271423]  ? exc_general_protection+0x1ea/0x450
>>>>>>> [ 3049.271879]  ? asm_exc_general_protection+0x22/0x30
>>>>>>> [ 3049.272344]  ? _raw_spin_lock_irqsave+0x19/0x40
>>>>>>> [ 3049.272803]  __percpu_counter_sum+0xd/0x70
>>>>>>> [ 3049.273219]  nfsd_show+0x4f/0x1d0 [nfsd]
>>>>>>> [ 3049.273666]  seq_read_iter+0x11d/0x4d0
>>>>>>> [ 3049.274073]  ? avc_has_perm+0x42/0xc0
>>>>>>> [ 3049.274489]  seq_read+0xfe/0x140
>>>>>>> [ 3049.274866]  proc_reg_read+0x56/0xa0
>>>>>>> [ 3049.275257]  vfs_read+0xa7/0x340
>>>>>>> [ 3049.275647]  ? __do_sys_newfstat+0x57/0x60
>>>>>>> [ 3049.276059]  ksys_read+0x5f/0xe0
>>>>>>> [ 3049.276439]  do_syscall_64+0x5e/0x170
>>>>>>> [ 3049.276836]  entry_SYSCALL_64_after_hwframe+0x78/0x80
>>>>>>> [ 3049.277296] RIP: 0033:0x7fa3ddcfd9b2
>>>>>>> [ 3049.277719] Code: c0 e9 b2 fe ff ff 50 48 8d 3d ea 1d 0c 00 e8 c5
>>>>>>> fd 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75
>>>>>>> 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89
>>>>>>> 54 24
>>>>>>> [ 3049.279139] RSP: 002b:00007ffd930672e8 EFLAGS: 00000246 ORIG_RAX:
>>>>>>> 0000000000000000
>>>>>>> [ 3049.279788] RAX: ffffffffffffffda RBX: 0000555ded47c2a0 RCX: 00007fa3ddcfd9b2
>>>>>>> [ 3049.280402] RDX: 0000000000000400 RSI: 0000555ded47c480 RDI: 0000000000000003
>>>>>>> [ 3049.281046] RBP: 00007fa3dddf75e0 R08: 0000000000000003 R09: 0000000000000077
>>>>>>> [ 3049.281673] R10: 000000000000005d R11: 0000000000000246 R12: 0000555ded47c2a0
>>>>>>> [ 3049.282307] R13: 0000000000000d68 R14: 00007fa3dddf69e0 R15: 0000000000000d68
>>>>>>> [ 3049.282928]  </TASK>
>>>>>>> [ 3049.283310] Modules linked in: mptcp_diag(E) xsk_diag(E)
>>>>>>> raw_diag(E) unix_diag(E) af_packet_diag(E) netlink_diag(E) udp_diag(E)
>>>>>>> tcp_diag(E) inet_diag(E) tun(E) br_netfilter(E) bridge(E) stp(E)
>>>>>>> llc(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sunrpc(E)
>>>>>>> nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) binfmt_misc(E)
>>>>>>> zram(E) tls(E) isofs(E) vfat(E) fat(E) intel_rapl_msr(E)
>>>>>>> intel_rapl_common(E) kvm_amd(E) ccp(E) kvm(E) irqbypass(E)
>>>>>>> virtio_net(E) i2c_i801(E) virtio_gpu(E) i2c_smbus(E) net_failover(E)
>>>>>>> virtio_balloon(E) failover(E) virtio_dma_buf(E) fuse(E) ext4(E)
>>>>>>> mbcache(E) jbd2(E) sr_mod(E) cdrom(E) sg(E) ahci(E) libahci(E)
>>>>>>> crct10dif_pclmul(E) crc32_pclmul(Ea) polyval_clmulni(E)
>>>>>>> polyval_generic(E) libata(E) ghash_clmulni_intel(E) sha512_ssse3(E)
>>>>>>> virtio_blk(E) serio_raw(E) btrfs(E) xor(E) zstd_compress(E)
>>>>>>> raid6_pq(E) libcrc32c(E) crc32c_intel(E) dm_mirror(E)
>>>>>>> dm_region_hash(E) dm_log(E) dm_mod(E)
>>>>>>> [ 3049.283345] Unloaded tainted modules: edac_mce_amd(E):1 padlock_aes(E)
>>>>>>>
>>>>>>> Any suggestion on how to fix it is appreciated.
>>>>>>
>>>>>> Bisect between v6.8.9 and v6.8.10 would give us the exact point
>>>>>> where the failures were introduced.
>>>>>>
>>>>>> I see that GregKH pulled in:
>>>>>>
>>>>>> 26a0ddb04230 ("nfsd: rename NFSD_NET_* to NFSD_STATS_*")
>>>>>> b7b05f98f3f0 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
>>>>>> abf5fb593c90 ("nfsd: make all of the nfsd stats per-network namespace")
>>>>>>
>>>>>> for v6.8.10 as a Stable-Dep-of: 18180a4550d0 ("NFSD: Fix nfsd4_encode_fattr4() crasher")
>>>>>>
>>>>>> Which is a little baffling, I don't see how those two change sets
>>>>>> are mechanically related to each other. But I suspect the culprit is
>>>>>> one of those three stat-related patches.
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Chuck Lever
>>>>>
>>>>>
>>>>> Hello,
>>>>>
>>>>> I run bisecting. It was easy to reproduce, simple execution of
>>>>> "nfsstat" from terminal stuck the server:
>>>>>
>>>>> abf5fb593c90d3ab55d6cf1dea7bec8ee0bf3566 is the first bad commit
>>>>>
>>>>>
>>>>> $ git bisect bad
>>>>> abf5fb593c90d3ab55d6cf1dea7bec8ee0bf3566 is the first bad commit
>>>>> commit abf5fb593c90d3ab55d6cf1dea7bec8ee0bf3566 (HEAD)
>>>>> Author: Josef Bacik <josef@toxicpanda.com>
>>>>> Date:   Fri Jan 26 10:39:47 2024 -0500
>>>>>
>>>>>   nfsd: make all of the nfsd stats per-network namespace
>>>>>
>>>>>   [ Upstream commit 4b14885411f74b2b0ce0eb2b39d0fffe54e5ca0d ]
>>>>>
>>>>>   We have a global set of counters that we modify for all of the nfsd
>>>>>   operations, but now that we're exposing these stats across all network
>>>>>   namespaces we need to make the stats also be per-network namespace.  We
>>>>>   already have some caching stats that are per-network namespace, so move
>>>>>   these definitions into the same counter and then adjust all the helpers
>>>>>   and users of these stats to provide the appropriate nfsd_net struct so
>>>>>   that the stats are maintained for the per-network namespace objects.
>>>>>
>>>>>   Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>>>   Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>>>   Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>>   Stable-dep-of: 18180a4550d0 ("NFSD: Fix nfsd4_encode_fattr4() crasher")
>>>>>   Signed-off-by: Sasha Levin <sashal@kernel.org>
>>>>>
>>>>> fs/nfsd/cache.h     |  2 --
>>>>> fs/nfsd/netns.h     | 17 +++++++++++++++--
>>>>> fs/nfsd/nfs4proc.c  |  6 +++---
>>>>> fs/nfsd/nfs4state.c |  3 ++-
>>>>> fs/nfsd/nfscache.c  | 36 +++++++-----------------------------
>>>>> fs/nfsd/nfsctl.c    | 12 +++---------
>>>>> fs/nfsd/nfsfh.c     |  3 ++-
>>>>> fs/nfsd/stats.c     | 26 ++++++++++++++------------
>>>>> fs/nfsd/stats.h     | 54 +++++++++++++++++++-----------------------------------
>>>>> fs/nfsd/vfs.c       |  6 ++++--
>>>>> 10 files changed, 69 insertions(+), 96 deletions(-)
>>>>>
>>>>> $ git bisect log
>>>>> git bisect start
>>>>> # status: waiting for both good and bad commits
>>>>> # good: [f3d61438b613b87afb63118bea6fb18c50ba7a6b] Linux 6.8.9
>>>>> git bisect good f3d61438b613b87afb63118bea6fb18c50ba7a6b
>>>>> # status: waiting for bad commit, 1 good commit known
>>>>> # bad: [a0c69a570e420e86c7569b8c052913213eef2b45] Linux 6.8.10
>>>>> git bisect bad a0c69a570e420e86c7569b8c052913213eef2b45
>>>>> # bad: [4aaed9dbe8acd2b6114458f0498a617283d6275b] hv_netvsc: Don't
>>>>> free decrypted memory
>>>>> git bisect bad 4aaed9dbe8acd2b6114458f0498a617283d6275b
>>>>> # bad: [ee190d04c2f99c8e557b00e997621c04592baed1] net: gro: add flush
>>>>> check in udp_gro_receive_segment
>>>>> git bisect bad ee190d04c2f99c8e557b00e997621c04592baed1
>>>>> # bad: [781e34b736014188ba9e46a71535237313dcda81] efi/unaccepted:
>>>>> touch soft lockup during memory accept
>>>>> git bisect bad 781e34b736014188ba9e46a71535237313dcda81
>>>>> # bad: [6a7b07689af6e4e023404bf69b1230f43b2a15bc] NFSD: Fix
>>>>> nfsd4_encode_fattr4() crasher
>>>>> git bisect bad 6a7b07689af6e4e023404bf69b1230f43b2a15bc
>>>>> # good: [e05194baae299f2148ab5f6bab659c6ce8d1f6d3] nfs: expose
>>>>> /proc/net/sunrpc/nfs in net namespaces
>>>>> git bisect good e05194baae299f2148ab5f6bab659c6ce8d1f6d3
>>>>> # good: [946ab150335d92f852288c1c6b0f0466b5d6e97f] power: supply:
>>>>> mt6360_charger: Fix of_match for usb-otg-vbus regulator
>>>>> git bisect good 946ab150335d92f852288c1c6b0f0466b5d6e97f
>>>>> # good: [b7b05f98f3f06fea3986b46e5c7fe2928676b02d] nfsd: expose
>>>>> /proc/net/sunrpc/nfsd in net namespaces
>>>>> git bisect good b7b05f98f3f06fea3986b46e5c7fe2928676b02d
>>>>> # bad: [0e8003af77879572dbc1df56860cbe2bfa8498f0] NFSD: add support
>>>>> for CB_GETATTR callback
>>>>> git bisect bad 0e8003af77879572dbc1df56860cbe2bfa8498f0
>>>>> # bad: [abf5fb593c90d3ab55d6cf1dea7bec8ee0bf3566] nfsd: make all of
>>>>> the nfsd stats per-network namespace
>>>>> git bisect bad abf5fb593c90d3ab55d6cf1dea7bec8ee0bf3566
>>>>> # first bad commit: [abf5fb593c90d3ab55d6cf1dea7bec8ee0bf3566] nfsd:
>>>>> make all of the nfsd stats per-network namespace
>>>>
>>>> I built a full 6.8.10 with reverted single commit
>>>> "abf5fb593c90d3ab55d6cf1dea7bec8ee0bf3566". The server does not get
>>>> stuck when calling "nfsstat".
>>>
>>> Good to know, but I don't think it's entirely safe to revert
>>> only that patch -- all three would have to come off.
>>>
>>> I can't seem to get nfsstat to trigger a problem on my
>>> server.
>>>
>>>
>>> --
>>> Chuck Lever
>>>
>>>
> 
> --
> Chuck Lever
> 
> 

