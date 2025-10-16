Return-Path: <linux-nfs+bounces-15300-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA69BE4FB6
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 20:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDAB1898E5F
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 18:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170D819DF8D;
	Thu, 16 Oct 2025 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIKGrVdM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F0E7464;
	Thu, 16 Oct 2025 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637848; cv=none; b=udUdhZpdzXq2SYIs3FRU+qPo/WVXshbmmojN2aVJ5MBG1M6rXCUQevFvZhLwl6djVycrf7NhIYOYI2pjS+LxwXjU3Bgr91Vlx3g8r67t7kgJAORk7gwux1aQ+zWS99+WlhBoksY4Obbecc5IvfWmIeBe3QYGz5tI5Kt2JgVKPtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637848; c=relaxed/simple;
	bh=AllKviwDYBoW08UUm0XivDSKQdyI5z9w/WKoCR8L21M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqvtjRu/SUeV2rRVAjVKZx2Rbo9nkhYKoqKpZDJcLttnZipQwhHVZNaiqSpSSRn0VaqRNpgpPCGl6/Gi0CQ1PKeuSapetg2LiwWnZ16pFpgFGqPfz3BdEJHgsAMUkiqSfTn6aPo2Xg5oHEdeET5KQL7JJNzlyI01vF69UZ0ACf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIKGrVdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEC9C4CEFB;
	Thu, 16 Oct 2025 18:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760637847;
	bh=AllKviwDYBoW08UUm0XivDSKQdyI5z9w/WKoCR8L21M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIKGrVdMJKF9LCwUuc9wB4u3w21p9dKIEqda/cRit0QMhGj0SsNod8hwDVNDp+zib
	 1puRGxfPoF+abNVQUAn7T7HPhqgSP0I9wNj7Nwm1HkaCOB+emlRanFfZC+yFieFjZb
	 2SnxF/oUGT54d9ngrlsOY+TFPFvj1rQZf6M2Be/QZ8tzZLZWIK6nQT9qLxPD07tfJR
	 LBasTBrCuaJA6GxbsIhS1TnbaSy56qasVNz/7tuH6RDGVabNCHL6CvFne8rj/hz2Pg
	 SUUX+Edktcgp3c88EIjOm4Y5N2zXB/r8Ag3pr4db9RP3A53mpGGeEG6QQXyS0Eae1c
	 QOCjcwuXLmVmA==
Date: Thu, 16 Oct 2025 11:02:34 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Jeff Layton <jlayton@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [GIT PULL] NFSD changes for v6.18
Message-ID: <20251016180234.GC1575@sol>
References: <20251006135010.2165-1-cel@kernel.org>
 <CAMuHMdVYNUBH11trBr2Mo3i_fDh5sw5AzqYbPwO7_m4H6Y3sfA@mail.gmail.com>
 <20251013192103.GA61714@google.com>
 <f3a3f734-e75a-4d93-9a89-988417d5008c@kernel.org>
 <96e2c0717722be57011f4670b1a6b19bb5f4ef48.camel@kernel.org>
 <CAMuHMdX-LN-uhecx_ZJ9DokNJQ-0maGiLij_u9LVhNk9TODFVA@mail.gmail.com>
 <b97cea29-4ab7-4fb6-85ba-83f9830e524f@kernel.org>
 <99d95e27637c6eeb82939d98d6aa3344b7518d89.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99d95e27637c6eeb82939d98d6aa3344b7518d89.camel@kernel.org>

