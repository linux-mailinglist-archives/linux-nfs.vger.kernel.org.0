Return-Path: <linux-nfs+bounces-17753-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1C3D13AF3
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 16:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A06303022F0F
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jan 2026 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FD72E7199;
	Mon, 12 Jan 2026 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhz8pe2U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C0296BDB
	for <linux-nfs@vger.kernel.org>; Mon, 12 Jan 2026 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230994; cv=none; b=K7JZ1D8HKS3MLnSvddGE43fbjavmjC2XbSZVVC4cqzkDceFmkeUdEy2v+TWZYebjSvzwsI3yoQ62LdR1Ix6E8DHsXkkTAsMKOi8PUTmdb+pMxQ98l8kNFHRwwYC/xNu1N5DLbUr7HMQX+cMmtE5xx0vcNQlAfHFe/s/CW6DC8Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230994; c=relaxed/simple;
	bh=S450hIDOWWsDIofXxicq/L+YCE1u3Z2yrEPfLDSBbqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdDfTMU3LMFrcQXWgeidABlgy6Dt/lzNrKe2vjp3QSdy+AX+gRCkaEfKrDK413tm91uq4G4zCGfy4S9kJOoiX8PmBX7sg2ikA+Jhy/8lCkhQzhpLeHFMq8YDoc1P76l3x6vmNBDbyCIAYnU2amj5eNvQ8RPCvMYxFLJx0oIa+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhz8pe2U; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-890228ed342so69759616d6.2
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jan 2026 07:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768230992; x=1768835792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MoKlWPcUEY0HTUZFf3NIt2JrP4vfvCGXXVYplHzrD0k=;
        b=lhz8pe2UlQ1kKWiBg3Bc9QtFeAwiDMbii6dFUVSh2ghujrYe+Kn/Vj4W5aj1LLdC15
         LDW8h2Z1BdGlFWqtIFoBqTFa8cw4nC9JhdxNrb7DhC2P60IavnY3oQmQwPMfutBwojbA
         c2lfYVpFdRwXrPRpPL1joBgkgdOJ9aethQP/0o2TwAWC7ZgQFLgLot2lK7NjYltDJ3pZ
         +5BlPppcCidGoRPuuRe+haQl2nvhtnrpG7/QJgzexffmP2hdUr4jyqsVTItUzE89Y4Z4
         1BoEHyMIMyYGAUqHBZzZYC6oIZSbIyRVUV8GReBLuBni8rGKAt9oXLx/q9tAC7U/Ck5x
         3fTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768230992; x=1768835792;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoKlWPcUEY0HTUZFf3NIt2JrP4vfvCGXXVYplHzrD0k=;
        b=enUbNeOOkxEVKpou2jph039VOkopRtJMISwgauOoaovO0rYYSN+FzDyUvtU0Rvn2pH
         l5pFZWutrIYM+G9YNoVtuJwCbkvSkUtXw77B6g+BXbwW37w4sgeX6Xd6mFm5dR5hdzZP
         pre4bZ4hh+2dslTULAfy+YEVrVQec9wAQ3ACHBSSBQ0maJShWCXtR2bpzYmijFID7ROg
         kTePQlosj55Qk7v6ThctyxQfxt8sj5bXxC59G9v/kEo3kWEveZV3xP1sbz4CYRZtwWG+
         qX1SCzFaW4OBC+1Pz8Ua47uh9b+7BFn59+R5x04fXPe/bpBlOyHEZjR9vpKfmbMRJUOm
         rnSw==
X-Forwarded-Encrypted: i=1; AJvYcCU3Gffll+8BULT3ZQTtOa0SlV/yVc/z8eRU6djcR5DX+zvp2CKSOWVBY444FVOj9kik0KvPBxlECL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5B7pcZ9PGWETHFN6V403lHuzCYKYzI5XT3Mkh27u/K4gbsbwp
	q/GwzpJvtTkYuUfwnpUwaxScEZP8cVatY5mm8UVk5JxkdzPfE9LyT6ZdIBpfjAvbvoyAvF2hlqm
	NJrsU+hZPMQuevAn2niIYI/YqNUukgdA=
