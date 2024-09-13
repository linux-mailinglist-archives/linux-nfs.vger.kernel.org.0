Return-Path: <linux-nfs+bounces-6455-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D88A19784FB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 17:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E17280E23
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 15:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15C739FCF;
	Fri, 13 Sep 2024 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YN4MdyGt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868482EB02;
	Fri, 13 Sep 2024 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241798; cv=none; b=lmNcRvAQQSPn+wRyc2xW3lfrbW2N7gFeh2/aXhSJaT9xzcehrNzNMnsG/eyFhD92E9oS4RltYKzdK9HPe/2sRXaS8geLEMPcVfHK+w698t0ZsSW8mM9ee7OT+3K3sta7s8CAEj1Vw0WctE+NllsOmQS2AjSLnbLl64NyARPPhXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241798; c=relaxed/simple;
	bh=RVqRBRsVH1AVrSfltGecQSUntV2rlbNzyx87uddCwXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6ROeQJUsLsNJM1ph7gaNTp3p5CHwtWSFWcBAu1VpsgqV6lYv5AFWZSJNTWx8uwIFIaLZw+3M+qRdVsyrb7JLznJrfeuQZ06orJZu7WtwRD6TiEwx9KK8KnY4q1mHK1dJ61Vmrt807DHrcxPyEn54AK2Vqq8i1Z0KCUVOyRuKrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YN4MdyGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0FEC4CEC0;
	Fri, 13 Sep 2024 15:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726241798;
	bh=RVqRBRsVH1AVrSfltGecQSUntV2rlbNzyx87uddCwXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YN4MdyGtpadj42zM4+5HVJIVGfP0SJREsjhkkU8DkQtJH4DYdjtCVhcocYIa4W3os
	 WtnQc2zi3IeEEzGbijuW4Bw01AsOgJ281oXtkmUVyKJI0GRGSocI3jZWM/eykQynwU
	 KISW3OFGskLuNEeUC+jJJGqgW0J77pd2VFreBooBXEBJO5kRInPwUwgV375+KzVypz
	 vN7uu7vgGwBP7Q/sQKphWs/qj9Ld9J8TcUU9DbLLb2/SCw2uw5FqR8URb3ai9McfvG
	 chQSRSk0cs0MxD0pdXCbtKZwJc7gp9nXH+E9gRZNl6bgsm2AGRkFjlm8N6vLyVv4Op
	 D5JXZFZKLOm4g==
Received: by pali.im (Postfix)
	id DB449725; Fri, 13 Sep 2024 17:36:31 +0200 (CEST)
Date: Fri, 13 Sep 2024 17:36:31 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fill NFSv4.1 server implementation fields in
 OP_EXCHANGE_ID response
Message-ID: <20240913153631.2lqq5nybuitjiwmo@pali>
References: <20240912220919.23449-1-pali@kernel.org>
 <ZuRX/QfG+OLm9fTR@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuRX/QfG+OLm9fTR@tissot.1015granger.net>
User-Agent: NeoMutt/20180716

On Friday 13 September 2024 11:19:25 Chuck Lever wrote:
> On Fri, Sep 13, 2024 at 12:09:19AM +0200, Pali Rohár wrote:
> > NFSv4.1 OP_EXCHANGE_ID response from server may contain server
> > implementation details (domain, name and build time) in optional
> > nfs_impl_id4 field. Currently nfsd does not fill this field.
> > 
> > NFSv4.1 OP_EXCHANGE_ID call request from client may contain client
> > implementation details and Linux NFSv4.1 client is already filling these
> > information based on runtime module param "nfs.send_implementation_id" and
> > build time Kconfig option "NFS_V4_1_IMPLEMENTATION_ID_DOMAIN". Module param
> > send_implementation_id specify whether to fill implementation fields and
> > Kconfig option "NFS_V4_1_IMPLEMENTATION_ID_DOMAIN" specify the domain
> > string.
> > 
> > Do same in nfsd, introduce new runtime param "nfsd.send_implementation_id"
> > and build time Kconfig option "NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN" and
> > based on them fill NFSv4.1 server implementation details in OP_EXCHANGE_ID
> > response. Logic in nfsd is exactly same as in nfs.
> > 
> > This aligns Linux NFSv4.1 server logic with Linux NFSv4.1 client logic.
> > 
> > NFSv4.1 client and server implementation fields are useful for statistic
> > purposes or for identifying type of clients and servers.
> 
> NFSD has gotten along for more than a decade without returning this
> information. The patch description should explain the use case in a
> little more detail, IMO.
> 
> As a general comment, I recognize that you copied the client code
> for EXCHANGE_ID to construct this patch. The client and server code
> bases are somewhat different and have different coding conventions.
> Most of the comments below have to do with those differences.

