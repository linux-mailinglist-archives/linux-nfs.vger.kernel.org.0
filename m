Return-Path: <linux-nfs+bounces-5900-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B769E9636E3
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 02:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 459B7B20B74
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Aug 2024 00:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304EFDDA6;
	Thu, 29 Aug 2024 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ac8ASh6H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B93EDDA1
	for <linux-nfs@vger.kernel.org>; Thu, 29 Aug 2024 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724891222; cv=none; b=ecvUMmjVaWxJ0/FaDzG1OQCvxVXwd3cM79zJYKZ2N8109gey5iWtgqX6JjYh1dbzXOupJD1fco1xhQPe+B00WarRIII1ACfQYoDR1CJu5NtGLWMwHm9Du7mo200mRTyyJj04c4qmQeMVlNsUIJokZYEKs9wT5V638gqbr91s2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724891222; c=relaxed/simple;
	bh=pxzeuDQz4BBSJRJAqX0XP06GyF19F1S130kHNFIw1lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzhRUZk6Eb5RGkfHWzq2B/2QfEEv5vXFBZdBnQphn7LTClUJ1OWTjcBuyNrHAJgySbpHMzavyRDlz8eQeZrdcGadst9B6m0KBTPDpaLlALdRflDA4f7fntJKrUx/qNLnAxbkpl83S54bijiz504j3dTlGyAVgbHBMp7C7tEvv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ac8ASh6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94CFC4CEC0;
	Thu, 29 Aug 2024 00:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724891221;
	bh=pxzeuDQz4BBSJRJAqX0XP06GyF19F1S130kHNFIw1lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ac8ASh6HoNkJnx42cdmNc4R0CFlIkzpYvHVH5MBqT2A60XtnTAchI63aW0kGQdmw9
	 4/rHnGt/hx791iw5/voZ5kvWGdc2B8NXR5E06QF7iDBe43sGyWzLsz20btxPZG89Tp
	 DDdR7AG6U3nuk1G6Bc3K218hFRvXXzQS1KjGk6f2cO7jNptphDjZGkaTqBSgmIltrQ
	 MysalTeD1Lj+dDRyjUyM6CTYCHUkLOgLyT+TP6Hrizuz3WpTCNNrzai/KxWJzwAAbT
	 BVkyyPPQFQIwSA+JTAVf/4+l3w2DhDhGgpo2k5/0G0a4TwPRtn6CFwYD0EOJRDRk7s
	 2rSmrnL0dS6fA==
Date: Wed, 28 Aug 2024 20:27:00 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] NFSD: Handle @rqstp == NULL in
 check_nfsd_access()
Message-ID: <Zs_AVOZ3n8CXu9NA@kernel.org>
References: <>
 <Zs8p6ej4K0CLcmt0@kernel.org>
 <172487914501.4433.5035812857573545333@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172487914501.4433.5035812857573545333@noble.neil.brown.name>

On Thu, Aug 29, 2024 at 07:05:45AM +1000, NeilBrown wrote:
> On Wed, 28 Aug 2024, Mike Snitzer wrote:
> > 
> > So I honestly feel like Chuck's latest revision is perfectly fine.
> > I disagree that "The behavior for LOCALIO is therefore the same as
> > the AUTH_UNIX check below." is inaccurate.  The precondition from the
> > client (used to establish localio and cause rqstp to be NULL in
> > check_nfsd_access) is effectively comparable no?
> > 
> 
> I don't think the correctness of the code is at all related to
> AUTH_UNIX.
> Suppose we did add support for krb5 somehow - would we really need a
> different test?  I think not.
> 
> I think that the reason the code is correct and safe is that we trust
> the client.  We *know* the client will only present an filehandle which
> it has received over the wire and which it verified - with the
> accompanying credential - it was allowed to access.
> 
> Maybe that is what you meant by "The precondition from the client".  I
> agree that does give us sufficient safety.  I don't think AUTH_UNIX is
> relevant.
> 
> /*
>  * If rqstp is NULL, this is a LOCALIO request which will only ever use
>  * filehandle/credential pair for which access has been affirmed (by
>  * ACCESS or OPEN NFS requests) over the wire.  So there is no need for
>  * further checks here.
>  */

Makes sense, and thanks!

> (It wasn't quite this clear to me when I wrote previously - but I always
>  seems to think more clearly in the mornings!)

I haven't been sleeping enough.. tonight, tonight I will!!! ;)

Mike

