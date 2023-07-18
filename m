Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10703757F13
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 16:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjGROKr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 10:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjGROKo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 10:10:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3C499
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 07:10:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D19A615D4
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 14:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87169C433C7;
        Tue, 18 Jul 2023 14:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689689441;
        bh=9c3C988jkDd8Kk8czKP2cZc21cuxnAg2V93BFXTPbiw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kexSai0lKnvhCqAOdBquGAvILYBDMREiFxFPQBr9YeqSSHQHMuUIDec8yOIEciRT0
         020khcMkw4CAYGp83K0+RNr3S/YiBjyss9c3KWVI4x37oS5zIW7587ZDR0EV89Z+p7
         A2Zy0u3Thp9NcOnl/3tMdKsSeAxUsscDCjh9+hbh7jJGhKDY9af1DMC0sVj0bdFRxC
         DMShmOEHPy/CKc2IF8J2d/SM8pTUckz2J75f7NqLFRwKJEjimLhH8mPk4WgqXHAaM6
         yVat+U/3gRG0fINffMJerKGw5qfrECRo/4GGFdP2GvdGZtcVl8o7v19w3HEFtJKPs2
         149J+kJQI6P5g==
Message-ID: <916ec4f1999cdb2ff358d7cbfc69f3bbe7f4f2fc.camel@kernel.org>
Subject: Re: [PATCH] nfsd: Remove incorrect check in nfsd4_validate_stateid
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 18 Jul 2023 10:10:40 -0400
In-Reply-To: <106daf5e0242b67bdb04e2e8e4ae7e114a4b47ab.camel@kernel.org>
References: <20230718123837.124780-1-trondmy@kernel.org>
         <6dc89e4859a6851773bc2931d919e1cb204ae690.camel@kernel.org>
         <106daf5e0242b67bdb04e2e8e4ae7e114a4b47ab.camel@kernel.org>
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

On Tue, 2023-07-18 at 09:51 -0400, Trond Myklebust wrote:
> On Tue, 2023-07-18 at 09:35 -0400, Jeff Layton wrote:
> > On Tue, 2023-07-18 at 08:38 -0400, trondmy@kernel.org=A0wrote:
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > >=20
> > > If the client is calling TEST_STATEID, then it is because some
> > > event
> > > occurred that requires it to check all the stateids for validity
> > > and
> > > call FREE_STATEID on the ones that have been revoked. In this case,
> > > either the stateid exists in the list of stateids associated with
> > > that
> > > nfs4_client, in which case it should be tested, or it does not.
> > > There
> > > are no additional conditions to be considered.
> > >=20
> > > Reported-by: Frank Ch. Eigler <fche@redhat.com>
> > > Fixes: 663e36f07666 ("nfsd4: kill warnings on testing stateids with
> > > mismatched clientids")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > ---
> > > =A0fs/nfsd/nfs4state.c | 2 --
> > > =A01 file changed, 2 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 6e61fa3acaf1..3aefbad4cc09 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -6341,8 +6341,6 @@ static __be32 nfsd4_validate_stateid(struct
> > > nfs4_client *cl, stateid_t *stateid)
> > > =A0=A0=A0=A0=A0=A0=A0=A0if (ZERO_STATEID(stateid) || ONE_STATEID(stat=
eid) ||
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0CLOSE_STATEID(stateid=
))
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return status;
> > > -=A0=A0=A0=A0=A0=A0=A0if (!same_clid(&stateid->si_opaque.so_clid, &cl=
-
> > > > cl_clientid))
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return status;
> > > =A0=A0=A0=A0=A0=A0=A0=A0spin_lock(&cl->cl_lock);
> > > =A0=A0=A0=A0=A0=A0=A0=A0s =3D find_stateid_locked(cl, stateid);
> > > =A0=A0=A0=A0=A0=A0=A0=A0if (!s)
> >=20
> > IDGI. Is this fixing an actual bug? Granted this code does seem
> > unnecessary, but removing it doesn't seem like it will cause any
> > user-visible change in behavior. Am I missing something?
>=20
> It was clearly triggering in
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2176575
>=20
> Furthermore, if you look at commit 663e36f07666, you'll see that all it
> does is remove the log message because "it is expected". For some
> unknown reason, it did not register that "then the check is incorrect".
>=20

Yeah, that commit just removes the warning, AFAICT.

> So yes, this is fixing a real bug.
>=20

My assumption was that for any stateid that the server hands out, the
si_opaque.so_clid must match the clid. But...it looks like s2s copy
might have changed that rule?

In any case, the patch looks fine, so I have no objection. I'm just
trying to understand how this could happen.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
