Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF46325E3A
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Feb 2021 08:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhBZHUw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Feb 2021 02:20:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:60356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230164AbhBZHUo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 26 Feb 2021 02:20:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C524BAAAE;
        Fri, 26 Feb 2021 07:20:01 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Chuck Lever <chuck.lever@oracle.com>, mgorman@techsingularity.net
Date:   Fri, 26 Feb 2021 18:19:56 +1100
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org, kuba@kernel.org
Subject: Re: [PATCH v2 4/4] SUNRPC: Cache pages that were replaced during a
 read splice
In-Reply-To: <161400740732.195066.3792261943053910900.stgit@klimt.1015granger.net>
References: <161400722731.195066.9584156841718557193.stgit@klimt.1015granger.net>
 <161400740732.195066.3792261943053910900.stgit@klimt.1015granger.net>
Message-ID: <87k0qvi9cz.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22 2021, Chuck Lever wrote:

> To avoid extra trips to the page allocator, don't free unused pages
> in nfsd_splice_actor(), but instead place them in a local cache.
> That cache is then used first when refilling rq_pages.
>
> On workloads that perform large NFS READs on splice-capable file
> systems, this saves a considerable amount of work.
>
> Suggested-by: NeilBrown <neilb@suse.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c                   |    4 ++--
>  include/linux/sunrpc/svc.h      |    1 +
>  include/linux/sunrpc/svc_xprt.h |   28 ++++++++++++++++++++++++++++
>  net/sunrpc/svc.c                |    7 +++++++
>  net/sunrpc/svc_xprt.c           |   12 ++++++++++++
>  5 files changed, 50 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index d316e11923c5..25cf41eaf3c4 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -852,14 +852,14 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, str=
uct pipe_buffer *buf,
>=20=20
>  	if (rqstp->rq_res.page_len =3D=3D 0) {
>  		get_page(page);
> -		put_page(*rqstp->rq_next_page);
> +		svc_rqst_put_unused_page(rqstp, *rqstp->rq_next_page);
>  		*(rqstp->rq_next_page++) =3D page;
>  		rqstp->rq_res.page_base =3D buf->offset;
>  		rqstp->rq_res.page_len =3D size;
>  	} else if (page !=3D pp[-1]) {
>  		get_page(page);
>  		if (*rqstp->rq_next_page)
> -			put_page(*rqstp->rq_next_page);
> +			svc_rqst_put_unused_page(rqstp, *rqstp->rq_next_page);
>  		*(rqstp->rq_next_page++) =3D page;
>  		rqstp->rq_res.page_len +=3D size;
>  	} else
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 31ee3b6047c3..340f4f3989c0 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -250,6 +250,7 @@ struct svc_rqst {
>  	struct xdr_stream	rq_arg_stream;
>  	struct page		*rq_scratch_page;
>  	struct xdr_buf		rq_res;
> +	struct list_head	rq_unused_pages;
>  	struct page		*rq_pages[RPCSVC_MAXPAGES + 1];
>  	struct page *		*rq_respages;	/* points into rq_pages */
>  	struct page *		*rq_next_page; /* next reply page to use */
> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_x=
prt.h
> index 571f605bc91e..49ef86499876 100644
> --- a/include/linux/sunrpc/svc_xprt.h
> +++ b/include/linux/sunrpc/svc_xprt.h
> @@ -150,6 +150,34 @@ static inline void svc_xprt_get(struct svc_xprt *xpr=
t)
>  {
>  	kref_get(&xprt->xpt_ref);
>  }
> +
> +/**
> + * svc_rqst_get_unused_page - Tap a page from the local cache
> + * @rqstp: svc_rqst with cached unused pages
> + *
> + * To save an allocator round trip, pages can be added to a
> + * local cache and re-used later by svc_alloc_arg().
> + *
> + * Returns an unused page, or NULL if the cache is empty.
> + */
> +static inline struct page *svc_rqst_get_unused_page(struct svc_rqst *rqs=
tp)
> +{
> +	return list_first_entry_or_null(&rqstp->rq_unused_pages,
> +					struct page, lru);
> +}
> +
> +/**
> + * svc_rqst_put_unused_page - Stash a page in the local cache
> + * @rqstp: svc_rqst with cached unused pages
> + * @page: page to cache
> + *
> + */
> +static inline void svc_rqst_put_unused_page(struct svc_rqst *rqstp,
> +					    struct page *page)
> +{
> +	list_add(&page->lru, &rqstp->rq_unused_pages);
> +}
> +
>  static inline void svc_xprt_set_local(struct svc_xprt *xprt,
>  				      const struct sockaddr *sa,
>  				      const size_t salen)
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 61fb8a18552c..3920fa8f1146 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -570,6 +570,8 @@ svc_init_buffer(struct svc_rqst *rqstp, unsigned int =
size, int node)
>  	if (svc_is_backchannel(rqstp))
>  		return 1;
>=20=20
> +	INIT_LIST_HEAD(&rqstp->rq_unused_pages);
> +
>  	pages =3D size / PAGE_SIZE + 1; /* extra page as we hold both request a=
nd reply.
>  				       * We assume one is at most one page
>  				       */
> @@ -593,8 +595,13 @@ svc_init_buffer(struct svc_rqst *rqstp, unsigned int=
 size, int node)
>  static void
>  svc_release_buffer(struct svc_rqst *rqstp)
>  {
> +	struct page *page;
>  	unsigned int i;
>=20=20
> +	while ((page =3D svc_rqst_get_unused_page(rqstp))) {
> +		list_del(&page->lru);
> +		put_page(page);
> +	}
>  	for (i =3D 0; i < ARRAY_SIZE(rqstp->rq_pages); i++)
>  		if (rqstp->rq_pages[i])
>  			put_page(rqstp->rq_pages[i]);
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 15aacfa5ca21..84210e546a66 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -678,6 +678,18 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
>  	for (needed =3D 0, i =3D 0; i < pages ; i++)
>  		if (!rqstp->rq_pages[i])
>  			needed++;
> +	if (needed) {
> +		for (i =3D 0; i < pages; i++) {
> +			if (!rqstp->rq_pages[i]) {
> +				page =3D svc_rqst_get_unused_page(rqstp);
> +				if (!page)
> +					break;
> +				list_del(&page->lru);
> +				rqstp->rq_pages[i] =3D page;
> +				needed--;
> +			}
> +		}
> +	}
>  	if (needed) {
>  		LIST_HEAD(list);
>=20=20
This looks good!  Probably simpler than the way I imagined it :-)
I would do that last bit of code differently though...

  for (needed =3D 0, i =3D 0; i < pages ; i++)
          if (!rqstp->rq_pages[i]) {
                  page =3D svc_rqst_get_unused_pages(rqstp);
                  if (page) {
                          list_del(&page->lru);
                          rqstp->rq_pages[i] =3D page;
                  } else
                          needed++;
          }

but it is really a minor style difference - I don't object to your
version.

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCAAuFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmA4oRwQHG5laWxAYnJv
d24ubmFtZQAKCRA57J7dVmKBuYkCEACCwjdOIz4QAwZUH166WdVF8+mPmPYFilq1
OzTzVDDFN4oDZoUBDGWFd4xZAhwVNCJ/dJhLoAJo0znCOHeckM3mTWFF9fOdEhXM
67/+IXe6keX/8d9d/Vv3KN6vGN+IMjT2MfrW5Lvx7CnV3fYMQsQPAACeUkVtrDR5
s+DffgIlltKAKlFapA9x73h8nMzxvU6ngogsfKGWGd5dhhWVq6XlbzCbeVBAl4sL
SG+PAcU+/1Fzubppob5xM8+p9EgpCiLdSbwSZcjZfDFgPFTWDU/xn3/40ikixQl7
mLWW/vcOjgOCniVibXSrlc0fAB4po/8/pZWvUCzoUOp1A2bJq3TASHGXSEIFzKWL
lPuVurZvPKbhj96HAIr4Gio24HndDAqbI8zqH6r4idu6YGziSVMY8yYH4a/nFHFz
Wuwf14NUSXR10v8Q9hi3CX31WLlpObcmTEd7E0ryB5ADPSRCJp7GSKal5XnMtOe4
+YVOiFbXVxZIduJsFmkcJE9YrcnZ+32spnQ2lXw7k5Nk7YAiIiGj+ayVfHsPieg0
vid2WcV4WVodzTkodql+F+dGWLJNOLBq2ISQLntB5FJCw0zCNTRfPOBME41cvT1a
qYnyJ4TtqXyWDlpkP082hZXuzjAJwmoRcyd8ZnB6bG6T2IaYxzJHO9/J9UDaZ3by
nVfm0AULsQ==
=GFpw
-----END PGP SIGNATURE-----
--=-=-=--
