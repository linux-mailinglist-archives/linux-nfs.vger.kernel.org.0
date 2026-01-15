Return-Path: <linux-nfs+bounces-17966-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F18D4D28E89
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 22:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F41A43064AA1
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jan 2026 21:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C36328605;
	Thu, 15 Jan 2026 21:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV0BKAUB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A8132573C;
	Thu, 15 Jan 2026 21:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768514031; cv=none; b=H5oW6Df3tXTj0131lUkMGABJegt213XnY5Z3cn6VFsB0Hkg+zrNZstkUCjZEtN49MQToHdA4c82OA0eObw21MvFhbhbjpHHRv/Ghb0nzKsKqgvIEaFP3KGvfjOk39d0sz/2Hl+jyCn6lbQR/T+X1utfCKa1QXluV0I4eM/HGMGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768514031; c=relaxed/simple;
	bh=AzZxYenLiBx6EPlRytXbfJ7VSldjQrSuEncKRM+E190=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyK0xvwyukPNbhprPXX57ZcQIqMUio3HMniZOUca6/UAtLlaKTcJpxrrIxGLldP/NqLU18HtCFoVeyb51AT+CE5v6Ik2/fhOpiJZs4zXAsuoRZO3As3skuG+d4iFJdA7U2bxlj1AQsUW1g5GvYFljKZ2API4arHTgJ0Nyejk6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV0BKAUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA1EC4AF09;
	Thu, 15 Jan 2026 21:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768514031;
	bh=AzZxYenLiBx6EPlRytXbfJ7VSldjQrSuEncKRM+E190=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mV0BKAUBbNk6sxESOybRj0S70OY2dKeLBjJFTAxt7V3LAkQTBDkOrLMxLrSdgZ9Zo
	 bWC1pwq6pMr4TPOew7HqLK6iR4hvTmlP9GilFAZUUVOwEsprdg9ZUpqqAv4IrHURxD
	 b38J0NAcsEWyoPGP2SQ5+/CGoXg9olxXkOIwkP1FhZ/Mm+z6z+HBg9ouEYHMB5FqX3
	 J1oxju+mD5b2oXMmxlv9NTi4GWydQZCCqgyQqgQh5eYH/UdvFGlLkG94NOvXr6RXei
	 mGfhbbkfi5Z+Y1cQPRtNH70lo8Ogtd1PlTS4BzhGTVW1rK6zc7gLr2gtsAHpdJyoh7
	 RAgqYOfFTXurA==
Date: Thu, 15 Jan 2026 16:53:49 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Mike Owen <mjnowen@gmail.com>
Cc: Daire Byrne <daire@dneg.com>, dhowells@redhat.com,
	linux-nfs@vger.kernel.org, netfs@lists.linux.dev,
	trondmy@hammerspace.com, okorniev@redhat.com
Subject: Re: fscache/NFS re-export server lockup
Message-ID: <aWlh7XAoR0NENXNo@kernel.org>
References: <CADFF-zeNJUPLaVcogSBt=s4+o2Lty45-DueSYKJmCgZw6hraEg@mail.gmail.com>
 <CAPt2mGOV+ZxVLkFFXRKX3Cr9vZ-pd=5QeN=cxwc_msGFtpPN=Q@mail.gmail.com>
 <CADFF-zcFgycZ7c0KC_5eUafjvba_ZxhzED0a7yDR4oip4_KxbA@mail.gmail.com>
 <aWIgdDImfFg6fgxn@kernel.org>
 <CADFF-zf1qypwRDYkCPH9MFVLoPgsJxsNXZ7-qEbiMLo-L3Ldsg@mail.gmail.com>
 <c6dc98cc-df27-4a37-9b15-c4543e199ad0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6dc98cc-df27-4a37-9b15-c4543e199ad0@gmail.com>

