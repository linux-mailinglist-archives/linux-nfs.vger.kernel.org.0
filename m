Return-Path: <linux-nfs+bounces-6428-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C30977481
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 00:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571CC1F24960
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 22:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92F019F12E;
	Thu, 12 Sep 2024 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtckGtNW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07DE6FBF;
	Thu, 12 Sep 2024 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726181270; cv=none; b=hxNh/4C3ByRHVcXortCYpCWZqKIxayS+JWiS0BCiye23fi2YBPnMT5E9Ea00U4D08AAmzwCqmBz+tbXBYgRGqINY5iH3ljtiAZ9RfPWOhJ3LWuzKeUbLXBrdOt0Rmwvz9aGSgHLm9DY3zRr9iSM2fuTj6N1rB0658mZw66dCe0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726181270; c=relaxed/simple;
	bh=o+thl0FrmN1ZWDJz3WiWsA8xc17J4JUROoSz5Knmz74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deT2oZT9JbLCjo5wpkkz01mTSiLgrB7UkYuLq19/Regfmjf+NHiuDUTOAqz2d2coNF+GOuD9qrRTlt14QeH0KtjyP5ubUlx2Ir23BLvlmJN8HL5npzp0lxgSwV9tmwOTfqQ36Hr9WtlYOzPDyMxvq52nN0Lfj+uKi6UsnDwAmVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtckGtNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E538FC4CEC3;
	Thu, 12 Sep 2024 22:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726181270;
	bh=o+thl0FrmN1ZWDJz3WiWsA8xc17J4JUROoSz5Knmz74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QtckGtNWtr7xjjtlM57/XwmrZwCrVjFtXvTUY5N+HRoH+4LM/7nsA3xrLHxpVrry7
	 pRFXYRRbw2u6HQwLeqPQn+Wv4C0NhQLWsdA/Lmk243XLXX4YGiLETUBJc4CoV+jPaU
	 C1cC8XeONCLvHgfGWv8DbbojNQ+2EgS/dRv0V/gNYQqbQAgJOWH0jN31VcHHt/1ARW
	 q4Cw3rzieEyVX1aroOPLVp0klY5+PRENzCsBE9stzn4vaQ3pwAUAphYuZ26iH4CG/N
	 ITmN55O8XZbpB64nB5585F6SHUQmE3Tbt/mkFGt+VSWLz1p5nEsw3gg8rJ+PPhZVoQ
	 ckOz7OdM8/SlA==
Received: by pali.im (Postfix)
	id 02B855E9; Fri, 13 Sep 2024 00:47:44 +0200 (CEST)
Date: Fri, 13 Sep 2024 00:47:44 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fill NFSv4.1 server implementation fields in
 OP_EXCHANGE_ID response
Message-ID: <20240912224744.e5lb6j53wldxvfdm@pali>
References: <20240912220919.23449-1-pali@kernel.org>
 <172618031521.17050.16135461752183993428@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172618031521.17050.16135461752183993428@noble.neil.brown.name>
User-Agent: NeoMutt/20180716

On Friday 13 September 2024 08:31:55 NeilBrown wrote:
> On Fri, 13 Sep 2024, Pali Rohár wrote:
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
> > 
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
> > +	  the format of a DNS domain name and should be set to the DNS domain
> > +	  name of the distribution.
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
> >  
> >  #define NFSDDBG_FACILITY		NFSDDBG_XDR
> >  
> > @@ -4833,6 +4836,53 @@ nfsd4_encode_server_owner4(struct xdr_stream *xdr, struct svc_rqst *rqstp)
> >  	return nfsd4_encode_opaque(xdr, nn->nfsd_name, strlen(nn->nfsd_name));
> >  }
> >  
> > +#define IMPL_NAME_LIMIT (sizeof(utsname()->sysname) + sizeof(utsname()->release) + \
> > +			 sizeof(utsname()->version) + sizeof(utsname()->machine) + 8)
> 
> This "+8" seems strange.  In the xdr_reserve_space() call below you are
> very thorough about explaining the magic numbers - which is great.  Here
> that is this unexplained 8.

I copied this code from nfs/nfs4xdr.c file. And verified in wireshark
that packets were correctly constructed.

> I don't think you need +8 at all.  sizeof(string) will give room to
> print the string plus a trailing space or nul, and that is all you need.

I'm looking at it, and I think you are right, +8 should not be needed.
Thanks for review.

> Otherwise the patch looks OK.
> 
> Thanks,
> NeilBrown
> 
> 
> > +
> > +static __be32
> > +nfsd4_encode_server_impl_id(struct xdr_stream *xdr)
> > +{
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
> > +
> > +	if (xdr_stream_encode_u32(xdr, 1) != XDR_UNIT)
> > +		return nfserr_resource;
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
> > 
> 

