Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8959176A451
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Aug 2023 00:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjGaWos (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 18:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGaWon (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 18:44:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9041BF5;
        Mon, 31 Jul 2023 15:44:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F71A6132F;
        Mon, 31 Jul 2023 22:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0ABC433C9;
        Mon, 31 Jul 2023 22:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690843446;
        bh=yMfEQxMz10YeYVrq5kAiqUPTJVeuhElSeAlUF9m51Ug=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=c6AE4ZO3XIeFcMTLntZ2MmNNrkUZENXMn+feHFS4sRM7cyxAzS5MNmLZaR8hxotXu
         zEwlqXZ85B3QmGIrg/j+cw94qWbo7iusBknpcot/DlpWrstH2cTBwpFE1HwroJpSef
         S73iT7lR+COrpyxkFtPxbj9+QFQaOeVwOWtuSzoneMxv2qa5UxJT1QL9be0Cn+kmkK
         xSFFQQcjNWPEelEwwESKIfaZP2fCKHMG5gep8vq5gdWx+ODwtAEjhdgUCvwAYUj7/L
         jxJzTYg9u0aFr8mPz823ik+RUkQ/L2KDOJkFcbNIXBAVcdiglbvW1QPYJuU21JqqPd
         ZKEqACIVBzhsg==
Message-ID: <bd3dc956d7b43f34ee458992919c5afd71abd3d3.camel@kernel.org>
Subject: Re: [PATCH RFC] nfsd: don't hand out write delegations on O_WRONLY
 opens
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 31 Jul 2023 18:44:04 -0400
In-Reply-To: <169084147821.32308.9286837678268595107@noble.neil.brown.name>
References: <20230731-wdeleg-v1-1-f8fe1ce11b36@kernel.org>
         <169084147821.32308.9286837678268595107@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-08-01 at 08:11 +1000, NeilBrown wrote:
> On Tue, 01 Aug 2023, Jeff Layton wrote:
> > I noticed that xfstests generic/001 was failing against linux-next nfsd=
.
> >=20
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
> >=20
> > Don't hand out a delegation if the client didn't request
> > OPEN4_SHARE_ACCESS_BOTH.
> >=20
> > This fixes xfstest generic/001.
> >=20
> > Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D412
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
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
> <bikeshed>
> The actual error code returned by nfs4_set_delegation() is ignored -
> only the fact of an error is relevant.
> Given that, how did you choose -EBADF.  nfsd doesn't use file
> descriptors, and doesn't use EBADF anywhere else.
> Given that you have just tested access, EACCES might be justifiable.
> But I would prefer if nfs4_set_delegation() returns NULL if it could not
> find or create a delegation, without bothering with giving a reason.
> </bikeshed>
>=20

I chose EBADF because the fcntl code uses it for similar purposes. From
the manpage:

EBADF	cmd is F_SETLK or F_SETLKW and the file descriptor open      =20
	mode doesn't match with the type of lock requested.

We're requesting a "lock" here in a delegation, so this made some sense
to me. I'm not particular here though. If another error makes more
sense, then that's fine.


> Reviewed-by: NeilBrown <neilb@suse.de>
>=20

Thanks!

> NeilBrown
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
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
