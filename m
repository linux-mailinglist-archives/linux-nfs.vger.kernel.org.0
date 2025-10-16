Return-Path: <linux-nfs+bounces-15305-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF2ABE5091
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 20:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78EA4546F9A
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59948229B12;
	Thu, 16 Oct 2025 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQySRyVu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26391226541;
	Thu, 16 Oct 2025 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638896; cv=none; b=p+ZoCD1C17QgDyupmx/cf/WDBnD9JZDYshbMLYJe923wwBBoFrgZzMhAyobXqLnoaV+RSRJSwKljFAFvmMDAKiIe5NAf4IU8oKaah7fPvI8uZwMFWxQWzvoepL6WdA/7dQNFWuTwE6jEOXvG8X7mnsfNkJn2wDyErghpG5NqIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638896; c=relaxed/simple;
	bh=K/Ziui+vfgwqXK6JIzNv/cL2YcUwMadKOLRQMyeEvYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMEStDuEG6GiuUgUVh1e/4lQGCVuWeOBRAmBTanGQ0aT1uPvYUamflx3KDIOB0b5dd5rswavKdJIaOXWhFuwP12ppj5nJGiIY3HgDZ1BNu8ekciQGpkKq0427kXUlQF1u6R1GXF+0Qj4rACkCrOmcgxC6FH5bLW2qQPw7QsIW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQySRyVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D43CC4CEF1;
	Thu, 16 Oct 2025 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760638895;
	bh=K/Ziui+vfgwqXK6JIzNv/cL2YcUwMadKOLRQMyeEvYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQySRyVuWDMIBwTwu+46uh/orEQ44VW33/RgpVWYgBRVpDrPZXzLXvaetavNdpH7P
	 AsdFycazTsId8c0PWKF1HjsewdWMaxXeofHP8BL149G7445oC6HkPNhPpLBHS6ENun
	 0d7psF2W1fGiCuDtnoMzUtcvdqowyQo8Rzd1g/MPZ7MLv4/1YYOBDLTmwVHvv+KqfA
	 q42IckdHk4X8QhTg3ytgVa3+I4I1S3wfzM/VS0FTAaY8uyQ1BHdneY3pq1RMiv7ZOg
	 HghZ43ehQ8ZyTqRCZuHp0v5RW/xWbIgDmD9Vzs1xV7Cn7Ql7nK2LSbg+cp4vy2vFpW
	 lf6QLPKCi5Lyg==
Date: Thu, 16 Oct 2025 11:20:02 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: Use MD5 library instead of crypto_shash
Message-ID: <20251016182002.GA6416@sol>
References: <20251016181534.17252-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016181534.17252-1-ebiggers@kernel.org>

On Thu, Oct 16, 2025 at 11:15:34AM -0700, Eric Biggers wrote:
> Update NFSD's support for "legacy client tracking" (which uses MD5) to
> use the MD5 library instead of crypto_shash.  This has several benefits:
> 
> - Simpler code.  Notably, much of the error-handling code is no longer
>   needed, since the library functions can't fail.
> 
> - Improved performance due to reduced overhead.  A microbenchmark of
>   nfs4_make_rec_clidname() shows a speedup from 1455 cycles to 425.
> 
> - The MD5 code can now safely be built as a loadable module when nfsd is
>   built as a loadable module.  (Previously, nfsd forced the MD5 code to
>   built-in, presumably to work around the unreliability of the
>   name-based loading.)  Thus select MD5 from the tristate option NFSD if
>   NFSD_LEGACY_CLIENT_TRACKING, instead of from the bool option NFSD_V4.
> 
> - Fixes a bug where legacy client tracking was not supported on kernels
>   booted with "fips=1", due to crypto_shash not allowing MD5 to be used.
>   This particular use of MD5 is not for a cryptographic purpose, though,
>   so it is acceptable even when fips=1 (see
>   https://lore.kernel.org/r/dae495a93cbcc482f4ca23c3a0d9360a1fd8c3a8.camel@redhat.com/).
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

I forgot the tags from v1.  Please add when applying:

    Acked-by: Ard Biesheuvel <ardb@kernel.org>
    Acked-by: Jeff Layton <jlayton@kernel.org>
    Reviewed-by: Scott Mayhew <smayhew@redhat.com>

- Eric