Ok, this can be adjusted/aligned.

> 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  fs/nfsd/Kconfig   | 12 +++++++++++
> >  fs/nfsd/nfs4xdr.c | 55 +++++++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 65 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> > index ec2ab6429e00..70067c29316e 100644
> > --- a/fs/nfsd/Kconfig
> > +++ b/fs/nfsd/Kconfig
> > @@ -136,6 +136,18 @@ config NFSD_FLEXFILELAYOUT
> >  
> >  	  If unsure, say N.
> >  
> > +config NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN
> > +	string "NFSv4.1 Implementation ID Domain"
> > +	depends on NFSD_V4
> > +	default "kernel.org"
> > +	help
> > +	  This option defines the domain portion of the implementation ID that
> > +	  may be sent in the NFS exchange_id operation.  The value must be in
> 
> Nit: "that the server returns in its NFSv4 EXCHANGE_ID response."
> 
> 
> > +	  the format of a DNS domain name and should be set to the DNS domain
> > +	  name of the distribution.
> 
> Perhaps add: "See the description of the nii_domain field in Section
> 3.3.21 of RFC 8881 for details."

Ok.

> But honestly, I'm not sure why nii_domain is parametrized at all, on
> the client. Why not /always/ return "kernel.org" ?

I do not know. I just followed logic of client. In my opinion, it does
not make sense to have different logic in client and server. If it is
not needed, maybe remove it from client too?

> What checking should be done to ensure that the value of this
> setting is a valid DNS label?

Checking for valid DNS label is not easy. Client does not do it, so is
it needed?

> 
> > +	  If the NFS server is unchanged from the upstream kernel, this
> > +	  option should be set to the default "kernel.org".
> > +
> >  config NFSD_V4_2_INTER_SSC
> >  	bool "NFSv4.2 inter server to server COPY"
> >  	depends on NFSD_V4 && NFS_V4_2
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index b45ea5757652..5e89f999d4c7 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -62,6 +62,9 @@
> >  #include <linux/security.h>
> >  #endif
> >  
> > +static bool send_implementation_id = true;
> > +module_param(send_implementation_id, bool, 0644);
> > +MODULE_PARM_DESC(send_implementation_id, "Send implementation ID with NFSv4.1 exchange_id");
> 
> I'd rather not add a module parameter if we don't have to. Can you
> explain why this new parameter is necessary? For instance, is there
> a reason why an administrator who runs NFSD on a stock distro kernel
> would want to change this setting to "false" ?

I really do not know. Client has this parameter, so I though it is a
good idea to have it.

> If it turns out that the parameter is valuable, is there admin
> documentation to go with it?

I'm not sure if client have documentation for it.

