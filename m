Return-Path: <linux-nfs+bounces-7575-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318B89B65AE
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 15:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627B11C235F7
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 14:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471671EABD4;
	Wed, 30 Oct 2024 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQ1fKz5n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D39C13C;
	Wed, 30 Oct 2024 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298253; cv=none; b=gsL1JC27kndK+L07I+QT4ILy4lDetWRca29NHmVgttc11EN2Zmafgi1OBEuIjJZKTZO5O/7OV77vpWH8YFvlzjX41/wRomeZ2nG23nFhneTaNZiBHQ8zzqtPuAo+g1roww7Ebn26QHmbmvf0Hp2wGRA5/UCskznzcn3v+x2a8Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298253; c=relaxed/simple;
	bh=Jlbh46uYMoPvjrSStd9G+ktfLv4AQ7h39qoGLB1NO/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQUpsorwUGPSnuM7drIliXOUD0mZP00jIX0PU+P0QSF3772fLWAy3Nl5m4Rj3LlAPJ5EV+Pi6bvShhSQibQE9NXcrDJUr4ydx43SBk8jx6fgs2JRVypR/YQwhh1OjAtqbmI7Sl9hOgSxFuvQyc0e8c9f10qFn5OZubMilf5ChsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ1fKz5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7279FC4CECE;
	Wed, 30 Oct 2024 14:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730298252;
	bh=Jlbh46uYMoPvjrSStd9G+ktfLv4AQ7h39qoGLB1NO/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQ1fKz5n5gpG5qsi3p9A70C23TC6oh0G2CRmTwZ87+HIJnfE5gmPL+TWHiyxq8Y07
	 o8xbOjSH9jzPfcKLcU04a2izqaB7XdObE1JejMyqvXN0vCEgFudqQqe6b+yy4YOnep
	 CQGpjj6Yenk4WeBtC7i8yPCv9UsmOI9jXMT0oRRdchPANSIGs5Izvyj5TQi62Lbjuc
	 qLnC7Kz46JfqPNeZKo9mj4CzWRX8BJm+VxAFbjA8wLpf7SPRoIyKGP+/vRe+cR+a/4
	 OLoAuuUnnP9d3kNx7RXAgFOF9EMQCsBAmPrVI+KVUA51sw0fKq+a9OtTcI/eA0qPdp
	 inCYkmP6SB5kQ==
Date: Wed, 30 Oct 2024 10:24:11 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org
Subject: Re: dm: add support for get_unique_id
Message-ID: <ZyJBi68xWvTgUV5g@kernel.org>
References: <f3657efae72f9abb93d3169308052e77bf0dbad6.1730292757.git.bcodding@redhat.com>
 <20241030135214.GA28166@lst.de>
 <ABD563AE-C7F3-43C2-A698-479C7D5924BF@redhat.com>
 <20241030140823.GA29475@lst.de>
 <313BC47B-6069-4AB4-BD44-F71461726F8B@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <313BC47B-6069-4AB4-BD44-F71461726F8B@redhat.com>

On Wed, Oct 30, 2024 at 10:19:11AM -0400, Benjamin Coddington wrote:
> On 30 Oct 2024, at 10:08, Christoph Hellwig wrote:
> 
> > On Wed, Oct 30, 2024 at 10:05:03AM -0400, Benjamin Coddington wrote:
> >> Match each other in a multipath device you mean?  No, this will just return
> >> the first one where get_unique_id returns non-zero.  Can they actually be
> >> different, and if so should we return an error?
> >
> > That's what I've been wondering.  IIRC you can in theory create a
> > kernel mpath table for any devices you want.  multipathd only creates
> > them when the ids match, but do we want to rely on that?  It might be
> > perfectly fine to say if you break you keep the pieces, but then
> > I'd expected a comment about it in the comment.
> 
> Comment is easier than comparing them all, I'm happy to add it.  Seems like
> a mpath table with different devices would make little pieces of anything
> you try to put on it, and you wouldn't even get to keep those pieces.
> 
> Maybe other dm experts can think of ways that might break things.. I'll wait
> a day or so.

It would be a concern for multipathd, you don't need to worry about this.

Documenting that dm_blk_get_unique_id returns the uuid from the
first underlying device that supports ->get_unique_id should be
sufficient.

Mike

