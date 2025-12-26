Return-Path: <linux-nfs+bounces-17309-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A52BCDECBD
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Dec 2025 16:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F40DA3005EA2
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Dec 2025 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53B38834;
	Fri, 26 Dec 2025 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4+ny/tN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0513A1E7F;
	Fri, 26 Dec 2025 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766763036; cv=none; b=JtZicmHE+LwvdtJVMNNFV8Sb8SFtWOYdM+yyL1MVRon3ypTJBIAzNi84+vz5PmR8B9I/dqoZR5mFvE3zUj7G99XKAmkj6vHRpRhTU7zBCZ9I2wwn3u3L4kNWkch9k/WfBmOcFpNSWMjciY34bbHsfz7pyrMjsp8ckPS2ipFf/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766763036; c=relaxed/simple;
	bh=WT++a7q9zbXRNnNDsFP/up1Cp0gwvu7kGgDTaKS/TWw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eolSCJHF3L2ZXnkPRUQ2f8H9gWyP7cJuYyQ5VzadXtViWtklUIz0GpBBSLerbwaHqqGHWZenni1km71OWj2z/X0Rmf7Rp4xj9aiUMlyevmgAXHKTJMwFk8ebCRwLzVBPpAJlVe5FOI8M5cXogtp0fwQc2trjuQeVJmyvpg0jxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4+ny/tN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9E1C4CEF7;
	Fri, 26 Dec 2025 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766763036;
	bh=WT++a7q9zbXRNnNDsFP/up1Cp0gwvu7kGgDTaKS/TWw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=d4+ny/tNRBmTG+nmjrOMofcT7hWiApcXEgrlAn2V6A23NOAAo0FDovcw3KMPXfQeN
	 qeqapDdkjRDWW7+t4mnr5E/OGDRsiJeZohi98bc1jj1ZPbeK9vF1FaxdAx7Mzkh0DL
	 dR1t2bIZqK9zxLUTj+XFAwtI8Uc5yayXELbRLIs2tFPooyhPFuB9mKY/fuLyWNvvl6
	 zklGqxO6Lis+pDqOzJ8O7xm15O26NCH1BJ4OZ5ae0cPC5bczYRhb2rjlw/kQ29yTOT
	 qnjiG7NVQjNqdG+GG324GF50s6Rpk6A9pfGbRgpsUDG5UOa+CwwQdRKq36qw5/Elcr
	 PWXrJdTbbRuxw==
Message-ID: <7dea5c5fdc5a9d268bb95b2c7a967fedf629d19b.camel@kernel.org>
Subject: Re: [PATCH] SUNRPC: auth_gss: fix memory leaks in XDR decoding
 error paths
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neilb@ownmail.net>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
 Xingjing Deng <micro6947@gmail.com>, stable@vger.kernel.org
