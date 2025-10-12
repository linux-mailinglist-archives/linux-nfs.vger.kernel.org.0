Return-Path: <linux-nfs+bounces-15155-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C7ABD0817
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 19:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65CA3BD627
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 17:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042C22EC0A6;
	Sun, 12 Oct 2025 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPumCKzn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76328D850;
	Sun, 12 Oct 2025 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760288506; cv=none; b=tDq0X5M9BLy+D5Iv7+QjHxmUtH7JtS0k99PJ+UhzwsEqy6KtVqZaK5Mqr5YBxFGDrM35r/PnZ70DIVrYFOUo/NPXqdHv/L8s4zLu8A810MSqUI3fv6E2SWOXzH29eZTgYFyMOi+F569T2tfDwRWTT63Hk8lgt5+XJQ09P9XcQIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760288506; c=relaxed/simple;
	bh=/kYsYzPqYcYMuoMIPOGDWTNrVr0GssulRb1i/fDzlL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBnd9QyIKhTz0tMKYTd11f8zNo5GwsRPf1m2SCA+ZV+RKRy5YuCUJiVdnmszepTNI+2Cn+0JurPJkay9VSdIQ2de4/ynR0Oaj6AJR205Wn3BrVFBfzk8VIKr44JcZJtabLYHB2BaK3PqMhuEVbJ0SMYddiENFfRKIX4WywDm0+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPumCKzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347BCC4CEE7;
	Sun, 12 Oct 2025 17:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760288506;
	bh=/kYsYzPqYcYMuoMIPOGDWTNrVr0GssulRb1i/fDzlL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPumCKznmZFuEL/nz8PcIbdhjX+W4ksMwQxt2zMhDmFYLNTKd7fpOYLf+635uFXet
	 kJ/CUOTSuNcJ4dypd3YjzpdVYIdPtzlKragpw3RIm/Frq/kgYQtKGBgm3zITBjkvyz
	 O1y7FwLEUCp6fKb/CbNLng69Rx3wKry/gJH8+MKvhrPhvQg1/6lfYVAq7VS17MUKBd
	 Su9JEuxzkfsc/NHWGersRd/jN2c89Wbl8xBL0DEOtiLKKZcet9v53anasuw+XZD1yg
	 j2OmPcmrqf9c+uhaA5BBUJKhuhYlr0XXzQW5ydXEWvfTa+4L/xozV85CVmzv9CfPo+
	 9FLU9JCx4p5Sw==
Date: Sun, 12 Oct 2025 10:00:18 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Use MD5 library instead of crypto_shash
Message-ID: <20251012170018.GA1609@sol>
References: <20251011185225.155625-1-ebiggers@kernel.org>
 <582606e8b6699aeacae8ae4dcf9f990b4c0b5210.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <582606e8b6699aeacae8ae4dcf9f990b4c0b5210.camel@kernel.org>

On Sun, Oct 12, 2025 at 07:12:26AM -0400, Jeff Layton wrote:
> On Sat, 2025-10-11 at 11:52 -0700, Eric Biggers wrote:
> > Update NFSD's support for "legacy client tracking" (which uses MD5) to
> > use the MD5 library instead of crypto_shash.  This has several benefits:
> > 
> > - Simpler code.  Notably, much of the error-handling code is no longer
> >   needed, since the library functions can't fail.
> > 
> > - Improved performance due to reduced overhead.  A microbenchmark of
> >   nfs4_make_rec_clidname() shows a speedup from 1455 cycles to 425.
> > 
> > - The MD5 code can now safely be built as a loadable module when nfsd is
> >   built as a loadable module.  (Previously, nfsd forced the MD5 code to
> >   built-in, presumably to work around the unreliablity of the name-based
> >   loading.)  Thus, select MD5 from the tristate option NFSD if
> >   NFSD_LEGACY_CLIENT_TRACKING, instead of from the bool option NFSD_V4.
> > 
> > To preserve the existing behavior of legacy client tracking support
> > being disabled when the kernel is booted with "fips=1", make
> > nfsd4_legacy_tracking_init() return an error if fips_enabled.  I don't
> > know if this is truly needed, but it preserves the existing behavior.
> > 
> 
> FIPS is pretty draconian about algorithms, AIUI. We're not using MD5 in
> a cryptographically significant way here, but the FIPS gods won't bless
> a kernel that uses MD5 at all, so I think it is needed.

If it's not being used for a security purpose, then I think you can just
drop the fips_enabled check.  People are used to the old API where MD5
was always forbidden when fips_enabled, but it doesn't actually need to
be that strict.  For this patch I wasn't certain about the use case
though, so I just opted to preserve the existing behavior for now.  A
follow-on patch to remove the check could make sense.

- Eric