On Thu, Jan 15, 2026 at 03:20:24PM +0000, Mike Owen wrote:
> Hi Mike S,
> 
> On 12/01/2026 15:16, Mike Owen wrote:
> > Ah, this looks promising. Thanks for the info, Mike!
> > Whilst we wait for the necessary NFS client fixes PR, I'll look to add
> > the patch to 6.19-rc5 and report back if this fixes the issue we are
> > seeing.
> > I'll see what I can do internally to advocate Canonical absorbing it as well.
> > ACK on my log wrapping. My bad.
> > Thanks again!
> > -Mike
> > 
> > On Sat, 10 Jan 2026 at 09:48, Mike Snitzer <snitzer@kernel.org> wrote:
> >>
> >> Hi Mike,
> >>
> >> On Fri, Jan 09, 2026 at 09:45:47PM +0000, Mike Owen wrote:
> >>> Hi Daire, thanks for the comments.
> >>>
> >>>> Can you stop the nfs server and is access to /var/cache/fscache still blocked?
> >>> As the machine is deadlocked, after reboot (so the nfs server is
> >>> definitely stopped), the actual data is gone/corrupted.
> >>>
> >>>> And I presume there is definitely nothing else that might be
> >>> interacting with that /var/cache/fscache filesystem outside of fscache
> >>> or cachefilesd?
> >>> Correct. Machine is dedicated to KNFSD caching duties.
> >>>
> >>>> Our /etc/cachefilesd.conf is pretty basic (brun 30%, bcull 10%, bstop 3%).
> >>> Similar settings here:
> >>> brun 20%
> >>> bcull 7%
> >>> bstop 3%
> >>> frun 20%
> >>> fcull 7%
> >>> fstop 3%
> >>> Although I should note that the issue happens when only ~10-20% of the
> >>> NVMe capacity is used, so culling has never had to run at this point.
> >>>
> >>> We did try running 6.17.0 but made no difference. I see another thread
> >>> of yours with Chuck: "refcount_t underflow (nfsd4_sequence_done?) with
> >>> v6.18 re-export"
> >>> and suggested commits to investigate, incl: cbfd91d22776 ("nfsd: never
> >>> defer requests during idmap lookup") as well as try using 6.18.4, so
> >>> it's possible there is a cascading issue here and we are in need of
> >>> some NFS patches.
> >>>
> >>> I'm hoping @dhowells might have some suggestions on how to further
> >>> debug this issue, given the below stack we are seeing when it
> >>> deadlocks?
> >>>
> >>> Thanks,
> >>> -Mike
> >>
> >> This commit from Trond, which he'll be sending to Linus soon as part
> >> of his 6.19-rc NFS client fixes pull request, should fix the NFS
> >> re-export induced nfs_release_folio deadlock reflected in your below
> >> stack trace:
> >> https://git.linux-nfs.org/?p=trondmy/linux-nfs.git;a=commitdiff;h=cce0be6eb4971456b703aaeafd571650d314bcca
> >>
> >> Here is more context for why I know that to be likely, it fixed my
> >> nasty LOCALIO-based reexport deadlock situation too:
> >> https://lore.kernel.org/linux-nfs/20260107160858.6847-1-snitzer@kernel.org/
> >>
> >> I'm doing my part to advocate that Red Hat (Olga cc'd) take this
> >> fix into RHEL 10.2 (and backport as needed).
> >>
> >> Good luck getting Ubuntu to include this fix in a timely manner (we'll
> >> all thank you for that if you can help shake the Canonical tree).
> >>
> >> BTW, you'd do well to fix your editor/email so that it doesn't line
> >> wrap when you share logs on Linux mailing lists:
> >>
> ...
> 
> We deployed 6.19-rc5 + kernel patch: "NFS: Fix a deadlock involving nfs_release_folio()" but unfortunately this has not fixed the issue. The KNFSD server becomes wedged (as far as NFSD is concerned, can still login) and we get the attached dmesg log. I attempted an analysis/RCA of this circular dependency/deadlock issue to try and assist getting this resolved (see attached). Any other patches to try?
> -Mike

