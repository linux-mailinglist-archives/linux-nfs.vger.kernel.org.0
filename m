Return-Path: <linux-nfs+bounces-3892-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E93A90AB20
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 12:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBE01F223BD
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 10:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448717173C;
	Mon, 17 Jun 2024 10:33:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB5A5025E;
	Mon, 17 Jun 2024 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718620403; cv=none; b=WsORkfk9n0GRovcDe3TbqqT7wlAu4U6z3atDVz/2siFDs1krzwVR0nX/0d9frMr6DY2iKx94EWni+DDva12sZ7ny1RCD9nLd4xQB19VyGK7fgyqjZHueAI8eJ/EP7SBFIQ4pjy5aVs3yGtx5PomRkY6SQN7h7FAMUoEHOJzmbcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718620403; c=relaxed/simple;
	bh=D7daG2P3zTaLVdDPsBZ0/zrVy1K9o+Z2GL96yr4V6sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uO2Dll4gjQ9kj0ZI15eHo3At01XwZTPocNxu/rDjX9ojMeHMttXIAAOZxpGmAkmcX9nXZ9l+qwMuz7hw8PvNla775ytMy4IA1ZswaFmTY/jk6LnWnYiRWoAU9r8ftDH5APeeuiS6IaD1xYtDyWgfUtT8IYH8qmQOFVOcFXHSZzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADC0FDA7;
	Mon, 17 Jun 2024 03:33:44 -0700 (PDT)
