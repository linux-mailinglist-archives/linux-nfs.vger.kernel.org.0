Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3814E6BEA7B
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Mar 2023 14:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjCQNwx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Mar 2023 09:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCQNwx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Mar 2023 09:52:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14976EB81
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 06:52:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70980B825B1
        for <linux-nfs@vger.kernel.org>; Fri, 17 Mar 2023 13:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD5AC433D2;
        Fri, 17 Mar 2023 13:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679061169;
        bh=CRCgq4HeRStYpcRDgfOoM8TYaG0Bl8TB6N7bPILEP0w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sm4Y6Ocg+TgWB8/NHtKk+YNZF54H13WMw3LPeNkN8BoNCJdT27GzYN+cYm0o8frsR
         gI4jk3LcHuw5pNOVRx71X4EIcQc969nZ/0h/bkfJ2P8uBHiNw/Tlc0jl1dZ19wjB8n
         gfY95igCWx+Osb/bUlTAykDCliJA1CurJdpzChsfxI357hyYJ8hSRMYPott8XNju/f
         StI8luaPycXmda2pedt37WCxYGnq5xTiSB6OKD9i3fUI6y/UZo3chbQyVwkMutymrL
         dYTMm4sam7qnsRD/r0TeSt4sMtk4LP021OmLk7qxIc37Xsmb+od+jIRnj9K491QV5E
         0/6XmNHL/jGkg==
Message-ID: <ca552165dc70f8268b887bc35d395039ed093861.camel@kernel.org>
Subject: Re: [PATCH 2/2] sunrpc: add bounds checking to svc_rqst_replace_page
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "dcritch@redhat.com" <dcritch@redhat.com>,
        "d.lesca@solinos.it" <d.lesca@solinos.it>
Date:   Fri, 17 Mar 2023 09:52:47 -0400
In-Reply-To: <7DAC68F4-8CE7-4578-BBF1-626285B44B6E@oracle.com>
References: <20230317105608.19393-1-jlayton@kernel.org>
         <20230317105608.19393-2-jlayton@kernel.org>
         <7DAC68F4-8CE7-4578-BBF1-626285B44B6E@oracle.com>
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

On Fri, 2023-03-17 at 13:44 +0000, Chuck Lever III wrote:
>=20
> > On Mar 17, 2023, at 6:56 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > There's no good way to handle this gracefully, but if rq_next_page ends
> > up pointing outside the array, we can at least crash the box before it
> > scribbles over too much else.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > net/sunrpc/svc.c | 10 ++++++++++
> > 1 file changed, 10 insertions(+)
> >=20
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index fea7ce8fba14..864e62945647 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -845,6 +845,16 @@ EXPORT_SYMBOL_GPL(svc_set_num_threads);
> >  */
> > void svc_rqst_replace_page(struct svc_rqst *rqstp, struct page *page)
> > {
> > +	struct page **begin, **end;
> > +
> > +	/*
> > +	 * Bounds check: make sure rq_next_page points into the rq_respages
> > +	 * part of the array.
> > +	 */
> > +	begin =3D rqstp->rq_pages;
> > +	end =3D &rqstp->rq_pages[RPCSVC_MAXPAGES];
> > +	BUG_ON(rqstp->rq_next_page < begin || rqstp->rq_next_page > end);
>=20
> Linus has stated clearly that he does not want BUG_ON assertions
> if the system is not actually in danger... and this is clearly
> the result of a software bug, so a crash will occur anyway.
>=20

It'll crash, but only after we scribble over some memory.

Actually, it looks like the splice actor can return an error. We could
return -EIO here or something without doing anything if we hit this case
and then let that bubble back up to the read?

> Can you make this a pr_warn_once() ?
>=20
>=20
> > +
> > 	if (*rqstp->rq_next_page) {
> > 		if (!pagevec_space(&rqstp->rq_pvec))
> > 			__pagevec_release(&rqstp->rq_pvec);
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
