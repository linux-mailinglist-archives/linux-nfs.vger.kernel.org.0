Return-Path: <linux-nfs+bounces-6457-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D3497857C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 18:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2E61C21789
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 16:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75564778C;
	Fri, 13 Sep 2024 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qgs2YNIy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBF9D502;
	Fri, 13 Sep 2024 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243805; cv=none; b=uCpR4qZEo8M44nDCldKOtxvotMx0K9Aj2wU3Gkap6CIf6GYeazo5oVIen8RjFHjqEXPz94VR7LrO+LI6+WqCQ2rv6VzDLb3uBm1L+4doQrvo9LLxDmW7pWANQ6SjBA/Reuw9UzCyz069/Qzlm8DHBiI7uiJ/AqBpEZ/WWTfQTLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243805; c=relaxed/simple;
	bh=vY7ACJ785S7B/v9wL6zLrZvfyiIPparAH0om2ZPmtsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrTpbFwdk4U+1Fow3RLs9HuZj2YjIroRNRQeVMM2t/ZclEH0CwOy7A050lhNvxkLRQnI388tnCjijPoEENXVGHYAoPLUOwkDhFtk+CFfvARUNh5SymGNK3AOI/Q2mM9Lw2FKvCp/jpP6a9hyyAJz9UIag8YmzDRvCqWjN3EWYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qgs2YNIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF02FC4CEC0;
	Fri, 13 Sep 2024 16:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726243805;
	bh=vY7ACJ785S7B/v9wL6zLrZvfyiIPparAH0om2ZPmtsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qgs2YNIyEwOPm2c6pgsXpCRkxFo+6FGNZxDV6mDvGSMWcKNsn5Dn4MxdNkMz8UqYE
	 YpB/B78kVuQlT023SgwrHwvWq+i7CvB17+U+YuXnF4/Bb6HAHh5zruPcHqeruO/Pk5
	 YysKgf8eiiNUainHB5SyPZVOind1//sxb/pTq1dz3W24sDXBZKZFu+LkaKMqi87fzI
	 afNJc1sN4BDQVIIbO1JGxiu45w4Y4dXAOfHf2h6JRfUlMvUcr5YVO3/GK8vWsFbQbG
	 LNFCApJwm8GJSacX3j1O+/cH33ff3gmvHaae7HbxwEmWHi6UP9s7BofUqFaPsvAPlG
	 UFvlmM8TITZPQ==
Received: by pali.im (Postfix)
	id 2606B725; Fri, 13 Sep 2024 18:10:00 +0200 (CEST)
Date: Fri, 13 Sep 2024 18:10:00 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fill NFSv4.1 server implementation fields in
 OP_EXCHANGE_ID response
Message-ID: <20240913161000.33ogsvxbe3njghhw@pali>
References: <20240912220919.23449-1-pali@kernel.org>
 <ZuRX/QfG+OLm9fTR@tissot.1015granger.net>
 <20240913153631.2lqq5nybuitjiwmo@pali>
 <ZuRjSIyHguz3ult4@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuRjSIyHguz3ult4@tissot.1015granger.net>
User-Agent: NeoMutt/20180716

