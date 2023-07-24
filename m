Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A9B75FBD3
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 18:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjGXQVv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 12:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGXQVv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 12:21:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B13510C8;
        Mon, 24 Jul 2023 09:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CE0261200;
        Mon, 24 Jul 2023 16:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEA6C433C8;
        Mon, 24 Jul 2023 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690215709;
        bh=ofINXhEcixn1JUJZkatETIjZs/9QKdfI2nw3ECBI5ic=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nJejhWMVSUw1u5v6oOCzA4VvuG89LWLkJVKCrPlQdrxG+nPAoPQEctFYYnpGKteBo
         XwdWhMWIA47s9u+GHCZgkzpL8dpEQKyZG3t3/UVr3hLyDp/9SUxprLShQBWUuEf5Fw
         ByS1ZDokQ70L75mD+gE9vY/Orf1qT12A0Gt8WRc4r68nwIn2l1Pq2sxYsM2DrwqXct
         s8+iIpYi7Cs0ZNbeUEAi4WoNVpFNFM+Cr1N+yeiAqjj2DnaFlH6dmIck6IvKOhL2CK
         kM5ri7y3XV7YnXo6EQeNQjuABVRC4GhUPPxKeNsNGYZd6GP2Ih+kZORDqFsCGDaeTS
         iR62zWP0SaAhA==
Message-ID: <969a2ddc66df3ba05952fb14352ccee08bd84149.camel@kernel.org>
Subject: Re: [PATCH RFC] nfsd: set missing after_change as before_change + 1
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Jul 2023 12:21:47 -0400
In-Reply-To: <ZL6W0GqBSdlvVL2Y@tissot.1015granger.net>
References: <20230724-bz2223560-v1-1-b6da868c0fc6@kernel.org>
         <ZL6W0GqBSdlvVL2Y@tissot.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Mon, 2023-07-24 at 11:20 -0400, Chuck Lever wrote:
> On Mon, Jul 24, 2023 at 10:53:39AM -0400, Jeff Layton wrote:
> > In the event that we can't fetch post_op_attr attributes, we still need
> > to set a value for the after_change. The operation has already happened=
,
> > so we're not able to return an error at that point, but we do want to
> > ensure that the client knows that its cache should be invalidated.
> >=20
> > If we weren't able to fetch post-op attrs, then just set the
> > after_change to before_change + 1. The atomic flag should already be
> > clear in this case.
> >=20
> > Suggested-by: Neil Brown <neilb@suse.de>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfs4proc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> I'm not sure this change makes any difference. The client would
> possibly see the change value move forward then back. I'd think a
> false "atomic" field and using the /same/ pre- and post-change would
> be safer...?
>=20
> But I'm intrigued enough to apply this to nfsd-next provisionally,
> at least for testing and further review. It will appear a little
> later today.
>=20
>=20

Thanks. I think there really are no great choices here.

This is a rather unlikely error case that should only come into play
when there are problems with the underlying filesystem, but only when
fetching the post-op attrs.

We don't have a way to just opt out of providing a post-op attribute and
I think this is probably the least bad option of what to put in there.

> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 3f6710c9c5c9..f0f318e78630 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -411,7 +411,7 @@ set_change_info(struct nfsd4_change_info *cinfo, st=
ruct svc_fh *fhp)
> >  	if (WARN_ON_ONCE(!fhp->fh_pre_saved))
> >  		cinfo->before_change =3D 0;
> >  	if (!fhp->fh_post_saved)
> > -		cinfo->after_change =3D 0;
> > +		cinfo->after_change =3D cinfo->before_change + 1;
> >  }
> > =20
> >  static __be32
> >=20
> > ---
> > base-commit: 97a5d0146ef443df148805a4e9c3c44111f14ab1
> > change-id: 20230724-bz2223560-5ed6bc3a5db7
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
