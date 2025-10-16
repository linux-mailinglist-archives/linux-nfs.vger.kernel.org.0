Return-Path: <linux-nfs+bounces-15307-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A260BE51D5
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 20:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9EDB4EF5D7
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Oct 2025 18:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D31622D4FF;
	Thu, 16 Oct 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAof+DmT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8FE2163B2;
	Thu, 16 Oct 2025 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640822; cv=none; b=Vu2eivLDuP8w5PvSwskAXUNnhju4DifhqSDTxtIsn/nOjY06gZPI+kPowQxjrTiu6xitD2uXvVV0OxM4CCBy7SOKETs53svrICyUnKoCkejOPtlbSBr+xl5zBEbT6FuPSuEykvC0l6HAK9b5fnLtDX/8JLsZj0szPO5Y2r2oT8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640822; c=relaxed/simple;
	bh=hrQlHLEtQc5Jg8esn/wHKBTJKqnEawcbMN2Cr8n6I+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4OnAp2g5RUYzihbCMq9VRxN6Fhv92J7j8TDFIPGO4isA9MIUOeV/lwzrB0kXdMX5r6XqTqxHaDg31FgWcKU3cyu4e3n6VH3SJyIUJ3cN8GoOoR6FizQ9VpPRuO2LlOSvjRUcsy4wRM/OWXHl+n62sF8Y55yZIt9EiXL5iz/+Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAof+DmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCDAC4CEF1;
	Thu, 16 Oct 2025 18:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760640821;
	bh=hrQlHLEtQc5Jg8esn/wHKBTJKqnEawcbMN2Cr8n6I+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AAof+DmTC8hD/IUifOaFA9o8iLojakVyjZTMgRb2ctpDtdMlZq+yfuHhlNRhH2JAo
	 sAMSPVlLqD2GHzrcUvQ3uWsD3wKH+Zok6BBU4WQd9bPJRdyJn+0Lt/7vIU1/PvtlVT
	 OI3dqXZwlzR6qfodUMwrNU4MBXSWhMjP99Flxz3DHasA0Jsd1ppwaewqnb7/lMm7Ew
	 pguxBHs7+aeL0XdY2i21BqcggOhZnSeoc21nps45zGLS4H7v3ab5+08mNogRY7hebo
	 S2Yj3kfx+4Xut0rcorwDiHbqP8Yq/aRYCLSKN9dK536slPaPSeXunDda48djaTgDDi
	 OY10uW5C8SVRw==
Date: Thu, 16 Oct 2025 18:53:39 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfsd: Use MD5 library instead of crypto_shash
Message-ID: <20251016185339.GA1418608@google.com>
References: <20251016181534.17252-1-ebiggers@kernel.org>
 <176063936413.28537.4413010868699924082.b4-ty@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176063936413.28537.4413010868699924082.b4-ty@oracle.com>

On Thu, Oct 16, 2025 at 02:31:46PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> On Thu, 16 Oct 2025 11:15:34 -0700, Eric Biggers wrote:
> > Update NFSD's support for "legacy client tracking" (which uses MD5) to
> > use the MD5 library instead of crypto_shash.  This has several benefits:
> > 
> > - Simpler code.  Notably, much of the error-handling code is no longer
> >   needed, since the library functions can't fail.
> > 
> > - Improved performance due to reduced overhead.  A microbenchmark of
> >   nfs4_make_rec_clidname() shows a speedup from 1455 cycles to 425.
> > 
> > [...]
> 
> Applied to nfsd-testing, thanks!
> 
> Note that the posted version of this patch does not apply cleanly to
> the nfsd-testing branch here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=nfsd-testing
> 
> Be sure to rebase on that branch when posting subsequence patches
> that target NFSD.

Sorry, I had just based it on v6.18-rc1.  It did also apply cleanly to
nfsd-testing f59a20b8390dd with either 'git am -3' or 'git cherry-pick'.

I noticed you changed the author to yourself when applying.  Could you
fix that?

Thanks,

- Eric

