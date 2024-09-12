Return-Path: <linux-nfs+bounces-6426-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12B597745A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 00:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409E21F24388
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 22:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2CE18E03D;
	Thu, 12 Sep 2024 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RprixUhW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nb/Q/9DR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RprixUhW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nb/Q/9DR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74B717DFF5;
	Thu, 12 Sep 2024 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726180328; cv=none; b=aOnvGnyUbG0F0g/BKZL4vF5ZSD5jNOFSAOO8Yk6EDLRkY5XUpv/nerQXnltNqm7EKTUvm7aBkfwviTRVsGXCvHxxSocXYBsJQeuiFS4TzKNgEgCzWfvL073PV9F20UuG95TsFWomTCRjmQJ3TZWd6BBr2fy8kw2AIR+EBKtVCkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726180328; c=relaxed/simple;
	bh=5g2+j0Byn88pl+oFu2m7x4Nb2A84Mth+GNuhWKCy8lo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=i1CIOaTVqRk8kI3GSKtP+1zUs/pmgapEm7vNPRKJWFb2bHajBLPri1aU8ZXOi4SIdjed0IayGu7dRtHmGm0c59AK7qZkQe7zY6q2NtBWL9tZ477v6xHV4bzz5AMRTRoS0Xv2qYWyqGBgrOIuGA2fDRStpHvdNwZq6nEiD9KXxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RprixUhW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nb/Q/9DR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RprixUhW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nb/Q/9DR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E52A621B04;
	Thu, 12 Sep 2024 22:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726180324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rB7RZMZ9heVc4jFFAc/nvdMAulUbuPpOt+fSPIBNyU8=;
	b=RprixUhWl1P9VfHFs1OCSJe7Xhid/wW5QMJg1JSOvR9s3+RKbLeLXkwtlXOSzRj3oWD28j
	Olwh83DM+DzLdkiRZ78KySvPozcWxHguyAAHiO0M/ZWEaT4a80ODBLYuB6sgeAl6Q5W9B4
	kqfVxwlD/w00KzutOxVRNwZTBNyQlQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726180324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rB7RZMZ9heVc4jFFAc/nvdMAulUbuPpOt+fSPIBNyU8=;
	b=nb/Q/9DRv1MHLrlZMb1TAGfwmr6gCLsDUuvGhC3yJuaouR9Wpi/sCGGrmztIT1nJTHYepu
	quHtx08lInMFELDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726180324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rB7RZMZ9heVc4jFFAc/nvdMAulUbuPpOt+fSPIBNyU8=;
	b=RprixUhWl1P9VfHFs1OCSJe7Xhid/wW5QMJg1JSOvR9s3+RKbLeLXkwtlXOSzRj3oWD28j
	Olwh83DM+DzLdkiRZ78KySvPozcWxHguyAAHiO0M/ZWEaT4a80ODBLYuB6sgeAl6Q5W9B4
	kqfVxwlD/w00KzutOxVRNwZTBNyQlQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726180324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rB7RZMZ9heVc4jFFAc/nvdMAulUbuPpOt+fSPIBNyU8=;
	b=nb/Q/9DRv1MHLrlZMb1TAGfwmr6gCLsDUuvGhC3yJuaouR9Wpi/sCGGrmztIT1nJTHYepu
	quHtx08lInMFELDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3074013A73;
	Thu, 12 Sep 2024 22:32:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3x7GNeFr42ZdFAAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 12 Sep 2024 22:32:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fill NFSv4.1 server implementation fields in
 OP_EXCHANGE_ID response
