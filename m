Return-Path: <linux-nfs+bounces-10413-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB2CA4C28B
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 14:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1CD1894DA9
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 13:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F4E211A28;
	Mon,  3 Mar 2025 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJXaGm5w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B171F17E5;
	Mon,  3 Mar 2025 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010256; cv=none; b=SPSpJiCn6zvhQxILkrK68Fcfo++TthVgNaTTYzMun+hXzYHYG0z/pYkFu6QqAjcUyGTdqQaR8URcr+FEmWzB9c1H8/7K/ULexxGVmOgPjxJXTXNE5ycOGPaKCUkxvSW4zTlOa38SwDtjTwExpm1DE1mXBgUXvqsrFkseEbEDSt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010256; c=relaxed/simple;
	bh=CSeQfjhUATzi2apY2EvQ8EXBeQhagN7FdfUduB8FXgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srn5HfPOX98PeeTzISBOw7OxC7rrK0hbFFVYO0IDc7ypslrpD22LLvZC0MwEGpBHoVdQOkNIDKbYLmrKVnRZXtc9YlJvrqSf0Mpv/obtCcbmDl/aLyuANEvPJA9nn29qK3GjRDr9ptBYkvBBnjcWzFnRwZUwpSBi+j9FMLPTzJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJXaGm5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6217DC4CED6;
	Mon,  3 Mar 2025 13:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741010255;
	bh=CSeQfjhUATzi2apY2EvQ8EXBeQhagN7FdfUduB8FXgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJXaGm5wFQHufxHwfMSPCml2cJUBvt/u2mNGDyLyBALQf5vYYNYxKKUiCcpR+oPQz
	 8+lqZkyKL3uK252C7lfU8m5FHLHRW4Tu4tM/ex8hGyNtHGc+1vDori3uyjRlpIOOA+
	 RlVWhtqDOosHMmAXyVbb+aXVUC+0RBfDO2aPXJqNhuYICadpx2HRRLu0fSWSUmw//O
	 SipHxLrIxSGA77bLmfQoYE5Y+8CWSN53BVkBhY++x/aCXjjkND0S9wqYf/g6knjQ7Z
	 pg7TMn74+Fl94tmxASMFzj9+z8/07vE64GeDghgjMmfg91VAbOfxFN4jo3bAaOejET
	 LupofHPavTpdQ==
Date: Mon, 3 Mar 2025 14:57:29 +0100
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
Message-ID: <6obp2rythrcvlknqsczvxmhenhvxsosobc4cwx36iinyjjj5mr@b227ysqvp5vh>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-6-nicolas.bouchinet@clip-os.org>
 <20250224134105.GC53094@unreal>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224134105.GC53094@unreal>

On Mon, Feb 24, 2025 at 03:41:05PM +0200, Leon Romanovsky wrote:
> On Mon, Feb 24, 2025 at 10:58:20AM +0100, nicolas.bouchinet@clip-os.org wrote:
> > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > 
> > Bound infiniband iwcm and ucma sysctl writings between SYSCTL_ZERO
> > and SYSCTL_INT_MAX.
> > 
> > The proc_handler has thus been updated to proc_dointvec_minmax.
> > 
> > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > ---
> >  drivers/infiniband/core/iwcm.c | 4 +++-
> >  drivers/infiniband/core/ucma.c | 4 +++-
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> > 
> 
> Acked-by: Leon Romanovsky <leon@kernel.org>
> 
> How do you want to proceed from here? Should I take to RDMA repository?
> 
> Thanks
It would be great if we push this through RDMA. Here are a few comments:
1. Having the upper bound be SYSCTL_INT_MAX is not necessary (as it is
   silently capped by proc_dointvec_minmax, but it is good to have as it
   gives understanding on what the spread of the values are.

2. Having the lower bound capped by SYSCTL_ZERO is needed as it will
   prevent ppl trying to assing negative values to the unsigned integers

Please let me know if you will push this through RDMA, so I know to
remove it from sysctl.

Best

Reviewed-by: Joel Granados <joel.granados@kernel.org>

-- 

Joel Granados

