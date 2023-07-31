Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8A876A4EB
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Aug 2023 01:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjGaXhn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 19:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGaXhm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 19:37:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C049EE;
        Mon, 31 Jul 2023 16:37:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E599E61354;
        Mon, 31 Jul 2023 23:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C48C433C7;
        Mon, 31 Jul 2023 23:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690846659;
        bh=oP455tz/501J6ojdg0NqFIQl/IO5aRvk8q00hQauJeY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IeR1NaW581Gnj9+9ruzWMGS7gKQf4i9eT/CwrK8jWsbwgBV+A8mIdlBnAeto35ci5
         grvsKbGzY8Nn+XVvoX29E+LMKDIXqnP+MsZBCL/4riisXOUG+Nu3RG1E+C7ZJE6p+D
         DzkKA97CqUhIqg7vzzNj5ydnU5iq+qYfViJ3SqyCtHZ7Jk6UeS1vffEqCbBJMFpSxY
         DTm2P5STE7JaEZ75rOLzz9DGF0PCFihRVRrQqTPvuPAaBtgq1ar8iLk8BWoJ4XTE9K
         VWU07JQXcUfSIzAc4c4hiltf3wUesSpM3VmCL8cQY1fpFo4XT7+WKRH/9Sv2jD51eh
         i2XF2M8xM6hiw==
Message-ID: <596886b409e1f2037c507397e82fbca6a3ea685a.camel@kernel.org>
Subject: Re: [PATCH RFC] nfsd: don't hand out write delegations on O_WRONLY
 opens
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 31 Jul 2023 19:37:37 -0400
In-Reply-To: <ZMg5CrlMPsDj95Ua@tissot.1015granger.net>
References: <20230731-wdeleg-v1-1-f8fe1ce11b36@kernel.org>
         <ZMg5CrlMPsDj95Ua@tissot.1015granger.net>
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

On Mon, 2023-07-31 at 18:43 -0400, Chuck Lever wrote:
> On Mon, Jul 31, 2023 at 04:27:30PM -0400, Jeff Layton wrote:
> > I noticed that xfstests generic/001 was failing against linux-next nfsd=
.
>=20
> Only on NFSv4.2 mounts, I presume?
>=20

Correct.

>=20
> > The client would request a OPEN4_SHARE_ACCESS_WRITE open, and the serve=
r
> > would hand out a write delegation. The client would then try to use tha=
t
> > write delegation as the source stateid in a COPY or CLONE operation, an=
d
> > the server would respond with NFS4ERR_STALE.
> >=20
> > The problem is that the struct file associated with the delegation does
> > not necessarily have read permissions. It's handing out a write
> > delegation on what is effectively an O_WRONLY open. RFC 8881 states:
> >=20
> >  "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
> >   own, all opens."
> >=20
> > Given that the client didn't request any read permissions, and that nfs=
d
> > didn't check for any, it seems wrong to give out a write delegation.
>=20
> A client is, in fact, permitted to use a write delegation stateid
> in an otw READ operation. So, this makes sense to me.
>=20

Good.

>=20
> > Don't hand out a delegation if the client didn't request
> > OPEN4_SHARE_ACCESS_BOTH.
> >=20
> > This fixes xfstest generic/001.
> >=20
> > Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D412
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> I'm thinking this should be squashed into commit
> 68a593f24a35 ("NFSD: Enable write delegation support").
>=20

Sounds great to me.

>=20
> > ---
> >  fs/nfsd/nfs4state.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index ef7118ebee00..9f1c90afed72 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5462,6 +5462,8 @@ nfs4_set_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
> >  		return ERR_PTR(-EAGAIN);
> > =20
> >  	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> > +		if (!(open->op_share_access & NFS4_SHARE_ACCESS_READ))
> > +			return ERR_PTR(-EBADF);
>=20
> 			return ERR_PTR(-EAGAIN);
>=20
> might be more consistent with the other failure returns in this
> function.
>=20

Shrug, it doesn't matter much. A distinctive error is nice for debugging
purposes though.

>=20
> >  		nf =3D find_writeable_file(fp);
> >  		dl_type =3D NFS4_OPEN_DELEGATE_WRITE;
> >  	} else {
> >=20
> > ---
> > base-commit: ec89391563792edd11d138a853901bce76d11f44
> > change-id: 20230731-wdeleg-bbdb6b25a3c6
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