In-reply-to: <20240912220919.23449-1-pali@kernel.org>
References: <20240912220919.23449-1-pali@kernel.org>
Date: Fri, 13 Sep 2024 08:31:55 +1000
Message-id: <172618031521.17050.16135461752183993428@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 13 Sep 2024, Pali Roh=C3=A1r wrote:
> NFSv4.1 OP_EXCHANGE_ID response from server may contain server
> implementation details (domain, name and build time) in optional
> nfs_impl_id4 field. Currently nfsd does not fill this field.
>=20
> NFSv4.1 OP_EXCHANGE_ID call request from client may contain client
> implementation details and Linux NFSv4.1 client is already filling these
> information based on runtime module param "nfs.send_implementation_id" and
> build time Kconfig option "NFS_V4_1_IMPLEMENTATION_ID_DOMAIN". Module param
> send_implementation_id specify whether to fill implementation fields and
> Kconfig option "NFS_V4_1_IMPLEMENTATION_ID_DOMAIN" specify the domain
> string.
>=20
> Do same in nfsd, introduce new runtime param "nfsd.send_implementation_id"
> and build time Kconfig option "NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN" and
> based on them fill NFSv4.1 server implementation details in OP_EXCHANGE_ID
> response. Logic in nfsd is exactly same as in nfs.
>=20
> This aligns Linux NFSv4.1 server logic with Linux NFSv4.1 client logic.
>=20
> NFSv4.1 client and server implementation fields are useful for statistic
> purposes or for identifying type of clients and servers.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  fs/nfsd/Kconfig   | 12 +++++++++++
>  fs/nfsd/nfs4xdr.c | 55 +++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 65 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index ec2ab6429e00..70067c29316e 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -136,6 +136,18 @@ config NFSD_FLEXFILELAYOUT
> =20
>  	  If unsure, say N.
> =20
> +config NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN
> +	string "NFSv4.1 Implementation ID Domain"
> +	depends on NFSD_V4
> +	default "kernel.org"
> +	help
> +	  This option defines the domain portion of the implementation ID that
> +	  may be sent in the NFS exchange_id operation.  The value must be in
> +	  the format of a DNS domain name and should be set to the DNS domain
> +	  name of the distribution.
> +	  If the NFS server is unchanged from the upstream kernel, this
> +	  option should be set to the default "kernel.org".
> +
>  config NFSD_V4_2_INTER_SSC
>  	bool "NFSv4.2 inter server to server COPY"
>  	depends on NFSD_V4 && NFS_V4_2
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index b45ea5757652..5e89f999d4c7 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -62,6 +62,9 @@
>  #include <linux/security.h>
>  #endif
> =20
> +static bool send_implementation_id =3D true;
> +module_param(send_implementation_id, bool, 0644);
> +MODULE_PARM_DESC(send_implementation_id, "Send implementation ID with NFSv=
4.1 exchange_id");
> =20
>  #define NFSDDBG_FACILITY		NFSDDBG_XDR
> =20
> @@ -4833,6 +4836,53 @@ nfsd4_encode_server_owner4(struct xdr_stream *xdr, s=
truct svc_rqst *rqstp)
>  	return nfsd4_encode_opaque(xdr, nn->nfsd_name, strlen(nn->nfsd_name));
>  }
> =20
> +#define IMPL_NAME_LIMIT (sizeof(utsname()->sysname) + sizeof(utsname()->re=
lease) + \
> +			 sizeof(utsname()->version) + sizeof(utsname()->machine) + 8)

This "+8" seems strange.  In the xdr_reserve_space() call below you are
very thorough about explaining the magic numbers - which is great.  Here
that is this unexplained 8.

I don't think you need +8 at all.  sizeof(string) will give room to
print the string plus a trailing space or nul, and that is all you need.

Otherwise the patch looks OK.

Thanks,
NeilBrown


> +
> +static __be32
> +nfsd4_encode_server_impl_id(struct xdr_stream *xdr)
> +{
> +	char impl_name[IMPL_NAME_LIMIT];
> +	int impl_name_len;
> +	__be32 *p;
> +
> +	impl_name_len =3D 0;
> +	if (send_implementation_id &&
> +	    sizeof(CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN) > 1 &&
> +	    sizeof(CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN) <=3D NFS4_OPAQUE_LI=
MIT)
> +		impl_name_len =3D snprintf(impl_name, sizeof(impl_name), "%s %s %s %s",
> +			       utsname()->sysname, utsname()->release,
> +			       utsname()->version, utsname()->machine);
> +
> +	if (impl_name_len <=3D 0) {
> +		if (xdr_stream_encode_u32(xdr, 0) !=3D XDR_UNIT)
> +			return nfserr_resource;
> +		return nfs_ok;
> +	}
> +
> +	if (xdr_stream_encode_u32(xdr, 1) !=3D XDR_UNIT)
> +		return nfserr_resource;
> +
> +	p =3D xdr_reserve_space(xdr,
> +		4 /* nii_domain.len */ +
> +		(XDR_QUADLEN(sizeof(CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN) - 1) * 4)=
 +
> +		4 /* nii_name.len */ +
> +		(XDR_QUADLEN(impl_name_len) * 4) +
> +		8 /* nii_time.tv_sec */ +
> +		4 /* nii_time.tv_nsec */);
> +	if (!p)
> +		return nfserr_resource;
> +
> +	p =3D xdr_encode_opaque(p, CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN,
> +				sizeof(CONFIG_NFSD_V4_1_IMPLEMENTATION_ID_DOMAIN) - 1);
> +	p =3D xdr_encode_opaque(p, impl_name, impl_name_len);
> +	/* just send zeros for nii_date - the date is in nii_name */
> +	p =3D xdr_encode_hyper(p, 0); /* tv_sec */
> +	*p++ =3D cpu_to_be32(0); /* tv_nsec */
> +
> +	return nfs_ok;
> +}
> +
>  static __be32
>  nfsd4_encode_exchange_id(struct nfsd4_compoundres *resp, __be32 nfserr,
>  			 union nfsd4_op_u *u)
> @@ -4867,8 +4917,9 @@ nfsd4_encode_exchange_id(struct nfsd4_compoundres *re=
sp, __be32 nfserr,
>  	if (nfserr !=3D nfs_ok)
>  		return nfserr;
>  	/* eir_server_impl_id<1> */
> -	if (xdr_stream_encode_u32(xdr, 0) !=3D XDR_UNIT)
> -		return nfserr_resource;
> +	nfserr =3D nfsd4_encode_server_impl_id(xdr);
> +	if (nfserr !=3D nfs_ok)
> +		return nfserr;
> =20
>  	return nfs_ok;
>  }
> --=20
> 2.20.1
>=20
>=20


