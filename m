Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59FE6642AA
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 15:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjAJOBy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 09:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjAJOBX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 09:01:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FDD5015A
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 06:01:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F67161277
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 14:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4378DC433D2;
        Tue, 10 Jan 2023 14:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673359281;
        bh=TlJSruzTz9G3o5E6eqJdxRfSFEFgjfhyCdsLqNytZZ8=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=MgpDoMYj3wY70b521rwsTxAlOYp5OtC2/2pBL96ejYUrKCdAFOMVpIDvFM0d/fYKD
         SMf3/2Ljhx8hsAC/IDC95RadFMRMhCyLOBfg7w9l/EH92Ux4Rp/7MEGAelTnhYhNRr
         UMoqUPEJJhEqQRJaRrH6Cw6L5ENLyPEp6wotSColm/EV6JHb1jFH87o/crkt+yFUNQ
         qSObdzPdM3apwK31Se37bgzffllHqlA1qqI/SVX+0E4mdy/GjrRSNqgdXUsWhuVHgE
         llTn3Cntrp+MGwOvccxzioyynrBhReNt4xxs7DX6Hkob8FtRihCh3uhstknr37+1ol
         OmYg2MG9BikBg==
Message-ID: <fd1a0ac033f46229fadf03613d0664c2e817b066.camel@kernel.org>
Subject: Re: [PATCH v1 01/27] SUNRPC: Clean up svcauth_gss_release()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Date:   Tue, 10 Jan 2023 09:01:19 -0500
In-Reply-To: <167319531054.7490.10405247832294580026.stgit@bazille.1015granger.net>
References: <167319499150.7490.2294168831574653380.stgit@bazille.1015granger.net>
         <167319531054.7490.10405247832294580026.stgit@bazille.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2023-01-08 at 11:28 -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Now that upper layers use an xdr_stream to track the construction
> of each RPC Reply message, resbuf->len is kept up-to-date
> automatically. There's no need to recompute it in svc_gss_release().
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/auth_gss/svcauth_gss.c |   30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>=20
> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svca=
uth_gss.c
> index 2e603358fae1..4a576ed7aa32 100644
> --- a/net/sunrpc/auth_gss/svcauth_gss.c
> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
> @@ -969,12 +969,6 @@ svcauth_gss_unwrap_integ(struct svc_rqst *rqstp, u32=
 seq, struct gss_ctx *ctx)
>  	return -EINVAL;
>  }
> =20
> -static inline int
> -total_buf_len(struct xdr_buf *buf)
> -{
> -	return buf->head[0].iov_len + buf->page_len + buf->tail[0].iov_len;
> -}
> -
>  /*
>   * RFC 2203, Section 5.3.2.3
>   *
> @@ -1882,14 +1876,25 @@ svcauth_gss_wrap_resp_priv(struct svc_rqst *rqstp=
)
>  	return 0;
>  }
> =20
> +/**
> + * svcauth_gss_release - Wrap payload and release resources
> + * @rqstp: RPC transaction context
> + *
> + * Return values:
> + *    %0: the Reply is ready to be sent
> + *    %-ENOMEM: failed to allocate memory
> + *    %-EINVAL: encoding error
> + *
> + * XXX: These return values do not match the return values documented
> + *      for the auth_ops ->release method in linux/sunrpc/svcauth.h.

As an aside...

It looks like the only place ->release is called is in svc_authorise,
and its callers either ignore the return, or just test whether it
succeeded (returned 0). If it fails then it looks like the xprt is
closed.

The actual return code doesn't matter at all. We could make ->release a
bool return to make that clear.

That's not directly related to this set though.


>  static int
>  svcauth_gss_release(struct svc_rqst *rqstp)
>  {
> -	struct gss_svc_data *gsd =3D (struct gss_svc_data *)rqstp->rq_auth_data=
;
> -	struct rpc_gss_wire_cred *gc;
> -	struct xdr_buf *resbuf =3D &rqstp->rq_res;
> -	int stat =3D -EINVAL;
>  	struct sunrpc_net *sn =3D net_generic(SVC_NET(rqstp), sunrpc_net_id);
> +	struct gss_svc_data *gsd =3D rqstp->rq_auth_data;
> +	struct rpc_gss_wire_cred *gc;
> +	int stat;
> =20
>  	if (!gsd)
>  		goto out;
> @@ -1899,10 +1904,7 @@ svcauth_gss_release(struct svc_rqst *rqstp)
>  	/* Release can be called twice, but we only wrap once. */
>  	if (gsd->verf_start =3D=3D NULL)
>  		goto out;
> -	/* normally not set till svc_send, but we need it here: */
> -	/* XXX: what for?  Do we mess it up the moment we call svc_putu32
> -	 * or whatever? */
> -	resbuf->len =3D total_buf_len(resbuf);
> +
>  	switch (gc->gc_svc) {
>  	case RPC_GSS_SVC_NONE:
>  		break;
>=20
>=20

The patch itself looks fine.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