X-Gm-Gg: AY/fxX6O7E4K4+IDPVW9oHpFu4GZKkGJ+p0k2aP27KpUQDPpqaADq/xQykeSb0trPBI
	mBUAITQmVTTg0X5NHzniiyThQVipd+JTB20OeSigvL15Qv2fOfkEAaC64u6HhnR9SjUfdlxC+Wq
	nW5LnIdUlDBKC7tCugPn2NGkKOLbss/LcAvIJtpv6G7IXrF34ggNmHBctS8Pe+V2CzK5Fn8I4Rh
	BM2353eCMEE40pXNliZutomlI5+S4FjmPU2ZufGXXDcZuycCfWfWGAqpNtxF/p4Sxl0Cr7elJO6
	9lWdy6bw5BljnYvXJlWi1xCpGw==
X-Google-Smtp-Source: AGHT+IFeiEU2FlSzR7eAgESQKlIGW2EkPddzGwQiXS9SvwHpuA7rZaW6nlLUS9tbLtioPq38cf5mtSMlGjCF6Hj7/4I=
X-Received: by 2002:a05:6214:3f89:b0:88a:3b1d:2f70 with SMTP id
 6a1803df08f44-890841e461cmr236461286d6.10.1768230991390; Mon, 12 Jan 2026
 07:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADFF-zeNJUPLaVcogSBt=s4+o2Lty45-DueSYKJmCgZw6hraEg@mail.gmail.com>
 <CAPt2mGOV+ZxVLkFFXRKX3Cr9vZ-pd=5QeN=cxwc_msGFtpPN=Q@mail.gmail.com>
 <CADFF-zcFgycZ7c0KC_5eUafjvba_ZxhzED0a7yDR4oip4_KxbA@mail.gmail.com> <aWIgdDImfFg6fgxn@kernel.org>
In-Reply-To: <aWIgdDImfFg6fgxn@kernel.org>
Reply-To: mjnowen@gmail.com
From: Mike Owen <mjnowen@gmail.com>
Date: Mon, 12 Jan 2026 15:16:20 +0000
X-Gm-Features: AZwV_QjMDrGAS_wx8jscHyCw9C1LIQWE5jfMK9Fw02L8E8FeVM3CydfaZTNQK8M
Message-ID: <CADFF-zf1qypwRDYkCPH9MFVLoPgsJxsNXZ7-qEbiMLo-L3Ldsg@mail.gmail.com>
Subject: Re: fscache/NFS re-export server lockup
To: Mike Snitzer <snitzer@kernel.org>
Cc: Daire Byrne <daire@dneg.com>, dhowells@redhat.com, linux-nfs@vger.kernel.org, 
	netfs@lists.linux.dev, trondmy@hammerspace.com, okorniev@redhat.com
Content-Type: text/plain; charset="UTF-8"

Ah, this looks promising. Thanks for the info, Mike!
Whilst we wait for the necessary NFS client fixes PR, I'll look to add
the patch to 6.19-rc5 and report back if this fixes the issue we are
seeing.
I'll see what I can do internally to advocate Canonical absorbing it as well.
ACK on my log wrapping. My bad.
Thanks again!
-Mike

