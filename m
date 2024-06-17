Return-Path: <linux-nfs+bounces-3890-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4463590AA32
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 11:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25B42836E3
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 09:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4461946C4;
	Mon, 17 Jun 2024 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/CRJcwp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2A194A68;
	Mon, 17 Jun 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617222; cv=none; b=T3+8CmJkGQp9vLmjZz5kWPbYxW2AqZwfE4CU2+OM1BOX2Lt/N9PfygdPUU0Z95nEMgcjNhNEMaV6BhDVDHAiqZFxW2Zv7cEL2JHi3oYMbPqfsmxMrn4+mZdCr4nHXJ9Qi6fqZGraHlGeMIuMKZk5qFkMu+UXowcDisTVel+SCuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617222; c=relaxed/simple;
	bh=vsZ1trUtiw8fgH+CCMNP79vOqp5MLiAdLIcCAGUCoEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+pg/Yy5boLKg0P8KE0Icd/5V1xlcD+Arr5QGkM+5ZY/+ABMm4mJwd+KF9t7MhoedQxdzVJe+CXCloKNyUzPnCD4fGx4Br/dWUL45WkREt3Xz3z4Q/IAyAwzXs/QZMbaiUfN6MVX80FTinvzFNrjQZPkMdlE/97K2De5YY/+Fgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/CRJcwp; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4eb3277badcso1248770e0c.3;
        Mon, 17 Jun 2024 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718617219; x=1719222019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuDlyu9i7r0os+gEKzNJUuH1CCj1UPa7Q3D2hYttq4o=;
        b=O/CRJcwpPOIFhTFJUoO38cq1Nmxt6g0HewdMfLUrcmWdzBGEKMerGXMUne11ZvvGyH
         rl5hROWvdqhz6/hkxQyhaIEqQ0eLz9LtJuOClUgAA3zTL6B8aS6ZXWOpZF8KebMyTK0x
         99vV6Cph0tXYgFSa2H7KsgjjlCrdfoWiVJhE77a6lIp0J/TW9UIti8MOBTKD0EoxxUkA
         7BLDe3k0xM2efjnQcjzcava04eh/XBLeUp+RKA6W9SxzmMITwB36SL4BoEFOXGSoNsAF
         bIF55AY7tuKCHk/PnIeE2zTLQ63feZIZxjrOmeW6492uS9+NmG4Y0E3ZDXZVbjwb4K5N
         K5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718617219; x=1719222019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuDlyu9i7r0os+gEKzNJUuH1CCj1UPa7Q3D2hYttq4o=;
        b=sbWa8qDms07HYW4DNE8F/Uhizl4hcn4q2Ty+eaDXnLhWYQeH6yWEnIzkShBqx+XoEn
         Va9njfRRXnABYDhWdsiM4qyko6wIUq2UkTNGBZGLc+hzw1lgcIPqBhLu3lPyArDzjsO6
         hf+vGc2WwHplQfMiFyEdPC4ES219C0UxAuSFOv6eI2K8CVDbTC+IOgEBDcf3rw+C1eZE
         4dcRB7Wm0VxZ5hdZPQGXJ1OXBdX55m/lSyv2bibA9L6xB2FidTrbmNJlvVoKo03U7WiM
         VdB5N8pp478arptniA5PtPlS0dwl6tNwRDHERiZfybaVaf4/5RABoZG600BttpO3+/TT
         8+DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW4B+pZuRLTfwwVronbjnnLeilXx/1QBADJZXEflIQdPjvcxdi8E+grVGOt6Y0hNbJnQIhBtHGohUHT5hBQwAhW689qFd2NI7d4mkd2p84jWnrrxNHrtyHPzaiSoYhsRDcWdWScg==
X-Gm-Message-State: AOJu0YwH9N60Z7IoLGnMnDDDEwxNNz9Wl/qDZNDSU2JLdtehmMBdNKo1
	nmtvWzZiwA9CnujV7TSqoAtVQKrO2G25ZCISIw+nWL6yIKV9p7nE82wKcNlL/3VuSj8P29JQrgv
	NBjhi1NafjiX9/s5JXgNKEvBjm8c=
X-Google-Smtp-Source: AGHT+IEw6oDtm4mejFc0hZ7G9vbnUGfrUvJh9D6qHrcpHhpur5dNcAqM9IaP9weIEh32H/dNyPOlDpXOCwBcuv77C8I=
X-Received: by 2002:a05:6122:c9f:b0:4ed:80:bd85 with SMTP id
 71dfb90a1353d-4ee3df992c1mr8545507e0c.5.1718617219511; Mon, 17 Jun 2024
 02:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614100329.1203579-1-hch@lst.de> <20240614100329.1203579-2-hch@lst.de>
 <20240614112148.cd1961e84b736060c54bdf26@linux-foundation.org>
 <CAGsJ_4wnWzoScqO9_NddHcDPbe_GbAiRFVm4w_H+QDmH=e=Rsw@mail.gmail.com>
 <20240616085436.GA28058@lst.de> <CAGsJ_4ytrnXJbfVi=PpTw34iBDqEoAm3b16oZr2VQpVWLmh5zA@mail.gmail.com>
 <9ef638fc-5606-45da-a237-2e09ee05bbeb@arm.com>