> 
> >  #define NFSDDBG_FACILITY		NFSDDBG_XDR
> >  
> > @@ -4833,6 +4836,53 @@ nfsd4_encode_server_owner4(struct xdr_stream *xdr, struct svc_rqst *rqstp)
> >  	return nfsd4_encode_opaque(xdr, nn->nfsd_name, strlen(nn->nfsd_name));
> >  }
> >  
> > +#define IMPL_NAME_LIMIT (sizeof(utsname()->sysname) + sizeof(utsname()->release) + \
> > +			 sizeof(utsname()->version) + sizeof(utsname()->machine) + 8)
> > +
> > +static __be32
> > +nfsd4_encode_server_impl_id(struct xdr_stream *xdr)
> > +{
> 
> The matching XDR decoder in fs/nfsd/nfs4xdr.c is:
> 
>    static __be32 nfsd4_decode_nfs_impl_id4( ... )
> 
> The function name matches the name of the XDR type in the spec. So
> let's call this function nfsd4_encode_nfs_impl_id4().

Ok.

> 
> > +	char impl_name[IMPL_NAME_LIMIT];
> > +	int impl_name_len;
> > +	__be32 *p;
> > +
> > +	impl_name_len = 0;
> > +	if (send_implementation_id &&
> > +	    sizeof(CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN) > 1 &&
> > +	    sizeof(CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN) <= NFS4_OPAQUE_LIMIT)
> > +		impl_name_len = snprintf(impl_name, sizeof(impl_name), "%s %s %s %s",
> > +			       utsname()->sysname, utsname()->release,
> > +			       utsname()->version, utsname()->machine);
> > +
> > +	if (impl_name_len <= 0) {
> > +		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
> > +			return nfserr_resource;
> > +		return nfs_ok;
> > +	}
> 
> IMPL_NAME_LIMIT looks like it could be hundreds of bytes. Probably
> not good to put a character array that size on the stack.
> 
> I prefer that the construction and checking is done in
> nfsd4_exchange_id() instead, and the content of these fields passed
> to this encoder via struct nfsd4_exchange_id.
> 
> As a guideline, the XDR layer should be concerned solely with
> marshaling and unmarshalling data types. The content of the
> marshaled data fields should be handled by NFSD's proc layer
> (fs/nfsd/nfs4proc.c).

Ok, I could try to look at it.

> 
> > +
> > +	if (xdr_stream_encode_u32(xdr, 1) != XDR_UNIT)
> > +		return nfserr_resource;
> 
> A brief comment would help remind readers that what is encoded here
> is an array item count, and not a string length or a "value follows"
> boolean.
> 
> Nit: In fact, this value isn't really a part of the base
> nfs_impl_id4 data type. Maybe better to do this bit of logic in the
> caller nfsd4_encode_exchange_id().

Ok, it is truth that array item could is not part of impl_id4.

> 
> > +
> > +	p = xdr_reserve_space(xdr,
> > +		4 /* nii_domain.len */ +
> > +		(XDR_QUADLEN(sizeof(CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN) - 1) * 4) +
> > +		4 /* nii_name.len */ +
> > +		(XDR_QUADLEN(impl_name_len) * 4) +
> > +		8 /* nii_time.tv_sec */ +
> > +		4 /* nii_time.tv_nsec */);
> > +	if (!p)
> > +		return nfserr_resource;
> > +
> > +	p = xdr_encode_opaque(p, CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN,
> > +				sizeof(CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN) - 1);
> > +	p = xdr_encode_opaque(p, impl_name, impl_name_len);
> > +	/* just send zeros for nii_date - the date is in nii_name */
> > +	p = xdr_encode_hyper(p, 0); /* tv_sec */
> > +	*p++ = cpu_to_be32(0); /* tv_nsec */
> 
> We no longer write raw encoders like this in NFSD code. This is
> especially unnecessary because EXCHANGE_ID is not a hot path.
> 
> Instead, use the XDR utility functions to spell out the field names
> and data types, for easier auditing. For instance, something like
> this:
> 
> 	status = nfsd4_encode_opaque(xdr, exid->nii_domain.data,
> 				     exid->nii_domain.len);        
> 	if (status != nfs_ok)
> 		return status;
> 	status = nfsd4_encode_opaque(xdr, exid->nii_name.data,
> 				     exid->nii_name.len);        
> 	return nfsd4_encode_nfstime4(xdr, &exid->nii_date);

Ok.

> Regarding the content of these fields: I don't mind filling in
> nii_date, duplicating what might appear in the nii_name field, if
> that is not a bother.

I looked at this, and getting timestamp in numeric form is not possible.
Kernel utsname() and UTS functions provides date only in `date` format
which is unsuitable for parsing in kernel and converting into seconds
since epoch. Moreover uts structures are exported to userspace, so
changing and providing numeric value would be harder.

> 
> > +
> > +	return nfs_ok;
> > +}
> > +
> >  static __be32
> >  nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
> >  			 union nfsd4_op_u *u)
> > @@ -4867,8 +4917,9 @@ nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
> >  	if (nfserr != nfs_ok)
> >  		return nfserr;
> >  	/* eir_server_impl_id<1> */
> > -	if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
> > -		return nfserr_resource;
> > +	nfserr = nfsd4_encode_server_impl_id(xdr);
> > +	if (nfserr != nfs_ok)
> > +		return nfserr;
> >  
> >  	return nfs_ok;
> >  }
> > -- 
> > 2.20.1
> > 
> 
> -- 
> Chuck Lever

