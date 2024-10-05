Return-Path: <linux-nfs+bounces-6891-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28553991991
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 20:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47C71F210BF
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 18:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA1915C158;
	Sat,  5 Oct 2024 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pn9wJcQk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EA015854F;
	Sat,  5 Oct 2024 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728153313; cv=none; b=EGlhSyKad7LVGQkVxc+IoHW0W5Uo5FiCirP50LBLIfe6hnGGGOEodsewYsARLusev2g8FG/HkT19I9/ditYMLLuWGJ+G8UgQGIQYsgQjJ6PdXeIqwL4+2rP/MUcEqJFL9kAOyOMxNYDGQrXi39Pgo0EZV6VvUwT8yTYS4bq3SmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728153313; c=relaxed/simple;
	bh=8O7ex0Lx5cQ1FtgoodxpG5yAqOP3CyE5XErkA+IwvoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrLMS2EdFZZnj+AvfGgq4BdAvDugxxgXPnI8hZpzKZ88m7N0S6smL29doizmsMdRI4tBtO/iouJiGAgp3j5F9JzBg1GBpJdWOxax/VGpAYOeBx2eBur5ztZJ0PfdZljA4mxNp/slMtNaOwMKMCSU81IbkogpJz+lRaWR1o2gU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pn9wJcQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4A7C4CEC2;
	Sat,  5 Oct 2024 18:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728153313;
	bh=8O7ex0Lx5cQ1FtgoodxpG5yAqOP3CyE5XErkA+IwvoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pn9wJcQk3kvVA9WTNtt9R6zVucDLpvvFCUiwb4f7dSDLoq3TXJRER3FFYJLZb7RiX
	 b4ehtNDNRabfO4RtfqhN/hVeUOMX3cB1GbY/9Ghwn7lP3ixtWxqsJfqjzrlY4HkX8w
	 Vs/K7PZwVL0MxD2NGmPb9W8PQ/VTlBz1GarvYCVj2oob4avuLm9N2Kz34IFU8L99/2
	 K0NMy0a9Z1i5wOMFh62E0O6l9fieLy/1xhjevPh6s4SwKaXvonpP4ZPJgjQqt72bKJ
	 FHzV3KQrIZVSvpoRjrTJbHe2UFpR2WlM2qTsqc7+lu1GjriKhSYgSXmytOF2N1+6UA
	 VpaAAckOZm6fA==
Received: by pali.im (Postfix)
	id B626E648; Sat,  5 Oct 2024 20:35:07 +0200 (CEST)
Date: Sat, 5 Oct 2024 20:35:07 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fill NFSv4.1 server implementation fields in
 OP_EXCHANGE_ID response
Message-ID: <20241005183507.vbcwz4aju3sjrbwh@pali>
References: <20240912220919.23449-1-pali@kernel.org>
 <ZuRX/QfG+OLm9fTR@tissot.1015granger.net>
 <20240913153631.2lqq5nybuitjiwmo@pali>
 <ZuRjSIyHguz3ult4@tissot.1015granger.net>
 <20240913161000.33ogsvxbe3njghhw@pali>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240913161000.33ogsvxbe3njghhw@pali>
User-Agent: NeoMutt/20180716