Received: from [10.57.73.35] (unknown [10.57.73.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 202233F6A8;
	Mon, 17 Jun 2024 03:33:17 -0700 (PDT)
Message-ID: <d91b3c19-5d62-457a-88e4-6bb6c3c7d6a6@arm.com>
Date: Mon, 17 Jun 2024 11:33:16 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: fix nfs_swap_rw for large-folio swap
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Steve French <sfrench@samba.org>, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <v-songbaohua@oppo.com>
References: <20240614100329.1203579-1-hch@lst.de>
 <20240614100329.1203579-2-hch@lst.de>
 <20240614112148.cd1961e84b736060c54bdf26@linux-foundation.org>
 <CAGsJ_4wnWzoScqO9_NddHcDPbe_GbAiRFVm4w_H+QDmH=e=Rsw@mail.gmail.com>
 <20240616085436.GA28058@lst.de>
 <CAGsJ_4ytrnXJbfVi=PpTw34iBDqEoAm3b16oZr2VQpVWLmh5zA@mail.gmail.com>
 <9ef638fc-5606-45da-a237-2e09ee05bbeb@arm.com>
 <CAGsJ_4xDkjN0X8ogE9djmu+nDUd_PJcSwr+GVH4vUiUAeJskaQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4xDkjN0X8ogE9djmu+nDUd_PJcSwr+GVH4vUiUAeJskaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/06/2024 10:40, Barry Song wrote:
> On Mon, Jun 17, 2024 at 8:03 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 16/06/2024 11:23, Barry Song wrote:
>>> On Sun, Jun 16, 2024 at 4:54 PM Christoph Hellwig <hch@lst.de> wrote:
>>>>
>>>> On Sun, Jun 16, 2024 at 12:16:10PM +1200, Barry Song wrote:
>>>>> As I understand it, this isn't happening because we don't support
>>>>> mTHP swapping out to a swapfile, whether it's on NFS or any
>>>>> other filesystem.
>>>>
>>>> It does happen.  The reason why I sent this patch is becaue I observed
>>>> the BUG_ON trigger on a trivial swap generation workload (usemem.c from
>>>> xfstests).
>>>
>>> This is quite unusual. Could you share your setup and backtrace? I'd
>>> like to reproduce the issue, as the mm code only supports mTHP
>>> swapout on block devices. What is your swap device or swap file?
>>> Additionally, on what kind of filesystem is the executable file built
>>> from usemem.c located?
>>
>> Yes, I'm also confused by this, since as Barry says, the swap-out changes to
>> support mTHP are only intended to be activated when the swap device is a
>> non-rotating block device - swap files on file systems are explicitly not
>> supported and all swapping should be done page-by-page in that case. This
>> constraint is exactly the same as for the pre-existing PMD-size THP swap-out
>> support. So if you are seeing large folios being written after the mTHP swap-out
>> change, you should also be seeing large folios before this change.
>>
>> Hopefully the stack trace will tell us what's going on here.
> 
> Hi Ryan, Christoph,
> 
> I am able to reproduce the issue now. I am debugging and will update
> the root cause
> with you this week.

Ahh great; for some reason I'm not receiving Chrostoph's mails so didn't see the
stack trace and instructions until you replied to it. I had a go are repro'ing
too but am failing to even get the systemd nfs service to start. I'll leave it
to you.

> 
> Initial investigation shows the issue might *not* be related to THP_SWPOUT.
> 
> I am even able to reproduce it after disabling thp and mthp, entirely by
> small folios:
> 
> [  215.925069] folio_alloc_swap folio nr:1 anon:1 swapbacked:1
> [  215.926383] vmscan: shrink_folio_list folio nr:1 anon:1 swapbacked:1
> [  215.927008] folio_alloc_swap folio nr:1 anon:1 swapbacked:1
> [  215.929368] ------------[ cut here ]------------
> [  215.929824] kernel BUG at fs/nfs/direct.c:144!
> [  215.930403] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> [  215.931264] Modules linked in:
> [  215.932328] CPU: 3 PID: 214 Comm: mthp_swpout_tes Not tainted
> 6.10.0-rc3-ga12328d9fb85-dirty #292
> [  215.932953] Hardware name: linux,dummy-virt (DT)
> [  215.933461] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [  215.934030] pc : nfs_swap_rw+0x60/0x70
> [  215.935079] lr : swap_write_unplug+0x64/0xb0
> [  215.935559] sp : ffff800087363280
> [  215.935958] x29: ffff800087363280 x28: ffff0000c3241800 x27: fffffdffc323a4c0
> [  215.937012] x26: fffffdffc323a4c8 x25: ffff0001b4a51500 x24: ffff80008250f670
> [  215.937893] x23: 0000000000000001 x22: ffff0000c0b2da00 x21: 0000000000020000
> [  215.938734] x20: ffff0000c46a8bd8 x19: ffff0000c154f800 x18: ffffffffffffffff
> [  215.939594] x17: 0000000000000000 x16: 0000000000000000 x15: ffff800107363097
> [  215.940591] x14: 0000000000000000 x13: 313a64656b636162 x12: 7061777320313a6e
> [  215.941621] x11: 6f6e6120313a726e x10: ffff800083e86318 x9 : ffff8000803e9ad4
> [  215.942673] x8 : ffff800087363168 x7 : 0000000000000000 x6 : ffff0001adbfa4c6
> [  215.943674] x5 : 0000000000000002 x4 : 0000000000020000 x3 : 0000000000020000
> [  215.944673] x2 : ffff8000806015e8 x1 : ffff8000873632a0 x0 : ffff0000c154f800
> [  215.945568] Call trace:
> [  215.945906]  nfs_swap_rw+0x60/0x70
> [  215.946351]  __swap_writepage+0x2e8/0x328
> [  215.946775]  swap_writepage+0x68/0xd0
> [  215.947184]  pageout+0xe4/0x430
> [  215.947587]  shrink_folio_list+0x9bc/0xf60
> [  215.947992]  reclaim_folio_list+0x8c/0x168
> [  215.948454]  reclaim_pages+0xfc/0x178
> [  215.948843]  madvise_cold_or_pageout_pte_range+0x8d8/0xf28
> [  215.949285]  walk_pgd_range+0x390/0x808
> [  215.949660]  __walk_page_range+0x1e0/0x1f0
> [  215.950040]  walk_page_range+0x1f0/0x2c8
> [  215.950458]  madvise_pageout+0xf8/0x280
> [  215.950905]  madvise_vma_behavior+0x314/0xa20
> [  215.951361]  madvise_walk_vmas+0xc0/0x128
> [  215.951807]  do_madvise.part.0+0x110/0x558
> [  215.952298]  __arm64_sys_madvise+0x68/0x88
> [  215.952723]  invoke_syscall+0x50/0x128
> [  215.953148]  el0_svc_common.constprop.0+0x48/0xf8
> [  215.953592]  do_el0_svc+0x28/0x40
> [  215.954036]  el0_svc+0x50/0x150
> [  215.954610]  el0t_64_sync_handler+0x13c/0x158
> [  215.955070]  el0t_64_sync+0x1a4/0x1a8
> [  215.955685] Code: a8c17bfd d50323bf 9a9fd000 d65f03c0 (d4210000)
> [  215.956510] ---[ end trace 0000000000000000 ]---
> 
> 
>>
>> (Sorry for my slow responses/lack of engagement over the last month; its been a
>> combination of paternity leave/lack of sleep/working on other things. I'm hoping
>> to get properly back into this stuff within the next couple of weeks).
>>
>> Thanks,
>> Ryan
>>


