Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49C27B37D3
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Sep 2023 18:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjI2QVf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Sep 2023 12:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbjI2QVe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Sep 2023 12:21:34 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F35BBE
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 09:21:31 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-65b0a54d436so52630826d6.3
        for <linux-nfs@vger.kernel.org>; Fri, 29 Sep 2023 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poochiereds-net.20230601.gappssmtp.com; s=20230601; t=1696004490; x=1696609290; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d1lgCAESb//57ap0scjMocwVy/paWJzGgD5957sAqjs=;
        b=pEQVhsxYXXCGAJxsOmMJu10fe0ZicCetLdofJrg4hv7RnZ1/7L2fYoAMzN+KTGlVx/
         8ZSlt/j3doTYdVEwGcAx1eZrFtCCFyP4F2lC7t9APj0icbN2b95dRax1Zap+aeA55C+3
         eJgGiQ2F+xzBYmDce4IaBIpiO6FPeqJFIiOF0fKMSMm6jRYk8yZtAx0at8JT22Oy7dWQ
         juAibqvXwkLOtS+flZ+voBuBJNVkPlqsFC21no3BPTaDuuecNAZe64jM3QhnYzoGWdhf
         m0AFzlYhTZAvtdvSpf7C7kDnGaC+Z6FZ1nM9ErcxmNpHugzPmkEsf/SnyQpHr3vAinC3
         bxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696004490; x=1696609290;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d1lgCAESb//57ap0scjMocwVy/paWJzGgD5957sAqjs=;
        b=j38VKFMqNdq0OaV+z3ftaA1ZGTPo7ZydNvS4K37v56YNwy65ythjrJ8KbxFl61XXXO
         7CnJo9mxi62XRuMGRnINGFB40XCUE1Cx+lr2WVRmZ8SYZYBiE97mglYWPyE4gnYpn3L1
         xxdVkruxWGz9QVG58A2ZXNeq2e2cqb/73Sr/5PjOdECKeeBMgRUP60YWWTxWSzmUoaJs
         QGoOnc9J9iF3WlHd0/p/fX2O2Tc4KLgk76+bL4XdiRTUM16DjpgE9gVTQrDyAEw2vnG5
         x8t8KcHnqs+nqhTGj4udiOnJ3HQJ8wcBZaWtJ9iqCrlFaVkqbaEGrMdlFM+qU7gCPLBA
         9+Cg==
X-Gm-Message-State: AOJu0YzVdDFv7fDr04oWyG3ilcHVU62sCrcsFRPWDWSMIksntZzb+Ol8
        EI+b2Jvcgt+oMZcKIHV0Cqfykw==
X-Google-Smtp-Source: AGHT+IEPqOUIJEORfYhadzhJOE99dEsg5pCQaG/me5sm6DV3Wyr3RojQLQ52osAKQOepqHJC2jyCXw==
X-Received: by 2002:a05:6214:5345:b0:64f:3882:512a with SMTP id kv5-20020a056214534500b0064f3882512amr4665886qvb.13.1696004490051;
        Fri, 29 Sep 2023 09:21:30 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id n16-20020a0ce550000000b0065654f67a6fsm2057977qvm.77.2023.09.29.09.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 09:21:29 -0700 (PDT)
Message-ID: <4c6c46419d34cbe0a408aea4705383edecffa00d.camel@poochiereds.net>
Subject: Re: [PATCH v1 3/7] NFSD: Add nfsd4_encode_open_read_delegation4()
From:   Jeff Layton <jlayton@poochiereds.net>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 29 Sep 2023 12:21:28 -0400
In-Reply-To: <169599594587.5622.94747681619250190.stgit@manet.1015granger.net>
References: <169599581942.5622.15965175797823365235.stgit@manet.1015granger.net>
         <169599594587.5622.94747681619250190.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-09-29 at 09:59 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Refactor nfsd4_encode_open() so the open_read_delegation4 type is
