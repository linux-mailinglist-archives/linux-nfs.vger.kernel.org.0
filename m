Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03EF6BF02B
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 18:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCQRwN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 13:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCQRwM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 13:52:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95883E1CB
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 10:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C51AB82661
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 17:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB7EC433EF;
        Fri, 17 Mar 2023 17:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679075511;
        bh=IcJiEXV9KnS8peXst29OcaiFo2WqC9bCmcB5WNEdMLM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M0UdPuQ661g9/t1aAYnoNWhSvoZLMbOmtFefbbqfz9xdlhVUVwBll+goBQ+mK3BJO
         jOWCqiQ/+4nKu8GU0OVL5HAxfnXn4Nf4M1vuPPGrhsKvTr20S/+8YaVoqsa5bWSHff
         xsaI28howHzeteVBUe2ntmQKzF5FlTXT0cO0AXZBKtxFJDZKeN9R/bA0sVQKWikxRp
         troW8C6K4wyi5I+KS0ku8BlX3wop5zqQe/Rn+pzVNvSVhhE8yIFnWBizj/aOLtHW0Z
         XSzQynYgXuJH+238FiqB7V3gWGrScOhNmR+G9GCEfBWyFCHFyZkKV94trde9QSKdZR
         03Dkid7lwzcbA==
Message-ID: <c2fa806e20e55353ac0cfca2d4c1bfb0de6bbb5f.camel@kernel.org>
Subject: Re: [PATCH v2 2/2] sunrpc: add bounds checking to
 svc_rqst_replace_page
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, dcritch@redhat.com, d.lesca@solinos.it,
        viro@zeniv.linux.org.uk
Date:   Fri, 17 Mar 2023 13:51:49 -0400
In-Reply-To: <20230317171309.73607-2-jlayton@kernel.org>
References: <20230317171309.73607-1-jlayton@kernel.org>
         <20230317171309.73607-2-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-03-17 at 13:13 -0400, Jeff Layton wrote:
> If rq_next_page ends up pointing outside the array, then we can corrupt
> memory when we go to change its value. Ensure that it hasn't strayed
> outside the array, and have svc_rqst_replace_page return -EIO without
> changing anything if it has.
>=20
> Fix up nfsd_splice_actor (the only caller) to handle this case by either
> returning an error or a short splice when this happens.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/vfs.c              | 23 +++++++++++++++++------
>  include/linux/sunrpc/svc.h |  2 +-
>  net/sunrpc/svc.c           | 14 +++++++++++++-
>  3 files changed, 31 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 97b38b47c563..0ebd7a65a9f0 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -939,6 +939,7 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struc=
t pipe_buffer *buf,
>  	struct page *page =3D buf->page;	// may be a compound one
>  	unsigned offset =3D buf->offset;
>  	struct page *last_page;
> +	int ret =3D 0, consumed =3D 0;
> =20
>  	last_page =3D page + (offset + sd->len - 1) / PAGE_SIZE;
>  	for (page +=3D offset / PAGE_SIZE; page <=3D last_page; page++) {
> @@ -946,13 +947,23 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, str=
uct pipe_buffer *buf,
>  		 * Skip page replacement when extending the contents
>  		 * of the current page.
>  		 */
> -		if (page !=3D *(rqstp->rq_next_page - 1))
> -			svc_rqst_replace_page(rqstp, page);
> +		if (page !=3D *(rqstp->rq_next_page - 1)) {
> +			ret =3D svc_rqst_replace_page(rqstp, page);
> +			if (ret)
> +				break;
> +		}
> +		consumed +=3D min_t(int,
> +				  PAGE_SIZE - offset_in_page(offset),
> +				  sd->len - consumed);
> +		offset =3D 0;
>  	}
> -	if (rqstp->rq_res.page_len =3D=3D 0)	// first call
> -		rqstp->rq_res.page_base =3D offset % PAGE_SIZE;
> -	rqstp->rq_res.page_len +=3D sd->len;
> -	return sd->len;
> +	if (consumed) {
> +		if (rqstp->rq_res.page_len =3D=3D 0)	// first call
> +			rqstp->rq_res.page_base =3D offset % PAGE_SIZE;

Oops, this will get the page_base wrong if the first splice covers
multiple pages. I'll need to respin the offset handling.

> +		rqstp->rq_res.page_len +=3D consumed;
> +		return consumed;
> +	}
> +	return ret;
>  }
> =20
>  static int nfsd_direct_splice_actor(struct pipe_inode_info *pipe,
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 877891536c2f..9ea52f143f49 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -422,7 +422,7 @@ struct svc_serv *svc_create(struct svc_program *, uns=
igned int,
>  			    int (*threadfn)(void *data));
>  struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
>  					struct svc_pool *pool, int node);
> -void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
> +int		   svc_rqst_replace_page(struct svc_rqst *rqstp,
>  					 struct page *page);
>  void		   svc_rqst_free(struct svc_rqst *);
>  void		   svc_exit_thread(struct svc_rqst *);
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index fea7ce8fba14..d624c02f09be 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -843,8 +843,19 @@ EXPORT_SYMBOL_GPL(svc_set_num_threads);
>   * When replacing a page in rq_pages, batch the release of the
>   * replaced pages to avoid hammering the page allocator.
>   */
> -void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
> +int svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
>  {
> +	struct page **begin, **end;
> +
> +	/*
> +	 * Bounds check: make sure rq_next_page points into the rq_respages
> +	 * part of the array.
> +	 */
> +	begin =3D rqstp->rq_pages;
> +	end =3D &rqstp->rq_pages[RPCSVC_MAXPAGES];
> +	if (WARN_ON_ONCE(rqstp->rq_next_page < begin || rqstp->rq_next_page > e=
nd))
> +		return -EIO;
> +
>  	if (*rqstp->rq_next_page) {
>  		if (!pagevec_space(&rqstp->rq_pvec))
>  			__pagevec_release(&rqstp->rq_pvec);
> @@ -853,6 +864,7 @@ void svc_rqst_replace_page(struct svc_rqst *rqstp, st=
ruct page *page)
> =20
>  	get_page(page);
>  	*(rqstp->rq_next_page++) =3D page;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(svc_rqst_replace_page);
> =20

--=20
Jeff Layton <jlayton@kernel.org>
