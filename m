Return-Path: <linux-nfs+bounces-4644-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB44928AD1
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 16:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0092B1F21CC6
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 14:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2237E1465B3;
	Fri,  5 Jul 2024 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2CHHkV1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D9014B07D
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720190216; cv=none; b=nirLwzTOr26cCIMIdzQ87D5msYMnJF3iR3qZ6fsu17uTFB/Uh8Sm/Bsz38lWLtNDbmk2IXQpJ7i64+F8zEBY0adoUnLUHbVKJkvasiaY7ZOYiJnAqbssHB4umXxV/WHA0QaXErw68fB+Brdb9rhmdOgKapbmvJV0y9AfJZa0A2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720190216; c=relaxed/simple;
	bh=D2EyCtYKNEpWZmcCa0kVhHQVw5Tp3oeChrw5TvzW0FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OokgLNi4h604Gksr7jeMTaKvH2pEis9mlarPo5q+Bwys1RrWFihFAfR3gVZsOh/58XvGk2QVi2nzwdV6HrJd8d4PWWwsP8SoayTQ5YcmVlqJVhyKUI6y6ORr89nbYB8ldPGH4y7eNmgdnvqDeXIJ+9JUq3rSwMc2WRoH/hEpWPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2CHHkV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AC1C116B1;
	Fri,  5 Jul 2024 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720190215;
	bh=D2EyCtYKNEpWZmcCa0kVhHQVw5Tp3oeChrw5TvzW0FA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j2CHHkV1AKPjG16TLYQuC8HFtsE2K62cyphF/ad+upYz6pTlYebvkLA11OtJ+Lr6T
	 JMKWWZdiQpBa1ag/WD3B/ifcBp/3hK8tqyzcSvZuyLNi15MyxQ4MFJo+1Nv+M4jh9+
	 cCnsLkNhiFNr7eNJQlSPW1bnDdNr6YZyFCOisNtBL5XuvxH+f/Ot+G98VJSsigMe9G
	 pcnJa2cfbzFzgwAoF0rvDZdfl0exJ+9DToOowBCa31GqEFIwlaLSEfelp98PnmjkC3
	 +MPJ4CsgioCh7UVO2oB7HGYqH57TXTyXkNEk3XlndGSKYlU6UJTPcRZrS0RFjVm4I3
	 0yCFUEzwC8iCg==
Date: Fri, 5 Jul 2024 10:36:54 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZogFBqv0z7Rnh4_p@kernel.org>
References: <ZoVrqp-EpkPAhTGs@infradead.org>
 <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
 <ZoVv4IVNC2dP1EaM@kernel.org>
 <4486ee80a487c174ec88c7e12705d99e22ae812a.camel@kernel.org>
 <ZoY6e-BmRJFLkziG@infradead.org>
 <ZobqkgBeQaPwq7ly@kernel.org>
 <ZoeCFwzmGiQT4V0a@infradead.org>
 <57C1CB2B-3B46-48F3-A095-417845001C3E@oracle.com>
 <ZogAEqYvJaYLVyKj@kernel.org>
 <ZogAtVfeqXv3jgAv@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZogAtVfeqXv3jgAv@infradead.org>

On Fri, Jul 05, 2024 at 07:18:29AM -0700, Christoph Hellwig wrote:
> On Fri, Jul 05, 2024 at 10:15:46AM -0400, Mike Snitzer wrote:
> > NFSv3 is needed because NFSv3 is used to initiate IO to NFSv3 knfsd on
> > the same host.
> 
> That doesn't really bring is any further.  Why is it required?
> 
> I think we'll just need to stop this discussion until we have reasonable
> documentation of the use cases and assumptions, because without that
> we'll get hund up in dead loops.

It _really_ isn't material to the core capability that localio provides.
localio supporting NFSv3 is beneficial for NFSv3 users (NFSv3 in
containers).

Hammerspace needs localio to work with NFSv3 to assist with its "data
movers" that run on the host (using nfs and nfsd).

Please just remove yourself from the conversation if you cannot make
sense of this.  If you'd like to be involved, put the work in to
understand the code and be professional.

