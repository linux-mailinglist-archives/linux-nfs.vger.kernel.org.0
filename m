Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A5A7F0969
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Nov 2023 23:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjKSWXz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 17:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKSWXy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 17:23:54 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BC812D
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 14:23:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EB15A21852;
        Sun, 19 Nov 2023 22:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700432628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=isUaUvNLPrV3fFbSfi6mBBRuWcEdI0ASUYoB+qW7228=;
        b=GndNlKl+rudM336rQBMMrHwK8sjwyEcQgnYvLEtGV9UAeNXjwiB8I6KtuEGG+Inx9wlHdI
        DL+g+P3qoveqHCUTn9cUP7pjLv6RugSD7Z1qH+VaZwQjwSlPkpII14CmCRd+fNbWh3kKgw
        QWImBQ1URbXXk966F0O4ZSq6AINLYKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700432628;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=isUaUvNLPrV3fFbSfi6mBBRuWcEdI0ASUYoB+qW7228=;
        b=whVpzlLPdK78Y1tcqdzbP8RAq1VWhFlbShRQT67q7fLP8zj5tqT7cmIC8DCdYH41yk9jEz
        K5mMh06ChnmttVBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1944139B7;
        Sun, 19 Nov 2023 22:23:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qrbWGPKKWmXcWgAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 19 Nov 2023 22:23:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 2/9] nfsd: avoid race after unhash_delegation_locked()
In-reply-to: <ZVfCTVTmNd0cgqcY@tissot.1015granger.net>
References: <20231117022121.23310-1-neilb@suse.de>,
 <20231117022121.23310-3-neilb@suse.de>,
 <40e3c09538c58818e5ab0c713a49d62304c4c4a0.camel@kernel.org>,
 <ZVfCTVTmNd0cgqcY@tissot.1015granger.net>
Date:   Mon, 20 Nov 2023 09:23:43 +1100
Message-id: <170043262319.19300.1603901477254585695@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
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
> On Fri, Nov 17, 2023 at 06:41:37AM -0500, Jeff Layton wrote:
> > On Fri, 2023-11-17 at 13:18 +1100, NeilBrown wrote:
> > > NFS4_CLOSED_DELEG_STID and NFS4_REVOKED_DELEG_STID are similar in
> > > purpose.
> > > REVOKED is used for NFSv4.1 states which have been revoked because the
> > > lease has expired.  CLOSED is used in other cases.
> > > The difference has two practical effects.
> > > 1/ REVOKED states are on the ->cl_revoked list
> > > 2/ REVOKED states result in nfserr_deleg_revoked from
> > >    nfsd4_verify_open_stid() asnd nfsd4_validate_stateid while
> > >    CLOSED states result in nfserr_bad_stid.
> > >=20
> > > Currently a state that is being revoked is first set to "CLOSED" in
> > > unhash_delegation_locked(), then possibly to "REVOKED" in
> > > revoke_delegation(), at which point it is added to the cl_revoked list.
> > >=20
> > > It is possible that a stateid test could see the CLOSED state
> > > which really should be REVOKED, and so return the wrong error code.  So
> > > it is safest to remove this window of inconsistency.
> > >=20
> > > With this patch, unhash_delegation_locked() always set the state
> > > correctly, and revoke_delegation() no longer changes the state.
> > >=20
> > > Also remove a redundant test on minorversion when
> > > NFS4_REVOKED_DELEG_STID is seen - it can only be seen when minorversion
> > > is non-zero.
> > >=20
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfsd/nfs4state.c | 20 ++++++++++----------
> > >  1 file changed, 10 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 6368788a7d4e..7469583382fb 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -1334,7 +1334,7 @@ static bool delegation_hashed(struct nfs4_delegat=
ion *dp)
> > >  }
> > > =20
> > >  static bool
> > > -unhash_delegation_locked(struct nfs4_delegation *dp)
> > > +unhash_delegation_locked(struct nfs4_delegation *dp, unsigned char typ=
e)
>=20
> unsigned short type ?

At this stage in the series 'type' is still an unsigned char.  I don't
want to get ahead of myself.

