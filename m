Return-Path: <linux-nfs+bounces-15301-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5344BE4FD9
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 20:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7D23B011B
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 18:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95494217722;
	Thu, 16 Oct 2025 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlTO+7d0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682E9334699;
	Thu, 16 Oct 2025 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638115; cv=none; b=ORzLcOtHpjx0nAX46YYNQ/WE+oGrHcdUfkySWLgv30rYTN1n/v1VS6wuR+87dN8wAT+kYVg46E8YFViYYTowrrUuM95d/3C0FFYe2HG3BW8jtYHXoi0QffWKWmxuy2xPpgJkEoXxs06qEvL+ItgxIDr4Xm/Wt2h7U0JG9e/71t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638115; c=relaxed/simple;
	bh=paLwTOlO4ILoH1eNEv2QR+OyvWpBzVIOLZQ9Wqm3daY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P282l45FOkK0VUfuvjx32+EmjOGiQfjP66GWZHpYdfT50JkLZf1/KEvFQM5TVhx8yUe+bsPyJ/tfdjY4k/gxRDFav9Gn27uPJHg0lOAkixQSpUPslAR8LOz5E1Yyf0b6M+5mCUorwqW9jyYAjA4ILE2fwtpsFUjbcDIykeJUPtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlTO+7d0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997B9C4CEF1;
	Thu, 16 Oct 2025 18:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760638114;
	bh=paLwTOlO4ILoH1eNEv2QR+OyvWpBzVIOLZQ9Wqm3daY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SlTO+7d083LUtIpPENdgQOcszpAkjz3FriK61o2a+KxUZsl+a5Hs9hi6vyuwZGqeV
	 YLTSt99CbqbcXpETkWW3HBQ9FAz6JxnHh12cK0wa5aQ9ZjGCu760ZcFQv+33Qeba/W
	 +Brt6/COVC7W88Jb0dktl0rhCx9/iazp4mnEsMwvtSnlpNjbwWK6yjLuh5y4BtILHZ
	 aXozMZn9slp4VgSJzqRFsxtG0R2wq1EJ7wYrSnJlLrBAoG1r08PlM/9SfR7SAEXjAE
	 h3mvoAVkS2djiFUupZ+Z0dfycUt9AW0JoCFcyGDr+4yPm2eJhfXAXJ7pOuoVRnje7y
	 k7Bnp6HhdjqnQ==
Date: Thu, 16 Oct 2025 11:07:02 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Use MD5 library instead of crypto_shash
Message-ID: <20251016180702.GD1575@sol>
References: <20251011185225.155625-1-ebiggers@kernel.org>
 <582606e8b6699aeacae8ae4dcf9f990b4c0b5210.camel@kernel.org>
 <20251012170018.GA1609@sol>
 <d85b364d-b7d6-4893-b0eb-3df58ef45ce0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d85b364d-b7d6-4893-b0eb-3df58ef45ce0@oracle.com>

On Thu, Oct 16, 2025 at 09:41:27AM -0400, Chuck Lever wrote:
> On 10/12/25 1:00 PM, Eric Biggers wrote:
> > On Sun, Oct 12, 2025 at 07:12:26AM -0400, Jeff Layton wrote:
> >> On Sat, 2025-10-11 at 11:52 -0700, Eric Biggers wrote:
> >>> Update NFSD's support for "legacy client tracking" (which uses MD5) to
> >>> use the MD5 library instead of crypto_shash.  This has several benefits:
> >>>
> >>> - Simpler code.  Notably, much of the error-handling code is no longer
> >>>   needed, since the library functions can't fail.
> >>>
> >>> - Improved performance due to reduced overhead.  A microbenchmark of
> >>>   nfs4_make_rec_clidname() shows a speedup from 1455 cycles to 425.
> >>>
> >>> - The MD5 code can now safely be built as a loadable module when nfsd is
> >>>   built as a loadable module.  (Previously, nfsd forced the MD5 code to
> >>>   built-in, presumably to work around the unreliablity of the name-based
> >>>   loading.)  Thus, select MD5 from the tristate option NFSD if
> >>>   NFSD_LEGACY_CLIENT_TRACKING, instead of from the bool option NFSD_V4.
> >>>
> >>> To preserve the existing behavior of legacy client tracking support
> >>> being disabled when the kernel is booted with "fips=1", make
> >>> nfsd4_legacy_tracking_init() return an error if fips_enabled.  I don't
> >>> know if this is truly needed, but it preserves the existing behavior.
> >>>
> >>
> >> FIPS is pretty draconian about algorithms, AIUI. We're not using MD5 in
> >> a cryptographically significant way here, but the FIPS gods won't bless
> >> a kernel that uses MD5 at all, so I think it is needed.
> > 
> > If it's not being used for a security purpose, then I think you can just
> > drop the fips_enabled check.  People are used to the old API where MD5
> > was always forbidden when fips_enabled, but it doesn't actually need to
> > be that strict.  For this patch I wasn't certain about the use case
> > though, so I just opted to preserve the existing behavior for now.  A
> > follow-on patch to remove the check could make sense.
> Eric, were you going to follow up with a fresh revision that drops the
> fips_enabled check?

Sure, if you want.  I see you're also planning to revert my prerequisite
patch "SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead of depending
on it".  So I also need to work around that by keeping the
'select CRYPTO' in NFSD_V4.

- Eric

