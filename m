Return-Path: <linux-nfs+bounces-16009-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BF8C31F23
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 16:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85332189924E
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 15:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF422749D3;
	Tue,  4 Nov 2025 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml253epP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6CA26CE2E
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271660; cv=none; b=AOBpzvhfRTsPVbynPN7CPFFFVzmYkCb1Izl69gP1UevXblXfJ5QerQU3LToDpsXwuJgNqcOpzHNwS3WoTHk39HDvjmkozznsicOAkike3GorCOja0T4voutyEzp+1W3KLYqoUvmgn9tHYXejVEk5/Cn5N5Dpqnx40tsIvVHdqxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271660; c=relaxed/simple;
	bh=Iy/w7WQvhVLTDYge7SfBzCIn0MgQTNTPyYqI0hUPonw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhY/fMOnZdtGaWkpkKterL3K8jLIRekK4Htd9EevAYEJIyholoWZ+0KyC6khmHnoc1ywjUQRIomDSA3NVf5Mkm6ELMkiJ5E9VRmJNPCO4XcP9ngmRPWYlVqyTswPiKy3XQ0naDHmn0PiccUzi5JTeROnW1A9ui6TuCOj/DbKp28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ml253epP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39141C4CEF7;
	Tue,  4 Nov 2025 15:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762271660;
	bh=Iy/w7WQvhVLTDYge7SfBzCIn0MgQTNTPyYqI0hUPonw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ml253epPp68LH+H+xZnNiIViTLYFV8uTbNP1OisQQOpYEirnB7nqS+2NkRnSjpEBP
	 jzd+2rfzf9PpOITtGosbXYEI2OasgFQhvfv65mgg1CjUIg+nn4JuY7yWOSF867JAll
	 t7/JDatCKnvH4ammmQrt41Ybl5M1YBFyqDAV7Y3dL3nnQkfsnH6lnwEXiavjMeRJDB
	 py1148ib/va9Q6F2QsCQsL7QV2Mo/zlNhezSucFT9U1pUKu4Ff/M3Yl+2d0WhATH5A
	 Xtn6WLvo821G+tzX/y7zQcdHxKVUY5jV71ILpg+sktbxGXaSM2vp7UPV2yTvrAIEjw
	 nYlp9zq9vNyww==
Date: Tue, 4 Nov 2025 10:54:19 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v9 05/12] NFSD: Remove alignment size checking
Message-ID: <aQohqxw9fsqAE2OB@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>
 <20251103165351.10261-6-cel@kernel.org>
 <176220902556.1793333.10293656800242618512@noble.neil.brown.name>
 <aQnpB4mYMwW9IGM0@infradead.org>
 <35ddc8b0-2727-453e-b970-07b493e21f93@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ddc8b0-2727-453e-b970-07b493e21f93@kernel.org>

On Tue, Nov 04, 2025 at 09:14:09AM -0500, Chuck Lever wrote:
> On 11/4/25 6:52 AM, Christoph Hellwig wrote:
> > On Tue, Nov 04, 2025 at 09:30:25AM +1100, NeilBrown wrote:
> >> On Tue, 04 Nov 2025, Chuck Lever wrote:
> >>> From: Chuck Lever <chuck.lever@oracle.com>
> >>>
> >>> Noted that the NFS client's LOCALIO code still retains this check.
> >>
> >> It might be good to capture here *why* the check is removed.
> >> Is it because alignments never exceed PAGE_SIZE, or because the code is
> >> quite capable of handling larger alignments
> >> (I haven't been following the conversation closely..)
> > 
> > I'm still trying to understand why it was added in the first place :)
> 
> I'm trying to understand what action you'd like me to take. Should I
> drop this patch?

Maybe just fold it into Patch 3 and we can forget it ever happened?

The reason it was added is this NFSD_IO_DIRECT feature has had many
iterations, and in the earlier days on its development I was
allocating extra _pages_ to accomodate the misaligned head and tail
pages _outside_ of the sunrpc provided buffers.  This started with
READ and copy-n-paste brought it to the WRITE side IIRC.

> > But I'm also completely lost in the maze of fixup patches.
> Several people have asked me to collapse the fix-ups into a single
> patch. We would lose some history and attributions doing that. Does
> anyone have other thoughts?

The series has a mix of renames that distract, but overall what
matters most is where the code ends up. I don't have a problem with
the various changes when I look at the result (and because I've
acclimated to the evolution). Probably best to just leave well enough
alone given Jeff, myself and Neil have provided various Reviewed-by

Mike

