Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14C9743BFF
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 14:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjF3MhI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Jun 2023 08:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjF3MhF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Jun 2023 08:37:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE66B35AF;
        Fri, 30 Jun 2023 05:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AC686175D;
        Fri, 30 Jun 2023 12:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825D7C433CB;
        Fri, 30 Jun 2023 12:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688128621;
        bh=c350ESZGWpi7StoatukQWJZpbWswxl0Lt+3NLEC0n8Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GQnTAbH9m1Nm0opSpMsyUQmgxS+lNoRn2rkuO1TfNmBB7BIglLEnijj3A9Pvvi3FD
         o8CMN2OQiRqp95xDdwU8ZNFf9m96P0ykNxJ/WWa8fZAJS7KXlLhPzD/ZAb6Z8V2HeD
         BCkt3DKp3bu3mRCjCJbyMvrzxGO3BCKdph3CCe8wpQiOcrP2tyMn8IeJxc2kNNhcbR
         fymGCa2WPN3TOe/FdGkc7OmEdt9dnVLHBxYZueOydzTjSnavlRovr7M3jRjtZm7TlL
         MQ4aO2IQju4ywPK6PMqPqrhvBvdZV0llfWG+3mmO3zDVWjwf6RN+bL8oqOJy//RTKI
         RT/MIj2+zadQQ==
Message-ID: <1529de75f7a35e7847c292705c936cdb4649be39.camel@kernel.org>
Subject: Re: [PATCH] SUNRPC: clean up integer overflow check
From:   Jeff Layton <jlayton@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-nfs@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Date:   Fri, 30 Jun 2023 08:36:59 -0400
In-Reply-To: <2390fdc8-13fa-4456-ab67-44f0744db412@moroto.mountain>
References: <2390fdc8-13fa-4456-ab67-44f0744db412@moroto.mountain>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
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

On Fri, 2023-06-30 at 12:46 +0300, Dan Carpenter wrote:
> This integer overflow check works as intended but Clang and GCC and warn
> about it when compiling with W=3D1.
>=20
>     include/linux/sunrpc/xdr.h:539:17: error: comparison is always false
>     due to limited range of data type [-Werror=3Dtype-limits]
>=20
> Use size_mul() to prevent the integer overflow.  It silences the warning
> and it's cleaner as well.
>=20
> Reported-by: Dmitry Antipov <dmantipov@yandex.ru>
> Closes: https://lore.kernel.org/all/20230601143332.255312-1-dmantipov@yan=
dex.ru/
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> Btw, since the Clang developers are automatically CC'd, here is how I
> silenced this type of false positive in Smatch:
>=20
> 1) Check that longs are 64 bit.
> 2) Check that the right hand side has a SIZE_MAX.  SIZE_MAX is defined
>    as -1UL so you want both the type and the value to match.
> 3) Then on the other the other side, check that the type is uint.
>=20
> I'm looking at this code now in Smatch and it's kind of ugly, and also
> there are some other places where I need to apply the same logic...
>=20
>  include/linux/sunrpc/xdr.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index f89ec4b5ea16..dbf7620a2853 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -775,9 +775,7 @@ xdr_stream_decode_uint32_array(struct xdr_stream *xdr=
,
> =20
>  	if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
>  		return -EBADMSG;
> -	if (len > SIZE_MAX / sizeof(*p))
> -		return -EBADMSG;
> -	p =3D xdr_inline_decode(xdr, len * sizeof(*p));
> +	p =3D xdr_inline_decode(xdr, size_mul(len, sizeof(*p)));
>  	if (unlikely(!p))
>  		return -EBADMSG;
>  	if (array =3D=3D NULL)


Acked-by: Jeff Layton <jlayton@kernel.org>