In-Reply-To: <9ef638fc-5606-45da-a237-2e09ee05bbeb@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 17 Jun 2024 21:40:08 +1200
Message-ID: <CAGsJ_4xDkjN0X8ogE9djmu+nDUd_PJcSwr+GVH4vUiUAeJskaQ@mail.gmail.com>
Subject: Re: [PATCH] nfs: fix nfs_swap_rw for large-folio swap
To: Ryan Roberts <ryan.roberts@arm.com>, Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 8:03=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 16/06/2024 11:23, Barry Song wrote:
> > On Sun, Jun 16, 2024 at 4:54=E2=80=AFPM Christoph Hellwig <hch@lst.de> =
wrote:
> >>
> >> On Sun, Jun 16, 2024 at 12:16:10PM +1200, Barry Song wrote:
> >>> As I understand it, this isn't happening because we don't support
> >>> mTHP swapping out to a swapfile, whether it's on NFS or any
> >>> other filesystem.
> >>
> >> It does happen.  The reason why I sent this patch is becaue I observed
> >> the BUG_ON trigger on a trivial swap generation workload (usemem.c fro=
m
> >> xfstests).
> >
> > This is quite unusual. Could you share your setup and backtrace? I'd
> > like to reproduce the issue, as the mm code only supports mTHP
> > swapout on block devices. What is your swap device or swap file?
> > Additionally, on what kind of filesystem is the executable file built
> > from usemem.c located?
>
> Yes, I'm also confused by this, since as Barry says, the swap-out changes=
 to
> support mTHP are only intended to be activated when the swap device is a
> non-rotating block device - swap files on file systems are explicitly not
> supported and all swapping should be done page-by-page in that case. This
> constraint is exactly the same as for the pre-existing PMD-size THP swap-=
out
> support. So if you are seeing large folios being written after the mTHP s=
wap-out
> change, you should also be seeing large folios before this change.
>
> Hopefully the stack trace will tell us what's going on here.

Hi Ryan, Christoph,

I am able to reproduce the issue now. I am debugging and will update
the root cause
with you this week.

Initial investigation shows the issue might *not* be related to THP_SWPOUT.

I am even able to reproduce it after disabling thp and mthp, entirely by
small folios:

[  215.925069] folio_alloc_swap folio nr:1 anon:1 swapbacked:1
[  215.926383] vmscan: shrink_folio_list folio nr:1 anon:1 swapbacked:1
[  215.927008] folio_alloc_swap folio nr:1 anon:1 swapbacked:1
[  215.929368] ------------[ cut here ]------------
[  215.929824] kernel BUG at fs/nfs/direct.c:144!
[  215.930403] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SM=
P
[  215.931264] Modules linked in:
[  215.932328] CPU: 3 PID: 214 Comm: mthp_swpout_tes Not tainted
6.10.0-rc3-ga12328d9fb85-dirty #292
[  215.932953] Hardware name: linux,dummy-virt (DT)
[  215.933461] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=
=3D--)
[  215.934030] pc : nfs_swap_rw+0x60/0x70
[  215.935079] lr : swap_write_unplug+0x64/0xb0
[  215.935559] sp : ffff800087363280
[  215.935958] x29: ffff800087363280 x28: ffff0000c3241800 x27: fffffdffc32=
3a4c0
[  215.937012] x26: fffffdffc323a4c8 x25: ffff0001b4a51500 x24: ffff8000825=
0f670
[  215.937893] x23: 0000000000000001 x22: ffff0000c0b2da00 x21: 00000000000=
20000
[  215.938734] x20: ffff0000c46a8bd8 x19: ffff0000c154f800 x18: fffffffffff=
fffff
[  215.939594] x17: 0000000000000000 x16: 0000000000000000 x15: ffff8001073=
63097
[  215.940591] x14: 0000000000000000 x13: 313a64656b636162 x12: 70617773203=
13a6e
[  215.941621] x11: 6f6e6120313a726e x10: ffff800083e86318 x9 : ffff8000803=
e9ad4
[  215.942673] x8 : ffff800087363168 x7 : 0000000000000000 x6 : ffff0001adb=
fa4c6
[  215.943674] x5 : 0000000000000002 x4 : 0000000000020000 x3 : 00000000000=
20000
[  215.944673] x2 : ffff8000806015e8 x1 : ffff8000873632a0 x0 : ffff0000c15=
4f800
[  215.945568] Call trace:
[  215.945906]  nfs_swap_rw+0x60/0x70
[  215.946351]  __swap_writepage+0x2e8/0x328
[  215.946775]  swap_writepage+0x68/0xd0
[  215.947184]  pageout+0xe4/0x430
[  215.947587]  shrink_folio_list+0x9bc/0xf60
[  215.947992]  reclaim_folio_list+0x8c/0x168
[  215.948454]  reclaim_pages+0xfc/0x178
[  215.948843]  madvise_cold_or_pageout_pte_range+0x8d8/0xf28
[  215.949285]  walk_pgd_range+0x390/0x808
[  215.949660]  __walk_page_range+0x1e0/0x1f0
[  215.950040]  walk_page_range+0x1f0/0x2c8
[  215.950458]  madvise_pageout+0xf8/0x280
[  215.950905]  madvise_vma_behavior+0x314/0xa20
[  215.951361]  madvise_walk_vmas+0xc0/0x128
[  215.951807]  do_madvise.part.0+0x110/0x558
[  215.952298]  __arm64_sys_madvise+0x68/0x88
[  215.952723]  invoke_syscall+0x50/0x128
[  215.953148]  el0_svc_common.constprop.0+0x48/0xf8
[  215.953592]  do_el0_svc+0x28/0x40
[  215.954036]  el0_svc+0x50/0x150
[  215.954610]  el0t_64_sync_handler+0x13c/0x158
[  215.955070]  el0t_64_sync+0x1a4/0x1a8
[  215.955685] Code: a8c17bfd d50323bf 9a9fd000 d65f03c0 (d4210000)
[  215.956510] ---[ end trace 0000000000000000 ]---


>
> (Sorry for my slow responses/lack of engagement over the last month; its =
been a
> combination of paternity leave/lack of sleep/working on other things. I'm=
 hoping
> to get properly back into this stuff within the next couple of weeks).
>
> Thanks,
> Ryan
>

