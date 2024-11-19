Return-Path: <linux-nfs+bounces-8137-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FCC9D3076
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 23:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A935F1F21E06
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 22:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFC41C1F00;
	Tue, 19 Nov 2024 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N9fdT1Ni";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Erqk3Onl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N9fdT1Ni";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Erqk3Onl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB131D0B95
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732055283; cv=none; b=KMYhRfapqNNI1lc2dXpackRu7wSE4kk7DQjgIGBx9ZfFUN05zJnS4augURHOwrjmB7KUq3EDRUbNH62u6TrPmQg5bevDdRjp2ASl3gaPfzkkaQ+JGkkXA+7kn1on8GDWAYqXIPGnwB8NXyVXRDQlF+zy1IPjqwZOubkkcW1ZJQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732055283; c=relaxed/simple;
	bh=G83ACVzr1UsbpDLNSau3UQqpDsxALw24gnwZeFX+crA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qfwHBjtbggDnWDA3K0uxZDHmQOHGK+wA981CAplufRr7lksUkwMH0GFrbZ9pYgpWKVHcVljn734wzflqRCgpBFj2zA7N0S+5XjgtMhEIDQl2777pPKh21mmkMQf7c2uBWZCNfsavvzLAIYn9g3uU41rTylV+14vwrQzwXCPeWRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N9fdT1Ni; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Erqk3Onl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N9fdT1Ni; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Erqk3Onl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51ABE1F395;
	Tue, 19 Nov 2024 22:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732055280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1uhH0+nXTu9sL5vy3kYlsU+bbQJN/j220QUYezRfo0=;
	b=N9fdT1NiAB6asCrB+FnMdrU35iHVtqswr9+EGSnn9sBG6y+8HzlBBLl4/59rhSnlA9KQKG
	zI03rr0jquiT0JMJ6YXFD7u9pDvmHJB8dGrHld2Fyyxws6Ftq0TdZ8THORV9I1QH+MBpCC
	orc6L8KFklwSbDXfRfBsiMBiH4C4e84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732055280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1uhH0+nXTu9sL5vy3kYlsU+bbQJN/j220QUYezRfo0=;
	b=Erqk3OnlfVHfKZ1x3UTAVB3aXyIUEZ8+ohuyn7C1Vbs/rnmYmVQw+dW1ds5GTH5sjFzqIi
	ZzLfpJdLbz3lLQAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732055280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1uhH0+nXTu9sL5vy3kYlsU+bbQJN/j220QUYezRfo0=;
	b=N9fdT1NiAB6asCrB+FnMdrU35iHVtqswr9+EGSnn9sBG6y+8HzlBBLl4/59rhSnlA9KQKG
	zI03rr0jquiT0JMJ6YXFD7u9pDvmHJB8dGrHld2Fyyxws6Ftq0TdZ8THORV9I1QH+MBpCC
	orc6L8KFklwSbDXfRfBsiMBiH4C4e84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732055280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1uhH0+nXTu9sL5vy3kYlsU+bbQJN/j220QUYezRfo0=;
	b=Erqk3OnlfVHfKZ1x3UTAVB3aXyIUEZ8+ohuyn7C1Vbs/rnmYmVQw+dW1ds5GTH5sjFzqIi
	ZzLfpJdLbz3lLQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A89F13736;
	Tue, 19 Nov 2024 22:27:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eLX6AO4QPWdTHQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 19 Nov 2024 22:27:58 +0000
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
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 4/6] nfsd: allocate new session-based DRC slots on demand.
In-reply-to: <ZzzlCJAU357ig+Rm@tissot.1015granger.net>
References: <>, <ZzzlCJAU357ig+Rm@tissot.1015granger.net>
Date: Wed, 20 Nov 2024 09:27:51 +1100
Message-id: <173205527138.1734440.13300385185135924628@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, 20 Nov 2024, Chuck Lever wrote:
> On Tue, Nov 19, 2024 at 11:41:31AM +1100, NeilBrown wrote:
> > If a client ever uses the highest available slot for a given session,
> > attempt to allocate another slot so there is room for the client to use
> > more slots if wanted.  GFP_NOWAIT is used so if there is not plenty of
> > free memory, failure is expected - which is what we want.  It also
> > allows the allocation while holding a spinlock.
> >=20
> > We would expect to stablise with one more slot available than the client
> > actually uses.
>=20
> Which begs the question "why have a 2048 slot maximum session slot
> table size?" 1025 might work too. But is there a need for any
> maximum at all, or is this just a sanity check?

Linux NFS presumably isn't the only client, and it might change in the
future.  Maybe there is no need for a maximum.  It was mostly as a
sanity check.