>=20
>=20
> > >  {
> > >  	struct nfs4_file *fp =3D dp->dl_stid.sc_file;
> > > =20
> > > @@ -1343,7 +1343,9 @@ unhash_delegation_locked(struct nfs4_delegation *=
dp)
> > >  	if (!delegation_hashed(dp))
> > >  		return false;
> > > =20
> > > -	dp->dl_stid.sc_type =3D NFS4_CLOSED_DELEG_STID;
> > > +	if (dp->dl_stid.sc_client->cl_minorversion =3D=3D 0)
> > > +		type =3D NFS4_CLOSED_DELEG_STID;
> > > +	dp->dl_stid.sc_type =3D type;
> > >  	/* Ensure that deleg break won't try to requeue it */
> > >  	++dp->dl_time;
> > >  	spin_lock(&fp->fi_lock);
> > > @@ -1359,7 +1361,7 @@ static void destroy_delegation(struct nfs4_delega=
tion *dp)
> > >  	bool unhashed;
> > > =20
> > >  	spin_lock(&state_lock);
> > > -	unhashed =3D unhash_delegation_locked(dp);
> > > +	unhashed =3D unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
> > >  	spin_unlock(&state_lock);
> > >  	if (unhashed)
> > >  		destroy_unhashed_deleg(dp);
> > > @@ -1373,9 +1375,8 @@ static void revoke_delegation(struct nfs4_delegat=
ion *dp)
> > > =20
> > >  	trace_nfsd_stid_revoke(&dp->dl_stid);
> > > =20
> > > -	if (clp->cl_minorversion) {
> > > +	if (dp->dl_stid.sc_type =3D=3D NFS4_REVOKED_DELEG_STID) {
> > >  		spin_lock(&clp->cl_lock);
> > > -		dp->dl_stid.sc_type =3D NFS4_REVOKED_DELEG_STID;
> > >  		refcount_inc(&dp->dl_stid.sc_count);
> > >  		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
> > >  		spin_unlock(&clp->cl_lock);
> > > @@ -2234,7 +2235,7 @@ __destroy_client(struct nfs4_client *clp)
> > >  	spin_lock(&state_lock);
> > >  	while (!list_empty(&clp->cl_delegations)) {
> > >  		dp =3D list_entry(clp->cl_delegations.next, struct nfs4_delegation, =
dl_perclnt);
> > > -		WARN_ON(!unhash_delegation_locked(dp));
> > > +		WARN_ON(!unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID));
> > >  		list_add(&dp->dl_recall_lru, &reaplist);
> > >  	}
> > >  	spin_unlock(&state_lock);
> > > @@ -5197,8 +5198,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct n=
fsd4_open *open,
> > >  		goto out;
> > >  	if (deleg->dl_stid.sc_type =3D=3D NFS4_REVOKED_DELEG_STID) {
> > >  		nfs4_put_stid(&deleg->dl_stid);
> > > -		if (cl->cl_minorversion)
> > > -			status =3D nfserr_deleg_revoked;
> > > +		status =3D nfserr_deleg_revoked;
> > >  		goto out;
> > >  	}
> > >  	flags =3D share_access_to_flags(open->op_share_access);
> > > @@ -6235,7 +6235,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> > >  		dp =3D list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> > >  		if (!state_expired(&lt, dp->dl_time))
> > >  			break;
> > > -		WARN_ON(!unhash_delegation_locked(dp));
> > > +		WARN_ON(!unhash_delegation_locked(dp, NFS4_REVOKED_DELEG_STID));
> > >  		list_add(&dp->dl_recall_lru, &reaplist);
> > >  	}
> > >  	spin_unlock(&state_lock);
> > > @@ -8350,7 +8350,7 @@ nfs4_state_shutdown_net(struct net *net)
> > >  	spin_lock(&state_lock);
> > >  	list_for_each_safe(pos, next, &nn->del_recall_lru) {
> > >  		dp =3D list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> > > -		WARN_ON(!unhash_delegation_locked(dp));
> > > +		WARN_ON(!unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID));
>=20
> Neil, what say we get rid of these WARN_ONs?
>=20

I've added a patch with this intro:
Author: NeilBrown <neilb@suse.de>
Date:   Mon Nov 20 09:15:46 2023 +1100

    nfsd: don't call functions with side-effecting inside WARN_ON()
   =20
    Code like:
   =20
        WARN_ON(foo())
   =20
    looks like an assertion and might not be expected to have any side
    effects.
    When testing if a function with side-effects fails a construct like
   =20
        if (foo())
           WARN_ON(1);
   =20
    makes the intent more obvious.
   =20
    nfsd has several WARN_ON calls where the test has side effects, so it
    would be good to change them.  These cases don't really need the
    WARN_ON.  They have never failed in 8 years of usage so let's just
    remove the WARN_ON wrapper.
   =20
    Suggested-by: Chuck Lever <chuck.lever@oracle.com>
    Signed-off-by: NeilBrown <neilb@suse.de>

it removes 5 WARN_ONs from unhash_delegation_locked() calls.
They were added by
 Commit 3fcbbd244ed1 ("nfsd: ensure that delegation stateid hash references a=
re only put once")
in 4.3

Thanks,
NeilBrown

>=20
> > >  		list_add(&dp->dl_recall_lru, &reaplist);
> > >  	}
> > >  	spin_unlock(&state_lock);
> >=20
> > Same question here. Should this go to stable? I guess the race is not
> > generally fatal...
>=20
> Again, there's no existing bug report, so no urgency to get this
> backported. I would see these changes soak in upstream rather than
> pull them into stable quickly only to discover another bug has been
> introduced.
>=20
> We don't have a failing test or a data corruption risk, as far as
> I can tell.
>=20
>=20
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20
> --=20
> Chuck Lever
>=20

