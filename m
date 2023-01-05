Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0482165F555
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Jan 2023 21:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjAEUoE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 15:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjAEUoD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 15:44:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7475515FD7
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 12:44:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31113B81BEE
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 20:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D3BC433EF;
        Thu,  5 Jan 2023 20:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672951440;
        bh=XMYcM9VPImEnwOKbdQY90gO5LhgEDZBkPFGffz6YFIQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QgcrsNvQZtOSDFkrsp5UF2atD//9OH5f1QeB/pp4Nf7V/mNVy701+CCUBSZNX/eN7
         ooKA8Pbhm7bzoeHNRAqVGCEVGZHpsbQ2F/j1s0CMpArzbr+y/unkzVntA8f1W/0ezH
         gUuFI5H6Dt26bCe2VdRWQhTjM0pRM3vpZ6XwmP0pDahxcmCF9m9q4zpUcgE1AZ2vXY
         bDFBowh+mQka7X3ROjuL+WdhnNVwjbf4s41dQyz1Hx4duhcxT7gUSNRYlE9rFjfVLZ
         8nJ59WPwZL271kZfR2eNBFIBm+8ks9oJW/ast8ZNia3q+EqvDAnEl39ACc/jpQaAEh
         RJpTD+v1gYxWw==
Message-ID: <6ef7caa1b21f7fc2edf2722e504c1b18ff3a6023.camel@kernel.org>
Subject: Re: [PATCH] nfsd: fix potential race in nfs4_find_file
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 05 Jan 2023 15:43:58 -0500
In-Reply-To: <4255172A-EFB5-48B4-B2EF-700C10862427@oracle.com>
References: <20230105121823.21935-1-jlayton@kernel.org>
         <4255172A-EFB5-48B4-B2EF-700C10862427@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-01-05 at 14:46 +0000, Chuck Lever III wrote:
>=20
> > On Jan 5, 2023, at 7:18 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > Even though there is a WARN_ON_ONCE check, it seems possible for
> > nfs4_find_file to race with the destruction of an fi_deleg_file while
> > trying to take a reference to it.
> >=20
> > put_deleg_file is done while holding the fi_lock. Take and hold it
> > when dealing with the fi_deleg_file in nfs4_find_file.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > fs/nfsd/nfs4state.c | 16 ++++++++++------
> > 1 file changed, 10 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index b68238024e49..3df3ae84bd07 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -6417,23 +6417,27 @@ nfsd4_lookup_stateid(struct nfsd4_compound_stat=
e *cstate,
> > static struct nfsd_file *
> > nfs4_find_file(struct nfs4_stid *s, int flags)
> > {
> > +	struct nfsd_file *ret =3D NULL;
> > +
> > 	if (!s)
> > 		return NULL;
> >=20
> > 	switch (s->sc_type) {
> > 	case NFS4_DELEG_STID:
> > -		if (WARN_ON_ONCE(!s->sc_file->fi_deleg_file))
> > -			return NULL;
> > -		return nfsd_file_get(s->sc_file->fi_deleg_file);
> > +		spin_lock(&s->sc_file->fi_lock);
> > +		if (!WARN_ON_ONCE(!s->sc_file->fi_deleg_file))
>=20
> You'd think this would be a really really hard race to hit.
>=20
> What I'm wondering, though, is whether the WARN_ON_ONCE should
> be dropped by this patch. I've never seen it fire.
>=20
>=20

I have:

    https://bugzilla.redhat.com/show_bug.cgi?id=3D1997177

It's possible though that those WARNs are fallout from other bugs in the
delegation handling, but it's hard to know for sure. I think we ought to
keep it there for now.

> > +			ret =3D nfsd_file_get(s->sc_file->fi_deleg_file);
> > +		spin_unlock(&s->sc_file->fi_lock);
> > +		break;
> > 	case NFS4_OPEN_STID:
> > 	case NFS4_LOCK_STID:
> > 		if (flags & RD_STATE)
> > -			return find_readable_file(s->sc_file);
> > +			ret =3D find_readable_file(s->sc_file);
> > 		else
> > -			return find_writeable_file(s->sc_file);
> > +			ret =3D find_writeable_file(s->sc_file);
> > 	}
> >=20
> > -	return NULL;
> > +	return ret;
> > }
> >=20
> > static __be32
> > --=20
> > 2.39.0
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
