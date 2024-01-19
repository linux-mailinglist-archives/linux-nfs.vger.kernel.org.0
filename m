Return-Path: <linux-nfs+bounces-1203-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B325C83230F
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jan 2024 02:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41ECB1F2274C
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jan 2024 01:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5BA10F4;
	Fri, 19 Jan 2024 01:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ygf/92xY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X1zFUV4J";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ygf/92xY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X1zFUV4J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7F010E4
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jan 2024 01:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628510; cv=none; b=SYSO+OPgbq3smsWxPCcJg5PuH9hLEigPlb8JyHjl1B732xoDa0RQhiyBCSl6COYs3jfmkX2GpmAlAqmxS8c9oASD/ISujhqTlzIoVQ0ZWrbeESxiWNjvwnB0b+TiXehCMO2p4LZBzAIE7zLzsoa9dkvqgLk3TVFTxacCYJQvcyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628510; c=relaxed/simple;
	bh=0hUbXxOi21rroTmk8sENgQDkhoUVsC+ZbF5/Euuz1bo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Xu/NZhp4O5tGKMDHeUg9v8g5XN68SQ16tGlNwAdb/UxJq5KWUiAjr3+cLSM61sp1hnvNJ1v/cj8aOleQphuZU2WlbT7jHizV92XK9+Owk4YRp9xOc0l680sORkkiiovfIkboZ4p4qqL2vIZ+uPUQItkRn8gL3/JJPCtl93WVP0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ygf/92xY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X1zFUV4J; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ygf/92xY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X1zFUV4J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E8761FCFD;
	Fri, 19 Jan 2024 01:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705628506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyjo+KSnuDbeBELj7RwBg2ARGW9jKQ/REhDsYBx+zg8=;
	b=ygf/92xYk6+cCR22mVkUs9UYdyJfXkoB/VVUSK/zYL5LB6fyj7yyDZnfnU0tpxuzAsYH6w
	VeN6u7J7GRD2lQMOr101bpm1CVlmJImQpHmy857E7uo3X31+G+IbAK7bd8G8Ln+qgr0tSY
	cK1O9PhNFRg0RtS6gooa2uJyGuk4h3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705628506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyjo+KSnuDbeBELj7RwBg2ARGW9jKQ/REhDsYBx+zg8=;
	b=X1zFUV4Jq+yMm8jRZVObd9+99IHbqyQNCkNHg42jyUhEj11NwBMEePQIIhIf/waY7BIKFZ
	ec5IcqzMAjDGjyAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705628506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyjo+KSnuDbeBELj7RwBg2ARGW9jKQ/REhDsYBx+zg8=;
	b=ygf/92xYk6+cCR22mVkUs9UYdyJfXkoB/VVUSK/zYL5LB6fyj7yyDZnfnU0tpxuzAsYH6w
	VeN6u7J7GRD2lQMOr101bpm1CVlmJImQpHmy857E7uo3X31+G+IbAK7bd8G8Ln+qgr0tSY
	cK1O9PhNFRg0RtS6gooa2uJyGuk4h3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705628506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyjo+KSnuDbeBELj7RwBg2ARGW9jKQ/REhDsYBx+zg8=;
	b=X1zFUV4Jq+yMm8jRZVObd9+99IHbqyQNCkNHg42jyUhEj11NwBMEePQIIhIf/waY7BIKFZ
	ec5IcqzMAjDGjyAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 673C513777;
	Fri, 19 Jan 2024 01:41:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rv3fBljTqWUeWwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 19 Jan 2024 01:41:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject:
 Re: [PATCH 07/11] nfsd: allow admin-revoked NFSv4.0 state to be freed.
In-reply-to: <ZWOGW8/PTkjp1lKe@tissot.1015granger.net>
References: <20231124002925.1816-1-neilb@suse.de>,
 <20231124002925.1816-8-neilb@suse.de>,
 <ZWOGW8/PTkjp1lKe@tissot.1015granger.net>