It wouldn't take much to convince me to remove the limit.

>=20
>=20
> > Now that we grow the slot table on demand we can start with a smaller
> > allocation.  Define NFSD_MAX_INITIAL_SLOTS and allocate at most that
> > many when session is created.
>=20
> Maybe NFSD_DEFAULT_INITIAL_SLOTS is more descriptive?

I don't think "DEFAULT" is the right word.  The client requests a number
of slots.  That is the "Default".  The server can impose a limit - a
maximum.
Maybe we don't need a limit here either?

Thanks,
NeilBrown


>=20
>=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 32 ++++++++++++++++++++++++++------
> >  fs/nfsd/state.h     |  2 ++
> >  2 files changed, 28 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 31ff9f92a895..fb522165b376 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1956,7 +1956,7 @@ static struct nfsd4_session *alloc_session(struct n=
fsd4_channel_attrs *fattrs,
> >  	if (!slot || xa_is_err(xa_store(&new->se_slots, 0, slot, GFP_KERNEL)))
> >  		goto out_free;
> > =20
> > -	for (i =3D 1; i < numslots; i++) {
> > +	for (i =3D 1; i < numslots && i < NFSD_MAX_INITIAL_SLOTS; i++) {
> >  		slot =3D kzalloc(slotsize, GFP_KERNEL | __GFP_NORETRY);
> >  		if (!slot)
> >  			break;
> > @@ -4248,11 +4248,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
> >  	slot =3D xa_load(&session->se_slots, seq->slotid);
> >  	dprintk("%s: slotid %d\n", __func__, seq->slotid);
> > =20
> > -	/* We do not negotiate the number of slots yet, so set the
> > -	 * maxslots to the session maxreqs which is used to encode
> > -	 * sr_highest_slotid and the sr_target_slot id to maxslots */
> > -	seq->maxslots =3D session->se_fchannel.maxreqs;
> > -
> >  	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
> >  	status =3D check_slot_seqid(seq->seqid, slot->sl_seqid,
> >  					slot->sl_flags & NFSD4_SLOT_INUSE);
> > @@ -4302,6 +4297,31 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
> >  	cstate->session =3D session;
> >  	cstate->clp =3D clp;
> > =20
> > +	/*
> > +	 * If the client ever uses the highest available slot,
> > +	 * gently try to allocate another one.
> > +	 */
> > +	if (seq->slotid =3D=3D session->se_fchannel.maxreqs - 1 &&
> > +	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
> > +		int s =3D session->se_fchannel.maxreqs;
> > +
> > +		/*
> > +		 * GFP_NOWAIT is a low-priority non-blocking allocation
> > +		 * which can be used under client_lock and only succeeds
> > +		 * if there is plenty of memory.
> > +		 * Use GFP_ATOMIC which is higher priority for xa_store()
> > +		 * so we are less likely to waste the effort of the first
> > +		 * allocation.
>=20
> IIUC, GFP_ATOMIC allocations come from a special pool. I don't think
> we want that here. I'd rather stick with NORETRY or KERNEL.
>=20
>=20
> > +		 */
> > +		slot =3D kzalloc(slot_bytes(&session->se_fchannel), GFP_NOWAIT);
> > +		if (slot && !xa_is_err(xa_store(&session->se_slots, s, slot,
> > +						GFP_ATOMIC)))
> > +			session->se_fchannel.maxreqs +=3D 1;
> > +		else
> > +			kfree(slot);
> > +	}
> > +	seq->maxslots =3D session->se_fchannel.maxreqs;
> > +
> >  out:
> >  	switch (clp->cl_cb_state) {
> >  	case NFSD4_CB_DOWN:
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index e97626916a68..a14a823670e9 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -249,6 +249,8 @@ static inline struct nfs4_delegation *delegstateid(st=
ruct nfs4_stid *s)
> >   * get good throughput on high-latency servers.
> >   */
> >  #define NFSD_MAX_SLOTS_PER_SESSION	2048
> > +/* Maximum number of slots per session to allocate for CREATE_SESSION */
> > +#define NFSD_MAX_INITIAL_SLOTS		32
>=20
> The first couple of patches did so nicely at ruthlessly discarding a
> lot of arbitrary logic. I'm not convinced by the patch description
> that the INITIAL_SLOTS complexity is needed...
>=20
>=20
> >  /* Maximum  session per slot cache size */
> >  #define NFSD_SLOT_CACHE_SIZE		2048
> >  /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
> > --=20
> > 2.47.0
> >=20
>=20
> --=20
> Chuck Lever
>=20


