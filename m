Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F5557A3A7
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jul 2022 17:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239046AbiGSPtz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jul 2022 11:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239144AbiGSPtw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Jul 2022 11:49:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68B65A448
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jul 2022 08:49:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06667B81BC5
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jul 2022 15:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC07C341C6;
        Tue, 19 Jul 2022 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658245786;
        bh=Wk5QmJOJhlB7QK5o+Nt3bx6TUsGRau8K3HfLxPrZ63k=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=ajKhxEC//NVB6FpyNhVNxcVDdDAZHDbF42C/CESEvjSfWmjIXnnqE8PVR3jcqGBbu
         LnN7tTfC7z7PfTXb9de3FpxPfZtv8lBMGnXbnSepQ6uxKLVWbu3FFRKPiw1nE8dA/r
         Cy8z2h2fllFKRdwMputqbWQ2dF8c85HKTavXT1fqzWugzVHNZMf5OpuQuCMddeoSph
         OoJ6dAZZwxcy5dVM9+BLvnYMOTCrBg2p/RCWhkMKfYkDS4tlyaSQeIfvKqvFdFC4e9
         PbM6RJwj2gT5JDBSTPEUkInU2+wHsyT3h73rVahnY2RBhw2q9Pm7GnOIpnUa2lJqZT
         ApvkJTl3q6wsg==
Message-ID: <39417eca1dd4a810270cb35d0978b6636aeb0654.camel@kernel.org>
Subject: Re: [PATCH] SUNRPC: Fix xdr_encode_bool()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Tue, 19 Jul 2022 11:49:44 -0400
In-Reply-To: <165823671509.3047.16569036635528856192.stgit@manet.1015granger.net>
References: <165823671509.3047.16569036635528856192.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-07-19 at 09:18 -0400, Chuck Lever wrote:
> I discovered that xdr_encode_bool() was returning the same address
> that was passed in the @p parameter. The documenting comment states
> that the intent is to return the address of the next buffer
> location, just like the other "xdr_encode_*" helpers.
>=20
> The result was the encoded results of NFSv3 PATHCONF operations were
> not formed correctly.
>=20
> Fixes: ded04a587f6c ("NFSD: Update the NFSv3 PATHCONF3res encoder to use =
struct xdr_stream")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/xdr.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index 5860f32e3958..986c8a17ca5e 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -419,8 +419,8 @@ static inline int xdr_stream_encode_item_absent(struc=
t xdr_stream *xdr)
>   */
>  static inline __be32 *xdr_encode_bool(__be32 *p, u32 n)
>  {
> -	*p =3D n ? xdr_one : xdr_zero;
> -	return p++;
> +	*p++ =3D n ? xdr_one : xdr_zero;
> +	return p;
>  }
> =20
>  /**
>=20
>=20

Nice catch. Postincrement operators strike again!

Reviewed-by: Jeff Layton <jlayton@kernel.org>
