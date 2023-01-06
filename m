Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E0265FFDA
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jan 2023 12:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjAFL6T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Jan 2023 06:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjAFL6S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Jan 2023 06:58:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76849718B7
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 03:58:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1120B61DA4
        for <linux-nfs@vger.kernel.org>; Fri,  6 Jan 2023 11:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08254C433EF;
        Fri,  6 Jan 2023 11:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673006296;
        bh=e6alipnVSn42TfsYJRlbhdkpIidYHq6dTGQaEQZ8Unw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dbQ9aDxY5EOq1mrsnnR31wB9PYCwMhe6XlXb/H/rirgl9G7OLJlZWdztmrYWzvMSP
         QgimbxPvyvCZGBxpcOBuHdvPmcnNHb4MBQn442/J3G3blP+zj5G8QTljjg/Rw5a6nb
         LNgIg6Zqh714BOTrOB8RxHcJIAMLstkU7k07gEyfiFy5b2tfdQNnNHwJ2VizYc3xTh
         JW0DV6N3PjMl4cVfeV0A33opNgjCBecxQiB7SutCdq8QV5mjjVkb8YnzBTI7jyt9pP
         GUx5LP+eOHsrvjVWp8z07nCc4QaBNH73dCcxKc2FBxhDoL9Y/EvWYnIYRx/E3deYo1
         h5D8w//3g3lmA==
Message-ID: <0c8bdc346321b24e551306ff0998e1712f5e4199.camel@kernel.org>
Subject: Re: [PATCH] nfsd: fix potential race in nfs4_find_file
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Date:   Fri, 06 Jan 2023 06:58:14 -0500
In-Reply-To: <167295993121.13974.8791979932693514625@noble.neil.brown.name>
References: <20230105121823.21935-1-jlayton@kernel.org>
         <167295993121.13974.8791979932693514625@noble.neil.brown.name>
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

On Fri, 2023-01-06 at 10:05 +1100, NeilBrown wrote:
> On Thu, 05 Jan 2023, Jeff Layton wrote:
> > Even though there is a WARN_ON_ONCE check, it seems possible for
> > nfs4_find_file to race with the destruction of an fi_deleg_file while
> > trying to take a reference to it.
> >=20
> > put_deleg_file is done while holding the fi_lock. Take and hold it
> > when dealing with the fi_deleg_file in nfs4_find_file.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfs4state.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index b68238024e49..3df3ae84bd07 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -6417,23 +6417,27 @@ nfsd4_lookup_stateid(struct nfsd4_compound_stat=
e *cstate,
> >  static struct nfsd_file *
> >  nfs4_find_file(struct nfs4_stid *s, int flags)
> >  {
> > +	struct nfsd_file *ret =3D NULL;
> > +
> >  	if (!s)
> >  		return NULL;
> > =20
> >  	switch (s->sc_type) {
> >  	case NFS4_DELEG_STID:
> > -		if (WARN_ON_ONCE(!s->sc_file->fi_deleg_file))
> > -			return NULL;
> > -		return nfsd_file_get(s->sc_file->fi_deleg_file);
> > +		spin_lock(&s->sc_file->fi_lock);
> > +		if (!WARN_ON_ONCE(!s->sc_file->fi_deleg_file))
> > +			ret =3D nfsd_file_get(s->sc_file->fi_deleg_file);
> > +		spin_unlock(&s->sc_file->fi_lock);
> > +		break;
>=20
> As an nfsd_file is freed with rcu, we don't need the spinlock.
>=20
>  rcu_read_lock()
>  ret =3D rcu_dereference(s->sc_file->fi_deleg_file);
>  if (ret)
> 	ret =3D nfsd_file_get(ret);
>  rcu_read_unlock();
>=20
> You could even put the NULL test in nfsd_file_get() and have:
>=20
>  rcu_read_lock()l;
>  ret =3D nfsd_file_get(rcu_dereference(s->sc_file->fi_deleg_file));
>  rcu_read_unlock();
>=20
> but that might not be a win.
>=20
> I agree with Chuck that the WARNing isn't helpful.
>=20
>=20

Good point. I'll send a v2 set in a bit.

>=20
> >  	case NFS4_OPEN_STID:
> >  	case NFS4_LOCK_STID:
> >  		if (flags & RD_STATE)
> > -			return find_readable_file(s->sc_file);
> > +			ret =3D find_readable_file(s->sc_file);
> >  		else
> > -			return find_writeable_file(s->sc_file);
> > +			ret =3D find_writeable_file(s->sc_file);
> >  	}
> > =20
> > -	return NULL;
> > +	return ret;
> >  }
> > =20
> >  static __be32
> > --=20
> > 2.39.0
> >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
