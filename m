Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCAF7F0949
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 23:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjKSWHw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 17:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjKSWHw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 17:07:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A3B136
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 14:07:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 019521F381;
        Sun, 19 Nov 2023 22:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700431667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=seU1cGDLq3xypSaM+C5k6FGNvKJei/YH+vW1GQsp4/M=;
        b=T6EsVNlWYzLwT2jncEZbDA1151MLhICvJcgugEcnshJctioRcd6tGckUIC3GzHfO0Kc4K0
        8JQczoUxBj4P1tu41eYFRPiBaRPTlL7RUnRtriMYM97jzpYZbgKvEnqM27QOJxRaKhNt5L
        MU7t8/SbliJz3NE9rRZGzDZnxlYQStw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700431667;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=seU1cGDLq3xypSaM+C5k6FGNvKJei/YH+vW1GQsp4/M=;
        b=Z5dw9LRNIjMAiSxc0aPaulHsB1OmPJfqaA3up0h2nurlHxUAoaY44vyBAwD20s3ax5jzUH
        lub7bjEKEPwTJuAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6BFA139B7;
        Sun, 19 Nov 2023 22:07:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LbjoHTCHWmWOVAAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 19 Nov 2023 22:07:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 1/9] nfsd: hold ->cl_lock for hash_delegation_locked()
In-reply-to: <ZVeA82rMFJL27OoN@tissot.1015granger.net>
References: <20231117022121.23310-1-neilb@suse.de>,
 <20231117022121.23310-2-neilb@suse.de>,
 <ZVeA82rMFJL27OoN@tissot.1015granger.net>
Date:   Mon, 20 Nov 2023 09:07:41 +1100
Message-id: <170043166163.19300.15300340757194691794@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 3.40
X-Spamd-Result: default: False [3.40 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM_SHORT(3.00)[0.999];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_SPAM_LONG(3.50)[1.000];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 18 Nov 2023, Chuck Lever wrote:
> On Fri, Nov 17, 2023 at 01:18:47PM +1100, NeilBrown wrote:
> > The protocol for creating a new state in nfsd is to allocated the state
> > leaving it largely uninitialised, add that state to the ->cl_stateids
> > idr so as to reserve a state id, then complete initialisation of the
> > state and only set ->sc_type to non-zero once the state is fully
> > initialised.
> >=20
> > If a state is found in the idr with ->sc_type =3D=3D 0, it is ignored.
> > The ->cl_lock list is used to avoid races - it is held while checking
>=20
> s/->cl_lock list/->cl_lock lock
>=20
>=20
> > sc_type during lookup,
>=20
> In particular, find_stateid_locked(), but yet, not in nfs4_find_file()
>=20
> Can you help me understand why it's not needed in the latter case?

nfs4_find_file() is called from nfs4_check_file() which is called from
nfs4_preprocess_stateid_op(), which gets the nfs4_stid from
nfsd4_lookup_stateid().
That in turn gets the stateid from find_stateid_by_type() which gets it
from find_stateid_locked().

If find_stateid_locked() returns a stateid, then ->sc_type is not 0, and
it can never be set to zero (At least after subsequent patches land).

Or, more succinctly, nfs4_find_file() does not do lookup, so it doesn't
check sc_type against zero, so it doesn't need a lock.

>=20
>=20
> > and held when a non-zero value is stored in  ->sc_type.
>=20
> I see a few additional spots where an sc_type value is set and
> cl_lock is not held:
>=20
> init_open_stateid

 ->cl_lock is taken 9 lines before NFS4_OPEN_STID is assigned to
  >sc_type, and it is dropped 13 lines later.

> nfsd4_process_open2

This assignment does not change from zero to non-zero.  So it cannot
race with lookup, which tests for zero.
A later patch changes this assignment to be a change to the new
sc_status.

>=20
>=20
> > ... except... hash_delegation_locked() finalises the initialisation of a
> > delegation state, but does NOT hold ->cl_lock.
> >=20
> > So this patch takes ->cl_lock at the appropriate time w.r.t other locks,
> > and so ensures there are no races (which are extremely unlikely in any
> > case).
>=20
> I would have expected that cl_lock should be taken first. Can the
> patch description provide some rationale for the lock ordering
> you chose?

I've added

As ->fi_lock is often taken when ->cl_lock is held, we need to take
->cl_lock first of those two.
Currently ->cl_lock and state_lock are never both taken at the same time.
We need both for this patch so an arbitrary choice is needed concerning
which to take first.  As state_lock is more global, it might be more
contended, so take it first.


I'm happy to choose a different ordering for ->cl_lock and state_lock if
you have a different justification - I accept that mine isn't
particularly strong.

>=20
> Jeff asks in another email whether this fix should get copied to
> stable. Since the race is unlikely, I'm inclined to wait for an
> explicit problem report.

I agree.

Thanks,
NeilBrown


>=20
>=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 65fd5510323a..6368788a7d4e 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1317,6 +1317,7 @@ hash_delegation_locked(struct nfs4_delegation *dp, =
struct nfs4_file *fp)
> > =20
> >  	lockdep_assert_held(&state_lock);
> >  	lockdep_assert_held(&fp->fi_lock);
> > +	lockdep_assert_held(&clp->cl_lock);
> > =20
> >  	if (nfs4_delegation_exists(clp, fp))
> >  		return -EAGAIN;
> > @@ -5609,12 +5610,14 @@ nfs4_set_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
> >  		goto out_unlock;
> > =20
> >  	spin_lock(&state_lock);
> > +	spin_lock(&clp->cl_lock);
> >  	spin_lock(&fp->fi_lock);
> >  	if (fp->fi_had_conflict)
> >  		status =3D -EAGAIN;
> >  	else
> >  		status =3D hash_delegation_locked(dp, fp);
> >  	spin_unlock(&fp->fi_lock);
> > +	spin_unlock(&clp->cl_lock);
> >  	spin_unlock(&state_lock);
> > =20
> >  	if (status)
> > --=20
> > 2.42.0
> >=20
>=20
> --=20
> Chuck Lever
>=20

