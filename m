Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFBD5A4E7C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 15:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiH2Nse (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 09:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiH2Nsd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 09:48:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD721956BD
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 06:48:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56D04B8107A
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 13:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4A9C433D6;
        Mon, 29 Aug 2022 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661780909;
        bh=NWMyxZvup7b12MaC/BZ0HppMAePd+fwYJWJF9RHwOrs=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=dcSVxjPv0hMdRMErkdwfnRZ9BiA8TnEK0gIoENytv5Wcpino1ixcWDE/GvezL5CmA
         4Vn7n7AlNKbwJawOvWOrBZvhf6cgvtwxk85Wx1vx5zjkAj20JjabWZkxiEs1Veu2qS
         2WHqY1lKEyEXWIHke3UWCNqvbzJ5AzHczpELrAIGDhoN2pcQ9oXLCHIbub+29gcl9M
         IT7YqNG7uVVEOvT7JX+W0mA0KhNRSp6u9gPJQpjb9QUOjeCmwp2EgSmEb888XODhO+
         3Fg80wiTSRav7ifdF9Tat3T+sEh1BVO0FRFU3Du9rzp77Bc7FT+YMyiWwYQV5OnSi4
         8pXzd/4KHEvbQ==
Message-ID: <6b5b45ea8d94c6122445ee26ae7bf6d2555770f2.camel@kernel.org>
Subject: Re: [PATCH v2 4/7] NFSD: Use xdr_inline_decode() to decode NFSv3
 symlinks
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 29 Aug 2022 09:48:28 -0400
In-Reply-To: <166171264105.21449.17586756015319208200.stgit@manet.1015granger.net>
References: <166171174172.21449.5036120183381273656.stgit@manet.1015granger.net>
         <166171264105.21449.17586756015319208200.stgit@manet.1015granger.net>
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
> Replace the check for buffer over/underflow with a helper that is
> commonly used for this purpose. The helper also sets xdr->nwords
> correctly after successfully linearizing the symlink argument into
> the stream's scratch buffer.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs3xdr.c |   14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index 0293b8d65f10..71e32cf28885 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -616,8 +616,6 @@ nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, st=
ruct xdr_stream *xdr)
>  {
>  	struct nfsd3_symlinkargs *args =3D rqstp->rq_argp;
>  	struct kvec *head =3D rqstp->rq_arg.head;
> -	struct kvec *tail =3D rqstp->rq_arg.tail;
> -	size_t remaining;
> =20
>  	if (!svcxdr_decode_diropargs3(xdr, &args->ffh, &args->fname, &args->fle=
n))
>  		return false;
> @@ -626,16 +624,10 @@ nfs3svc_decode_symlinkargs(struct svc_rqst *rqstp, =
struct xdr_stream *xdr)
>  	if (xdr_stream_decode_u32(xdr, &args->tlen) < 0)
>  		return false;
> =20
> -	/* request sanity */
> -	remaining =3D head->iov_len + rqstp->rq_arg.page_len + tail->iov_len;
> -	remaining -=3D xdr_stream_pos(xdr);
> -	if (remaining < xdr_align_size(args->tlen))
> -		return false;
> -
> -	args->first.iov_base =3D xdr->p;
> +	/* symlink_data */
>  	args->first.iov_len =3D head->iov_len - xdr_stream_pos(xdr);
> -
> -	return true;
> +	args->first.iov_base =3D xdr_inline_decode(xdr, args->tlen);
> +	return args->first.iov_base !=3D NULL;
>  }
> =20
>  bool
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
