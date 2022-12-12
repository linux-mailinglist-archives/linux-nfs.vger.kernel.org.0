Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFC464A54E
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 17:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiLLQxf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 11:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiLLQxc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 11:53:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E3710554
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 08:53:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E00B5B80DCB
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 16:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7AEC433F0;
        Mon, 12 Dec 2022 16:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670864009;
        bh=4HTU3ktIC54yMoLta98PeQJHJVrTCM/5i0Lq1yLmqXA=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=JYRv2NiY56OKlHlOmrPxlFtV1XFDPosCo+oOOtM0WR51kb49S7kEpvNquP/VAqlsE
         wQF0hTN9qFFA/2u+E9u5hUBpEzipRpCWMWO5NMexTuXOJT5We5rJagFMevWoGdPRbr
         2cajviLIWxNNANDx15FT0Na04eyAeZtB2amVq83i6mFAEXsS23pmTWW4fzirkIc+xv
         suZiv+mxXrRq+ugA3qV1MUT0c1ZJiOVCFiiAPBEl/SmFeYOaEH8aUUNwLKZyMDpm3n
         YhiSNw3ahdWREH6vWuUkZSMmaAWyjOE/5Fs6WeWHHff14jL8ORSiDhQDrGqb7UwDn4
         tCPAO7HtXWPuA==
Message-ID: <2f8af9190926ac682121a9c75808240fea0e580e.camel@kernel.org>
Subject: Re: [PATCH 2/4] SUNRPC: Clean up xdr_write_pages()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Mon, 12 Dec 2022 11:53:27 -0500
In-Reply-To: <166949612452.106845.16079864294324208424.stgit@klimt.1015granger.net>
References: <166949601705.106845.10614964159272504008.stgit@klimt.1015granger.net>
         <166949612452.106845.16079864294324208424.stgit@klimt.1015granger.net>
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

On Sat, 2022-11-26 at 15:55 -0500, Chuck Lever wrote:
> Make it more evident how xdr_write_pages() updates the tail buffer
> by using the convention of naming the iov pointer variable "tail".
> I spent more than a couple of hours chasing through code to
> understand this, so someone is likely to find this useful later.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xdr.c |   22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 336a7c7833e4..f7767bf22406 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -1224,30 +1224,34 @@ EXPORT_SYMBOL(xdr_restrict_buflen);
>  /**
>   * xdr_write_pages - Insert a list of pages into an XDR buffer for sendi=
ng
>   * @xdr: pointer to xdr_stream
> - * @pages: list of pages
> - * @base: offset of first byte
> - * @len: length of data in bytes
> + * @pages: array of pages to insert
> + * @base: starting offset of first data byte in @pages
> + * @len: number of data bytes in @pages to insert
>   *
> + * After the @pages are added, the tail iovec is instantiated pointing t=
o
> + * end of the head buffer, and the stream is set up to encode subsequent
> + * items into the tail.
>   */
>  void xdr_write_pages(struct xdr_stream *xdr, struct page **pages, unsign=
ed int base,
>  		 unsigned int len)
>  {
>  	struct xdr_buf *buf =3D xdr->buf;
> -	struct kvec *iov =3D buf->tail;
> +	struct kvec *tail =3D buf->tail;
> +
>  	buf->pages =3D pages;
>  	buf->page_base =3D base;
>  	buf->page_len =3D len;
> =20
> -	iov->iov_base =3D (char *)xdr->p;
> -	iov->iov_len  =3D 0;
> -	xdr->iov =3D iov;
> +	tail->iov_base =3D xdr->p;
> +	tail->iov_len =3D 0;
> +	xdr->iov =3D tail;
> =20
>  	if (len & 3) {
>  		unsigned int pad =3D 4 - (len & 3);
> =20
>  		BUG_ON(xdr->p >=3D xdr->end);
> -		iov->iov_base =3D (char *)xdr->p + (len & 3);
> -		iov->iov_len  +=3D pad;
> +		tail->iov_base =3D (char *)xdr->p + (len & 3);
> +		tail->iov_len +=3D pad;
>  		len +=3D pad;
>  		*xdr->p++ =3D 0;
>  	}
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
