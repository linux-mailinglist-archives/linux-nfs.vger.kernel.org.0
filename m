Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8344A660DF6
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 11:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjAGKja (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Jan 2023 05:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjAGKjJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 05:39:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F543750D
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 02:39:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E5B41284D0;
        Sat,  7 Jan 2023 10:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673087945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JVoXa0uopszjpLRHQ+xr6QEUPhX4WigZdmGptVfO108=;
        b=i1g/OEIGGk/RC5EFq7Ym+7o7m1rAlm1mjLgzJdrOObCwP26HCHa9Y/ic6VghADGT/jKYvh
        yzj0d/PCKkoetwPz9yZTvVhC71qVok8hA5iWXUitfaUN57JyYtKgL7nqX26Z71AkGlMJi0
        SY+oHnraB4vgeL9xB75mfBr0rfx6rGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673087945;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JVoXa0uopszjpLRHQ+xr6QEUPhX4WigZdmGptVfO108=;
        b=m77LLxA5ZkTL8t/YKbyDiwTgfabbofsxFWhp7EglGhmgI3T7PuU1j0CfZ/Ot+c201oufsT
        FSYXXOneSB2nB1BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A922D134AD;
        Sat,  7 Jan 2023 10:39:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /moEF8hLuWOVWAAAMHmgww
        (envelope-from <neilb@suse.de>); Sat, 07 Jan 2023 10:39:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix potential race in nfs4_find_file
In-reply-to: <be0ef41fc2d62fb11d731754833d68e424a422ee.camel@kernel.org>
References: <20230105121823.21935-1-jlayton@kernel.org>,
 <167295993121.13974.8791979932693514625@noble.neil.brown.name>,
 <be0ef41fc2d62fb11d731754833d68e424a422ee.camel@kernel.org>
Date:   Sat, 07 Jan 2023 21:39:00 +1100
Message-id: <167308794099.13974.13553898791665084113@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 06 Jan 2023, Jeff Layton wrote:
> On Fri, 2023-01-06 at 10:05 +1100, NeilBrown wrote:
> > On Thu, 05 Jan 2023, Jeff Layton wrote:
> > > Even though there is a WARN_ON_ONCE check, it seems possible for
> > > nfs4_find_file to race with the destruction of an fi_deleg_file while
> > > trying to take a reference to it.
> > >=20
> > > put_deleg_file is done while holding the fi_lock. Take and hold it
> > > when dealing with the fi_deleg_file in nfs4_find_file.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/nfs4state.c | 16 ++++++++++------
> > >  1 file changed, 10 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index b68238024e49..3df3ae84bd07 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -6417,23 +6417,27 @@ nfsd4_lookup_stateid(struct nfsd4_compound_stat=
e *cstate,
> > >  static struct nfsd_file *
> > >  nfs4_find_file(struct nfs4_stid *s, int flags)
> > >  {
> > > +	struct nfsd_file *ret =3D NULL;
> > > +
> > >  	if (!s)
> > >  		return NULL;
> > > =20
> > >  	switch (s->sc_type) {
> > >  	case NFS4_DELEG_STID:
> > > -		if (WARN_ON_ONCE(!s->sc_file->fi_deleg_file))
> > > -			return NULL;
> > > -		return nfsd_file_get(s->sc_file->fi_deleg_file);
> > > +		spin_lock(&s->sc_file->fi_lock);
> > > +		if (!WARN_ON_ONCE(!s->sc_file->fi_deleg_file))
> > > +			ret =3D nfsd_file_get(s->sc_file->fi_deleg_file);
> > > +		spin_unlock(&s->sc_file->fi_lock);
> > > +		break;
> >=20
> > As an nfsd_file is freed with rcu, we don't need the spinlock.
> >=20
> >  rcu_read_lock()
> >  ret =3D rcu_dereference(s->sc_file->fi_deleg_file);
> >  if (ret)
> > 	ret =3D nfsd_file_get(ret);
> >  rcu_read_unlock();
> >=20
> > You could even put the NULL test in nfsd_file_get() and have:
> >=20
> >  rcu_read_lock()l;
> >  ret =3D nfsd_file_get(rcu_dereference(s->sc_file->fi_deleg_file));
> >  rcu_read_unlock();
> >=20
> > but that might not be a win.
> >=20
> > I agree with Chuck that the WARNing isn't helpful.
> >=20
> > NeilBrown
> >=20
>=20
> Ok, I took a look at this.
>=20
> To do it right, we'd need to annotate the fi_deleg_file field with
> __rcu. That means we'd need to clean up a bunch of existing
> fi_deleg_file accesses to properly use rcu_dereference_protected.
>=20
> This is probably worthwhile stuff to do, but it's a larger patch series
> and will touch a bunch of unrelated delegation handling. At this point,
> I think I'd rather just keep the spinlocking here since that should be
> safe. Cleaning up delegation handling is a longer-term project that I'd
> rather table for now.

That all seems very sensible - thank for looking into it.

NeilBrown


>=20
> I will remove the WARN_ON_ONCE though, and I think allowing
> nfsd_file_get to accept a NULL pointer is probably a good thing too.
> I'll resend a new series in a bit.
>=20
> >=20
> > >  	case NFS4_OPEN_STID:
> > >  	case NFS4_LOCK_STID:
> > >  		if (flags & RD_STATE)
> > > -			return find_readable_file(s->sc_file);
> > > +			ret =3D find_readable_file(s->sc_file);
> > >  		else
> > > -			return find_writeable_file(s->sc_file);
> > > +			ret =3D find_writeable_file(s->sc_file);
> > >  	}
> > > =20
> > > -	return NULL;
> > > +	return ret;
> > >  }
> > > =20
> > >  static __be32
> > > --=20
> > > 2.39.0
> > >=20
> > >=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
