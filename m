Return-Path: <linux-nfs+bounces-14723-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 516ADBA15C1
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 22:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD0F325E92
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 20:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1804B35940;
	Thu, 25 Sep 2025 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuezkN83"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DDFEAE7;
	Thu, 25 Sep 2025 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832359; cv=none; b=WL2KOmaAilmAyy3XSQGRTqeAov2/ei+/ZUzp0ttWdQN5YzfTfmuvdu+nYQ/kabQAzDqDhuY8eItZ2tmQoovo9mD8zkv3KSpQFTATngGcQQta6FTxfkjQNeXUKyC6qsDzIWUgdii4ws5nfAxZjTHNutfERWLv5J5X3+XPZM+fqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832359; c=relaxed/simple;
	bh=LH5+K3GRpQXNBPw30ObKfOhuQY+wJt77ujcb37iB2dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enSx8w4/a0YrupqRc6nTDPc1HaXEfpgKJNTxlbWBMY0tOJBKDLH7hFY6PN5okDrHhWqr5v5CNGQabkaq1RLGNriK3BDVWlOgRC4R7lSPKTMrKrZGtC3s2+3J90zlSK900DsRIsvBGBzhe5wxKh3AZBQUZEBvf+fTZnglReFKk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuezkN83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CB3C4CEF0;
	Thu, 25 Sep 2025 20:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758832358;
	bh=LH5+K3GRpQXNBPw30ObKfOhuQY+wJt77ujcb37iB2dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OuezkN83cwh6QB9uXazZZFSiedSHQbYGQcEmK8Y/ga8bMFK5tt2WVVt8yQq/IHbPm
	 yks8uFFZEKilaJiBt2VjiWNZisqCO9K1EyaJNgdaU1KXC+7rEVRqpO9qQKsS0ff9jn
	 hQcTHPs2mOTN1DgLIE4X3NIt1Joivuxn7OY7wB8jfCr0L+8pKCRtBm8OIkpax3+ON6
	 LTWwvrZGNHYDXzNT93weqTryCemMXYkvq/3wdOhlONdz3TqR/EGN2cEWcwY+hlVJY6
	 I7WiHIILb67wicfJyTRgSltAg+zOZNElnHJqMXlLBI2/u8oDwIK4vSCysHvKdRnS6m
	 HIAIOon2AqEZQ==
Date: Thu, 25 Sep 2025 16:32:33 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Simon Horman <horms@kernel.org>, linux-nfs@vger.kernel.org,
	patches@lists.linux.dev, Anna Schumaker <anna.schumaker@oracle.com>
Subject: Re: [PATCH] nfsd: Move strlen declaration in
 nfsd4_encode_components_esc()
Message-ID: <20250925203233.GB491548@ax162>
References: <20250925-nfsd-fix-trace-printk-strlen-error-v1-1-1360530e4c6b@kernel.org>
 <6669bd1e-ba37-433a-8f8c-5cd9787b846f@oracle.com>
 <27d0b9176a444dcf87ecd40c17b6ed1865c1b789.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27d0b9176a444dcf87ecd40c17b6ed1865c1b789.camel@kernel.org>

On Thu, Sep 25, 2025 at 12:52:10PM -0400, Jeff Layton wrote:
> On Thu, 2025-09-25 at 09:43 -0400, Chuck Lever wrote:
> > Would anyone be heartbroken if this patch removed the dprintk call site?

Yeah, I had figured this print may be low value and worth removing as a
fix.

> > I think renaming the strlen variable to a name with a lower collision
> > risk would be sensible as well.
> > 
> 
> Fine with me on both counts. No point in overloading a well known
> function name here.

Agreed. Should I send a patch or does someone else want to?

Cheers,
Nathan

