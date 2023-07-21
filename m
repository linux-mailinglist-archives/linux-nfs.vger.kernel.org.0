Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7B775D004
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 18:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjGUQuR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 12:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGUQuQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 12:50:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB68ED;
        Fri, 21 Jul 2023 09:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D7BD61D4E;
        Fri, 21 Jul 2023 16:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCF4C433C9;
        Fri, 21 Jul 2023 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689958214;
        bh=mQU7Wkq/57BlFhaTQjhs2F0m+cSWKxeKpX063RD5X0s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=c0pY93/OuIZ5yhMVy+tz+CqP3YaeAwh+x8IaN6ayJ3lzBmQPMx0vMlFMmC+TJJyiv
         0qvL91SjQCJ3TV43jtUgPvu3nANN0FLRkb5umH9jAisuSPAar2i06cgT+VjGS9NGf4
         Ut5SQ6tBB5FK41fcAJySiT0THk9LgtCA/OkUk6pUSCloGItP7EPKcc5+4IiFyszdkQ
         14CkjjbuEGaW97LWFwqLvg+ks+rsk2LZk6lYn4+Qftz972iyQCf/0zSPiNk5HqZvBr
         HPVBlr2dbsD9g5NdY7oz9QlWCDR963Df+XXr4w40KbrWu4TFgpDc2q3k+WzP+qeC0n
         dU5iEAOuKqUPw==
Message-ID: <38c7c0f4a7578fb9852e19d7c7b4bf3fadb2cc9b.camel@kernel.org>
Subject: Re: [PATCH] nfsd: better conform to setfacl's method for setting
 missing ACEs
From:   Jeff Layton <jlayton@kernel.org>
To:     Andreas =?ISO-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 21 Jul 2023 12:50:12 -0400
In-Reply-To: <CAHpGcM+JCXu6TVrt+-woHCRFTKD2Dr_x6Xp0n4fw9aJHScbbMw@mail.gmail.com>
References: <20230721142642.45871-1-jlayton@kernel.org>
         <CAHpGcM+JCXu6TVrt+-woHCRFTKD2Dr_x6Xp0n4fw9aJHScbbMw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-07-21 at 18:29 +0200, Andreas Gr=FCnbacher wrote:
> Am Fr., 21. Juli 2023 um 16:26 Uhr schrieb Jeff Layton <jlayton@kernel.or=
g>:
> > Andreas pointed out that the way we're setting missing ACEs doesn't
> > quite conform to what setfacl does. Change it to better conform to
> > how setfacl does this.
>=20
> Thanks, this looks reasonable.
>=20
> Andreas
>=20
> > Cc: Andreas Gr=FCnbacher <andreas.gruenbacher@gmail.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfs4acl.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >=20
> > Chuck, it might be best to fold this into the original patch, if it
> > looks ok.
> >=20
> > diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
> > index 64e45551d1b6..9ec61bd0e11b 100644
> > --- a/fs/nfsd/nfs4acl.c
> > +++ b/fs/nfsd/nfs4acl.c
> > @@ -742,14 +742,15 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_ac=
l *acl,
> >          *  no owner, owning group, or others entry,  a  copy of  the  =
ACL
> >          *  owner, owning group, or others entry is added to the Defaul=
t ACL."
> >          *
> > -        * If none of the requisite ACEs were set, and some explicit us=
er or group
> > -        * ACEs were, copy the requisite entries from the effective set=
.
> > +        * Copy any missing ACEs from the effective set.
> >          */
> > -       if (!default_acl_state.valid &&
> > -           (default_acl_state.users->n || default_acl_state.groups->n)=
) {
> > -               default_acl_state.owner =3D effective_acl_state.owner;
> > -               default_acl_state.group =3D effective_acl_state.group;
> > -               default_acl_state.other =3D effective_acl_state.other;
> > +       if (default_acl_state.users->n || default_acl_state.groups->n) =
{

I think we probably need to also do this if any "valid" bits are set.
IOW, if we explicitly set a default entry only for OWNER@, we also need
ACEs for group and other.

I'll send another revision in a bit. This time, I'll just resend an
updated patch of the original instead of a patch on a patch.

Sorry for the churn!

> > +               if (!(default_acl_state.valid & ACL_USER_OBJ))
> > +                       default_acl_state.owner =3D effective_acl_state=
.owner;
> > +               if (!(default_acl_state.valid & ACL_GROUP_OBJ))
> > +                       default_acl_state.group =3D effective_acl_state=
.group;
> > +               if (!(default_acl_state.valid & ACL_OTHER))
> > +                       default_acl_state.other =3D effective_acl_state=
.other;
> >         }
> >=20
> >         *pacl =3D posix_state_to_acl(&effective_acl_state, flags);
> > --
> > 2.41.0
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
