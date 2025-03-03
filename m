Return-Path: <linux-nfs+bounces-10416-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B66A4C2F7
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 15:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B66218875CB
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6E4213255;
	Mon,  3 Mar 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8Ncmeal"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8BF1F4183;
	Mon,  3 Mar 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011182; cv=none; b=PfTVTHhgfCyZXBPen9v3a7wJd4H1QQlx5mdjkfLIkAMcxtOxd9cZNn1krmTx/tqRPAtANj33gZ8EmBtTq2KYULl23xqB6dyDh4+7d/4NziwIARonMu2zz75/J+ynkVQbD06IaM4SfeiALnt4cegqGqiUWoUHz+rwrYAbe+CMrOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011182; c=relaxed/simple;
	bh=NIkjVShdKRa5sGBLlP+sLIy3qEWBWoHE4n488XDvYok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6rx5m5lLMJRoiAyG/8MMqkZcQ1w4K95/tzmh6WTjIlR672xWuCMh1i6hN1I6b2UDRadIZRTmRBsLz5bLRYNkF+hs3I+oAjtZYkhJDIAl8PVInZCvSiiOHAUnsiT2MZIcqh22jpgG4kD+D0zc3pFG9mzayst8x1wkahlpWkTDw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8Ncmeal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC87EC4CEE8;
	Mon,  3 Mar 2025 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741011182;
	bh=NIkjVShdKRa5sGBLlP+sLIy3qEWBWoHE4n488XDvYok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8NcmealtKOCjMDYfhdGZsoBwszh/QDHSXXyO9AkgtlA0A7pTR7/xFaGW34rZnnaz
	 YHS0EwxYVDs1NFXN+N2tSljRNN13wZmGh6sFsfuk0zt3imQMkQesFDN2Lqx+2b2NeD
	 o+omZ99N4G9TItj/1aVbVqOJjMPEX5em5uEm2F2rrL0aPFH1m7ScVFAyKghAtBCOFP
	 XWRW5JwHnscbK0tsgpyf5q+RHj8aOk+pSlm6/pKcYUJWhFECMznnK4DWOzq7ABL6k2
	 zI2//1NZ2NEPGWYm67q76imjrJSJRgiJLYR2HsOEilvxHei1l7N4qtTuJH3LllhEjS
	 aPRRlbXzLvdyg==
Date: Mon, 3 Mar 2025 15:12:57 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: nicolas.bouchinet@clip-os.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	linux-nfs@vger.kernel.org, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Joel Granados <j.granados@samsung.com>, Clemens Ladisch <clemens@ladisch.de>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/6] sysctl: Fixes nsm_local_state bounds
Message-ID: <42t2lpwwwihg4heu4ogudt4fe5uz7trg3y2lsoqvmjnzmhnjmy@pebnborzqodv>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-3-nicolas.bouchinet@clip-os.org>
 <da418443-a98b-4b08-ad44-7d45d89b4173@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da418443-a98b-4b08-ad44-7d45d89b4173@oracle.com>

On Mon, Feb 24, 2025 at 09:38:17AM -0500, Chuck Lever wrote:
> On 2/24/25 4:58 AM, nicolas.bouchinet@clip-os.org wrote:
> > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > 
> > Bound nsm_local_state sysctl writings between SYSCTL_ZERO
> > and SYSCTL_INT_MAX.
> > 
> > The proc_handler has thus been updated to proc_dointvec_minmax.
> > 
> > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > ---
> >  fs/lockd/svc.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> > index 2c8eedc6c2cc9..984ab233af8b6 100644
> > --- a/fs/lockd/svc.c
> > +++ b/fs/lockd/svc.c
> > @@ -461,7 +461,9 @@ static const struct ctl_table nlm_sysctls[] = {
> >  		.data		= &nsm_local_state,
> >  		.maxlen		= sizeof(int),
> >  		.mode		= 0644,
> > -		.proc_handler	= proc_dointvec,
> > +		.proc_handler	= proc_dointvec_minmax,
> > +		.extra1		= SYSCTL_ZERO,
> > +		.extra2		= SYSCTL_INT_MAX,
> >  	},
> >  };
> >  
> 
> Hi Nicolas -
> 
> nsm_local_state is an unsigned 32-bit integer. The type of that value is
> defined by spec, because this value is exchanged between peers on the
> network.
> 
> Perhaps this patch should replace proc_dointvec with proc_douintvec
> instead.
As Nicolas stated, that is completely up to how you used the variable.

Things to notice:
1. If you want the full range of a unsigned long, then you should stop
   using proc_dointvec as it will upper limit the value to INT_MAX.
2. If you want to keep using nsm_local_state as unsigned int, then
   please add SYSCTL_ZERO as a lower bound to avoid assigning negative
   values
3. Having SYSCTL_INT_MAX is not necessary as it is already capped by
   proc_dointvec{_minmax,}, but it is nice to have as it makes explicit
   what is happening.

Let me know if you take this through your trees so I can remove it from
sysctl.

Reviewed-by: Joel Granados <joel.granados@kernel.org>

Best

> 
> 
> -- 
> Chuck Lever

-- 

Joel Granados