Date: Fri, 19 Jan 2024 12:41:37 +1100
Message-id: <170562849709.23031.15952595029127518749@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.10

On Mon, 27 Nov 2023, Chuck Lever wrote:
> On Fri, Nov 24, 2023 at 11:28:42AM +1100, NeilBrown wrote:
> > For NFSv4.1 and later the client easily discovers if there is any
> > admin-revoked state and will then find and explicitly free it.
> >=20
> > For NFSv4.0 there is no such mechanism.  The client can only find that
> > state is admin-revoked if it tries to use that state, and there is no
> > way for it to explicitly free the state.  So the server must hold on to
> > the stateid (at least) for an indefinite amount of time.  A
> > RELEASE_LOCKOWNER request might justify forgetting some of these
> > stateids, as would the whole clients lease lapsing, but these are not
> > reliable.
>=20
> They aren't reliable, but what are the consequences of revoked
> state left on the server? Seems like our implementation has a
> number of mechanisms for cleaning up state over time. Do you feel
> this is a denial-of-service vector?

The consequence of revoked state being left on the server is only the
memory usage (and possible associated costs of indexing a data structure
that is larger than it needs to be).  The only existing mechanisms that
will clean it up is the cleanup when a client expires or when the server
exits.  These may not happen for years.

We might expect admin-revoke to be used rarely, but such expectations
are not reliable.  So the number of revoked states that accumulate could
grow without bound - unlikely though that is.

I don't think it is a denial-of-service "attack" vector as only the
admin can initiate the admin-revocation.  But an admin could unwittingly
bring denial of service upon themselves by revoking state repeatedly
over an extended period of time - if we did not proactively clean up old
revoked state.

>=20
>=20
> > This patch takes two approaches.
> >=20
> > Whenever a client uses an revoked stateid, that stateid is then
> > discarded and will not be recognised again.  This might confuse a client
> > which expect to get NFS4ERR_ADMIN_REVOKED consistently once it get it at
> > all, but should mostly work.  Hopefully one error will lead to other
> > resources being closed (e.g.  process exits), which will result in more
> > stateid being freed when a CLOSE attempt gets NFS4ERR_ADMIN_REVOKED.
>=20
> I'm leery of this: "This might confuse..." and "Hopefully..." suggest
> we're not real sure how this will behave in practice with the current
> cohort of client implementations.

It is true - we are not really sure.  There are many reason why we have
NFSv4.1 and I suspect this is one of them.
I would be happy to only support admin-revoke for v4.1 and later and put
v4.0 in the "too hard" basket.  But I think this "best effort" without
strong guarantees is better than not supporting it at all.

>=20
> Also, this paragraph in Section 10.2.1 of RFC 7530 is concerning:
>=20
> >  A client normally finds out about revocation of a delegation when it
> >  uses a stateid associated with a delegation and receives one of the
> >  errors NFS4ERR_EXPIRED, NFS4ERR_BAD_STATEID, or NFS4ERR_ADMIN_REVOKED
> >  (NFS4ERR_EXPIRED indicates that all lock state associated with the
> >  client has been lost).  It also may find out about delegation
> >  revocation after a client reboot when it attempts to reclaim a
> >  delegation and receives NFS4ERR_EXPIRED.  Note that in the case of a
> >  revoked OPEN_DELEGATE_WRITE delegation, there are issues because data
> >  may have been modified by the client whose delegation is revoked and,
> >  separately, by other clients.  See Section 10.5.1 for a discussion of
> >  such issues.  Note also that when delegations are revoked,
> >  information about the revoked delegation will be written by the
> >  server to stable storage (as described in Section 9.6).  This is done
> >  to deal with the case in which a server reboots after revoking a
> >  delegation but before the client holding the revoked delegation is
> >  notified about the revocation.
>=20
> The text here suggests that the server persists the ADMIN_REVOKED
> status, which suggests to me that the server is supposed to continue
> returning ADMIN_REVOKED when presented with the revoked state,
> until the state is freed.

