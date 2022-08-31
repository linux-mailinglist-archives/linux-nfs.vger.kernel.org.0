Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D427A5A8342
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Aug 2022 18:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiHaQbu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Aug 2022 12:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiHaQbs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Aug 2022 12:31:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0E9D6321
        for <linux-nfs@vger.kernel.org>; Wed, 31 Aug 2022 09:31:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E39C7B821AD
        for <linux-nfs@vger.kernel.org>; Wed, 31 Aug 2022 16:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE0BC433D6;
        Wed, 31 Aug 2022 16:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661963503;
        bh=lVq5bEqa1w+Qch6Xb9mnuWhbwrkaoibKXcij+VSuAO0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VsiZatLk7L/6NPV++j1sNpVbsfEgofVyJxAfNpHOnBj9XKmIbb7gR9AJEe+6XW9Xb
         MVZScoCOt8QRh0rz/XsKBzEW+nPLClI45wT54lon4GH6ij8IVBrg0wIlBqd0qA4cSd
         7jgqJMfL2XeEU1C7Hwe7zoh/yd3wmUb3FIC+TY0EdHpOYEB67Q5QIrUWxkIr06Zko3
         wDO/Ng4nz84dth3i36GIhAyKmNgT1Y1HLd6KkKDOEgWVmAvv1qn/u4jXhIauV0BMKZ
         hrzy48CJfHxmvgdnp2gjFhcu4yxi4oql6Uaq4/crhwD8fNO6Cj8JrVaL3/AA6++lAR
         G1kfo3b8Hc8TA==
Message-ID: <6a8523552dba647518fd8590349d64d25d1b6fe4.camel@kernel.org>
Subject: Re: [PATCH v3 1/3] NFS: Rename readpage_async_filler to
 nfs_pageio_add_page
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Date:   Wed, 31 Aug 2022 12:31:41 -0400
In-Reply-To: <20220831005053.1287363-2-dwysocha@redhat.com>
References: <20220831005053.1287363-1-dwysocha@redhat.com>
         <20220831005053.1287363-2-dwysocha@redhat.com>
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

