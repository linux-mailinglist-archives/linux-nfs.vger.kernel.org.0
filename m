Return-Path: <linux-nfs+bounces-10480-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AF4A50289
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 15:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438EA1668F2
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 14:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04E24EAB6;
	Wed,  5 Mar 2025 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VL8phBxE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72E24EA9D;
	Wed,  5 Mar 2025 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185833; cv=none; b=qTQUQSuuBn0ERTbBB0SmUsUojA+CfTFxDdXt9oJe7wu523ENWoi6SLCw+Ca5PlZbtfUHODNpGk6Wie5yWdkaTPFCKeHB5+4EgB/t2EtmeI+RyYrY/62K5Z5PrgoiVVsuvgGd9eIECu9CGClyhVCbBfPB+M1lZ5oe5rLr5x00T98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185833; c=relaxed/simple;
	bh=q0jxvZ22iaWtq6NXJfvioYNnCp9yCTO3f0Gdzs+gwAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4NQmQkMiFG6x0LY6309d5GHHmu95+XE50KDjkNXGy2OJbEEssiekahxHmPTM4gEX5dKXNgbGzU0gGiGv/E32mRpYlvXz4Jt1/FAqczZZza82b6WhU8sBJ0bTf+pDF0yhMOdPaSauj0MwWZfZJNGm106FllJ6r/3SxfBuDICOv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VL8phBxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1D4C4CEEA;
	Wed,  5 Mar 2025 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741185832;
	bh=q0jxvZ22iaWtq6NXJfvioYNnCp9yCTO3f0Gdzs+gwAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VL8phBxEFd5Fj6YetuiSBuA7/2QNGmEqIVa74UvUIYW80vX0LG79IILjPHeitzW0G
	 kKgSxMzYiq0Y0dhIUiFAvFEmNQf5v5zlg8hR5+CAwnF7LKb6VLYrlpDkZ70FBzg+cP
	 Mm45tEh6W6do3V+ZD485y4tIequsew05viWenFmNBPlgwerdWL+k8H/sRuEwZdSAbc
	 uhKP8OFJIs49UDkeinedf+FZJIxeoWkxY1nYoStB94ZbJfOA7SycLFJW2K9rrlv3or
	 OaJC15q8Dv7EEM3le6UMkrtmoYYbMrMgMIaY0WCc6H+v0xY66aS5CuM3eOxDUFycbm
	 rYfVb1j4UicFQ==
Date: Wed, 5 Mar 2025 15:43:47 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: nicolas.bouchinet@clip-os.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	linux-nfs@vger.kernel.org, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Joel Granados <j.granados@samsung.com>, Clemens Ladisch <clemens@ladisch.de>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jan Harkes <jaharkes@cs.cmu.edu>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 5/6] sysctl/infiniband: Fixes infiniband sysctl bounds
Message-ID: <i4x736hwah7vc7mjjooxyeo3t73wzcm365mah3qganrs6x6l2d@khb2a6uggrop>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-6-nicolas.bouchinet@clip-os.org>
 <20250224134105.GC53094@unreal>
 <6obp2rythrcvlknqsczvxmhenhvxsosobc4cwx36iinyjjj5mr@b227ysqvp5vh>
 <20250303185309.GA1955273@unreal>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303185309.GA1955273@unreal>

On Mon, Mar 03, 2025 at 08:53:09PM +0200, Leon Romanovsky wrote:
> On Mon, Mar 03, 2025 at 02:57:29PM +0100, Joel Granados wrote:
> > On Mon, Feb 24, 2025 at 03:41:05PM +0200, Leon Romanovsky wrote:
> > > On Mon, Feb 24, 2025 at 10:58:20AM +0100, nicolas.bouchinet@clip-os.org wrote:
> > > > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > > > 
> > > > Bound infiniband iwcm and ucma sysctl writings between SYSCTL_ZERO
> > > > and SYSCTL_INT_MAX.
> > > > 
> > > > The proc_handler has thus been updated to proc_dointvec_minmax.
> > > > 
> > > > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > > > ---
> > > >  drivers/infiniband/core/iwcm.c | 4 +++-
> > > >  drivers/infiniband/core/ucma.c | 4 +++-
> > > >  2 files changed, 6 insertions(+), 2 deletions(-)
> > > > 
> > > 
> > > Acked-by: Leon Romanovsky <leon@kernel.org>
> > > 
> > > How do you want to proceed from here? Should I take to RDMA repository?
> > > 
> > > Thanks
> > It would be great if we push this through RDMA. Here are a few comments:
> > 1. Having the upper bound be SYSCTL_INT_MAX is not necessary (as it is
> >    silently capped by proc_dointvec_minmax, but it is good to have as it
> >    gives understanding on what the spread of the values are.
> > 
> > 2. Having the lower bound capped by SYSCTL_ZERO is needed as it will
> >    prevent ppl trying to assing negative values to the unsigned integers
> > 
> > Please let me know if you will push this through RDMA, so I know to
> > remove it from sysctl.
> 
> Applied to RDMA tree.
> https://web.git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/leon-for-next&id=f33cd9b3fd03a791296ab37550ffd26213a90c4e
Perfect. Thx.

@Nicolas: pls take this one out of your next version as it is
already on its way upstrea.

Best
> 
> > 
> > Best
> > 
> > Reviewed-by: Joel Granados <joel.granados@kernel.org>
> 
> Thanks
> 
> > 
> > -- 
> > 
> > Joel Granados

-- 

Joel Granados

