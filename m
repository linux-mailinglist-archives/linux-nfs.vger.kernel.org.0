Return-Path: <linux-nfs+bounces-10977-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E093A7819A
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 19:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDCC37A4964
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 17:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F0E1E9B02;
	Tue,  1 Apr 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uy3aodr5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1479461
	for <linux-nfs@vger.kernel.org>; Tue,  1 Apr 2025 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743529212; cv=none; b=GZCElrXVeTM0L+P6h4myKRb1YxxdLtg5LoLq8sxGO7HjLACcQU9a3Np5YO0tpivZWu71rDycImpI7W5RGAvOqIW8hOgFo1D6lnwSTVW5TZ/qNTppGVffqtgFe36Fm7eNIMxvlEuKKfZg58SVyH2Rz4P1+HcyRB0lZr6aQggOOaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743529212; c=relaxed/simple;
	bh=Mw8CR9OVuNY6T1ztrVVJxZ5BPmGvReqQymmbilhFZ0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hx+AwvOteRpHu1lEjTxpEcX9D/bPSDele5O12PW4bHJBWWxyi0A/lQtLlRC0L3iOFIklrPiNwBLozSuUcqwkcN7DCw2vUiRjdeQ1vjEUQL7JgVIsFrTYKSq9zMHNs19kD2TbINlOa7B3QAemqQ7M/Egm65HndjlBU/P9wt1Gf3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uy3aodr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893A9C4CEE4;
	Tue,  1 Apr 2025 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743529211;
	bh=Mw8CR9OVuNY6T1ztrVVJxZ5BPmGvReqQymmbilhFZ0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uy3aodr5X74mQpSDs1LNJPpApOsLxJgmb2cglaPqDdyv3Tw6xav+nuLJNWFFoYgNT
	 l8mWgVQrkD2AMNIT04c2yRuv6O8iQbsO3EIN+NUly950MKoNnnoTK6+DfLgruYOp3m
	 RyAXnyIpCXXmfhfYc7wzudwaJ+ml5YytrlNSX3Z5BkgpSIkPT7ypSmj7FNSiCXm76W
	 lLbTMTDWI1lofG+d1ahE4IdoxuYEMlj8x5SMcVt0aNBtqidHe4AmGNgy66JsGBswDl
	 Tqf/V7mPDL98pqLOVLmNBs5rgosqou5I4+Xq1+2CGu4VWvEV3gqfXgRsc1WAC+gal/
	 jhQc4eppsToVQ==
Date: Tue, 1 Apr 2025 13:40:10 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Rik Theys <rik.theys@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Memory reclaim and high nfsd usage
Message-ID: <Z-wk-sJXi0dzttM_@kernel.org>
References: <CAPwv0JktC7Kb4cibSbioNAAZ9FeWs6aHeLRXDk_6MKUik1j3mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPwv0JktC7Kb4cibSbioNAAZ9FeWs6aHeLRXDk_6MKUik1j3mg@mail.gmail.com>

On Mon, Mar 31, 2025 at 09:05:54PM +0200, Rik Theys wrote:
> Hi,
> 
> Our fileserver is currently running 6.12.13 with the following 3
> patches (from nfsd-testing) applied to it:
> 
> - fix-decoding-in-nfs4_xdr_dec_cb_getattr
> - skip-sending-CB_RECALL_ANY
> - fix-cb_getattr_status-fix
> 
> Frequently the load on the system goes up and top shows a lot of
> kswapd and kcompact threads next to nfsd threads. During these period
> (which can last for hours), users complain about very slow NFS access.
> We have approx 260 systems connecting to this server and the number of
> nfs client states (from the states files in the clients directory) are
> around 200000.

Are any of these clients connecting to a server from the same host?
Only reason I ask is I fixed a recursion deadlock that manifested in
testing when memory was very low and LOCALIO used to loopback mount on
the same host.  See:

ce6d9c1c2b5cc785 ("NFS: fix nfs_release_folio() to not deadlock via kcompactd writeback")
https://git.kernel.org/linus/ce6d9c1c2b5cc785

(I suspect you aren't using NFS loopback mounts at all otherwise your
report would indicate breadcrumbs like I mentioned in my commit,
e.g. "task kcompactd0:58 blocked for more than 4435 seconds").
 
> When I look at our monitoring logs, the system has frequent direct
> reclaim stalls (allocstall_movable, and some allocstall_normal) and
> pgscan_kswapd goes up to ~10000000. The kswapd_low_wmark_hit_quickly
> is about 50. So it seems the system is out of memory and is constantly
> trying to free pages? If I understand it correctly the system hits a
> threshold which makes it scan for pages to free, frees some pages and
> when it stops it very quickly hits the low watermark again?
> 
> But the system has over 150G of memory dedicated to cache, and
> slab_reclaim is only about 16G. Why is the system not dropping more
> caches to free memory instead of constantly looking to free memory? Is
> there a tunable that we can set so the system will prefer to drop
> caches and increase memory usage for other nfsd related things? Any
> tips on how to debug where the memory pressure is coming from, or why
> the system decides to keep the pages used for cache instead of freeing
> some of those?

All good questions, to which I don't have immediate answers (but
others may).

Just FYI: there is a slow-start development TODO to leverage 6.14's
"DONTCACHE" support (particularly in nfsd, but client might benefit
some too) to avoid nfsd writeback stalls due to memory being
fragmented and reclaim having to work too hard (in concert with
kcompactd) to find adequate pages.

> I've ran a perf record for 10s and the top 4 of the events seem to be:
> 
> 1. 54% is swapper in intel_idle_ibrs
> 2. 12% is swapper in intel_idle
> 3. 7.43% is nfsd in native_queued_spin_lock_slowpath:
> 4. 5% is kswapd0 in __list_del_entry_valid_or_report

10s is pretty short... might consider a longer sample and then use the
perf.data to generate a flamegraph, e.g.:

- Download Flamegraph project: git clone https://github.com/brendangregg/FlameGraph
  you will likely need to install some missing deps, e.g.:
  yum install perl-open.noarch
- export FLAME=/root/git/FlameGraph
- perf record -F 99 -a -g sleep 120
  - this will generate a perf.data output file.

Once you have perf.data output, generate a flamegraph file (named
perf.svg) using these 2 commands:
perf script | $FLAME/stackcollapse-perf.pl > out.perf-folded
$FLAME/flamegraph.pl out.perf-folded > perf.svg

Open the perf.svg image with your favorite image viewer (a web browser
works well).

I just find flamegraph way more useful than 'perf report' ranked
ordering.
 
> Are there any know memory management changes related to NFS that have
> been introduced that could explain this behavior? What steps can I
> take to debug the root cause of this? Looking at iftop there isn't
> much going on regarding throughput. The top 3 NFS4 server operations
> are sequence 9563/s), putfh(9032/s) and getattr (7150/s).

You'd likely do well to expand the audience to include MM too (now cc'd).

