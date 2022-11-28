Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8192463AE9B
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Nov 2022 18:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiK1RMV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Nov 2022 12:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiK1RMR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Nov 2022 12:12:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20CDA182
        for <linux-nfs@vger.kernel.org>; Mon, 28 Nov 2022 09:12:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64CB7B80E71
        for <linux-nfs@vger.kernel.org>; Mon, 28 Nov 2022 17:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6ED5C433D6;
        Mon, 28 Nov 2022 17:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669655534;
        bh=ECWgCDl9HWPtHLfKuXu4vmTBsm6XvilsPmDw6SaC2hQ=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=rqjdfYWBh4duLvQVmQhnL8TPbh8C3pnmsJCBUk/xcLA34VtXMlDVDdasdiHcVJyaE
         133XghNaL3gHvM2O4C1e403atPdvBFicsWN+ndCKiY6RQrKI2iUMNu0r17CJzQGji3
         vXa4ZTUYPSHrohzWVhFnJP05s3qNWsU31p72pRY06h5knQnLDq996LvokQBlmQ7b3T
         N6LJxlNYTyHffOmtgK8W7AVLIC0njNuiXcMcT355mWqHRpxOCcfgDYLmmlXSLcGlxu
         WpbApepfwtrRP2KxuwAVL1iofIk3XeM7tjpFGeQkOH5TorCtWX6yZ3GBY17s9Qgn0o
         boL7NhF4ht22g==
Message-ID: <c7ba9e84577d4d1ba917f6f47d1b227e292894ec.camel@kernel.org>
Subject: Re: [PATCH] SUNRPC: Fix crasher in unwrap_integ_data()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 28 Nov 2022 12:12:12 -0500
In-Reply-To: <166956944745.113279.2771726273440100988.stgit@klimt.1015granger.net>
References: <166956944745.113279.2771726273440100988.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2022-11-27 at 12:17 -0500, Chuck Lever wrote:
> If a zero length is passed to kmalloc() it returns 0x10, which is
> not a valid address. gss_verify_mic() subsequently crashes when it
> attempts to dereference that pointer.
>=20
> Instead of allocating this memory on every call based on an
> untrusted size value, use a piece of dynamically-allocated scratch
> memory that is always available.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/auth_gss/svcauth_gss.c |   55 ++++++++++++++++++++++---------=
------
>  1 file changed, 32 insertions(+), 23 deletions(-)
>=20
> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svca=
uth_gss.c
> index 9a5db285d4ae..148bb0a7fa5b 100644
> --- a/net/sunrpc/auth_gss/svcauth_gss.c
> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
> @@ -49,11 +49,36 @@
>  #include <linux/sunrpc/svcauth.h>
>  #include <linux/sunrpc/svcauth_gss.h>
>  #include <linux/sunrpc/cache.h>
> +#include <linux/sunrpc/gss_krb5.h>
> =20
>  #include <trace/events/rpcgss.h>
> =20
>  #include "gss_rpc_upcall.h"
> =20
> +/*
> + * Unfortunately there isn't a maximum checksum size exported via the
> + * GSS API. Manufacture one based on GSS mechanisms supported by this
> + * implementation.
> + */
> +#define GSS_MAX_CKSUMSIZE (GSS_KRB5_TOK_HDR_LEN + GSS_KRB5_MAX_CKSUM_LEN=
)
> +
> +/*
> + * This value may be increased in the future to accommodate other
> + * usage of the scratch buffer.
> + */
> +#define GSS_SCRATCH_SIZE GSS_MAX_CKSUMSIZE
> +
> +struct gss_svc_data {
> +	/* decoded gss client cred: */
> +	struct rpc_gss_wire_cred	clcred;
> +	/* save a pointer to the beginning of the encoded verifier,
> +	 * for use in encryption/checksumming in svcauth_gss_release: */
> +	__be32				*verf_start;
> +	struct rsc			*rsci;
> +
> +	/* for temporary results */
> +	u8				gsd_scratch[GSS_SCRATCH_SIZE];
> +};
> =20
>  /* The rpcsec_init cache is used for mapping RPCSEC_GSS_{,CONT_}INIT req=
uests
>   * into replies.
> @@ -887,13 +912,11 @@ read_u32_from_xdr_buf(struct xdr_buf *buf, int base=
, u32 *obj)
>  static int
>  unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, =
struct gss_ctx *ctx)
>  {
> +	struct gss_svc_data *gsd =3D rqstp->rq_auth_data;
>  	u32 integ_len, rseqno, maj_stat;
> -	int stat =3D -EINVAL;
>  	struct xdr_netobj mic;
>  	struct xdr_buf integ_buf;
> =20
> -	mic.data =3D NULL;
> -
>  	/* NFS READ normally uses splice to send data in-place. However
>  	 * the data in cache can change after the reply's MIC is computed
>  	 * but before the RPC reply is sent. To prevent the client from
> @@ -917,11 +940,9 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xdr=
_buf *buf, u32 seq, struct g
>  	/* copy out mic... */
>  	if (read_u32_from_xdr_buf(buf, integ_len, &mic.len))
>  		goto unwrap_failed;
> -	if (mic.len > RPC_MAX_AUTH_SIZE)
> -		goto unwrap_failed;
> -	mic.data =3D kmalloc(mic.len, GFP_KERNEL);
> -	if (!mic.data)
> +	if (mic.len > sizeof(gsd->gsd_scratch))
>  		goto unwrap_failed;
> +	mic.data =3D gsd->gsd_scratch;
>  	if (read_bytes_from_xdr_buf(buf, integ_len + 4, mic.data, mic.len))
>  		goto unwrap_failed;
>  	maj_stat =3D gss_verify_mic(ctx, &integ_buf, &mic);
> @@ -932,20 +953,17 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xd=
r_buf *buf, u32 seq, struct g
>  		goto bad_seqno;
>  	/* trim off the mic and padding at the end before returning */
>  	xdr_buf_trim(buf, round_up_to_quad(mic.len) + 4);
> -	stat =3D 0;
> -out:
> -	kfree(mic.data);
> -	return stat;
> +	return 0;
> =20
>  unwrap_failed:
>  	trace_rpcgss_svc_unwrap_failed(rqstp);
> -	goto out;
> +	return -EINVAL;
>  bad_seqno:
>  	trace_rpcgss_svc_seqno_bad(rqstp, seq, rseqno);
> -	goto out;
> +	return -EINVAL;
>  bad_mic:
>  	trace_rpcgss_svc_mic(rqstp, maj_stat);
> -	goto out;
> +	return -EINVAL;
>  }
> =20
>  static inline int
> @@ -1023,15 +1041,6 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xd=
r_buf *buf, u32 seq, struct gs
>  	return -EINVAL;
>  }
> =20
> -struct gss_svc_data {
> -	/* decoded gss client cred: */
> -	struct rpc_gss_wire_cred	clcred;
> -	/* save a pointer to the beginning of the encoded verifier,
> -	 * for use in encryption/checksumming in svcauth_gss_release: */
> -	__be32				*verf_start;
> -	struct rsc			*rsci;
> -};
> -
>  static int
>  svcauth_gss_set_client(struct svc_rqst *rqstp)
>  {
>=20
>=20

That makes a lot more sense!

Reviewed-by: Jeff Layton <jlayton@kernel.org>
