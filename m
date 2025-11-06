Return-Path: <linux-nfs+bounces-16121-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE112C3A420
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 11:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E5D1890A66
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 10:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47CF2DC784;
	Thu,  6 Nov 2025 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Q5A2As6A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uliy6kDu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172792248B4
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424654; cv=none; b=Msgr0nT17uY9Pf0BHBWydM+i4z72bN2kK6h0Jr4b1VLTZZqxCnGFimSvd56s2LlOSftgCvFcLjfYKf5imym9pIEK0PyA830C6i/VP5820r4U9Bws287rFP3peKwE+Ya9xOuLHkRg5aHBUUpMqS2tuMIL9sz9f00XrYy8GSpzDfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424654; c=relaxed/simple;
	bh=3JxfKrdn8OhYOXx7j3g2qgHEHOeArCR1slfOkhLYNHI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SeYEwR8Tm9laGAdY7wPZaWgeipINseq9rcrUwBQANvw2arWSmOy9x3Fm5VjQaGAGReozMTlsepDlb5Z6hkrVQ9dFNuB+gLjA+HLMUpFTEuZq0QVZT67iVhG2GTC8dzZhAn7Infi6+RE1WzO10B4nwh+qCgz15Xg3tX2rmSsFofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Q5A2As6A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uliy6kDu; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 11A761D00179;
	Thu,  6 Nov 2025 05:24:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 06 Nov 2025 05:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762424650; x=1762511050; bh=24cu/IohH++nM1f9B6FJA+sbODUWnElgMUj
	6AsnfX6o=; b=Q5A2As6AxrBWWzT3NenUbH+VSuPUWOEo7kKqwGDRsl8mLp7RB5+
	3VDLpRuVlUwL1W4lNGQrYTUVr54NiFmOOIwsEI4ia7hdlkCEOqIlJOnqItrlscnL
	BnkyH2WdTW6Cxlu/1T9I3axYLPAaefTsJsYbrDqiZjxXAEEV4VNe4CA0c7bTGom1
	thBP+QukTQ2Z5ypOYCJ/ou9NILAUv8txdZ1cbsxaVtKrkimtE/9zE1fVIif86LYV
	NLXEamJ+E+R+4siSv/PCYKZJqQ7WzkEIc9DlRnB9Bko4xn+Ffwgy3M5NNJs1bijO
	l72Hyaw4bnXG0hJenwQViqA5Ycvwew9irIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762424650; x=
	1762511050; bh=24cu/IohH++nM1f9B6FJA+sbODUWnElgMUj6AsnfX6o=; b=U
	liy6kDug2kBeiae2nDAQq99pnRxyeREkzTpoBP8n39EVptpMYo7P+iSNO7AsGe7C
	plFz0rvmlXLi9+lp+oypg0HrY7NTp3RcyMJunTGjXeUt2SusTw/ev6GdjJx8QQoy
	zc+sblGuST8CzXpk06MqMlYRPKkfuKsPhDhKvX71p5ddGkYlNk0IILNQW1yH85Sr
	xhg4/tYNaGhsdX5w1Gj7Pl3cvZnG8wtvGjXrbAwJvDL2timiXRbz161Y0T2Y2kSA
	u7qgX3vaAugxhtCS8yDf96n70mrqM+MhVV73BsO0d4b89X/DYMV0l3o5td8qNefr
	0Mu3/svt7qqSdwcm0nmzA==
X-ME-Sender: <xms:SncMaYKgx5EiUjYOKdjCtc4zqtnguikpHWRX5VagI8eFUysSCDkIlQ>
    <xme:SncMaaYn2h6H_F46ANF2-P7jQJ6UHSdnIw6oc3CegHM-REbGkI-4SZXDJ2I6ff7z8
    gEZVpwNZtRQ50V28hQsuaOL8oJ3Kz46uAn4QvxicNzFJBfQ>
X-ME-Received: <xmr:SncMaa_hzY7CLh_WLESjioUpNHkO_lbsRIZAKyYj3wteb9uphiPs5uRb4Smo3G--AmzcyhVgkU9eZUWkgRtRZabFMEJ841ipBT5A9K1FuQXX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeiheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhesthgrlhhp
    vgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehsnhhi
    thiivghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SncMaba_byTmQiud63_Db_qZIL-28fRQWvQ4USSrcZNncdfCRwGxJg>
    <xmx:SncMaeP4TsHg-YC4pt8h-L31QMkmQ1-pl_tcciEREbcsl7Mmb5yBYQ>
    <xmx:SncMaXBKzd8IELl94fbKpvKasqbqM0beltiFT5zeQ1LYaY5xr0Wqnw>
    <xmx:SncMaVKtY-6wE_IDisNvS71LpCb9tcEFnZho11HuiJjqN-GBtNZoiw>
    <xmx:SncMaeFYYTPySMXerTSQK0JtFNN-KEbcQElxPcZUa5lPIQFSkZjnZdNZ>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 05:24:08 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Mike Snitzer" <snitzer@kernel.org>