On Friday 13 September 2024 18:10:00 Pali Rohár wrote:
> On Friday 13 September 2024 12:07:36 Chuck Lever wrote:
> > On Fri, Sep 13, 2024 at 05:36:31PM +0200, Pali Rohár wrote:
> > > On Friday 13 September 2024 11:19:25 Chuck Lever wrote:
> > > > On Fri, Sep 13, 2024 at 12:09:19AM +0200, Pali Rohár wrote:
> > > > > NFSv4.1 OP_EXCHANGE_ID response from server may contain server
> > > > > implementation details (domain, name and build time) in optional
> > > > > nfs_impl_id4 field. Currently nfsd does not fill this field.
> > > > > 
> > > > > NFSv4.1 OP_EXCHANGE_ID call request from client may contain client
> > > > > implementation details and Linux NFSv4.1 client is already filling these
> > > > > information based on runtime module param "nfs.send_implementation_id" and
> > > > > build time Kconfig option "NFS_V4_1_IMPLEMENTATION_ID_DOMAIN". Module param
> > > > > send_implementation_id specify whether to fill implementation fields and
> > > > > Kconfig option "NFS_V4_1_IMPLEMENTATION_ID_DOMAIN" specify the domain
> > > > > string.
> > > > > 
> > > > > Do same in nfsd, introduce new runtime param "nfsd.send_implementation_id"
> > > > > and build time Kconfig option "NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN" and
> > > > > based on them fill NFSv4.1 server implementation details in OP_EXCHANGE_ID
> > > > > response. Logic in nfsd is exactly same as in nfs.
> > > > > 
> > > > > This aligns Linux NFSv4.1 server logic with Linux NFSv4.1 client logic.
> > > > > 
> > > > > NFSv4.1 client and server implementation fields are useful for statistic
> > > > > purposes or for identifying type of clients and servers.
> > > > 
> > > > NFSD has gotten along for more than a decade without returning this
> > > > information. The patch description should explain the use case in a
> > > > little more detail, IMO.
> > > > 
> > > > As a general comment, I recognize that you copied the client code
> > > > for EXCHANGE_ID to construct this patch. The client and server code
> > > > bases are somewhat different and have different coding conventions.
> > > > Most of the comments below have to do with those differences.
> > > 
> > > Ok, this can be adjusted/aligned.
> > > 
> > > > 
> > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > > ---
> > > > >  fs/nfsd/Kconfig   | 12 +++++++++++
> > > > >  fs/nfsd/nfs4xdr.c | 55 +++++++++++++++++++++++++++++++++++++++++++++--
> > > > >  2 files changed, 65 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> > > > > index ec2ab6429e00..70067c29316e 100644
> > > > > --- a/fs/nfsd/Kconfig
> > > > > +++ b/fs/nfsd/Kconfig
> > > > > @@ -136,6 +136,18 @@ config NFSD_FLEXFILELAYOUT
> > > > >  
> > > > >  	  If unsure, say N.
> > > > >  
> > > > > +config NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN
> > > > > +	string "NFSv4.1 Implementation ID Domain"
> > > > > +	depends on NFSD_V4
> > > > > +	default "kernel.org"
> > > > > +	help
> > > > > +	  This option defines the domain portion of the implementation ID that
> > > > > +	  may be sent in the NFS exchange_id operation.  The value must be in
> > > > 
> > > > Nit: "that the server returns in its NFSv4 EXCHANGE_ID response."
> > > > 
> > > > 
> > > > > +	  the format of a DNS domain name and should be set to the DNS domain
> > > > > +	  name of the distribution.
> > > > 
> > > > Perhaps add: "See the description of the nii_domain field in Section
> > > > 3.3.21 of RFC 8881 for details."
> > > 
> > > Ok.
> > > 
> > > > But honestly, I'm not sure why nii_domain is parametrized at all, on
> > > > the client. Why not /always/ return "kernel.org" ?
> > > 
> > > I do not know. I just followed logic of client. In my opinion, it does
> > > not make sense to have different logic in client and server. If it is
> > > not needed, maybe remove it from client too?
> > 
> > > > What checking should be done to ensure that the value of this
> > > > setting is a valid DNS label?
> > > 
> > > Checking for valid DNS label is not easy. Client does not do it, so is
> > > it needed?
> > 
> > Input checking is always a good thing to do. But I haven't found a
> > compliance mandate in RFC 8881 for the content of nii_domain, so
> > maybe it doesn't matter.
> > 
> > One possibility would be to not add the parametrization of this
> > string on the server unless it is found to be needed. So, this
> > patch could simply always set "kernel.org", and then a Kconfig
> > option can be added by a subsequent patch if/when a use case ever
> > turns up.
> 
> No problem, I can drop it.
> 
> > Or... NFSD could simply re-use the client's setting. I can't think
> > of a reason why the NFS client and NFS server in the same kernel
> > should report different nii_domain strings.
> > 
> > 
> > > > > +	  If the NFS server is unchanged from the upstream kernel, this
> > > > > +	  option should be set to the default "kernel.org".
> > > > > +
> > > > >  config NFSD_V4_2_INTER_SSC
> > > > >  	bool "NFSv4.2 inter server to server COPY"
> > > > >  	depends on NFSD_V4 && NFS_V4_2
> > > > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > > > index b45ea5757652..5e89f999d4c7 100644
> > > > > --- a/fs/nfsd/nfs4xdr.c
> > > > > +++ b/fs/nfsd/nfs4xdr.c
> > > > > @@ -62,6 +62,9 @@
> > > > >  #include <linux/security.h>
> > > > >  #endif
> > > > >  
> > > > > +static bool send_implementation_id = true;
> > > > > +module_param(send_implementation_id, bool, 0644);
> > > > > +MODULE_PARM_DESC(send_implementation_id, "Send implementation ID with NFSv4.1 exchange_id");
> > > > 
> > > > I'd rather not add a module parameter if we don't have to. Can you
> > > > explain why this new parameter is necessary? For instance, is there
> > > > a reason why an administrator who runs NFSD on a stock distro kernel
> > > > would want to change this setting to "false" ?
> > > 
> > > I really do not know. Client has this parameter, so I though it is a
> > > good idea to have it.
> > > 
> > > > If it turns out that the parameter is valuable, is there admin
> > > > documentation to go with it?
> > > 
> > > I'm not sure if client have documentation for it.
> > 
> > Again, if we don't have a clear use case in front of us, it is
> > sensible to postpone the addition of this parameter.
> > 
> > 
> > [ ... snip ... ]
> > 
> > > > Regarding the content of these fields: I don't mind filling in
> > > > nii_date, duplicating what might appear in the nii_name field, if
> > > > that is not a bother.
> > > 
> > > I looked at this, and getting timestamp in numeric form is not possible.
> > > Kernel utsname() and UTS functions provides date only in `date` format
> > > which is unsuitable for parsing in kernel and converting into seconds
> > > since epoch. Moreover uts structures are exported to userspace, so
> > > changing and providing numeric value would be harder.
> > 
> > Not a big deal. And, it's something that can be changed later if
> > someone finds a clean way to extract a numeric build time.
> 
> Ok.

I sent V2 version. I hope that I addressed all points from this discussion.