On Thu, Oct 16, 2025 at 11:19:24AM -0400, Trond Myklebust wrote:
> On Thu, 2025-10-16 at 11:04 -0400, Chuck Lever wrote:
> > On 10/16/25 10:36 AM, Geert Uytterhoeven wrote:
> > > Hi Jeff,
> > > 
> > > On Thu, 16 Oct 2025 at 16:31, Jeff Layton <jlayton@kernel.org>
> > > wrote:
> > > > On Mon, 2025-10-13 at 15:37 -0400, Chuck Lever wrote:
> > > > > On 10/13/25 3:21 PM, Eric Biggers wrote:
> > > > > > On Mon, Oct 13, 2025 at 12:15:52PM +0200, Geert Uytterhoeven
> > > > > > wrote:
> > > > > > > Hi Chuck, Eric,
> > > > > > > 
> > > > > > > On Wed, 8 Oct 2025 at 00:05, Chuck Lever <cel@kernel.org>
> > > > > > > wrote:
> > > > > > > > Eric Biggers (4):
> > > > > > > >       SUNRPC: Make RPCSEC_GSS_KRB5 select CRYPTO instead
> > > > > > > > of depending on it
> > > > > > > 
> > > > > > > This is now commit d8e97cc476e33037 ("SUNRPC: Make
> > > > > > > RPCSEC_GSS_KRB5
> > > > > > > select CRYPTO instead of depending on it") in v6.18-rc1.
> > > > > > > As RPCSEC_GSS_KRB5 defaults to "y", CRYPTO is now auto-
> > > > > > > enabled in
> > > > > > > defconfigs that didn't enable it before.
> > > > > > 
> > > > > > Now the config is:
> > > > > > 
> > > > > >     config RPCSEC_GSS_KRB5
> > > > > >         tristate "Secure RPC: Kerberos V mechanism"
> > > > > >         depends on SUNRPC
> > > > > >         default y
> > > > > >         select SUNRPC_GSS
> > > > > >         select CRYPTO
> > > > > >         select CRYPTO_SKCIPHER
> > > > > >         select CRYPTO_HASH
> > > > > > 
> > > > > > Perhaps the 'default y' should be removed?
> > > > > > 
> > > > > > Chuck, do you know why it's there?
> > > > > The "default y" was added by 2010 commit df486a25900f ("NFS:
> > > > > Fix the
> > > > > selection of security flavours in Kconfig"), then modified
> > > > > again by
> > > > > commit e3b2854faabd ("SUNRPC: Fix the SUNRPC Kerberos V
> > > > > RPCSEC_GSS
> > > > > module dependencies") in 2011.
> > > > > 
> > > > > Copying Trond, the author of both of those patches.
> > > > 
> > > > Looking at this a bit closer, maybe a patch like this is what we
> > > > want?
> > > > This should make it so that we only enable RPCSEC_GSS_KRB5 if
> > > > CRYPTO is
> > > > already enabled:
> > > > 
> > > > diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
> > > > index 984e0cf9bf8a..d433626c7917 100644
> > > > --- a/net/sunrpc/Kconfig
> > > > +++ b/net/sunrpc/Kconfig
> > > > @@ -19,9 +19,8 @@ config SUNRPC_SWAP
> > > >  config RPCSEC_GSS_KRB5
> > > >         tristate "Secure RPC: Kerberos V mechanism"
> > > >         depends on SUNRPC
> > > > -       default y
> > > > +       default y if CRYPTO
> > > 
> > > This merely controls the default, the user can still override it.
> > > Implementing your suggestion above would mean re-adding "depends on
> > > CRYPTO", i.e. reverting commit d8e97cc476e33037.
> > > 
> > > >         select SUNRPC_GSS
> > > > -       select CRYPTO
> > > >         select CRYPTO_SKCIPHER
> > > >         select CRYPTO_HASH
> > > >         help
> > > 
> > > Gr{oetje,eeting}s,
> > > 
> > >                         Geert
> > > 
> > 
> > The graph of dependencies and selects between NFS, NFSD, and SUNRPC
> > is
> > brittle, unfortunately. I suggest reverting d8e97cc476e33037 for now
> > while a proper solution is worked out and then tested.
> > 
> 
> Yes. The reason why I went for the weaker 'default y if ...' and
> 'depends on ...' is precisely because 'select' is so brittle, and at
> the time others advised against using it for more complicated
> situations such as this. The crypto code has a number of dependencies,
> and those have been known to change both over time and across hardware
> platforms.

CRYPTO doesn't have any dependencies.  As I documented in the commit
itself, CRYPTO is normally selected rather than depended on.  Similar to
how e.g. this option (RPCSEC_GSS_KRB5) already selected CRYPTO_SKCIPHER
and CRYPTO_HASH rather than depending on them.  It doesn't really make
sense to handle these options differently.

The real issue is RPCSEC_GSS_KRB5 being 'default y'.  The nfs folks
should make a decision about whether they want that or not.

I'll also that NFSD_V4 already selects RPCSEC_GSS_KRB5.  Perhaps that
already achieves what the 'default y' may have been intended to achieve?

- Eric