I agree - but when can the state be freed?  NFSv4.0 has no mechanism to
do this.  So the text suggests that the server is supposed to continue
returning ADMIN_REVOKED when presented with the revoked state
indefinitely.

We could do that.  I just don't feel comfortable storing an indefinite
amount of state for an indefinite amount of time.

>=20
> AFAICT NFSD isn't recording this status persistently... Is there a
> plan to add that (later) or some words suggesting that it is safe
> and reasonable not to record it?

I hadn't thought about this...

The expectation (well ...  my expectation) is that state will only be
admin-revoked after the filesystem has been un-exported (and shortly
before it is unmounted).  In this case there is no chance for another
client to open the file and violate expectations reasonably held by the
first client.

But people might use the functionality differently to my expectations
(it happens all the time...).

I cannot see that Linux nfsd currently saves any per-state info to
stable storage.  There is only per-client information.
Based on this, section 9.6.3.4.3 Handling Server Edge Conditions
seems to suggest that all attempts to reclaim locks should get
NFS4ERR_NO_GRACE.  But I don't think we do this.

So maybe I can justify the lack of recording admin-revoke state to
stable storage on the basis that the whole "record state to stable
storage" idea is currently ignored by nfsd ????

>=20
>=20
> > Also, any admin-revoked stateids that have been that way for more than
> > one lease time are periodically revoke.
> >=20
> > No actual freeing of state happens in this patch.  That will come in
> > future patches which handle the different sorts of revoked state.
> >
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/netns.h     |  4 ++
> >  fs/nfsd/nfs4state.c | 97 ++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 100 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index ab303a8b77d5..7458f672b33e 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -197,6 +197,10 @@ struct nfsd_net {
> >  	atomic_t		nfsd_courtesy_clients;
> >  	struct shrinker		*nfsd_client_shrinker;
> >  	struct work_struct	nfsd_shrinker_work;
> > +
> > +	/* last time an admin-revoke happened for NFSv4.0 */
> > +	time64_t		nfs40_last_revoke;
> > +
> >  };
> > =20
> >  /* Simple check to find out if a given net was properly initialized */
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 52e680235afe..c57f2ff954cb 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1724,6 +1724,14 @@ void nfsd4_revoke_states(struct net *net, struct s=
uper_block *sb)
> >  				}
> >  				nfs4_put_stid(stid);
> >  				spin_lock(&nn->client_lock);
> > +				if (clp->cl_minorversion =3D=3D 0)
> > +					/* Allow cleanup after a lease period.
> > +					 * store_release ensures cleanup will
> > +					 * see any newly revoked states if it
> > +					 * sees the time updated.
> > +					 */
> > +					nn->nfs40_last_revoke =3D
> > +						ktime_get_boottime_seconds();
> >  				goto retry;
> >  			}
> >  		}
> > @@ -4648,6 +4656,39 @@ nfsd4_find_existing_open(struct nfs4_file *fp, str=
uct nfsd4_open *open)
> >  	return ret;
> >  }
> > =20
> > +static void nfsd_drop_revoked_stid(struct nfs4_stid *s)
> > +{
> > +	struct nfs4_client *cl =3D s->sc_client;
> > +
> > +	switch (s->sc_type) {
> > +	default:
> > +		spin_unlock(&cl->cl_lock);
> > +	}
> > +}
> > +
> > +static void nfs40_drop_revoked_stid(struct nfs4_client *cl,
> > +				    stateid_t *stid)
>=20
> Nits: I'd prefer nfsd4_drop_revoked_stid() and nfsd40_drop_revoked_stid()
>=20

I guess..

nfsd code sometimes uses "nfsd" and sometimes "nfs" and sometimes adds a
"4" and it doesn't seem to be at all consistent.  Standardising on the
longest such form doesn't fill me with joy.  I would prefer to remove
the prefix completely - at least for names local to a file and probably
for names local to the module..

I've made the change you suggest.

Thanks,
NeilBrown