> encoded in a separate function. This makes it more straightforward
> to later add support for returning an nfsace4 in OPEN responses that
> offer a delegation.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4state.c |    6 +++--
>  fs/nfsd/nfs4xdr.c   |   61 ++++++++++++++++++++++++++++++++++++++-------=
------
>  fs/nfsd/xdr4.h      |    2 +-
>  3 files changed, 49 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 22e95b9ae82f..b1118050ff52 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5688,11 +5688,11 @@ nfs4_open_delegation(struct nfsd4_open *open, str=
uct nfs4_ol_stateid *stp,
>  	struct path path;
> =20
>  	cb_up =3D nfsd4_cb_channel_good(oo->oo_owner.so_client);
> -	open->op_recall =3D 0;
> +	open->op_recall =3D false;
>  	switch (open->op_claim_type) {
>  		case NFS4_OPEN_CLAIM_PREVIOUS:
>  			if (!cb_up)
> -				open->op_recall =3D 1;
> +				open->op_recall =3D true;
>  			break;
>  		case NFS4_OPEN_CLAIM_NULL:
>  			parent =3D currentfh;
> @@ -5746,7 +5746,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struc=
t nfs4_ol_stateid *stp,
>  	if (open->op_claim_type =3D=3D NFS4_OPEN_CLAIM_PREVIOUS &&
>  	    open->op_delegate_type !=3D NFS4_OPEN_DELEGATE_NONE) {
>  		dprintk("NFSD: WARNING: refusing delegation reclaim\n");
> -		open->op_recall =3D 1;
> +		open->op_recall =3D true;
>  	}
> =20
>  	/* 4.1 client asking for a delegation? */
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index ee8a7989f54f..f411fcc435f6 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4074,6 +4074,49 @@ nfsd4_encode_link(struct nfsd4_compoundres *resp, =
__be32 nfserr,
>  	return nfsd4_encode_change_info4(xdr, &link->li_cinfo);
>  }
> =20
> +/*
> + * This implementation does not yet support returning an ACE in an
> + * OPEN that offers a delegation.
> + */
> +static __be32
> +nfsd4_encode_open_nfsace4(struct xdr_stream *xdr)
> +{
> +	__be32 status;
> +
> +	/* type */
> +	status =3D nfsd4_encode_acetype4(xdr, NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE)=
;
> +	if (status !=3D nfs_ok)
> +		return nfserr_resource;
> +	/* flag */
> +	status =3D nfsd4_encode_aceflag4(xdr, 0);
> +	if (status !=3D nfs_ok)
> +		return nfserr_resource;
> +	/* access mask */
> +	status =3D nfsd4_encode_acemask4(xdr, 0);
> +	if (status !=3D nfs_ok)
> +		return nfserr_resource;
> +	/* who - empty for now */
> +	if (xdr_stream_encode_u32(xdr, 0) !=3D XDR_UNIT)
> +		return nfserr_resource;
> +	return nfs_ok;
> +}
> +
> +static __be32
> +nfsd4_encode_open_read_delegation4(struct xdr_stream *xdr, struct nfsd4_=
open *open)
> +{
> +	__be32 status;
> +
> +	/* stateid */
> +	status =3D nfsd4_encode_stateid4(xdr, &open->op_delegate_stateid);
> +	if (status !=3D nfs_ok)
> +		return status;
> +	/* recall */
> +	status =3D nfsd4_encode_bool(xdr, open->op_recall);
> +	if (status !=3D nfs_ok)
> +		return status;
> +	/* permissions */
> +	return nfsd4_encode_open_nfsace4(xdr);
> +}
> =20
>  static __be32
>  nfsd4_encode_open(struct nfsd4_compoundres *resp, __be32 nfserr,
> @@ -4106,22 +4149,8 @@ nfsd4_encode_open(struct nfsd4_compoundres *resp, =
__be32 nfserr,
>  	case NFS4_OPEN_DELEGATE_NONE:
>  		break;
>  	case NFS4_OPEN_DELEGATE_READ:
> -		nfserr =3D nfsd4_encode_stateid4(xdr, &open->op_delegate_stateid);
> -		if (nfserr)
> -			return nfserr;
> -		p =3D xdr_reserve_space(xdr, 20);
> -		if (!p)
> -			return nfserr_resource;
> -		*p++ =3D cpu_to_be32(open->op_recall);
> -
> -		/*
> -		 * TODO: ACE's in delegations
> -		 */
> -		*p++ =3D cpu_to_be32(NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE);
> -		*p++ =3D cpu_to_be32(0);
> -		*p++ =3D cpu_to_be32(0);
> -		*p++ =3D cpu_to_be32(0);   /* XXX: is NULL principal ok? */
> -		break;
> +		/* read */
> +		return nfsd4_encode_open_read_delegation4(xdr, open);
>  	case NFS4_OPEN_DELEGATE_WRITE:
>  		nfserr =3D nfsd4_encode_stateid4(xdr, &open->op_delegate_stateid);
>  		if (nfserr)
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index aba07d5378fc..c142a9b5ab98 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -389,7 +389,7 @@ struct nfsd4_open {
>  	u32		op_deleg_want;      /* request */
>  	stateid_t	op_stateid;         /* response */
>  	__be32		op_xdr_error;       /* see nfsd4_open_omfg() */
> -	u32		op_recall;          /* recall */
> +	bool		op_recall;          /* response */

nit: this would probably pack better if you moved op_recall down beside
op_truncate.

>  	struct nfsd4_change_info  op_cinfo; /* response */
>  	u32		op_rflags;          /* response */
>  	bool		op_truncate;        /* used during processing */
>=20
>=20

--=20
Jeff Layton <jlayton@poochiereds.net>
