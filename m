Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299E56D1195
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Mar 2023 23:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjC3V6P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Mar 2023 17:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjC3V6O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Mar 2023 17:58:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7A44690
        for <linux-nfs@vger.kernel.org>; Thu, 30 Mar 2023 14:58:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54063621B6
        for <linux-nfs@vger.kernel.org>; Thu, 30 Mar 2023 21:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6053BC433EF;
        Thu, 30 Mar 2023 21:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680213492;
        bh=6e/xQgyggASBeNWA2fPlcDgcobVw6I/iKt46YAFRFXk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LSjYoturc8LjJS+nCcGtXRK3CFx+R2MLzgF8ax9W7s2XWLVWL4FQAzdfpNruLEM8s
         I3mz5YKTa/itgWZgCoIJQe3WvE6LW637JaPZVUV0KxFjDvXi0WenzUal65ujhbc3Ws
         M8nMGTtHb2pTEDXLuwcipBr7HZy2w8X35hxm1xMlfk4jsFCflJ1o+a99iZPS1nzUOZ
         2vNmC+CNLo8HqSBbTlTwWDKeRe08FpvKILj/xqRi/TXcfeOhQi0sZKR/+e+SpFmZ4L
         /m99HkIFE1955ZC0lAC2GKn7GiDEMgK5mv21v3eZwK0VK/mR/0LuMvnkhAwZCLKKHi
         UDh7SidZoymSA==
Message-ID: <41520e08585dad71413e16c148f59aa8faac8236.camel@kernel.org>
Subject: Re: [PATCH] nfsd: don't allow OPDESC to walk off the end of
 nfsd4_ops
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 30 Mar 2023 17:58:10 -0400
In-Reply-To: <3EA9A5F9-1F2F-4C90-8363-A357278D8C63@oracle.com>
References: <20230330185729.22895-1-jlayton@kernel.org>
         <3EA9A5F9-1F2F-4C90-8363-A357278D8C63@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-03-30 at 19:32 +0000, Chuck Lever III wrote:
>=20
> > On Mar 30, 2023, at 2:57 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > Ensure that OPDESC() doesn't return a pointer that doesn't lie within
> > the array. In particular, this is a problem when this funtion is passed
> > OP_ILLEGAL, but let's return NULL for any invalid value.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/nfs4proc.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >=20
> > This is the patch that I think we want ahead of this one:
> >=20
> >    nfsd: call op_release, even when op_func returns an error
> >=20
> > If you end up with OP_ILLEGAL, then op->opdesc ends up pointing
> > somewhere far, far away, and the new op_release changes can trip over
> > that.  We could add a Fixes tag for this, I suppose:
> >=20
> >    22b03214962e nfsd4: introduce OPDESC helper
> >=20
> > ...but that commit is from 2011, so it's probably not worth it.
>=20
> Well, my concern would be that we want this fix in stable if the
> op_release fix is applied as well. I think we will need to either
> squash these two or mark this one with an explicit Fixes: tag.
>=20
>=20

Your call.

> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 5ae670807449..5e7b4ca7a266 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -2494,6 +2494,8 @@ static __be32 nfs41_check_op_ordering(struct nfsd=
4_compoundargs *args)
> >=20
> > const struct nfsd4_operation *OPDESC(struct nfsd4_op *op)
> > {
> > +	if (op->opnum < FIRST_NFS4_OP || op->opnum > LAST_NFS42_OP)
> > +		return NULL;
> > 	return &nfsd4_ops[op->opnum];
> > }
>=20
> Several OPDESC callers appear to expect the return value will be
> a non-NULL pointer, so this will either crash the system, or
> crash the human reading the code. ;-)
>=20

Yep, but the alternative is that they go off into la-la land and
probably just crash anyway with a GPF. You might get lucky and not
crash, but it's doubtful that it'd do anything you'd expect. At least by
setting it early to a NULL pointer, you're more likely to crash earlier,
at a point where you might be able to determine the cause.

> Besides, those callers appear to have already range-checked the
> opnum (on cursory inspection). It's only nfsd4_decode_compound()
> that looks dodgy.
>=20
> How about something like this (untested) instead?
>=20
> NFSD: Don't call OPDESC with a potentially illegal opnum
>=20
> [ Fill in your description here, or squash this patch ]
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 97edb32be77f..67bbd2d6334c 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2476,10 +2476,12 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *=
argp)
>         for (i =3D 0; i < argp->opcnt; i++) {
>                 op =3D &argp->ops[i];
>                 op->replay =3D NULL;
> +               op->opdesc =3D NULL;
> =20
>                 if (xdr_stream_decode_u32(argp->xdr, &op->opnum) < 0)
>                         return false;
>                 if (nfsd4_opnum_in_range(argp, op)) {
> +                       op->opdesc =3D OPDESC(op);
>                         op->status =3D nfsd4_dec_ops[op->opnum](argp, &op=
->u);
>                         if (op->status !=3D nfs_ok)
>                                 trace_nfsd_compound_decode_err(argp->rqst=
p,
> @@ -2490,7 +2492,7 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *ar=
gp)
>                         op->opnum =3D OP_ILLEGAL;
>                         op->status =3D nfserr_op_illegal;
>                 }
> -               op->opdesc =3D OPDESC(op);
> +
>                 /*
>                  * We'll try to cache the result in the DRC if any one
>                  * op in the compound wants to be cached:
>=20
>=20

I'm fine with that approach. In fact, that was basically what I had in
an earlier iteration of fixing this.

--=20
Jeff Layton <jlayton@kernel.org>
