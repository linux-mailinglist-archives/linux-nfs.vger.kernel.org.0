Return-Path: <linux-nfs+bounces-10484-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FED7A502B9
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 15:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26F23A6924
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 14:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A4B24BBE3;
	Wed,  5 Mar 2025 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOdXTj3H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4321B248863;
	Wed,  5 Mar 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186064; cv=none; b=WrUUoquAUMsMyF+BR1L+AgL5pZzfePVQdPF3ANvglmYhX79skSCFVv6Zr7NNcPFJ7hnYmvgHzc1pZr1u9jEmsY5MNnlq3/1dTI0IFTsX/ZUttbfbf8zG/Mfn8D+9muq/y0BBFiBPKKQ3ZQIYNyCoiYzjLC69ETI0RS8ud1aAbLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186064; c=relaxed/simple;
	bh=0nKpmpCNxYH8Z+0rlZ74ZK5vY3M1YKDKBq8UNZOSqbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5CQ6YYajVwWaggBOn4Z0oAkLtmCrERg5eK+rDtArqv40MOWUvfPKCVn6U57+P0Y4ZsIGbhAFrDXWPMFeDvFiuAyRNJ6Dg25ddak/WNR3nGP9QCT+qZWgDbrve+D+v7bB1/ymf8TctcctoRrYPEtTV0MgRB7U6PkqRN/WYMH9I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOdXTj3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A65C4CED1;
	Wed,  5 Mar 2025 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741186063;
	bh=0nKpmpCNxYH8Z+0rlZ74ZK5vY3M1YKDKBq8UNZOSqbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YOdXTj3H2plhn/BST20bnDuxSY0RJXeFrcQ+3aimzVjoikkWSpG4KPnwlAGy/Q2Ds
	 bcl6/jUFIbhI+klJk8IGwwlXaXnuot8803FSwmKJtc/iF9huCwhzhmrzzreYYDLiAm
	 Q7dZghjwPCIhzy0BjCxU4KEzueELzuipHClRssnK+eGFdxQF7wLkGWZHbR92iNYRLx
	 IYDw/MfgKjHu1J4QjnLUZu15e55b0xIJlsBCOXd94J/HqWvoLgvPqi2ZnkxARWyEQn
	 vn0QVhAeaX/w7+5njaRddoNM87jv95lSBy5QauWLw3L7xENZZe4ZuIgVdnR3fBfLy6
	 qRcCn9RO/FN6A==
Date: Wed, 5 Mar 2025 15:47:39 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: nicolas.bouchinet@clip-os.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Joel Granados <j.granados@samsung.com>, 
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 3/6] sysctl/coda: Fixes timeout bounds
Message-ID: <ukkrk6tcf4peempwyutpruupqjkyrbeizrqz2ymjsjpmj6tds5@zb5vp5rh7qoe>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-4-nicolas.bouchinet@clip-os.org>
 <u7q5rpzw6mohtnnhpa2j3u4photckmgllsl3noafnyfttepbui@rzmndu533xcv>
 <20250303143937.etzv7idjbenugsgw@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303143937.etzv7idjbenugsgw@cs.cmu.edu>

On Mon, Mar 03, 2025 at 09:39:37AM -0500, Jan Harkes wrote:
> On Mon, Mar 03, 2025 at 09:16:10AM -0500, Joel Granados wrote:
> > On Mon, Feb 24, 2025 at 10:58:18AM +0100, nicolas.bouchinet@clip-os.org wrote:
> > > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > > 
> > > Bound coda timeout sysctl writings between SYSCTL_ZERO
> > > and SYSCTL_INT_MAX.
> > > 
> > > The proc_handler has thus been updated to proc_dointvec_minmax.
> > > 
> > > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > > ---
> > >  fs/coda/sysctl.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
> > > index 0df46f09b6cc5..d6f8206c51575 100644
> > > --- a/fs/coda/sysctl.c
> > > +++ b/fs/coda/sysctl.c
> > > @@ -20,7 +20,9 @@ static const struct ctl_table coda_table[] = {
> > >  		.data		= &coda_timeout,
> > I noticed that coda_timeout is an unsigned long. With that in mind I
> > would change it to unsigned int. It seems to be a value that can be
> > ranged within [0,INT_MAX]
> 
> That seems fine by me.
> 
> It is a timeout in seconds and it is typically set to some value well
> under a minute.
> 

Thx for the confirmation. I'll let nicolas take care of the change
Best

-- 

Joel Granados

