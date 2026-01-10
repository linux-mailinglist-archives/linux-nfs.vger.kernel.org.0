Return-Path: <linux-nfs+bounces-17723-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C814FD0D42F
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Jan 2026 10:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A54B730204B1
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Jan 2026 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6C021257A;
	Sat, 10 Jan 2026 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kc8eccxX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DDD11713;
	Sat, 10 Jan 2026 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768038517; cv=none; b=YKyhX1+pLHz2Mf5wWeIhfujCPCz5PN28DJBbedG3DikS5xJu8k58FedUWHG9U8HEMPL5nCK2CBdNebhSKzfz7wEovahuAcuBXoXmWDvCZddIRdOGIbRV/0VVdEPYsYwLL7HBg1EmX2Pry3YCZW8SEeDeV0ztM6aB8wt6oY7leU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768038517; c=relaxed/simple;
	bh=2pMUr17XpgrQhSuv59gTKcLq65rE5CC2s3p54E+p6l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM+BUT8da0NiuGDiJoPAHOzCD7JN3vWUZlbc3hAxjHA8E3zC4TdY3XtdZXJ7tZNu84IfDOS8J9Q7d97aZYtFSH1BbQNbIy1WvN2GW7OV96yAiORGQWHZ/KnnQyYJRna/zYxD6bDcx/4RySHztyXQcrEjTnZ3IvR6RouYOYdi4No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kc8eccxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5AAC4CEF1;
	Sat, 10 Jan 2026 09:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768038517;
	bh=2pMUr17XpgrQhSuv59gTKcLq65rE5CC2s3p54E+p6l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kc8eccxXoin+36nV3T3wmYJQ4cnmOJchuWsxLtILe1eAXvTaIIdWJRJJQIFtgdeAk
	 GAaAjJU7yxqOO900A+IKMct4GxEiA1iTmFJhRfcZow50U7qYdJ2PTqdft00xkPJ5wj
	 FQj3tbqPv3Y+RzdBddGueGFlTrfN3ubDjIUAHnHCgHzVFO6I5sicixCsS6JfeGDNaN
	 HxGspFG1tgfLisGScVUci0KT2i7u6RQe6tifmHFIrA4XgMRhcPqbkj3B+nKuUIrLzP
	 IrKiNNso4Aba7O21Ighvq4zRFwRqp12s8GXcLkmk8/+LbrxvMt+gPP0JsnYAtneagM
	 eFFjGTp4p7YkQ==
Date: Sat, 10 Jan 2026 04:48:36 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Mike Owen <mjnowen@gmail.com>
Cc: Daire Byrne <daire@dneg.com>, dhowells@redhat.com,
	linux-nfs@vger.kernel.org, netfs@lists.linux.dev,
	trondmy@hammerspace.com, okorniev@redhat.com
Subject: Re: fscache/NFS re-export server lockup
Message-ID: <aWIgdDImfFg6fgxn@kernel.org>
References: <CADFF-zeNJUPLaVcogSBt=s4+o2Lty45-DueSYKJmCgZw6hraEg@mail.gmail.com>
 <CAPt2mGOV+ZxVLkFFXRKX3Cr9vZ-pd=5QeN=cxwc_msGFtpPN=Q@mail.gmail.com>
 <CADFF-zcFgycZ7c0KC_5eUafjvba_ZxhzED0a7yDR4oip4_KxbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADFF-zcFgycZ7c0KC_5eUafjvba_ZxhzED0a7yDR4oip4_KxbA@mail.gmail.com>

Hi Mike,

