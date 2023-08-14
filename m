Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281ED77BBDD
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Aug 2023 16:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjHNOk6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Aug 2023 10:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjHNOkt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Aug 2023 10:40:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC33F10C;
        Mon, 14 Aug 2023 07:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41BE661F2D;
        Mon, 14 Aug 2023 14:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E46C433C7;
        Mon, 14 Aug 2023 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692024047;
        bh=RlrwrPoSY6jYpgs1tuNAikmbh3k/2dkpitBYNNhD7x4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=q56ancRwVQI0a1xujzCi0gBDGV7Dkm9Sxunj29CAztGWkbKjMQNETIuFjx3z9EP1K
         oVfUoHsVkmesHmA1Zq+Fk8TKNZnKT7dcNjzo2kgXILdr25wgPQcR/bNsfJM5TQBd5v
         Zv7Yi9fRTE/QIko4ScRLrv8WsiPXoAhrYzyUA87jK6PGDc6J7id5VPR2afF1ngJNBG
         QJiBESPm9H5+WWlkB3aAP8Hhp0cmttZ+EBUKJjdJl+LLQSlZyTH4kBB7i6xPRr4Jy1
         xuGWMN25y1wcMN1oDZisJr8qYDZAGWaGLlsXlUVwRRfu5nRlN6nsDYZ5LF+a/ML/2k
         tdc+ClIPrSx2w==
Message-ID: <7abc529b2066fcaeb17458846746ab6de2ccb186.camel@kernel.org>
Subject: Re: [PATCH] sunrpc: account for xdr->page_base in xdr_alloc_bvec
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 14 Aug 2023 10:40:45 -0400
In-Reply-To: <20230814-sendpage-v1-1-d551b0d7f870@kernel.org>
References: <20230814-sendpage-v1-1-d551b0d7f870@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-08-14 at 10:32 -0400, Jeff Layton wrote:
> I've been seeing a regression in mainline (v6.5-rc) kernels where
> unaligned reads were returning corrupt data.
>=20
> 9d96acbc7f37 added a routine to allocate and populate a bvec array that
> can be used to back an iov_iter. When it does this, it always sets the
> offset in the first bvec to zero, even when the xdr->page_base is
> non-zero.
>=20
> The old code in svc_tcp_sendmsg used to account for this, as it was
> sending the pages one at a time anyway, but now that we just hand the
> iov to the network layer, we need to ensure that the bvecs are properly
> initialized.
>=20
> Fix xdr_alloc_bvec to set the offset in the first bvec to the offset
> indicated by xdr->page_base, and then 0 in all subsequent bvecs.
>=20
> Fixes: 9d96acbc7f37 ("SUNRPC: Add a bvec array to struct xdr_buf for use =
with iovec_iter()")

We might need a different fixes tag here. While I think xdr_alloc_bvec
ought to be where we account for this, the actual patch that broke
things is this one:

    5df5dd03a8f7 sunrpc: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage

The old code accounted for the fact that the first bvec always had a zero o=
ffset.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> NB: This is only lightly tested so far, but it seems to fix the pynfs
> regressions I've been seeing.
> ---
>  net/sunrpc/xdr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 2a22e78af116..d0f5fc8605b8 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -144,6 +144,7 @@ int
>  xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp)
>  {
>  	size_t i, n =3D xdr_buf_pagecount(buf);
> +	unsigned int offset =3D offset_in_page(buf->page_base);
> =20
>  	if (n !=3D 0 && buf->bvec =3D=3D NULL) {
>  		buf->bvec =3D kmalloc_array(n, sizeof(buf->bvec[0]), gfp);
> @@ -151,7 +152,8 @@ xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp)
>  			return -ENOMEM;
>  		for (i =3D 0; i < n; i++) {
>  			bvec_set_page(&buf->bvec[i], buf->pages[i], PAGE_SIZE,
> -				      0);
> +				      offset);
> +			offset =3D 0;
>  		}
>  	}
>  	return 0;
>=20
> ---
> base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
> change-id: 20230814-sendpage-b04874eed249
>=20
> Best regards,

--=20
Jeff Layton <jlayton@kernel.org>