On Tue, 2022-08-30 at 20:50 -0400, Dave Wysochanski wrote:
> Rename readpage_async_filler to nfs_pageio_add_page to
> better reflect what this function does (add a page to
> the nfs_pageio_descriptor), and simplify arguments to
> this function by removing struct nfs_readdesc.
>=20
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
>  fs/nfs/read.c | 60 +++++++++++++++++++++++++--------------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
>=20
> diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> index 8ae2c8d1219d..525e82ea9a9e 100644
> --- a/fs/nfs/read.c
> +++ b/fs/nfs/read.c
> @@ -127,11 +127,6 @@ static void nfs_readpage_release(struct nfs_page *re=
q, int error)
>  	nfs_release_request(req);
>  }
> =20
> -struct nfs_readdesc {
> -	struct nfs_pageio_descriptor pgio;
> -	struct nfs_open_context *ctx;
> -};
> -
>  static void nfs_page_group_set_uptodate(struct nfs_page *req)
>  {
>  	if (nfs_page_group_sync_on_bit(req, PG_UPTODATE))
> @@ -153,7 +148,8 @@ static void nfs_read_completion(struct nfs_pgio_heade=
r *hdr)
> =20
>  		if (test_bit(NFS_IOHDR_EOF, &hdr->flags)) {
>  			/* note: regions of the page not covered by a
> -			 * request are zeroed in readpage_async_filler */
> +			 * request are zeroed in nfs_pageio_add_page
> +			 */
>  			if (bytes > hdr->good_bytes) {
>  				/* nothing in this request was good, so zero
>  				 * the full extent of the request */
> @@ -281,8 +277,10 @@ static void nfs_readpage_result(struct rpc_task *tas=
k,
>  		nfs_readpage_retry(task, hdr);
>  }
> =20
> -static int
> -readpage_async_filler(struct nfs_readdesc *desc, struct page *page)
> +int
> +nfs_pageio_add_page(struct nfs_pageio_descriptor *pgio,
> +		    struct nfs_open_context *ctx,
> +		    struct page *page)
>  {
>  	struct inode *inode =3D page_file_mapping(page)->host;
>  	unsigned int rsize =3D NFS_SERVER(inode)->rsize;
> @@ -302,15 +300,15 @@ readpage_async_filler(struct nfs_readdesc *desc, st=
ruct page *page)
>  			goto out_unlock;
>  	}
> =20
> -	new =3D nfs_create_request(desc->ctx, page, 0, aligned_len);
> +	new =3D nfs_create_request(ctx, page, 0, aligned_len);
>  	if (IS_ERR(new))
>  		goto out_error;
> =20
>  	if (len < PAGE_SIZE)
>  		zero_user_segment(page, len, PAGE_SIZE);
> -	if (!nfs_pageio_add_request(&desc->pgio, new)) {
> +	if (!nfs_pageio_add_request(pgio, new)) {
>  		nfs_list_remove_request(new);
> -		error =3D desc->pgio.pg_error;
> +		error =3D pgio->pg_error;
>  		nfs_readpage_release(new, error);
>  		goto out;
>  	}
> @@ -332,7 +330,8 @@ readpage_async_filler(struct nfs_readdesc *desc, stru=
ct page *page)
>  int nfs_read_folio(struct file *file, struct folio *folio)
>  {
>  	struct page *page =3D &folio->page;
> -	struct nfs_readdesc desc;
> +	struct nfs_pageio_descriptor pgio;
> +	struct nfs_open_context *ctx;
>  	struct inode *inode =3D page_file_mapping(page)->host;
>  	int ret;
> =20
> @@ -358,29 +357,29 @@ int nfs_read_folio(struct file *file, struct folio =
*folio)
> =20
>  	if (file =3D=3D NULL) {
>  		ret =3D -EBADF;
> -		desc.ctx =3D nfs_find_open_context(inode, NULL, FMODE_READ);
> -		if (desc.ctx =3D=3D NULL)
> +		ctx =3D nfs_find_open_context(inode, NULL, FMODE_READ);
> +		if (ctx =3D=3D NULL)
>  			goto out_unlock;
>  	} else
> -		desc.ctx =3D get_nfs_open_context(nfs_file_open_context(file));
> +		ctx =3D get_nfs_open_context(nfs_file_open_context(file));
> =20
> -	xchg(&desc.ctx->error, 0);
> -	nfs_pageio_init_read(&desc.pgio, inode, false,
> +	xchg(&ctx->error, 0);
> +	nfs_pageio_init_read(&pgio, inode, false,
>  			     &nfs_async_read_completion_ops);
> =20
> -	ret =3D readpage_async_filler(&desc, page);
> +	ret =3D nfs_pageio_add_page(&pgio, ctx, page);
>  	if (ret)
>  		goto out;
> =20
> -	nfs_pageio_complete_read(&desc.pgio);
> -	ret =3D desc.pgio.pg_error < 0 ? desc.pgio.pg_error : 0;
> +	nfs_pageio_complete_read(&pgio);
> +	ret =3D pgio.pg_error < 0 ? pgio.pg_error : 0;
>  	if (!ret) {
>  		ret =3D wait_on_page_locked_killable(page);
>  		if (!PageUptodate(page) && !ret)
> -			ret =3D xchg(&desc.ctx->error, 0);
> +			ret =3D xchg(&ctx->error, 0);
>  	}
>  out:
> -	put_nfs_open_context(desc.ctx);
> +	put_nfs_open_context(ctx);
>  	trace_nfs_aop_readpage_done(inode, page, ret);
>  	return ret;
>  out_unlock:
> @@ -391,9 +390,10 @@ int nfs_read_folio(struct file *file, struct folio *=
folio)
> =20
>  void nfs_readahead(struct readahead_control *ractl)
>  {
> +	struct nfs_pageio_descriptor pgio;
> +	struct nfs_open_context *ctx;
>  	unsigned int nr_pages =3D readahead_count(ractl);
>  	struct file *file =3D ractl->file;
> -	struct nfs_readdesc desc;
>  	struct inode *inode =3D ractl->mapping->host;
>  	struct page *page;
>  	int ret;
> @@ -407,25 +407,25 @@ void nfs_readahead(struct readahead_control *ractl)
> =20
>  	if (file =3D=3D NULL) {
>  		ret =3D -EBADF;
> -		desc.ctx =3D nfs_find_open_context(inode, NULL, FMODE_READ);
> -		if (desc.ctx =3D=3D NULL)
> +		ctx =3D nfs_find_open_context(inode, NULL, FMODE_READ);
> +		if (ctx =3D=3D NULL)
>  			goto out;
>  	} else
> -		desc.ctx =3D get_nfs_open_context(nfs_file_open_context(file));
> +		ctx =3D get_nfs_open_context(nfs_file_open_context(file));
> =20
> -	nfs_pageio_init_read(&desc.pgio, inode, false,
> +	nfs_pageio_init_read(&pgio, inode, false,
>  			     &nfs_async_read_completion_ops);
> =20
>  	while ((page =3D readahead_page(ractl)) !=3D NULL) {
> -		ret =3D readpage_async_filler(&desc, page);
> +		ret =3D nfs_pageio_add_page(&pgio, ctx, page);
>  		put_page(page);
>  		if (ret)
>  			break;
>  	}
> =20
> -	nfs_pageio_complete_read(&desc.pgio);
> +	nfs_pageio_complete_read(&pgio);
> =20
> -	put_nfs_open_context(desc.ctx);
> +	put_nfs_open_context(ctx);
>  out:
>  	trace_nfs_aop_readahead_done(inode, nr_pages, ret);
>  }

Yeah, a special args struct only with 2 fields in it does seem sort of
pointless:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
