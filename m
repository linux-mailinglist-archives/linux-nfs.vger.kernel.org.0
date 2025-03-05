Return-Path: <linux-nfs+bounces-10481-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7039CA5027C
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 15:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F12C07A4E74
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB26F24E4A0;
	Wed,  5 Mar 2025 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAGrGH9O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8A248885;
	Wed,  5 Mar 2025 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185901; cv=none; b=izJ+1BERUQ5ZSLjYmQgp7XcklutbPlU7E35wRpO8gqFux8Qa0XMKZTqvXlYicQP4Q8y86VGqPGkiaKOIp1Y38p/4/GNYekKIAhqetjFTPfeK7dcDxhUD7u7c17Y21OYjH6SIfkvahOIVKr1eTY6Dh35f52dG2JmYCSNI5CzY+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185901; c=relaxed/simple;
	bh=7ASHfawryKHf3PEPpBd0pHmfcg7rVi91rbNSa2ZTzBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLi9WWh1Nyw9zk0M8Nm8bp6Si8IP/N+8j65fKKrg0oKgJaR6t38SiSah48DRVakVM4oEmkfvSFwZmuOWD1pI8OjmXFxc5Jl78d/t/xV7SQ5nPY0AWtC0OSpyztPczWSE6BHwNTECR2MfocYwL24gFOMHzDiZaFEqYzSzpztvlGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAGrGH9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4061C4CED1;
	Wed,  5 Mar 2025 14:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741185901;
	bh=7ASHfawryKHf3PEPpBd0pHmfcg7rVi91rbNSa2ZTzBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAGrGH9ObtVWKX3e7bD2yu25LK/nLOfizTQ/iTNjT19pub2TX11fojTHUclJi0Maw
	 XiShJOndCK3ebVQNwkDAdBHkuY7oXVOC1kZMOrzpN6QnkFuFEF5U8LomKPSJ5KY/v1
	 iqu3cPbA4Q+WuUKgCITReQabZcnF/Q6b+BKIkgTXKsceR09scb9ykO+1jItzYskhcl
	 38XzwEzzpjkcgqJpLPkmGqFWsZrHyBSxzImdXrr9roAFUu+WmW6WK8Z6sBHDP4o9Xn
	 mST6U9k7/MWqfRPPOw2Pa0sJYTdE5jLJxi7VH+noKRBRKxC1CwWrTy8RRDaz7q301K
	 j0XVvbAwwtzgQ==
Date: Wed, 5 Mar 2025 15:44:56 +0100
From: Joel Granados <joel.granados@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>, 
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
Message-ID: <oy2jkeisvm7edg7zrohp6iipvnktj5o3sw5hxksoxgorppoj6r@hubn7cifqdxl>
References: <20250224095826.16458-1-nicolas.bouchinet@clip-os.org>
 <20250224095826.16458-5-nicolas.bouchinet@clip-os.org>
 <yq1y0xubz40.fsf@ca-mkp.ca.oracle.com>
 <0a9869e0-d091-4568-a6e7-8d7d72b296a9@clip-os.org>
 <rgh2ffvmp2wlyupv6vw5s3qexuipgu6vdr2qsitgnbn6syk6ye@ln74xh26jdwp>
 <yq134ftv8h4.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq134ftv8h4.fsf@ca-mkp.ca.oracle.com>

On Mon, Mar 03, 2025 at 09:24:43PM -0500, Martin K. Petersen wrote:
> 
> Joel,
> 
> > 1. Having the upper bound be SYSCTL_INT_MAX is not necessary (as it is
> >    silently capped by proc_dointvec_minmax, but it is good to have as it
> >    adds to the understanding on what the range of the values are.
> >
> > 2. Having the lower bound capped by SYSCTL_ZERO is needed as it will
> >    prevent ppl trying to assigning negative values to the unsigned integer
> >
> > Let me know if you take this through the scsi subsystem so I know to
> > drop it from sysctl 
> 
> Applied to 6.15/scsi-staging, thanks!
Thx!!

@Nicolas: Please take this out of your next version as it is already
going upstream.

Best

> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering

-- 

Joel Granados