Subject:
 Re: [PATCH v10 5/5] NFSD: add Documentation/filesystems/nfs/nfsd-io-modes.rst
In-reply-to: <20251105192806.77093-6-cel@kernel.org>
References: <20251105192806.77093-1-cel@kernel.org>,
 <20251105192806.77093-6-cel@kernel.org>
Date: Thu, 06 Nov 2025 21:24:06 +1100
Message-id: <176242464673.634289.9740740689934261321@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 06 Nov 2025, Chuck Lever wrote:
> From: Mike Snitzer <snitzer@kernel.org>
>=20
> This document details the NFSD IO modes that are configurable using
> NFSD's experimental debugfs interfaces:
>=20
>   /sys/kernel/debug/nfsd/io_cache_read
>   /sys/kernel/debug/nfsd/io_cache_write
>=20
> This document will evolve as NFSD's interfaces do (e.g. if/when NFSD's
> debugfs interfaces are replaced with per-export controls).
>=20
> Future updates will provide more specific guidance and howto
> information to help others use and evaluate NFSD's IO modes:
> BUFFERED, DONTCACHE and DIRECT.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  .../filesystems/nfs/nfsd-io-modes.rst         | 150 ++++++++++++++++++
>  1 file changed, 150 insertions(+)
>  create mode 100644 Documentation/filesystems/nfs/nfsd-io-modes.rst
>=20
> diff --git a/Documentation/filesystems/nfs/nfsd-io-modes.rst b/Documentatio=
n/filesystems/nfs/nfsd-io-modes.rst
> new file mode 100644
> index 000000000000..29b84c9c9e25
> --- /dev/null
> +++ b/Documentation/filesystems/nfs/nfsd-io-modes.rst
> @@ -0,0 +1,150 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +NFSD IO MODES
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NFSD has historically always used buffered IO when servicing READ and
> +WRITE operations. BUFFERED is NFSD's default IO mode, but it is possible
> +to override that default to use either DONTCACHE or DIRECT IO modes.
> +
> +Experimental NFSD debugfs interfaces are available to allow the NFSD IO
> +mode used for READ and WRITE to be configured independently. See both:
> +- /sys/kernel/debug/nfsd/io_cache_read
> +- /sys/kernel/debug/nfsd/io_cache_write
> +
> +The default value for both io_cache_read and io_cache_write reflects
> +NFSD's default IO mode (which is NFSD_IO_BUFFERED=3D0).
> +
> +Based on the configured settings, NFSD's IO will either be:
> +- cached using page cache (NFSD_IO_BUFFERED=3D0)
> +- cached but removed from page cache on completion (NFSD_IO_DONTCACHE=3D1)
> +- not cached stable_how=3DNFS_UNSTABLE (NFSD_IO_DIRECT=3D2)
> +- not cached stable_how=3DNFS_DATA_SYNC (NFSD_IO_DIRECT_WRITE_DATA_SYNC=3D=
3)
> +- not cached stable_how=3DNFS_FILE_SYNC (NFSD_IO_DIRECT_WRITE_FILE_SYNC=3D=
4)
> +
> +To set an NFSD IO mode, write a supported value (0 - 4) to the
> +corresponding IO operation's debugfs interface, e.g.:
> +  echo 2 > /sys/kernel/debug/nfsd/io_cache_read
> +  echo 4 > /sys/kernel/debug/nfsd/io_cache_write
> +
> +To check which IO mode NFSD is using for READ or WRITE, simply read the
> +corresponding IO operation's debugfs interface, e.g.:
> +  cat /sys/kernel/debug/nfsd/io_cache_read
> +  cat /sys/kernel/debug/nfsd/io_cache_write
> +
> +NFSD DONTCACHE
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +DONTCACHE offers a hybrid approach to servicing IO that aims to offer
> +the benefits of using DIRECT IO without any of the strict alignment
> +requirements that DIRECT IO imposes. To achieve this buffered IO is used
> +but the IO is flagged to "drop behind" (meaning associated pages are
> +dropped from the page cache) when IO completes.
> +
> +DONTCACHE aims to avoid what has proven to be a fairly significant
> +limition of Linux's memory management subsystem if/when large amounts of
> +data is infrequently accessed (e.g. read once _or_ written once but not
> +read until much later). Such use-cases are particularly problematic
> +because the page cache will eventually become a bottleneck to servicing
> +new IO requests.
> +
> +For more context on DONTCACHE, please see these Linux commit headers:
> +- Overview:  9ad6344568cc3 ("mm/filemap: change filemap_create_folio()
> +  to take a struct kiocb")
> +- for READ:  8026e49bff9b1 ("mm/filemap: add read support for
> +  RWF_DONTCACHE")
> +- for WRITE: 974c5e6139db3 ("xfs: flag as supporting FOP_DONTCACHE")
> +
> +If NFSD_IO_DONTCACHE is specified by writing 1 to NFSD's debugfs
> +interfaces, FOP_DONTCACHE must be advertised as supported by the
> +underlying filesystem (e.g. XFS), otherwise all IO flagged with
> +RWF_DONTCACHE will fail with -EOPNOTSUPP.

If FOP_DONTCACHE isn't advertised, nfsd doesn't even try RWF_DONTCACHE,
so error don't occur.

Maybe:

  "NFSD_IO_DONTCACHE will fall back to NFSD_IO_BUFFERED if the
  underlying filesystem doesn't indicaate support by setting
  FOP_DONTCACHE."

> +
> +NFSD DIRECT
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +DIRECT IO doesn't make use of the page cache, as such it is able to
> +avoid the Linux memory management's page reclaim scalability problems
> +without resorting to the hybrid use of page cache that DONTCACHE does.
> +
> +Some workloads benefit from NFSD avoiding the page cache, particularly
> +those with a working set that is significantly larger than available
> +system memory. The pathological worst-case workload that NFSD DIRECT has
> +proven to help most is: NFS client issuing large sequential IO to a file
> +that is 2-3 times larger than the NFS server's available system memory.
> +The reason for such improvement is NFSD DIRECT eliminates a lot of work
> +that the memory management subsystem would otherwise be required to
> +perform (e.g. page allocation, dirty writeback, page reclaim). When
> +using NFSD DIRECT, kswapd and kcompactd are no longer commanding CPU
> +time trying to find adequate free pages so that forward IO progress can
> +be made.
> +
> +The performance win associated with using NFSD DIRECT was previously
> +discussed on linux-nfs, see:
> +https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
> +But in summary:
> +- NFSD DIRECT can significantly reduce memory requirements
> +- NFSD DIRECT can reduce CPU load by avoiding costly page reclaim work
> +- NFSD DIRECT can offer more deterministic IO performance
> +
> +As always, your mileage may vary and so it is important to carefully
> +consider if/when it is beneficial to make use of NFSD DIRECT. When
> +assessing comparative performance of your workload please be sure to log
> +relevant performance metrics during testing (e.g. memory usage, cpu
> +usage, IO performance). Using perf to collect perf data that may be used
> +to generate a "flamegraph" for work Linux must perform on behalf of your
> +test is a really meaningful way to compare the relative health of the
> +system and how switching NFSD's IO mode changes what is observed.
> +
> +If NFSD_IO_DIRECT is specified by writing 2 (or 3 and 4 for WRITE) to
> +NFSD's debugfs interfaces, ideally the IO will be aligned relative to
> +the underlying block device's logical_block_size. Also the memory buffer
> +used to store the READ or WRITE payload must be aligned relative to the
> +underlying block device's dma_alignment.
> +
> +But NFSD DIRECT does handle misaligned IO in terms of O_DIRECT as best
> +it can:
> +
> +Misaligned READ:
> +    If NFSD_IO_DIRECT is used, expand any misaligned READ to the next
> +    DIO-aligned block (on either end of the READ). The expanded READ is
> +    verified to have proper offset/len (logical_block_size) and
> +    dma_alignment checking.
> +
> +    Any misaligned READ that is less than 32K won't be expanded to be
> +    DIO-aligned (this heuristic just avoids excess work, like allocating
> +    start_extra_page, for smaller IO that can generally already perform
> +    well using buffered IO).

I couldn't find this 32K in the code.

Do we want to say something like:

  If you experiment with this on a recent kernel have have interesting
  results, please report them to linux-nfs@vger.kernel.org

Thanks,
NeilBrown


> +
> +Misaligned WRITE:
> +    If NFSD_IO_DIRECT is used, split any misaligned WRITE into a start,
> +    middle and end as needed. The large middle segment is DIO-aligned
> +    and the start and/or end are misaligned. Buffered IO is used for the
> +    misaligned segments and O_DIRECT is used for the middle DIO-aligned
> +    segment. DONTCACHE buffered IO is _not_ used for the misaligned
> +    segments because using normal buffered IO offers significant RMW
> +    performance benefit when handling streaming misaligned WRITEs.
> +
> +Tracing:
> +    The nfsd_read_direct trace event shows how NFSD expands any
> +    misaligned READ to the next DIO-aligned block (on either end of the
> +    original READ, as needed).
> +
> +    This combination of trace events is useful for READs:
> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_vector/enable
> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_direct/enable
> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_read_io_done/enable
> +    echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable
> +
> +    The nfsd_write_direct trace event shows how NFSD splits a given
> +    misaligned WRITE into a DIO-aligned middle segment.
> +
> +    This combination of trace events is useful for WRITEs:
> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_opened/enable
> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_direct/enable
> +    echo 1 > /sys/kernel/tracing/events/nfsd/nfsd_write_io_done/enable
> +    echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable
> --=20
> 2.51.0
>=20
>=20