On Friday 13 September 2024 12:07:36 Chuck Lever wrote:
> On Fri, Sep 13, 2024 at 05:36:31PM +0200, Pali Rohár wrote:
> > On Friday 13 September 2024 11:19:25 Chuck Lever wrote:
> > > On Fri, Sep 13, 2024 at 12:09:19AM +0200, Pali Rohár wrote:
> > > > NFSv4.1 OP_EXCHANGE_ID response from server may contain server
> > > > implementation details (domain, name and build time) in optional
> > > > nfs_impl_id4 field. Currently nfsd does not fill this field.
> > > > 
> > > > NFSv4.1 OP_EXCHANGE_ID call request from client may contain client
> > > > implementation details and Linux NFSv4.1 client is already filling these
> > > > information based on runtime module param "nfs.send_implementation_id" and
> > > > build time Kconfig option "NFS_V4_1_IMPLEMENTATION_ID_DOMAIN". Module param
> > > > send_implementation_id specify whether to fill implementation fields and
> > > > Kconfig option "NFS_V4_1_IMPLEMENTATION_ID_DOMAIN" specify the domain
> > > > string.
> > > > 
> > > > Do same in nfsd, introduce new runtime param "nfsd.send_implementation_id"
> > > > and build time Kconfig option "NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN" and
> > > > based on them fill NFSv4.1 server implementation details in OP_EXCHANGE_ID
> > > > response. Logic in nfsd is exactly same as in nfs.
> > > > 
> > > > This aligns Linux NFSv4.1 server logic with Linux NFSv4.1 client logic.
> > > > 
> > > > NFSv4.1 client and server implementation fields are useful for statistic
> > > > purposes or for identifying type of clients and servers.
> > > 
> > > NFSD has gotten along for more than a decade without returning this
> > > information. The patch description should explain the use case in a
> > > little more detail, IMO.
> > > 
> > > As a general comment, I recognize that you copied the client code
> > > for EXCHANGE_ID to construct this patch. The client and server code
> > > bases are somewhat different and have different coding conventions.
> > > Most of the comments below have to do with those differences.
> > 
> > Ok, this can be adjusted/aligned.
> > 
> > > 
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > ---
> > > >  fs/nfsd/Kconfig   | 12 +++++++++++
> > > >  fs/nfsd/nfs4xdr.c | 55 +++++++++++++++++++++++++++++++++++++++++++++--
> > > >  2 files changed, 65 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> > > > index ec2ab6429e00..70067c29316e 100644
> > > > --- a/fs/nfsd/Kconfig
> > > > +++ b/fs/nfsd/Kconfig
> > > > @@ -136,6 +136,18 @@ config NFSD_FLEXFILELAYOUT
> > > >  
> > > >  	  If unsure, say N.
> > > >  
> > > > +config NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN
> > > > +	string "NFSv4.1 Implementation ID Domain"
> > > > +	depends on NFSD_V4
> > > > +	default "kernel.org"
> > > > +	help
> > > > +	  This option defines the domain portion of the implementation ID that
> > > > +	  may be sent in the NFS exchange_id operation.  The value must be in
> > > 
> > > Nit: "that the server returns in its NFSv4 EXCHANGE_ID response."
> > > 
> > > 
> > > > +	  the format of a DNS domain name and should be set to the DNS domain
> > > > +	  name of the distribution.
> > > 
> > > Perhaps add: "See the description of the nii_domain field in Section
> > > 3.3.21 of RFC 8881 for details."
> > 
> > Ok.
> > 
> > > But honestly, I'm not sure why nii_domain is parametrized at all, on
> > > the client. Why not /always/ return "kernel.org" ?
> > 
> > I do not know. I just followed logic of client. In my opinion, it does
> > not make sense to have different logic in client and server. If it is
> > not needed, maybe remove it from client too?
> 
> > > What checking should be done to ensure that the value of this
> > > setting is a valid DNS label?
> > 
> > Checking for valid DNS label is not easy. Client does not do it, so is
> > it needed?
> 
> Input checking is always a good thing to do. But I haven't found a
> compliance mandate in RFC 8881 for the content of nii_domain, so
> maybe it doesn't matter.
> 
> One possibility would be to not add the parametrization of this
> string on the server unless it is found to be needed. So, this
> patch could simply always set "kernel.org", and then a Kconfig
> option can be added by a subsequent patch if/when a use case ever
> turns up.

No problem, I can drop it.

> Or... NFSD could simply re-use the client's setting. I can't think
> of a reason why the NFS client and NFS server in the same kernel
> should report different nii_domain strings.
> 
> 
> > > > +	  If the NFS server is unchanged from the upstream kernel, this
> > > > +	  option should be set to the default "kernel.org".
> > > > +
> > > >  config NFSD_V4_2_INTER_SSC
> > > >  	bool "NFSv4.2 inter server to server COPY"
> > > >  	depends on NFSD_V4 && NFS_V4_2
> > > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > > index b45ea5757652..5e89f999d4c7 100644
> > > > --- a/fs/nfsd/nfs4xdr.c
> > > > +++ b/fs/nfsd/nfs4xdr.c
> > > > @@ -62,6 +62,9 @@
> > > >  #include <linux/security.h>
> > > >  #endif
> > > >  
> > > > +static bool send_implementation_id = true;
> > > > +module_param(send_implementation_id, bool, 0644);
> > > > +MODULE_PARM_DESC(send_implementation_id, "Send implementation ID with NFSv4.1 exchange_id");
> > > 
> > > I'd rather not add a module parameter if we don't have to. Can you
> > > explain why this new parameter is necessary? For instance, is there
> > > a reason why an administrator who runs NFSD on a stock distro kernel
> > > would want to change this setting to "false" ?
> > 
> > I really do not know. Client has this parameter, so I though it is a
> > good idea to have it.
> > 
> > > If it turns out that the parameter is valuable, is there admin
> > > documentation to go with it?
> > 
> > I'm not sure if client have documentation for it.
> 
> Again, if we don't have a clear use case in front of us, it is
> sensible to postpone the addition of this parameter.
> 
> 
> [ ... snip ... ]
> 
> > > Regarding the content of these fields: I don't mind filling in
> > > nii_date, duplicating what might appear in the nii_name field, if
> > > that is not a bother.
> > 
> > I looked at this, and getting timestamp in numeric form is not possible.
> > Kernel utsname() and UTS functions provides date only in `date` format
> > which is unsuitable for parsing in kernel and converting into seconds
> > since epoch. Moreover uts structures are exported to userspace, so
> > changing and providing numeric value would be harder.
> 
> Not a big deal. And, it's something that can be changed later if
> someone finds a clean way to extract a numeric build time.

Ok.

