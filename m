Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D887F09E2
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 00:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjKSXmD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 18:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjKSXmC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 18:42:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B495B8
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 15:41:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 84E99218F0;
        Sun, 19 Nov 2023 23:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700437317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FKWvpIFwXUL0jC0qOJX7qta5V8oK+eGoE06hJqTzW2E=;
        b=JBWylqI+QMVvscAQWT3y0+vaXGAVIzQq/3M5cAjFrdoJocxPWiSu7Hifk/ancOImJ0fmdH
        DN7SJkU2GX52jhwnk5DS1avtFisCgcSp6alHwStUsGFb/OQ8SwsiWyl0ptH6+Ljw0DrAPM
        EjutSrmOb6vh/1RZxlTsAS4F/sVEp14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700437317;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FKWvpIFwXUL0jC0qOJX7qta5V8oK+eGoE06hJqTzW2E=;
        b=aokmubtgwVhYyhkQ8ep9hD8dVa7IMTX71sIcTroNhu87OVlG0jK7VRKAXLriSrTviqhFKZ
        FWrI0tTGxWxM/zBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48CA31377F;
        Sun, 19 Nov 2023 23:41:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4icMO0KdWmX1eAAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 19 Nov 2023 23:41:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 1/9] nfsd: hold ->cl_lock for hash_delegation_locked()
In-reply-to: <ZVqciNeBnfAaHZ6a@tissot.1015granger.net>
References: <20231117022121.23310-1-neilb@suse.de>,
 <20231117022121.23310-2-neilb@suse.de>,
 <40e1bf417c635ce303f9e42ddb0e3dbd90022477.camel@kernel.org>,
 <170042987584.19300.7721851585544522693@noble.neil.brown.name>,
 <ZVqciNeBnfAaHZ6a@tissot.1015granger.net>
Date:   Mon, 20 Nov 2023 10:41:52 +1100
Message-id: <170043731218.19300.6947617887297970977@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 3.40
X-Spamd-Result: default: False [3.40 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM_SHORT(3.00)[1.000];
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 20 Nov 2023, Chuck Lever wrote:
> On Mon, Nov 20, 2023 at 08:37:55AM +1100, NeilBrown wrote:
> > On Fri, 17 Nov 2023, Jeff Layton wrote:
> > > On Fri, 2023-11-17 at 13:18 +1100, NeilBrown wrote:
> > > > The protocol for creating a new state in nfsd is to allocated the sta=
te
> > > > leaving it largely uninitialised, add that state to the ->cl_stateids
> > > > idr so as to reserve a state id, then complete initialisation of the
> > > > state and only set ->sc_type to non-zero once the state is fully
> > > > initialised.
> > > >=20
> > > > If a state is found in the idr with ->sc_type =3D=3D 0, it is ignored.
> > > > The ->cl_lock list is used to avoid races - it is held while checking
> > > > sc_type during lookup, and held when a non-zero value is stored in
> > > > ->sc_type.
> > > >=20
> > > > ... except... hash_delegation_locked() finalises the initialisation o=
f a
> > > > delegation state, but does NOT hold ->cl_lock.
> > > >=20
> > > > So this patch takes ->cl_lock at the appropriate time w.r.t other loc=
ks,
> > > > and so ensures there are no races (which are extremely unlikely in any
> > > > case).
> > > >=20
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > ---
> > > >  fs/nfsd/nfs4state.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >=20
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index 65fd5510323a..6368788a7d4e 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -1317,6 +1317,7 @@ hash_delegation_locked(struct nfs4_delegation *=
dp, struct nfs4_file *fp)
> > > > =20
> > > >  	lockdep_assert_held(&state_lock);
> > > >  	lockdep_assert_held(&fp->fi_lock);
> > > > +	lockdep_assert_held(&clp->cl_lock);
> > > > =20
> > > >  	if (nfs4_delegation_exists(clp, fp))
> > > >  		return -EAGAIN;
> > > > @@ -5609,12 +5610,14 @@ nfs4_set_delegation(struct nfsd4_open *open, =
struct nfs4_ol_stateid *stp,
> > > >  		goto out_unlock;
> > > > =20
> > > >  	spin_lock(&state_lock);
> > > > +	spin_lock(&clp->cl_lock);
> > > >  	spin_lock(&fp->fi_lock);
> > > >  	if (fp->fi_had_conflict)
> > > >  		status =3D -EAGAIN;
> > > >  	else
> > > >  		status =3D hash_delegation_locked(dp, fp);
> > > >  	spin_unlock(&fp->fi_lock);
> > > > +	spin_unlock(&clp->cl_lock);
> > > >  	spin_unlock(&state_lock);
> > > > =20
> > > >  	if (status)
> > >=20
> > > I know it's (supposedly) an unlikely race, but should we send this to
> > > stable?
> >=20
> > I don't know.  Once upon a time, "stable" meant something.  There was a
> > clear list of rules.  Those seem to have been torn up.  Now it seems to
> > be whatever some machine-learning tool chooses.
> > If that tool chooses this patch (which I suspect it will), I won't
> > object.  But I don't think it is worth encouraging it.
>=20
> We've asked Sasha and GregKH not to use AUTOSEL on NFSD patches,
> promising that we will explicitly mark anything that should be
> back-ported.

Oh good - I didn't know that.
Thanks.

NeilBrown