On Fri, Jan 09, 2026 at 09:45:47PM +0000, Mike Owen wrote:
> Hi Daire, thanks for the comments.
> 
> > Can you stop the nfs server and is access to /var/cache/fscache still blocked?
> As the machine is deadlocked, after reboot (so the nfs server is
> definitely stopped), the actual data is gone/corrupted.
> 
> >And I presume there is definitely nothing else that might be
> interacting with that /var/cache/fscache filesystem outside of fscache
> or cachefilesd?
> Correct. Machine is dedicated to KNFSD caching duties.
> 
> > Our /etc/cachefilesd.conf is pretty basic (brun 30%, bcull 10%, bstop 3%).
> Similar settings here:
> brun 20%
> bcull 7%
> bstop 3%
> frun 20%
> fcull 7%
> fstop 3%
> Although I should note that the issue happens when only ~10-20% of the
> NVMe capacity is used, so culling has never had to run at this point.
> 
> We did try running 6.17.0 but made no difference. I see another thread
> of yours with Chuck: "refcount_t underflow (nfsd4_sequence_done?) with
> v6.18 re-export"
> and suggested commits to investigate, incl: cbfd91d22776 ("nfsd: never
> defer requests during idmap lookup") as well as try using 6.18.4, so
> it's possible there is a cascading issue here and we are in need of
> some NFS patches.
> 
> I'm hoping @dhowells might have some suggestions on how to further
> debug this issue, given the below stack we are seeing when it
> deadlocks?
> 
> Thanks,
> -Mike

This commit from Trond, which he'll be sending to Linus soon as part
of his 6.19-rc NFS client fixes pull request, should fix the NFS
re-export induced nfs_release_folio deadlock reflected in your below
stack trace:
https://git.linux-nfs.org/?p=trondmy/linux-nfs.git;a=commitdiff;h=cce0be6eb4971456b703aaeafd571650d314bcca

Here is more context for why I know that to be likely, it fixed my
nasty LOCALIO-based reexport deadlock situation too:
https://lore.kernel.org/linux-nfs/20260107160858.6847-1-snitzer@kernel.org/

I'm doing my part to advocate that Red Hat (Olga cc'd) take this
fix into RHEL 10.2 (and backport as needed).

Good luck getting Ubuntu to include this fix in a timely manner (we'll
all thank you for that if you can help shake the Canonical tree).

BTW, you'd do well to fix your editor/email so that it doesn't line
wrap when you share logs on Linux mailing lists:

