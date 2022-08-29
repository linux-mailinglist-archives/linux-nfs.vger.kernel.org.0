Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6C15A4CC4
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 14:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiH2M67 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 08:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiH2M46 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 08:56:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1103D77566
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 05:48:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4568EB80EF3
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 12:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B70C433D6;
        Mon, 29 Aug 2022 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661777323;
        bh=3cHJZez9zZFBD7QT2fPWKMCwXYEo56SPR8batC/uSXw=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=qRutGQi4jyhjLDB7BjQBNEXBCm9TDL+g+Kb2VPwJYxIMbW0sHKvNIHdItd2Maw64x
         j+RmaUYur0zUoeS1q5unFUpLw43Psg5qerAJEQzGAs3oR2+MTNrkEHJ7nlN48cnZC4
         vVPdxF8Ndn862WGC4LW6Du4LHJuTBTMja3bbu7S+IGLqJ/FWqECAZDjgnroNlqpeFO
         z+ZoK9IskSMHh5jPmcUmeeyAaJgupJwDFkQC/Mg8mJAX/b5n4+SQ4L3QkAaE1eFwwx
         FsPUKinAbngqd0+32/O4gXa4t1ruDhWZLjBOxngamQkUN9U5BhZmw1gti6JCYnfDxx
         /8t7lb0i5v6ew==
Message-ID: <3d6242195f2ea33fc10d8e7dafadb9e5ad65b1be.camel@kernel.org>
Subject: Re: [PATCH v2 1/7] SUNRPC: Fix svcxdr_init_decode's end-of-buffer
 calculation
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 29 Aug 2022 08:48:41 -0400
In-Reply-To: <166171262197.21449.2261873517844800915.stgit@manet.1015granger.net>
References: <166171174172.21449.5036120183381273656.stgit@manet.1015granger.net>
         <166171262197.21449.2261873517844800915.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, 2022-08-28 at 14:50 -0400, Chuck Lever wrote:
> Ensure that stream-based argument decoding can't go past the actual
> end of the receive buffer. xdr_init_decode's calculation of the
> value of xdr->end over-estimates the end of the buffer because the
> Linux kernel RPC server code does not remove the size of the RPC
> header from rqstp->rq_arg before calling the upper layer's
> dispatcher.
>=20
> The server-side still uses the svc_getnl() macros to decode the
> RPC call header. These macros reduce the length of the head iov
> but do not update the total length of the message in the buffer
> (buf->len).
>=20
> A proper fix for this would be to replace the use of svc_getnl() and
> friends in the RPC header decoder, but that would be a large and
> invasive change that would be difficult to backport.
>=20
> Fixes: 5191955d6fc6 ("SUNRPC: Prepare for xdr_stream-style decoding on th=
e server-side")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc.h |   17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index daecb009c05b..5a830b66f059 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -544,16 +544,27 @@ static inline void svc_reserve_auth(struct svc_rqst=
 *rqstp, int space)
>  }
> =20
>  /**
> - * svcxdr_init_decode - Prepare an xdr_stream for svc Call decoding
> + * svcxdr_init_decode - Prepare an xdr_stream for Call decoding
>   * @rqstp: controlling server RPC transaction context
>   *
> + * This function currently assumes the RPC header in rq_arg has
> + * already been decoded. Upon return, xdr->p points to the
> + * location of the upper layer header.

nit: "upper layer header" is a bit nebulous here. Maybe "points to the
start of the RPC program header" ?

>   */
>  static inline void svcxdr_init_decode(struct svc_rqst *rqstp)
>  {
>  	struct xdr_stream *xdr =3D &rqstp->rq_arg_stream;
> -	struct kvec *argv =3D rqstp->rq_arg.head;
> +	struct xdr_buf *buf =3D &rqstp->rq_arg;
> +	struct kvec *argv =3D buf->head;
> =20
> -	xdr_init_decode(xdr, &rqstp->rq_arg, argv->iov_base, NULL);
> +	/*
> +	 * svc_getnl() and friends do not keep the xdr_buf's ::len
> +	 * field up to date. Refresh that field before initializing
> +	 * the argument decoding stream.
> +	 */
> +	buf->len =3D buf->head->iov_len + buf->page_len + buf->tail->iov_len;
> +
> +	xdr_init_decode(xdr, buf, argv->iov_base, NULL);
>  	xdr_set_scratch_page(xdr, rqstp->rq_scratch_page);
>  }
> =20
>=20
>=20

Patch looks fine. I do wish this code were less confusing with length
handing though I'm not sure how to approach cleaning that up.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