On Sat, 10 Jan 2026 at 09:48, Mike Snitzer <snitzer@kernel.org> wrote:
>
> Hi Mike,
>
> On Fri, Jan 09, 2026 at 09:45:47PM +0000, Mike Owen wrote:
> > Hi Daire, thanks for the comments.
> >
> > > Can you stop the nfs server and is access to /var/cache/fscache still blocked?
> > As the machine is deadlocked, after reboot (so the nfs server is
> > definitely stopped), the actual data is gone/corrupted.
> >
> > >And I presume there is definitely nothing else that might be
> > interacting with that /var/cache/fscache filesystem outside of fscache
> > or cachefilesd?
> > Correct. Machine is dedicated to KNFSD caching duties.
> >
> > > Our /etc/cachefilesd.conf is pretty basic (brun 30%, bcull 10%, bstop 3%).
> > Similar settings here:
> > brun 20%
> > bcull 7%
> > bstop 3%
> > frun 20%
> > fcull 7%
> > fstop 3%
> > Although I should note that the issue happens when only ~10-20% of the
> > NVMe capacity is used, so culling has never had to run at this point.
> >
> > We did try running 6.17.0 but made no difference. I see another thread
> > of yours with Chuck: "refcount_t underflow (nfsd4_sequence_done?) with
> > v6.18 re-export"
> > and suggested commits to investigate, incl: cbfd91d22776 ("nfsd: never
> > defer requests during idmap lookup") as well as try using 6.18.4, so
> > it's possible there is a cascading issue here and we are in need of
> > some NFS patches.
> >
> > I'm hoping @dhowells might have some suggestions on how to further
> > debug this issue, given the below stack we are seeing when it
> > deadlocks?
> >
> > Thanks,
> > -Mike
>
> This commit from Trond, which he'll be sending to Linus soon as part
> of his 6.19-rc NFS client fixes pull request, should fix the NFS
> re-export induced nfs_release_folio deadlock reflected in your below
> stack trace:
> https://git.linux-nfs.org/?p=trondmy/linux-nfs.git;a=commitdiff;h=cce0be6eb4971456b703aaeafd571650d314bcca
>
> Here is more context for why I know that to be likely, it fixed my
> nasty LOCALIO-based reexport deadlock situation too:
> https://lore.kernel.org/linux-nfs/20260107160858.6847-1-snitzer@kernel.org/
>
> I'm doing my part to advocate that Red Hat (Olga cc'd) take this
> fix into RHEL 10.2 (and backport as needed).
>
> Good luck getting Ubuntu to include this fix in a timely manner (we'll
> all thank you for that if you can help shake the Canonical tree).
>
> BTW, you'd do well to fix your editor/email so that it doesn't line
> wrap when you share logs on Linux mailing lists:
>
> > 2025-12-03T15:57:25.438905+00:00 ip-172-23-113-43 kernel: INFO: task
> > kcompactd0:171 blocked for more than 122 seconds.
> > 2025-12-03T15:57:25.438921+00:00 ip-172-23-113-43 kernel:
> > Tainted: G           OE      6.14.0-36-generic #36~24.04.1-Ubuntu
> > 2025-12-03T15:57:25.438928+00:00 ip-172-23-113-43 kernel: "echo 0 >
> > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > 2025-12-03T15:57:25.439 is bellow995+00:00 ip-172-23-113-43 kernel:
> > task:kcompactd0      state:D stack:0     pid:171   tgid:171   ppid:2
> >    task_flags:0x210040 flags:0x00004000
> > 2025-12-03T15:57:25.440000+00:00 ip-172-23-113-43 kernel: Call Trace:
> > 2025-12-03T15:57:25.440000+00:00 ip-172-23-113-43 kernel:  <TASK>
> > 2025-12-03T15:57:25.440003+00:00 ip-172-23-113-43 kernel:
> > __schedule+0x2cf/0x640
> > 2025-12-03T15:57:25.441017+00:00 ip-172-23-113-43 kernel:  schedule+0x29/0xd0
> > 2025-12-03T15:57:25.441022+00:00 ip-172-23-113-43 kernel:  io_schedule+0x4c/0x80
> > 2025-12-03T15:57:25.441023+00:00 ip-172-23-113-43 kernel:
> > folio_wait_bit_common+0x138/0x310
> > 2025-12-03T15:57:25.441023+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_wake_page_function+0x10/0x10
> > 2025-12-03T15:57:25.441024+00:00 ip-172-23-113-43 kernel:
> > folio_wait_private_2+0x2c/0x60
> > 2025-12-03T15:57:25.441025+00:00 ip-172-23-113-43 kernel:
> > nfs_release_folio+0xa0/0x120 [nfs]
> > 2025-12-03T15:57:25.441032+00:00 ip-172-23-113-43 kernel:
> > filemap_release_folio+0x68/0xa0
> > 2025-12-03T15:57:25.441033+00:00 ip-172-23-113-43 kernel:
> > split_huge_page_to_list_to_order+0x401/0x970
> > 2025-12-03T15:57:25.441033+00:00 ip-172-23-113-43 kernel:  ?
> > compaction_alloc_noprof+0x1c5/0x2f0
> > 2025-12-03T15:57:25.441034+00:00 ip-172-23-113-43 kernel:
> > split_folio_to_list+0x22/0x70
> > 2025-12-03T15:57:25.441035+00:00 ip-172-23-113-43 kernel:
> > migrate_pages_batch+0x2f2/0xa70
> > 2025-12-03T15:57:25.441035+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_compaction_free+0x10/0x10
> > 2025-12-03T15:57:25.441038+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_compaction_alloc+0x10/0x10
> > 2025-12-03T15:57:25.441039+00:00 ip-172-23-113-43 kernel:  ?
> > __mod_memcg_lruvec_state+0xf4/0x250
> > 2025-12-03T15:57:25.441039+00:00 ip-172-23-113-43 kernel:  ?
> > migrate_pages_batch+0x5e8/0xa70
> > 2025-12-03T15:57:25.441040+00:00 ip-172-23-113-43 kernel:
> > migrate_pages_sync+0x84/0x1e0
> > 2025-12-03T15:57:25.441040+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_compaction_free+0x10/0x10
> > 2025-12-03T15:57:25.441041+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_compaction_alloc+0x10/0x10
> > 2025-12-03T15:57:25.441044+00:00 ip-172-23-113-43 kernel:
> > migrate_pages+0x38f/0x4c0
> > 2025-12-03T15:57:25.441047+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_compaction_free+0x10/0x10
> > 2025-12-03T15:57:25.441048+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_compaction_alloc+0x10/0x10
> > 2025-12-03T15:57:25.441048+00:00 ip-172-23-113-43 kernel:
> > compact_zone+0x385/0x700
> > 2025-12-03T15:57:25.441049+00:00 ip-172-23-113-43 kernel:  ?
> > isolate_migratepages_range+0xc1/0xf0
> > 2025-12-03T15:57:25.441049+00:00 ip-172-23-113-43 kernel:
> > kcompactd_do_work+0xfc/0x240
> > 2025-12-03T15:57:25.441050+00:00 ip-172-23-113-43 kernel:  kcompactd+0x43f/0x4a0
> > 2025-12-03T15:57:25.441052+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_autoremove_wake_function+0x10/0x10
> > 2025-12-03T15:57:25.441053+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_kcompactd+0x10/0x10
> > 2025-12-03T15:57:25.441053+00:00 ip-172-23-113-43 kernel:  kthread+0xfe/0x230
> > 2025-12-03T15:57:25.441054+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_kthread+0x10/0x10
> > 2025-12-03T15:57:25.441054+00:00 ip-172-23-113-43 kernel:
> > ret_from_fork+0x47/0x70
> > 2025-12-03T15:57:25.441055+00:00 ip-172-23-113-43 kernel:  ?
> > __pfx_kthread+0x10/0x10
> > 2025-12-03T15:57:25.441057+00:00 ip-172-23-113-43 kernel:
> > ret_from_fork_asm+0x1a/0x30
> > 2025-12-03T15:57:25.441058+00:00 ip-172-23-113-43 kernel:  </TASK>

