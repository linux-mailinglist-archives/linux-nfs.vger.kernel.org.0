Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554B8613DA3
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 19:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJaSq4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 14:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaSqz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 14:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8C913E22
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 11:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 467166139D
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 18:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443EFC433D6;
        Mon, 31 Oct 2022 18:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667242013;
        bh=WinFrCW4guSxsaIUGTuwhZSEFqgqNyIXwhHclVWLETs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TSIJqDAztPYzGfQM56kxuCEsbDHGld24tx/v/hTLPZZsin46dMu9D2ctrUuP15XYN
         qIstuBQl/8UMwDBm88R3FiMF1Etdy1iVILBOW5NJVZI7VtMp1pMSEf/4TEHXWFzasn
         2YFRo/GAPlfwLvmNMyRH7cKA1/7ShxE8DAyiYtzqHIGCqELYUa+78MfIxvo/uC8mQ0
         rmi1ouhgXERsa+XLF/j1wft1Xyue7QWJC4RQOLEu3907jNtMG3MtXmY7J4LHKIfDhA
         zbchgAoFaBlsYq5TkIuyg1EIgfJQxsVJyU8qp7dIB7fMtA7vrhfQdWPMR5zsfNj+Mg
         IoPL/S9bOdIcA==
Message-ID: <433f431a3684eb296a62f8f3cdbf34e185a5a84d.camel@kernel.org>
Subject: Re: [PATCH v2] nfsd: fix net-namespace logic in
 __nfsd_file_cache_purge
From:   Jeff Layton <jlayton@kernel.org>
To:     Petr Vorel <pvorel@suse.cz>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 31 Oct 2022 14:46:51 -0400
In-Reply-To: <Y2AXrMEim07Y0LLY@pevik>
References: <20221031154921.500620-1-jlayton@kernel.org>
         <BCEEEF05-11E3-4E31-BDE1-DDCA65A5AB6F@oracle.com> <Y2AXrMEim07Y0LLY@pevik>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-10-31 at 19:45 +0100, Petr Vorel wrote:
>=20
> > > On Oct 31, 2022, at 11:49 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> > > If the namespace doesn't match the one in "net", then we'll continue,
> > > but that doesn't cause another rhashtable_walk_next call, so it will
> > > loop infinitely.
>=20
> > > Fixes: ce502f81ba88 ("NFSD: Convert the filecache to use rhashtable")
> > > Reported-by: Petr Vorel <pvorel@suse.cz>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > fs/nfsd/filecache.c | 5 ++---
> > > 1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> > Thank you! Applied and pushed to for-rc. I'll send a PR in a few days.
>=20
> Thanks for a quick action!
>=20

No problem.=20

> What a shame you didn't put link to the report, which contains reproducer=
.
> https://lore.kernel.org/ltp/Y1%2FP8gDAcWC%2F+VR3@pevik/
>=20
> Kind regards,
> Petr
>=20

Chuck, could you add that link to the changelog when you merge it?

Thanks,
Jeff

> > > The v1 patch applies cleanly to v6.0, but not to Chuck's for-next
> > > branch. This one should be suitable there.
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index 98c6b5f51bc8..4a8aa7cd8354 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -890,9 +890,8 @@ __nfsd_file_cache_purge(struct net *net)
>=20
> > > 		nf =3D rhashtable_walk_next(&iter);
> > > 		while (!IS_ERR_OR_NULL(nf)) {
> > > -			if (net && nf->nf_net !=3D net)
> > > -				continue;
> > > -			nfsd_file_unhash_and_dispose(nf, &dispose);
> > > +			if (!net || nf->nf_net =3D=3D net)
> > > +				nfsd_file_unhash_and_dispose(nf, &dispose);
> > > 			nf =3D rhashtable_walk_next(&iter);
> > > 		}
>=20
> > > --=20
> > > 2.38.1

--=20
Jeff Layton <jlayton@kernel.org>