> [Thu Jan 15 10:37:38 2026] md127: array will not be assembled in old kernels that lack configurable LBS support (<= 6.18)
> [Thu Jan 15 10:37:38 2026] md127: detected capacity change from 0 to 29296345088
> [Thu Jan 15 10:38:46 2026] EXT4-fs (md127): mounted filesystem cc12ea7f-34f9-445a-b8ad-a9f1a122c51d r/w with ordered data mode. Quota mode: none.
> [Thu Jan 15 10:38:46 2026] netfs: FS-Cache loaded
> [Thu Jan 15 10:38:46 2026] CacheFiles: Loaded
> [Thu Jan 15 10:38:46 2026] netfs: Cache "mycache" added (type cachefiles)
> [Thu Jan 15 10:38:46 2026] CacheFiles: File cache on mycache registered
> [Thu Jan 15 10:39:07 2026] NFSD: Using nfsdcld client tracking operations.
> [Thu Jan 15 10:39:07 2026] NFSD: no clients to reclaim, skipping NFSv4 grace period (net effffff9)
> [Thu Jan 15 10:39:28 2026] audit: type=1400 audit(1768473568.836:130): apparmor="STATUS" operation="profile_replace" info="same as current profile, skipping" profile="unconfined" name="rsyslogd" pid=8112 comm="apparmor_parser"
> [Thu Jan 15 10:40:39 2026] hrtimer: interrupt took 10300 ns
> [Thu Jan 15 10:42:35 2026] loop4: detected capacity change from 0 to 98480
> [Thu Jan 15 10:42:35 2026] audit: type=1400 audit(1768473755.481:131): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/snap/snapd/25935/usr/lib/snapd/snap-confine" pid=9736 comm="apparmor_parser"
> [Thu Jan 15 10:42:35 2026] audit: type=1400 audit(1768473755.482:132): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/snap/snapd/25935/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=9736 comm="apparmor_parser"
> [Thu Jan 15 10:42:40 2026] loop5: detected capacity change from 0 to 8
> [Thu Jan 15 10:42:40 2026] audit: type=1400 audit(1768473760.184:133): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="/snap/snapd/25935/usr/lib/snapd/snap-confine" pid=10068 comm="apparmor_parser"
> [Thu Jan 15 10:42:40 2026] audit: type=1400 audit(1768473760.194:134): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="/snap/snapd/25935/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=10068 comm="apparmor_parser"
> [Thu Jan 15 10:42:40 2026] audit: type=1400 audit(1768473760.201:135): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="snap.amazon-ssm-agent.amazon-ssm-agent" pid=10071 comm="apparmor_parser"
> [Thu Jan 15 10:42:40 2026] audit: type=1400 audit(1768473760.201:136): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="snap.amazon-ssm-agent.ssm-cli" pid=10072 comm="apparmor_parser"
> [Thu Jan 15 10:42:40 2026] audit: type=1400 audit(1768473760.207:137): apparmor="STATUS" operation="profile_replace" profile="unconfined" name="snap-update-ns.amazon-ssm-agent" pid=10070 comm="apparmor_parser"
> [Thu Jan 15 11:59:09 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
> [Thu Jan 15 11:59:09 2026] netfs: O-cookie c=0000df95 [fl=6124 na=1 nA=2 s=L]
> [Thu Jan 15 11:59:09 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
> [Thu Jan 15 11:59:09 2026] netfs: O-key=[32] 'f360d67b060000003414386507000000ffffffff000000000200c10901000000'
> [Thu Jan 15 11:59:10 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
> [Thu Jan 15 11:59:10 2026] netfs: O-cookie c=0000e07f [fl=6124 na=1 nA=2 s=L]
> [Thu Jan 15 11:59:10 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
> [Thu Jan 15 11:59:10 2026] netfs: O-key=[32] 'f360d67b0600000020301c6207000000ffffffff000000000200c10901000000'
> [Thu Jan 15 11:59:10 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
> [Thu Jan 15 11:59:10 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
> [Thu Jan 15 11:59:10 2026] netfs: O-cookie c=0000e1a1 [fl=6124 na=1 nA=2 s=L]
> [Thu Jan 15 11:59:10 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
> [Thu Jan 15 11:59:10 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
> [Thu Jan 15 11:59:10 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
> [Thu Jan 15 11:59:10 2026] netfs: O-cookie c=0000e01c [fl=6124 na=1 nA=2 s=L]
> [Thu Jan 15 11:59:10 2026] netfs: O-cookie c=0000e14d [fl=6124 na=1 nA=2 s=L]
> [Thu Jan 15 11:59:10 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
> [Thu Jan 15 11:59:10 2026] netfs: O-key=[32] 'f360d67b0600000071149ebc06000000ffffffff000000000200c10901000000'
> [Thu Jan 15 11:59:10 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
> [Thu Jan 15 11:59:10 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
> [Thu Jan 15 11:59:10 2026] netfs: O-cookie c=0000b381 [fl=6124 na=1 nA=2 s=L]
> [Thu Jan 15 11:59:10 2026] netfs: O-key=[32] 'f360d67b06000000bfd9ce3407000000ffffffff000000000200c10901000000'
> [Thu Jan 15 11:59:10 2026] netfs: O-cookie c=0000df8c [fl=6124 na=1 nA=2 s=L]
> [Thu Jan 15 11:59:10 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
> [Thu Jan 15 11:59:10 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
> [Thu Jan 15 11:59:10 2026] netfs: O-key=[32] 'f360d67b060000006b7a9b3a07000000ffffffff000000000200c10901000000'
> [Thu Jan 15 11:59:10 2026] netfs: O-key=[32] 'f360d67b06000000317d6c3207000000ffffffff000000000200c10901000000'
> [Thu Jan 15 11:59:10 2026] netfs: O-cookie c=0000dbbc [fl=6124 na=1 nA=2 s=L]
> [Thu Jan 15 11:59:10 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
> [Thu Jan 15 11:59:10 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
> [Thu Jan 15 11:59:10 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
> [Thu Jan 15 11:59:10 2026] netfs: O-cookie c=0000b2c0 [fl=6124 na=1 nA=2 s=L]
> [Thu Jan 15 11:59:10 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
> [Thu Jan 15 11:59:10 2026] netfs: O-key=[32] 'f360d67b0600000038c7f06f06000000ffffffff000000000200c10901000000'
> [Thu Jan 15 11:59:10 2026] netfs: O-key=[32] 'f360d67b06000000e1483c3807000000ffffffff000000000200c10901000000'
> [Thu Jan 15 11:59:10 2026] netfs: O-key=[32] 'f360d67b06000000e811572e07000000ffffffff000000000200c10901000000'
> [Thu Jan 15 11:59:11 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
> [Thu Jan 15 11:59:11 2026] netfs: O-cookie c=0000dc24 [fl=6124 na=1 nA=2 s=L]
> [Thu Jan 15 11:59:11 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
> [Thu Jan 15 11:59:11 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
> [Thu Jan 15 11:59:11 2026] netfs: O-cookie c=0000c542 [fl=6124 na=1 nA=2 s=L]
> [Thu Jan 15 11:59:11 2026] netfs: O-key=[32] 'f360d67b06000000af19d78706000000ffffffff000000000200c10901000000'
> [Thu Jan 15 11:59:11 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
> [Thu Jan 15 11:59:11 2026] netfs: O-key=[32] 'f360d67b060000003d594c7508000000ffffffff000000000200c10901000000'
> [Thu Jan 15 11:59:11 2026] netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
> [Thu Jan 15 11:59:11 2026] netfs: O-cookie c=0000cea9 [fl=6124 na=1 nA=2 s=L]
> [Thu Jan 15 11:59:11 2026] netfs: O-cookie V=00000002 [Infs,3.0,2,,2109120a,7bd660f3,,,d0,100000,100000,927c0,927c0,927c0,927c0,1]
> [Thu Jan 15 11:59:11 2026] netfs: O-key=[32] 'f360d67b0600000016b7ae5907000000ffffffff000000000200c10901000000'
> [Thu Jan 15 12:01:08 2026] INFO: task kcompactd0:170 blocked for more than 122 seconds.
> [Thu Jan 15 12:01:08 2026]       Tainted: G           OE       6.19.0-rc5-knfsd #1
> [Thu Jan 15 12:01:08 2026] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [Thu Jan 15 12:01:08 2026] task:kcompactd0      state:D stack:0     pid:170   tgid:170   ppid:2      task_flags:0x210040 flags:0x00080000
> [Thu Jan 15 12:01:08 2026] Call Trace:
> [Thu Jan 15 12:01:08 2026]  <TASK>
> [Thu Jan 15 12:01:08 2026]  __schedule+0x481/0x17d0
> [Thu Jan 15 12:01:08 2026]  ? __pfx_radix_tree_node_ctor+0x10/0x10
> [Thu Jan 15 12:01:08 2026]  ? cgroup_writeback_by_id+0x4b/0x200
> [Thu Jan 15 12:01:08 2026]  ? xas_store+0x5b/0x7f0
> [Thu Jan 15 12:01:08 2026]  schedule+0x20/0xe0
> [Thu Jan 15 12:01:08 2026]  io_schedule+0x4c/0x80
> [Thu Jan 15 12:01:08 2026]  folio_wait_bit_common+0x133/0x310
> [Thu Jan 15 12:01:08 2026]  ? __pfx_wake_page_function+0x10/0x10
> [Thu Jan 15 12:01:08 2026]  folio_wait_private_2+0x2c/0x60
> [Thu Jan 15 12:01:08 2026]  nfs_release_folio+0x61/0x130 [nfs]
> [Thu Jan 15 12:01:08 2026]  filemap_release_folio+0x68/0xa0
> [Thu Jan 15 12:01:08 2026]  __folio_split+0x178/0x8e0
> [Thu Jan 15 12:01:08 2026]  ? post_alloc_hook+0xc1/0x140
> [Thu Jan 15 12:01:08 2026]  __split_huge_page_to_list_to_order+0x2b/0xb0
> [Thu Jan 15 12:01:08 2026]  split_folio_to_list+0x10/0x20
> [Thu Jan 15 12:01:08 2026]  migrate_pages_batch+0x45d/0xea0
> [Thu Jan 15 12:01:08 2026]  ? __pfx_compaction_alloc+0x10/0x10
> [Thu Jan 15 12:01:08 2026]  ? __pfx_compaction_free+0x10/0x10
> [Thu Jan 15 12:01:08 2026]  ? asm_exc_xen_unknown_trap+0x1/0x20
> [Thu Jan 15 12:01:08 2026]  ? __pfx_compaction_free+0x10/0x10
> [Thu Jan 15 12:01:08 2026]  migrate_pages+0xaef/0xd80
> [Thu Jan 15 12:01:08 2026]  ? __pfx_compaction_free+0x10/0x10
> [Thu Jan 15 12:01:08 2026]  ? __pfx_compaction_alloc+0x10/0x10
> [Thu Jan 15 12:01:08 2026]  compact_zone+0xb3f/0x1200
> [Thu Jan 15 12:01:08 2026]  ? psi_group_change+0x1f8/0x4c0
> [Thu Jan 15 12:01:08 2026]  ? kvm_sched_clock_read+0x11/0x20
> [Thu Jan 15 12:01:08 2026]  compact_node+0xaf/0x130
> [Thu Jan 15 12:01:08 2026]  kcompactd+0x374/0x4d0
> [Thu Jan 15 12:01:08 2026]  ? __pfx_autoremove_wake_function+0x10/0x10
> [Thu Jan 15 12:01:08 2026]  ? __pfx_kcompactd+0x10/0x10
> [Thu Jan 15 12:01:08 2026]  kthread+0xf9/0x210
> [Thu Jan 15 12:01:08 2026]  ? __pfx_kthread+0x10/0x10
> [Thu Jan 15 12:01:08 2026]  ret_from_fork+0x25c/0x290
> [Thu Jan 15 12:01:08 2026]  ? __pfx_kthread+0x10/0x10
> [Thu Jan 15 12:01:08 2026]  ret_from_fork_asm+0x1a/0x30
> [Thu Jan 15 12:01:08 2026]  </TASK>

OK, my deadlock was blocked in wait_on_commit whereas you've
consistently shown folio_wait_private_2 in your stack traces (I
originally missed that detail).  So I'm not aware of what is different
in your setup.. devil is in the details, but maybe its your use of
fscache?

> # Analysis of KNFSD/CacheFiles Deadlock
> 
> This document provides an analysis of a deadlock issue observed on Ubuntu 24.04 KNFSD nodes
> running a custom Linux kernel 6.19-rc5. The deadlock involves the NFS server (nfsd),
> CacheFiles/netfs layer, ext4 journaling, and memory compaction.
> 
> ## Summary
> 
> The system enters a deadlock state where:
> 
> 1. Multiple **nfsd threads** are blocked waiting for ext4 inode rw-semaphores
> 2. Those rw-semaphores are held by **kworker threads** (writers)
> 3. The **jbd2 journal thread** for the cache filesystem is blocked waiting for updates
> 4. **kcompactd** (memory compaction) is blocked waiting for an NFS folio to release fscache state
> 5. The **fscache cookie state machine** is timing out

David Howells may be able to inform his fscache-specific vantage point
by having a look at Trond's fix that I pointed to earlier?

Mike

ps. solid effort with your below analysis, but its quite fscache
specific so I think it'll best help inform David:

> 
> ## Environment
> 
> - **Kernel**: Linux 6.19.0-rc5-knfsd (custom build)
> - **Platform**: Amazon EC2 (24 CPUs, 192GB RAM)
> - **Configuration**: 256 nfsd threads
> - **Cache Filesystem**: ext4 on md127 RAID array
> 
> ## Detailed Breakdown
> 
> ### 1. Initial Symptom: Cookie State Timeouts (11:59:09)
> 
> The first warning signs appear as fscache cookie state timeout errors:
> 
> ```text
> netfs: fscache_begin_operation: cookie state change wait timed out: cookie->state=1 state=1
> ```
> 
> These errors indicate that fscache operations are waiting for cookies to transition to the
> correct state (`FSCACHE_COOKIE_STATE_ACTIVE`), but the state transitions are stalled.
> 
> ### 2. The Deadlock Chain (12:01:08)
> 
> #### kcompactd0 (memory compaction daemon)
> 
> ```text
> folio_wait_private_2+0x2c/0x60
> nfs_release_folio+0x61/0x130 [nfs]
> filemap_release_folio+0x68/0xa0
> __folio_split+0x178/0x8e0
> ```
> 
> The compaction daemon is trying to migrate/split NFS folios but is blocked in
> `folio_wait_private_2()`. This waits for the `PG_fscache` flag to clear, which happens when
> fscache completes its I/O operations on the folio. However, fscache operations are stuck.
> 
> #### jbd2/md127-8 (ext4 journal for cache filesystem)
> 
> ```text
> jbd2_journal_wait_updates+0x6e/0xe0
> jbd2_journal_commit_transaction+0x26e/0x1730
> ```
> 
> The journal commit is waiting for outstanding updates to complete, but those updates are
> blocked.
> 
> #### nfsd threads (multiple patterns)
> 
> **Pattern A** - Blocked on ext4 inode rwsem:
> 
> ```text
> rwsem_down_read_slowpath+0x278/0x500
> down_read+0x41/0xb0
> ext4_llseek+0xfc/0x120            <-- needs inode->i_rwsem for SEEK_DATA/SEEK_HOLE
> vfs_llseek+0x1c/0x40
> cachefiles_do_prepare_read        <-- checking what's cached
> ```
> 
> The kernel logs explicitly identify the blocking relationship:
> 
> - `nfsd:7300 <reader> blocked on an rw-semaphore likely owned by task kworker/u96:8:37820 <writer>`
> 
> **Pattern B** - Blocked on jbd2 transaction:
> 
> ```text
> wait_transaction_locked+0x87/0xd0
> add_transaction_credits+0x1e0/0x360
> jbd2__journal_start
> ext4_dirty_inode                  <-- updating atime on cache file
> cachefiles_read
> ```
> 
> ### 3. The Circular Dependency
> 
> ```text
>   nfsd read request
>        │
>        ▼
>   nfs_readahead → netfs_readahead → cachefiles_prepare_read
>        │
>        ▼
>   ext4_llseek (needs i_rwsem READ lock)
>        │
>        ▼
>   BLOCKED: kworkers hold i_rwsem as WRITER
>        │
>        ├─────────────────────────────────────────────┐
>        │                                             │
>        ▼                                             ▼
>   Those kworkers are likely doing              jbd2 waiting for
>   cachefiles write operations                  updates to complete
>        │                                             │
>        ▼                                             │
>   Waiting for journal                                │
>        │                                             │
>        └──────────────────►◄─────────────────────────┘
>                            │
>                            ▼
>                     Memory pressure triggers
>                     kcompactd which needs to
>                     release NFS folios
>                            │
>                            ▼
>                     nfs_release_folio waits for
>                     fscache (PG_fscache/private_2)
>                            │
>                            ▼
>                     fscache operations are stuck
>                     waiting for the blocked operations above
> ```
> 
> ## Root Cause Analysis
> 
> 1. **ext4_llseek holding i_rwsem**: When CacheFiles uses `SEEK_DATA`/`SEEK_HOLE` to check
>    what's cached, it takes the inode's rw-semaphore. If writers (kworkers doing cache writes)
>    hold this semaphore, readers (the prepare_read path) block.
> 
> 2. **Journal contention**: The ext4 journal on the cache filesystem (md127) is under heavy
>    load. With 256 nfsd threads all potentially doing cache operations, journal contention
>    is severe.
> 
> 3. **Memory pressure + folio release**: When memory compaction tries to free NFS folios that
>    have active fscache state, it must wait for fscache to complete—but fscache is blocked
>    on ext4.
> 
> 4. **Cookie state machine stalls**: The fscache cookie state transitions are blocked because
>    the underlying I/O can't complete, leading to the timeout messages.


