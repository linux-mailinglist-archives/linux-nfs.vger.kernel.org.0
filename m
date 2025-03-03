Return-Path: <linux-nfs+bounces-10415-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56337A4C2C0
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 15:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46375188A348
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 14:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0F9212D7C;
	Mon,  3 Mar 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAjYxIxb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F481F8733;
	Mon,  3 Mar 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010665; cv=none; b=r2qTiIi7fVnQgxHXDxaE2yg4bFU/fXUZhlbBSDE8vflQ5MLvps1UZs5mWtRaFj1FEllXfQzNKGXH8y857o4gNAUQPoGJTlSuHel5JzvduClqvL0OTqQqUzMXkoMMv/QCgoWUvuLZBDbp92KIbc+PW8pJ8/kmk8JllTXzlR7Vt+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010665; c=relaxed/simple;
	bh=vWYLCmVVjXgIacFX+hNigDLTQqVgZq+pPM2kMcc60p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfx60xgK6+/qjQkrWWJsDSKgrXWXnoKVNlBD5xNMAiWaM+dWW5djz04KQJLrFTd1/mxA44UjrLXK1Icie92eF2D4k2yUQPQYjLQqodV7zNH9cWUcroI1qE6lGjKA9T/zSYJ8H4QzLl491RZTZCVUPA/My9igcaS9kwj0Q1yx0dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAjYxIxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D15CC4CED6;
	Mon,  3 Mar 2025 14:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741010665;
	bh=vWYLCmVVjXgIacFX+hNigDLTQqVgZq+pPM2kMcc60p4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAjYxIxbNmdV1RMtw7UQDSa5c3z8p7aoYkPv224WubW2b5wPuPSE4nVTsySnxyPES
	 cSYjbQ13OCwxtLIauTh84eN/8NrZKMXU6NA4I/TV42DGqmLZrQpzd+oO199EO6tQBR
	 16kVgC/dU0ecXbKPpIncLba3mJVwgvMbf4/5bg/MxRi21cuB88PY1r1B5CQKrrW0DW
	 yiVf8Kzyag3oQnIWNK2RGf82MmiVelLFk81a77IcivMhSTMSR8cVdvQ4V1AQCDGI+A
	 vho/duRwrgNbT2ZewgJdFfEntk5+UysLgBm/an9Ua8OQ8cPQLxqMa66tQm/hCCljQ7
	 URNEQGGMV5YVw==
Date: Mon, 3 Mar 2025 15:04:19 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org, 
	codalist@coda.cs.cmu.edu, linux-nfs@vger.kernel.org, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Joel Granados <j.granados@samsung.com>, 
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, Zhu Yanjun <yanjun.zhu@linux.dev>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 4/6] sysctl: Fixes scsi_logging_level bounds
Message-ID: <rgh2ffvmp2wlyupv6vw5s3qexuipgu6vdr2qsitgnbn6syk6ye@ln74xh26jdwp>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-5-nicolas.bouchinet@clip-os.org>
 <yq1y0xubz40.fsf@ca-mkp.ca.oracle.com>
 <0a9869e0-d091-4568-a6e7-8d7d72b296a9@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a9869e0-d091-4568-a6e7-8d7d72b296a9@clip-os.org>

On Tue, Feb 25, 2025 at 11:47:42AM +0100, Nicolas Bouchinet wrote:
> 
> On 2/25/25 02:20, Martin K. Petersen wrote:
> > Hi Nicolas!
> > 
> > > --- a/drivers/scsi/scsi_sysctl.c
> > > +++ b/drivers/scsi/scsi_sysctl.c
> > > @@ -17,7 +17,9 @@ static const struct ctl_table scsi_table[] = {
> > >   	  .data		= &scsi_logging_level,
> > >   	  .maxlen	= sizeof(scsi_logging_level),
> > >   	  .mode		= 0644,
> > > -	  .proc_handler	= proc_dointvec },
> > > +	  .proc_handler	= proc_dointvec_minmax,
> > > +	  .extra1	= SYSCTL_ZERO,
> > > +	  .extra2	= SYSCTL_INT_MAX },
> > scsi_logging_level is a bitmask and should be unsigned.
> > 
> 
> Hi Martin,
> 
> Thank's for your review.
> 
> Does `scsi_logging_level` needs the full range of a unsigned 32-bit integer
> ?
> As it was using `proc_dointvec`, it was capped to an INT_MAX.
> 
> If it effectively need the full range of an unsigned 32-bit integer, the
> `proc_handler` could be changed to `proc_douintvec` as suggested by Chuck.
And as mentioned in another patch in this series:
1. Having the upper bound be SYSCTL_INT_MAX is not necessary (as it is
   silently capped by proc_dointvec_minmax, but it is good to have as it
   adds to the understanding on what the range of the values are.

2. Having the lower bound capped by SYSCTL_ZERO is needed as it will
   prevent ppl trying to assigning negative values to the unsigned integer

Let me know if you take this through the scsi subsystem so I know to
drop it from sysctl 

Best

Reviewed-by: Joel Granados <joel.granados@kernel.org>


> 
> Best regards,
> 
> Nicolas
> 

-- 

Joel Granados