Date: Fri, 26 Dec 2025 10:30:33 -0500
In-Reply-To: <20251226151532.440886-1-cel@kernel.org>
References: <20251226151532.440886-1-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-12-26 at 10:15 -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> The gssx_dec_ctx(), gssx_dec_status(), and gssx_dec_name()
> functions allocate memory via gssx_dec_buffer(), which calls
> kmemdup(). When a subsequent decode operation fails, these
> functions return immediately without freeing previously
> allocated buffers, causing memory leaks.
>=20
> The leak in gssx_dec_ctx() is particularly relevant because
> the caller (gssp_accept_sec_context_upcall) initializes several
> buffer length fields to non-zero values, resulting in memory
> allocation:
>=20
>     struct gssx_ctx rctxh =3D {
>         .exported_context_token.len =3D GSSX_max_output_handle_sz,
>         .mech.len =3D GSS_OID_MAX_LEN,
>         .src_name.display_name.len =3D GSSX_max_princ_sz,
>         .targ_name.display_name.len =3D GSSX_max_princ_sz
>     };
>=20
> If, for example, gssx_dec_name() succeeds for src_name but
> fails for targ_name, the memory allocated for
> exported_context_token, mech, and src_name.display_name
> remains unreferenced and cannot be reclaimed.
>=20
> Add error handling with goto-based cleanup to free any
> previously allocated buffers before returning an error.
>=20
> Reported-by: Xingjing Deng <micro6947@gmail.com>
> Closes: https://lore.kernel.org/linux-nfs/CAK+ZN9qttsFDu6h1FoqGadXjMx1QXq=
PMoYQ=3D6O9RY4SxVTvKng@mail.gmail.com/
> Fixes: 1d658336b05f ("SUNRPC: Add RPC based upcall mechanism for RPCGSS a=
uth")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/auth_gss/gss_rpc_xdr.c | 82 ++++++++++++++++++++++++-------
>  1 file changed, 64 insertions(+), 18 deletions(-)
>=20
> diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_=
rpc_xdr.c
> index 7d2cdc2bd374..f320c0a8e604 100644
> --- a/net/sunrpc/auth_gss/gss_rpc_xdr.c
> +++ b/net/sunrpc/auth_gss/gss_rpc_xdr.c
> @@ -320,29 +320,47 @@ static int gssx_dec_status(struct xdr_stream *xdr,
> =20
>  	/* status->minor_status */
>  	p =3D xdr_inline_decode(xdr, 8);
> -	if (unlikely(p =3D=3D NULL))
> -		return -ENOSPC;
> +	if (unlikely(p =3D=3D NULL)) {
> +		err =3D -ENOSPC;
> +		goto out_free_mech;
> +	}
>  	p =3D xdr_decode_hyper(p, &status->minor_status);
> =20
>  	/* status->major_status_string */
>  	err =3D gssx_dec_buffer(xdr, &status->major_status_string);
>  	if (err)
> -		return err;
> +		goto out_free_mech;
> =20
>  	/* status->minor_status_string */
>  	err =3D gssx_dec_buffer(xdr, &status->minor_status_string);
>  	if (err)
> -		return err;
> +		goto out_free_major_status_string;
> =20
>  	/* status->server_ctx */
>  	err =3D gssx_dec_buffer(xdr, &status->server_ctx);
>  	if (err)
> -		return err;
> +		goto out_free_minor_status_string;
> =20
>  	/* we assume we have no options for now, so simply consume them */
>  	/* status->options */
>  	err =3D dummy_dec_opt_array(xdr, &status->options);
> +	if (err)
> +		goto out_free_server_ctx;
> =20
> +	return 0;
> +
> +out_free_server_ctx:
> +	kfree(status->server_ctx.data);
> +	status->server_ctx.data =3D NULL;
> +out_free_minor_status_string:
> +	kfree(status->minor_status_string.data);
> +	status->minor_status_string.data =3D NULL;
> +out_free_major_status_string:
> +	kfree(status->major_status_string.data);
> +	status->major_status_string.data =3D NULL;
> +out_free_mech:
> +	kfree(status->mech.data);
> +	status->mech.data =3D NULL;
>  	return err;
>  }
> =20
> @@ -505,28 +523,35 @@ static int gssx_dec_name(struct xdr_stream *xdr,
>  	/* name->name_type */
>  	err =3D gssx_dec_buffer(xdr, &dummy_netobj);
>  	if (err)
> -		return err;
> +		goto out_free_display_name;
> =20
>  	/* name->exported_name */
>  	err =3D gssx_dec_buffer(xdr, &dummy_netobj);
>  	if (err)
> -		return err;
> +		goto out_free_display_name;
> =20
>  	/* name->exported_composite_name */
>  	err =3D gssx_dec_buffer(xdr, &dummy_netobj);
>  	if (err)
> -		return err;
> +		goto out_free_display_name;
> =20
>  	/* we assume we have no attributes for now, so simply consume them */
>  	/* name->name_attributes */
>  	err =3D dummy_dec_nameattr_array(xdr, &dummy_name_attr_array);
>  	if (err)
> -		return err;
> +		goto out_free_display_name;
> =20
>  	/* we assume we have no options for now, so simply consume them */
>  	/* name->extensions */
>  	err =3D dummy_dec_opt_array(xdr, &dummy_option_array);
> +	if (err)
> +		goto out_free_display_name;
> =20
> +	return 0;
> +
> +out_free_display_name:
> +	kfree(name->display_name.data);
> +	name->display_name.data =3D NULL;
>  	return err;
>  }
> =20
> @@ -649,32 +674,34 @@ static int gssx_dec_ctx(struct xdr_stream *xdr,
>  	/* ctx->state */
>  	err =3D gssx_dec_buffer(xdr, &ctx->state);
>  	if (err)
> -		return err;
> +		goto out_free_exported_context_token;
> =20
>  	/* ctx->need_release */
>  	err =3D gssx_dec_bool(xdr, &ctx->need_release);
>  	if (err)
> -		return err;
> +		goto out_free_state;
> =20
>  	/* ctx->mech */
>  	err =3D gssx_dec_buffer(xdr, &ctx->mech);
>  	if (err)
> -		return err;
> +		goto out_free_state;
> =20
>  	/* ctx->src_name */
>  	err =3D gssx_dec_name(xdr, &ctx->src_name);
>  	if (err)
> -		return err;
> +		goto out_free_mech;
> =20
>  	/* ctx->targ_name */
>  	err =3D gssx_dec_name(xdr, &ctx->targ_name);
>  	if (err)
> -		return err;
> +		goto out_free_src_name;
> =20
>  	/* ctx->lifetime */
>  	p =3D xdr_inline_decode(xdr, 8+8);
> -	if (unlikely(p =3D=3D NULL))
> -		return -ENOSPC;
> +	if (unlikely(p =3D=3D NULL)) {
> +		err =3D -ENOSPC;
> +		goto out_free_targ_name;
> +	}
>  	p =3D xdr_decode_hyper(p, &ctx->lifetime);
> =20
>  	/* ctx->ctx_flags */
> @@ -683,17 +710,36 @@ static int gssx_dec_ctx(struct xdr_stream *xdr,
>  	/* ctx->locally_initiated */
>  	err =3D gssx_dec_bool(xdr, &ctx->locally_initiated);
>  	if (err)
> -		return err;
> +		goto out_free_targ_name;
> =20
>  	/* ctx->open */
>  	err =3D gssx_dec_bool(xdr, &ctx->open);
>  	if (err)
> -		return err;
> +		goto out_free_targ_name;
> =20
>  	/* we assume we have no options for now, so simply consume them */
>  	/* ctx->options */
>  	err =3D dummy_dec_opt_array(xdr, &ctx->options);
> +	if (err)
> +		goto out_free_targ_name;
> =20
> +	return 0;
> +
> +out_free_targ_name:
> +	kfree(ctx->targ_name.display_name.data);
> +	ctx->targ_name.display_name.data =3D NULL;
> +out_free_src_name:
> +	kfree(ctx->src_name.display_name.data);
> +	ctx->src_name.display_name.data =3D NULL;
> +out_free_mech:
> +	kfree(ctx->mech.data);
> +	ctx->mech.data =3D NULL;
> +out_free_state:
> +	kfree(ctx->state.data);
> +	ctx->state.data =3D NULL;
> +out_free_exported_context_token:
> +	kfree(ctx->exported_context_token.data);
> +	ctx->exported_context_token.data =3D NULL;
>  	return err;
>  }
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