> 2025-12-03T15:57:25.438905+00:00 ip-172-23-113-43 kernel: INFO: task
> kcompactd0:171 blocked for more than 122 seconds.
> 2025-12-03T15:57:25.438921+00:00 ip-172-23-113-43 kernel:
> Tainted: G           OE      6.14.0-36-generic #36~24.04.1-Ubuntu
> 2025-12-03T15:57:25.438928+00:00 ip-172-23-113-43 kernel: "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> 2025-12-03T15:57:25.439 is bellow995+00:00 ip-172-23-113-43 kernel:
> task:kcompactd0      state:D stack:0     pid:171   tgid:171   ppid:2
>    task_flags:0x210040 flags:0x00004000
> 2025-12-03T15:57:25.440000+00:00 ip-172-23-113-43 kernel: Call Trace:
> 2025-12-03T15:57:25.440000+00:00 ip-172-23-113-43 kernel:  <TASK>
> 2025-12-03T15:57:25.440003+00:00 ip-172-23-113-43 kernel:
> __schedule+0x2cf/0x640
> 2025-12-03T15:57:25.441017+00:00 ip-172-23-113-43 kernel:  schedule+0x29/0xd0
> 2025-12-03T15:57:25.441022+00:00 ip-172-23-113-43 kernel:  io_schedule+0x4c/0x80
> 2025-12-03T15:57:25.441023+00:00 ip-172-23-113-43 kernel:
> folio_wait_bit_common+0x138/0x310
> 2025-12-03T15:57:25.441023+00:00 ip-172-23-113-43 kernel:  ?
> __pfx_wake_page_function+0x10/0x10
> 2025-12-03T15:57:25.441024+00:00 ip-172-23-113-43 kernel:
> folio_wait_private_2+0x2c/0x60
> 2025-12-03T15:57:25.441025+00:00 ip-172-23-113-43 kernel:
> nfs_release_folio+0xa0/0x120 [nfs]
> 2025-12-03T15:57:25.441032+00:00 ip-172-23-113-43 kernel:
> filemap_release_folio+0x68/0xa0
> 2025-12-03T15:57:25.441033+00:00 ip-172-23-113-43 kernel:
> split_huge_page_to_list_to_order+0x401/0x970
> 2025-12-03T15:57:25.441033+00:00 ip-172-23-113-43 kernel:  ?
> compaction_alloc_noprof+0x1c5/0x2f0
> 2025-12-03T15:57:25.441034+00:00 ip-172-23-113-43 kernel:
> split_folio_to_list+0x22/0x70
> 2025-12-03T15:57:25.441035+00:00 ip-172-23-113-43 kernel:
> migrate_pages_batch+0x2f2/0xa70
> 2025-12-03T15:57:25.441035+00:00 ip-172-23-113-43 kernel:  ?
> __pfx_compaction_free+0x10/0x10
> 2025-12-03T15:57:25.441038+00:00 ip-172-23-113-43 kernel:  ?
> __pfx_compaction_alloc+0x10/0x10
> 2025-12-03T15:57:25.441039+00:00 ip-172-23-113-43 kernel:  ?
> __mod_memcg_lruvec_state+0xf4/0x250
> 2025-12-03T15:57:25.441039+00:00 ip-172-23-113-43 kernel:  ?
> migrate_pages_batch+0x5e8/0xa70
> 2025-12-03T15:57:25.441040+00:00 ip-172-23-113-43 kernel:
> migrate_pages_sync+0x84/0x1e0
> 2025-12-03T15:57:25.441040+00:00 ip-172-23-113-43 kernel:  ?
> __pfx_compaction_free+0x10/0x10
> 2025-12-03T15:57:25.441041+00:00 ip-172-23-113-43 kernel:  ?
> __pfx_compaction_alloc+0x10/0x10
> 2025-12-03T15:57:25.441044+00:00 ip-172-23-113-43 kernel:
> migrate_pages+0x38f/0x4c0
> 2025-12-03T15:57:25.441047+00:00 ip-172-23-113-43 kernel:  ?
> __pfx_compaction_free+0x10/0x10
> 2025-12-03T15:57:25.441048+00:00 ip-172-23-113-43 kernel:  ?
> __pfx_compaction_alloc+0x10/0x10
> 2025-12-03T15:57:25.441048+00:00 ip-172-23-113-43 kernel:
> compact_zone+0x385/0x700
> 2025-12-03T15:57:25.441049+00:00 ip-172-23-113-43 kernel:  ?
> isolate_migratepages_range+0xc1/0xf0
> 2025-12-03T15:57:25.441049+00:00 ip-172-23-113-43 kernel:
> kcompactd_do_work+0xfc/0x240
> 2025-12-03T15:57:25.441050+00:00 ip-172-23-113-43 kernel:  kcompactd+0x43f/0x4a0
> 2025-12-03T15:57:25.441052+00:00 ip-172-23-113-43 kernel:  ?
> __pfx_autoremove_wake_function+0x10/0x10
> 2025-12-03T15:57:25.441053+00:00 ip-172-23-113-43 kernel:  ?
> __pfx_kcompactd+0x10/0x10
> 2025-12-03T15:57:25.441053+00:00 ip-172-23-113-43 kernel:  kthread+0xfe/0x230
> 2025-12-03T15:57:25.441054+00:00 ip-172-23-113-43 kernel:  ?
> __pfx_kthread+0x10/0x10
> 2025-12-03T15:57:25.441054+00:00 ip-172-23-113-43 kernel:
> ret_from_fork+0x47/0x70
> 2025-12-03T15:57:25.441055+00:00 ip-172-23-113-43 kernel:  ?
> __pfx_kthread+0x10/0x10
> 2025-12-03T15:57:25.441057+00:00 ip-172-23-113-43 kernel:
> ret_from_fork_asm+0x1a/0x30
> 2025-12-03T15:57:25.441058+00:00 ip-172-23-113-43 kernel:  </TASK>

