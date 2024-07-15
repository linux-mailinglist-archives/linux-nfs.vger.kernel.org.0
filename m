Return-Path: <linux-nfs+bounces-4933-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8013E931A40
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 20:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1531F21C2E
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 18:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BBA482EF;
	Mon, 15 Jul 2024 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Boug55xQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF8118B1A
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067913; cv=none; b=NGvOxagSiWPalt1WIWWK20Q9QtjNBziDvlxEm/VgGmgbBODYd5HwU2s0SY/MlXWjd8ZCEVWeCkL8WGg4zzaeaaNRuqjDpDRi6J7RtZXbz3w3bWqskip2R110T5xN5/zFCnmdC0nm8ESLftbW+rhOyL6NbiF9DU0yrc4Fj6181Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067913; c=relaxed/simple;
	bh=mpEpxSRRTRkk5YVuqQgSXOOhMaUcwFiMNY1p9tnrw0A=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=n8U+HlkRULFwM+VphyGb2j5oQvAxzprSA/UKDdjqazh+da0bFqMCgCzeZwllXxc0JJodaqRUxQ3p2bPN11/YReSFlwzdWnAKvks9MGN5Ow79FUp26kJh8r2yaYcgB6jLIxi0DgOOgGTiA49x/W8HJiQOpuuZnU/BE0X664RuF3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Boug55xQ; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 496814DAC9
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 20:17:51 +0200 (CEST)
Received: from [192.168.1.10] (unknown [46.22.16.140])
	(Authenticated sender: blokos@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id CBB8A2003DD
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 20:17:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1721067463;
	bh=mpEpxSRRTRkk5YVuqQgSXOOhMaUcwFiMNY1p9tnrw0A=;
	h=Date:To:From:Subject:From;
	b=Boug55xQ3OXDpNgYm7t0Zv40zJio3TwXcDswaz9pfy/4pQhAswEOnSGAdEUoYs/04
	 RIhGmwthZuB/nsRyUmqEmYpDPbbVt+XZcI8kIxzQTMQFOrALMiBdicnItJ+ZnX3zvq
	 /nrd6KdusE1ClGWdIoX1AuidSmGU/S+t9ZAMdsj7b2jUayroe6hewdNGyoBzUFXkA+
	 MtzhfeyAWkPELUjXE+IN+lyioc7sbN/J+KuL9YKpIWQ8IJwG363fg4KpNx8RPIx0Eo
	 MtneuN6+Fr0beZMnoVf2P2F7wO1nYcXNc/AfkFZyOpkkdlmJQgc06L1PIGquD2EFo/
	 eZPjSoX/Kkytw==
Message-ID: <b78c88db-8b3a-4008-94cb-82ae08f0e37b@free.fr>
Date: Mon, 15 Jul 2024 11:17:42 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-nfs@vger.kernel.org
From: blokos <blokos@free.fr>
Subject: kernel 6.10
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi there,

since kernel 6.10 I see this in dmesg

[ 1110.417792] BUG: kernel NULL pointer dereference, address: 
00000000000003a6
[ 1110.417835] #PF: supervisor read access in kernel mode
[ 1110.417843] #PF: error_code(0x0000) - not-present page
[ 1110.417850] PGD 0 P4D 0
[ 1110.417856] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[ 1110.417864] CPU: 6 PID: 79 Comm: kworker/u32:4 Tainted: 
G                T  6.10.0 #1
[ 1110.417875] Hardware name: Dell Inc. PowerEdge R210 II/03X6X0, BIOS 
2.10.0 05/24/2018
[ 1110.417884] Workqueue: writeback wb_workfn (flush-0:67)
[ 1110.417895] RIP: 0010:nfs_folio_find_private_request+0x3c/0xa0
[ 1110.417905] Code: 8b 07 f6 c4 08 75 56 4c 8b 63 18 48 8b 03 31 ed f6 
c4 40 74 3c 49 83 c4 48 4c 89 e7 e8 7d 0a e7 00 48 8b 6b 28 48 85 ed 74 
1f <48> 39 6d 50 75 4f 48 8d 7d 34 b 8 01 00 00 00 f0 0f c1 45 34 85 c0
[ 1110.417925] RSP: 0018:ffffb1ddc02ff858 EFLAGS: 00010206
[ 1110.417932] RAX: 0000000000000000 RBX: ffffde301370f780 RCX: 
000037dc6007b980
[ 1110.417942] RDX: 0000000000000001 RSI: ffffb1ddc02ffb78 RDI: 
ffff9a012332cb40
[ 1110.417950] RBP: 0000000000000356 R08: 0000000000000001 R09: 
0000000000000048
[ 1110.417959] R10: 0000000000000006 R11: ffffffffffffffff R12: 
ffff9a012332cb40
[ 1110.417968] R13: ffff9a012332c970 R14: ffff9a012332c970 R15: 
ffffb1ddc02ff93c
[ 1110.417977] FS:  0000000000000000(0000) GS:ffff9a015fc00000(0000) 
knlGS:000000000000000 0
[ 1110.417986] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1110.417994] CR2: 00000000000003a6 CR3: 0000000447242004 CR4: 
00000000001706f0
[ 1110.418003] Call Trace:
[ 1110.418008]  <TASK>
[ 1110.418012]  ? __die_body.cold+0x19/0x2c
[ 1110.418020]  ? page_fault_oops+0x155/0x2b0
[ 1110.418028]  ? search_module_extables+0x10/0x50
[ 1110.418036]  ? search_bpf_extables+0x56/0x80
[ 1110.418044]  ? exc_page_fault+0x66/0xb0
[ 1110.418052]  ? asm_exc_page_fault+0x22/0x30
[ 1110.418061]  ? nfs_folio_find_private_request+0x3c/0xa0
[ 1110.418069]  ? nfs_folio_find_private_request+0x33/0xa0
[ 1110.418076]  nfs_lock_and_join_requests+0xd8/0x290
[ 1110.418084]  ? __mod_memcg_lruvec_state+0xfc/0x1d0
[ 1110.418093]  nfs_page_async_flush+0x16/0x320
[ 1110.418100]  ? __pfx_nfs_writepages_callback+0x10/0x10
[ 1110.418107]  nfs_writepages_callback+0x3d/0x70
[ 1110.418283]  write_cache_pages+0x5f/0xb0
[ 1110.418426]  nfs_writepages+0x13d/0x210
[ 1110.418567]  do_writepages+0x78/0x280
[ 1110.418706]  ? __skb_datagram_iter+0x76/0x2a0
[ 1110.418846]  ? __pfx_simple_copy_to_iter+0x10/0x10
[ 1110.418986]  __writeback_single_inode+0x30/0x190
[ 1110.419123]  ? select_task_rq_fair+0x7e8/0x1db0
[ 1110.419258]  writeback_sb_inodes+0x21a/0x4a0
[ 1110.419394]  __writeback_inodes_wb+0x47/0xe0
[ 1110.419529]  wb_writeback.isra.0+0x174/0x1e0
[ 1110.419662]  wb_workfn+0x1e8/0x310
[ 1110.419794]  process_one_work+0x16d/0x280
[ 1110.419924]  worker_thread+0x256/0x390
[ 1110.420052]  ? __pfx_worker_thread+0x10/0x10
[ 1110.420177]  kthread+0xc9/0x100
[ 1110.420301]  ? __pfx_kthread+0x10/0x10
[ 1110.420425]  ret_from_fork+0x2b/0x40
[ 1110.420548]  ? __pfx_kthread+0x10/0x10
[ 1110.420670]  ret_from_fork_asm+0x1a/0x30
[ 1110.420791]  </TASK>
[ 1110.420924] Modules linked in: tls nft_chain_nat xt_MASQUERADE nf_nat 
nf_conntrack_netl ink xt_addrtype dm_thin_pool dm_persistent_data 
dm_bio_prison ts_bm nft_limit xt_string xt _connlimit nf_conncount 
xt_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 x 
t_hashlimit nft_compat nf_tables sch_prio act_police cls_u32 sch_ingress 
iscsi_tcp libiscs i_tcp rdma_ucm ib_iser libiscsi rdma_rxe ib_uverbs 
ip6_udp_tunnel udp_tunnel scsi_transpor t_iscsi ip_set_hash_ip lz4 
lz4_compress jc42 gpio_ich kvm_intel kvm bnx2 lpc_ich sch_fq_co del 
dm_multipath zstd raid0 polyval_clmulni polyval_generic sha512_ssse3 
sha256_ssse3 sha1 _ssse3 scsi_dh_rdac scsi_dh_emc scsi_dh_alua fuse 
br_netfilter bridge stp llc mgag200 drm_ shmem_helper snd_aloop snd_pcm 
snd_timer snd soundcore i915 i2c_algo_bit drm_buddy ttm drm 
_display_helper i2c_dev msr
[ 1110.421864] CR2: 00000000000003a6
[ 1110.421988] ---[ end trace 0000000000000000 ]---
[ 1110.430766] RIP: 0010:nfs_folio_find_private_request+0x3c/0xa0
[ 1110.430997] Code: 8b 07 f6 c4 08 75 56 4c 8b 63 18 48 8b 03 31 ed f6 
c4 40 74 3c 49 83 c4 48 4c 89 e7 e8 7d 0a e7 00 48 8b 6b 28 48 85 ed 74 
1f <48> 39 6d 50 75 4f 48 8d 7d 34 b 8 01 00 00 00 f0 0f c1 45 34 85 c0
[ 1110.431266] RSP: 0018:ffffb1ddc02ff858 EFLAGS: 00010206
[ 1110.431400] RAX: 0000000000000000 RBX: ffffde301370f780 RCX: 
000037dc6007b980
[ 1110.431536] RDX: 0000000000000001 RSI: ffffb1ddc02ffb78 RDI: 
ffff9a012332cb40
[ 1110.431673] RBP: 0000000000000356 R08: 0000000000000001 R09: 
0000000000000048
[ 1110.431810] R10: 0000000000000006 R11: ffffffffffffffff R12: 
ffff9a012332cb40
[ 1110.431949] R13: ffff9a012332c970 R14: ffff9a012332c970 R15: 
ffffb1ddc02ff93c
[ 1110.432088] FS:  0000000000000000(0000) GS:ffff9a015fc00000(0000) 
knlGS:000000000000000 0
[ 1110.432231] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1110.432373] CR2: 00000000000003a6 CR3: 0000000447242004 CR4: 
00000000001706f0
[ 1110.432518] note: kworker/u32:4[79] exited with irqs disabled
[ 1110.432677] note: kworker/u32:4[79] exited with preempt_count 1
[ 1110.432847] ------------[ cut here ]------------
[ 1110.433033] WARNING: CPU: 6 PID: 79 at kernel/exit.c:825 
do_exit+0x82b/0xa40
[ 1110.433184] Modules linked in: tls nft_chain_nat xt_MASQUERADE nf_nat 
nf_conntrack_netl ink xt_addrtype dm_thin_pool dm_persistent_data 
dm_bio_prison ts_bm nft_limit xt_string xt _connlimit nf_conncount 
xt_limit xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 x 
t_hashlimit nft_compat nf_tables sch_prio act_police cls_u32 sch_ingress 
iscsi_tcp libiscs i_tcp rdma_ucm ib_iser libiscsi rdma_rxe ib_uverbs 
ip6_udp_tunnel udp_tunnel scsi_transpor t_iscsi ip_set_hash_ip lz4 
lz4_compress jc42 gpio_ich kvm_intel kvm bnx2 lpc_ich sch_fq_co del 
dm_multipath zstd raid0 polyval_clmulni polyval_generic sha512_ssse3 
sha256_ssse3 sha1 _ssse3 scsi_dh_rdac scsi_dh_emc scsi_dh_alua fuse 
br_netfilter bridge stp llc mgag200 drm_ shmem_helper snd_aloop snd_pcm 
snd_timer snd soundcore i915 i2c_algo_bit drm_buddy ttm drm 
_display_helper i2c_dev msr
[ 1110.434416] CPU: 6 PID: 79 Comm: kworker/u32:4 Tainted: G D         
T  6.10.0 #1
[ 1110.434588] Hardware name: Dell Inc. PowerEdge R210 II/03X6X0, BIOS 
2.10.0 05/24/2018
[ 1110.434792] Workqueue: writeback wb_workfn (flush-0:67)
[ 1110.434976] RIP: 0010:do_exit+0x82b/0xa40
[ 1110.435151] Code: 83 d0 0c 00 00 e9 e9 fd ff ff 48 8b bb 90 0a 00 00 
31 f6 e8 97 e2 ff ff e9 6f fd ff ff 48 89 df e8 da 4a 0f 00 e9 cd f9 ff 
ff <0f> 0b e9 40 f8 ff ff 4c 89 e6 b f 05 06 00 00 e8 41 f0 00 00 e9 c3
[ 1110.435533] RSP: 0018:ffffb1ddc02ffed8 EFLAGS: 00010282
[ 1110.435725] RAX: 0000000000000000 RBX: ffff99fa40b5c000 RCX: 
0000000000000000
[ 1110.435918] RDX: 0000000000000001 RSI: 0000000000002710 RDI: 
ffff99fa40bd18c0
[ 1110.436115] RBP: ffff99fa40bde300 R08: 0000000000000000 R09: 
ffffb1ddc02ffdc8
[ 1110.436311] R10: ffffffffa334b428 R11: 0000000000000003 R12: 
0000000000000009
[ 1110.436509] R13: ffff99fa40bd18c0 R14: 0000000000000000 R15: 
0000000000000000
[ 1110.436707] FS:  0000000000000000(0000) GS:ffff9a015fc00000(0000) 
knlGS:000000000000000 0
[ 1110.436908] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1110.437130] CR2: 00000000000003a6 CR3: 0000000447242004 CR4: 
00000000001706f0
[ 1110.437348] Call Trace:
[ 1110.437556]  <TASK>
[ 1110.437750]  ? __warn+0x7f/0xb1
[ 1110.437943]  ? do_exit+0x82b/0xa40
[ 1110.438133]  ? report_bug+0xf6/0x140
[ 1110.438319]  ? handle_bug+0x3c/0x80
[ 1110.438500]  ? exc_invalid_op+0x13/0x60
[ 1110.438694]  ? asm_exc_invalid_op+0x16/0x20
[ 1110.438872]  ? do_exit+0x82b/0xa40
[ 1110.439050]  ? do_exit+0x64/0xa40
[ 1110.439243]  make_task_dead+0x88/0x90
[ 1110.439412]  rewind_stack_and_make_dead+0x16/0x20
[ 1110.439577] RIP: 0000:0x0
[ 1110.439756] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[ 1110.439918] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 
0000000000000000
[ 1110.440085] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000000
[ 1110.440267] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000000000000
[ 1110.440428] RBP: 0000000000000000 R08: 0000000000000000 R09: 
0000000000000000
[ 1110.440596] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000000
[ 1110.440762] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[ 1110.440917]  </TASK>
[ 1110.441068] ---[ end trace 0000000000000000 ]---


I really don't know what's happening here

thanks for your help

Sarah


