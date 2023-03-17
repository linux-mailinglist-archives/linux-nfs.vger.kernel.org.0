Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8486BEC05
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 16:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCQPAL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 11:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjCQPAG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 11:00:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BC1CB07F
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 08:00:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2A0D60301
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 14:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD587C433D2;
        Fri, 17 Mar 2023 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679065199;
        bh=BQ8sOc5gieCoKQP9Ktj+btizx0alL8eM3FBBV/LtOQ0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XyOzB8TtW7Aha145qfrP+4lNTX7/Yl7c0ewpWHPy8/IY7maD0UI7QEssNcqxTACp5
         yQQWswZWtS4Co10lOZf2gKeC76Ym7aVKpvX8L9ckxoIQ5AGdeiew/sTVsgEpPmSEJt
         qB71khELwoq7EW8aOGVrMbVINg1jCBDmD5viY2zJpXGMX7q6GZuUVBTOhwag859PLJ
         Pcth9JqtVaKRFe2aXE4iP7Zd/gIXWY8we4wOzf8jaB3hvrhYk9dE28dP+b0WH0HZco
         6g6rv6+v1G7CtcjSk2Jc6pzhYLNeRM7wM8r4af85mmc/ASgL+ZkUKqeRs5LjM7jg5o
         ukB0XWFFqnNvg==
Message-ID: <c1d4fbaf83c6e1e41e31f77d58d889adaecb6d35.camel@kernel.org>
Subject: Re: [PATCH 1/2] nfsd: don't replace page in rq_pages if it's a
 continuation of last page
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "dcritch@redhat.com" <dcritch@redhat.com>,
        "d.lesca@solinos.it" <d.lesca@solinos.it>
Date:   Fri, 17 Mar 2023 10:59:57 -0400
In-Reply-To: <65C84563-6BCD-41CE-AF68-80E1869D217F@oracle.com>
References: <20230317105608.19393-1-jlayton@kernel.org>
         <c57b48f500b859a3daf6f95ccefdfbec72e1c9de.camel@kernel.org>
         <65C84563-6BCD-41CE-AF68-80E1869D217F@oracle.com>
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

On Fri, 2023-03-17 at 14:16 +0000, Chuck Lever III wrote:
>=20
> > On Mar 17, 2023, at 9:06 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Fri, 2023-03-17 at 06:56 -0400, Jeff Layton wrote:
> > > The splice read calls nfsd_splice_actor to put the pages containing f=
ile
> > > data into the svc_rqst->rq_pages array. It's possible however to get =
a
> > > splice result that only has a partial page at the end, if (e.g.) the
> > > filesystem hands back a short read that doesn't cover the whole page.
> > >=20
> > > nfsd_splice_actor will plop the partial page into its rq_pages array =
and
> > > return. Then later, when nfsd_splice_actor is called again, the
> > > remainder of the page may end up being filled out. At this point,
> > > nfsd_splice_actor will put the page into the array _again_ corrupting
> > > the reply. If this is done enough times, rq_next_page will overrun th=
e
> > > array and corrupt the trailing fields -- the rq_respages and
> > > rq_next_page pointers themselves.
> > >=20
> > > If we've already added the page to the array in the last pass, don't =
add
> > > it to the array a second time when dealing with a splice continuation=
.
> > > This was originally handled properly in nfsd_splice_actor, but commit
> > > 91e23b1c3982 removed the check for it, and started universally replac=
ing
> > > pages.
> > >=20
> > > Fixes: 91e23b1c3982 ("NFSD: Clean up nfsd_splice_actor()")
> > > Reported-by: Dario Lesca <d.lesca@solinos.it>
> > > Tested-by: David Critch <dcritch@redhat.com>
> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2150630
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > fs/nfsd/vfs.c | 7 +++++--
> > > 1 file changed, 5 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > index 502e1b7742db..3709ef57d96e 100644
> > > --- a/fs/nfsd/vfs.c
> > > +++ b/fs/nfsd/vfs.c
> > > @@ -941,8 +941,11 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, =
struct pipe_buffer *buf,
> > > 	struct page *last_page;
> > >=20
> > > 	last_page =3D page + (offset + sd->len - 1) / PAGE_SIZE;
> > > -	for (page +=3D offset / PAGE_SIZE; page <=3D last_page; page++)
> > > -		svc_rqst_replace_page(rqstp, page);
> > > +	for (page +=3D offset / PAGE_SIZE; page <=3D last_page; page++) {
> > > +		/* Only replace page if we haven't already done so */
> >=20
> > Note that I think that this was probably the real rationale for the pp[=
-
> > 1] check that 91e23b1c3982 removed. Given that, maybe we should flesh
> > this comment out a bit more for posterity?
> >=20
> > 		/*
> > 		 * When we're splicing from a pipe, it's possible that
> > 		 * we'll get an incomplete page that may be updated on
> > 		 * a later call. Only splice it into rq_pages once.
> > 		 */
>=20
> The "real" bug here is that the API contract for pipe splicing
> isn't well defined, so I agree that it's very likely the pp[-1]
> check was because a splice can call the actor repeatedly for the
> same page. No one could remember why that check was there.
>=20

The whole splice API is a minefield.

> To be clear, if the passed-in page matches the current page in
> the rqst, we're "extending the current page" rather than avoiding
> replacement... maybe:
>=20
> 	/*
> 	 * Skip page replacement when extending the contents
> 	 * of the current page.
> 	 */
>=20

Sure, sounds good.

> In the patch description, would you mention that this case
> arises if the READ request is not page-aligned?
>=20

Does it though? I'm not sure that page alignment has that much to do
with it. I imagine you can hit this even with aligned I/Os.

My guess is the bigger issue is when your storage is doing sub-page-size
I/Os under the hood. We end up filling up part of a page from storage
and the kernel submits what it has to the pipe and then the next bit
comes in and the page is updated for the next actor call.

> If you resend this patch, please Cc: viro@ . Thanks for chasing
> this down!
>=20

Will do.

>=20
> > > +		if (page !=3D *(rqstp->rq_next_page - 1))
> > > +			svc_rqst_replace_page(rqstp, page);
> > > +	}
> > > 	if (rqstp->rq_res.page_len =3D=3D 0)	// first call
> > > 		rqstp->rq_res.page_base =3D offset % PAGE_SIZE;
> > > 	rqstp->rq_res.page_len +=3D sd->len;
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
>=20
> --
> Chuck Lever
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
