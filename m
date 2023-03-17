Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233BD6BF050
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 19:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCQSEq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 14:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCQSEp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 14:04:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94573D0AA
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 11:04:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C999B825D6
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 18:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78552C433D2;
        Fri, 17 Mar 2023 18:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679076281;
        bh=+4f5PdpkgK7POuMskh0ECVnSFu3xVSoW3HDgqr0Osmc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rKReEYMOpKmS2x1xBzSlzeJeMlxvP4W/a6NLoicyoXg1465BOgTPEU2YAX7hhBOp4
         ox/hjL2hOM3RvYGLvqqrA+f9sCCmZVydIoYjKleaWum5betpn800WOLuScpxxDay7E
         DfmV6+YOpc9lyI8ExRklmBUsK/RtVwbVb6nSdTnCTn/Wkue8SEGCYG4+ymIf+qDpKL
         fmiqeAgBfdVqvg5ZOb/LZ/hN6ShW9SN35numWlftRxFHL+72DP7bhg3ZYJOvQdrA79
         fp7BUUTk3MHZ54QjKJHvw/9yojRajmSykLwZL0WmVoSiaBFCDJYDo4lyEQoltWIXV6
         peD+bUO35zk8g==
Message-ID: <827d46876b57bec309164d4c9513bac523ad5843.camel@kernel.org>
Subject: Re: [PATCH v2 2/2] sunrpc: add bounds checking to
 svc_rqst_replace_page
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "dcritch@redhat.com" <dcritch@redhat.com>,
        "d.lesca@solinos.it" <d.lesca@solinos.it>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri, 17 Mar 2023 14:04:39 -0400
In-Reply-To: <6F8F3C24-A043-443A-BBB7-E4788FBE29C9@oracle.com>
References: <20230317171309.73607-1-jlayton@kernel.org>
         <20230317171309.73607-2-jlayton@kernel.org>
         <6F8F3C24-A043-443A-BBB7-E4788FBE29C9@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-03-17 at 17:51 +0000, Chuck Lever III wrote:
> > On Mar 17, 2023, at 1:13 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > If rq_next_page ends up pointing outside the array, then we can
> > corrupt
> > memory when we go to change its value. Ensure that it hasn't strayed
> > outside the array, and have svc_rqst_replace_page return -EIO
> > without
> > changing anything if it has.
> >=20
> > Fix up nfsd_splice_actor (the only caller) to handle this case by
> > either
> > returning an error or a short splice when this happens.
>=20
> IMO it's not worth the extra complexity to return a short splice.
> This is a "should never happen" scenario in a hot I/O path. Let's
> keep this code as simple as possible, and use unlikely() for the
> error cases in both nfsd_splice_actor and svc_rqst_replace_page().
>=20

Are there any issues with just returning an error even though we have
successfully spliced some of the data into the buffer? I guess the
caller will just see an EIO or whatever instead of the short read in
that case?


> Also, since "nfsd_splice_actor ... [is] the only caller", a WARN_ON
> stack trace is not adding value. I still think a tracepoint is more
> appropriate. I suggest:
>=20
> =A0=A0trace_svc_replace_page_err(rqst);
>=20
>=20

Ok, I can look at adding a conditional tracepoint.

> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/vfs.c              | 23 +++++++++++++++++------
> > include/linux/sunrpc/svc.h |  2 +-
> > net/sunrpc/svc.c           | 14 +++++++++++++-
> > 3 files changed, 31 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 97b38b47c563..0ebd7a65a9f0 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -939,6 +939,7 @@ nfsd_splice_actor(struct pipe_inode_info *pipe,
> > struct pipe_buffer *buf,
> > 	struct page *page =3D buf->page;	// may be a compound one
> > 	unsigned offset =3D buf->offset;
> > 	struct page *last_page;
> > +	int ret =3D 0, consumed =3D 0;
> >=20
> > 	last_page =3D page + (offset + sd->len - 1) / PAGE_SIZE;
> > 	for (page +=3D offset / PAGE_SIZE; page <=3D last_page; page++)
> > {
> > @@ -946,13 +947,23 @@ nfsd_splice_actor(struct pipe_inode_info
> > *pipe, struct pipe_buffer *buf,
> > 		 * Skip page replacement when extending the
> > contents
> > 		 * of the current page.
> > 		 */
> > -		if (page !=3D *(rqstp->rq_next_page - 1))
> > -			svc_rqst_replace_page(rqstp, page);
> > +		if (page !=3D *(rqstp->rq_next_page - 1)) {
> > +			ret =3D svc_rqst_replace_page(rqstp, page);
> > +			if (ret)
> > +				break;
> > +		}
> > +		consumed +=3D min_t(int,
> > +				  PAGE_SIZE -
> > offset_in_page(offset),
> > +				  sd->len - consumed);
> > +		offset =3D 0;
> > 	}
> > -	if (rqstp->rq_res.page_len =3D=3D 0)	// first call
> > -		rqstp->rq_res.page_base =3D offset % PAGE_SIZE;
> > -	rqstp->rq_res.page_len +=3D sd->len;
> > -	return sd->len;
> > +	if (consumed) {
> > +		if (rqstp->rq_res.page_len =3D=3D 0)	// first
> > call
> > +			rqstp->rq_res.page_base =3D offset %
> > PAGE_SIZE;
> > +		rqstp->rq_res.page_len +=3D consumed;
> > +		return consumed;
> > +	}
> > +	return ret;
> > }
> >=20
> > static int nfsd_direct_splice_actor(struct pipe_inode_info *pipe,
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index 877891536c2f..9ea52f143f49 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -422,7 +422,7 @@ struct svc_serv *svc_create(struct svc_program
> > *, unsigned int,
> > 			    int (*threadfn)(void *data));
> > struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
> > 					struct svc_pool *pool, int
> > node);
> > -void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
> > +int		   svc_rqst_replace_page(struct svc_rqst *rqstp,
> > 					 struct page *page);
> > void		   svc_rqst_free(struct svc_rqst *);
> > void		   svc_exit_thread(struct svc_rqst *);
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index fea7ce8fba14..d624c02f09be 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -843,8 +843,19 @@ EXPORT_SYMBOL_GPL(svc_set_num_threads);
> > =A0* When replacing a page in rq_pages, batch the release of the
> > =A0* replaced pages to avoid hammering the page allocator.
> > =A0*/
> > -void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page
> > *page)
> > +int svc_rqst_replace_page(struct svc_rqst *rqstp, struct page
> > *page)
> > {
> > +	struct page **begin, **end;
> > +
> > +	/*
> > +	 * Bounds check: make sure rq_next_page points into the
> > rq_respages
> > +	 * part of the array.
> > +	 */
> > +	begin =3D rqstp->rq_pages;
> > +	end =3D &rqstp->rq_pages[RPCSVC_MAXPAGES];
> > +	if (WARN_ON_ONCE(rqstp->rq_next_page < begin || rqstp-
> > >rq_next_page > end))
> > +		return -EIO;
> > +
> > 	if (*rqstp->rq_next_page) {
> > 		if (!pagevec_space(&rqstp->rq_pvec))
> > 			__pagevec_release(&rqstp->rq_pvec);
> > @@ -853,6 +864,7 @@ void svc_rqst_replace_page(struct svc_rqst
> > *rqstp, struct page *page)
> >=20
> > 	get_page(page);
> > 	*(rqstp->rq_next_page++) =3D page;
> > +	return 0;
> > }
> > EXPORT_SYMBOL_GPL(svc_rqst_replace_page);
> >=20
> > --=20
> > 2.39.2
> >=20
>=20
> --
> Chuck Lever
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
