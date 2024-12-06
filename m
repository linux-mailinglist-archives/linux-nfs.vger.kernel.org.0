Return-Path: <linux-nfs+bounces-8361-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 549A99E637F
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 02:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5FF18856BD
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 01:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE6113C677;
	Fri,  6 Dec 2024 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DUEhL5HX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R2F4uhjt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DUEhL5HX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R2F4uhjt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46CDBE46
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 01:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733449442; cv=none; b=J5I5jwabRralFQ8kIfbsxApSPUm1sAp+Dhg6GGI0tTV46+y6aNbRYknyLRAd2HYH3fL3a9vI729hNzru+WGCdAtElT8SyE91k55YaCGPW8akavFdU29b51tL4Psi0Xth7NuCZtZcw5w3P0tDhyJ7y1Fw4owS6qEUnJf41tj8PU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733449442; c=relaxed/simple;
	bh=T6pjA7UHZtK2iyau4JP8QpkICOP+4j32ii08OtIX6tQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=sNYxEZtbE7cmQOTAGzxkBNyJfh3d7DbqgJjwcO0mmL1aTNRicj1C9GX7JnkqVOs6xo0rOACMOmY14eHNhJ14xPhdMbrPXgJh5Ln/geX4hOJkCJLq+DV7KAezCjVESq+1Fbt4Ai0GYm1wOfmyrm6OD75aLRGewf7kmrSOdhzKa8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DUEhL5HX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R2F4uhjt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DUEhL5HX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R2F4uhjt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D19572118B;
	Fri,  6 Dec 2024 01:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733449438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+VyYFD/hsBAaUFCTWNJNRV979eEF0H1tXLm2W7lM+8=;
	b=DUEhL5HXnsAZel+7VQ6Ekigw/eHeZcy/5lkU/ZDZ2EKZzhsRLUQ8AZ7/xCElBVeYF6XfZw
	8bLl4mUItlLqSxcczyafsFHVLcBOghqEP2zSH79b7wcfa2B1WvanMLe+dMXA36H69W+o8C
	t99lfu9LYtUmd6NSEZ3GoD4aAf6mIeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733449438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+VyYFD/hsBAaUFCTWNJNRV979eEF0H1tXLm2W7lM+8=;
	b=R2F4uhjt8lQVbKISkIjlWrLdYvKSpKEsHH9H9YUrLIdHevNPxZnBykDXnLUryqyzqpmSnr
	fTfthNVKquIBjbCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733449438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+VyYFD/hsBAaUFCTWNJNRV979eEF0H1tXLm2W7lM+8=;
	b=DUEhL5HXnsAZel+7VQ6Ekigw/eHeZcy/5lkU/ZDZ2EKZzhsRLUQ8AZ7/xCElBVeYF6XfZw
	8bLl4mUItlLqSxcczyafsFHVLcBOghqEP2zSH79b7wcfa2B1WvanMLe+dMXA36H69W+o8C
	t99lfu9LYtUmd6NSEZ3GoD4aAf6mIeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733449438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+VyYFD/hsBAaUFCTWNJNRV979eEF0H1tXLm2W7lM+8=;
	b=R2F4uhjt8lQVbKISkIjlWrLdYvKSpKEsHH9H9YUrLIdHevNPxZnBykDXnLUryqyzqpmSnr
	fTfthNVKquIBjbCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7EFA13647;
	Fri,  6 Dec 2024 01:43:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZMqDFtxWUmfoGwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 01:43:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 4/6] nfsd: allocate new session-based DRC slots on demand.
In-reply-to: <911b04ba2e5389f97fdeaac632b8fb8c66da130e.camel@kernel.org>
References: <>, <911b04ba2e5389f97fdeaac632b8fb8c66da130e.camel@kernel.org>
Date: Fri, 06 Dec 2024 12:43:52 +1100
Message-id: <173344943283.1734440.2066475669031086509@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, 06 Dec 2024, Jeff Layton wrote:
> On Fri, 2024-12-06 at 11:43 +1100, NeilBrown wrote:
> > If a client ever uses the highest available slot for a given session,
> > attempt to allocate more slots so there is room for the client to use
> > them if wanted.  GFP_NOWAIT is used so if there is not plenty of
> > free memory, failure is expected - which is what we want.  It also
> > allows the allocation while holding a spinlock.
> >=20
> > Each time we increase the number of slots by 20% (rounded up).  This
> > allows fairly quick growth while avoiding excessive over-shoot.
> >=20
> > We would expect to stablise with around 10% more slots available than
> > the client actually uses.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 40 +++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 35 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 67dfc699e411..ec4468ebbd40 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -4235,11 +4235,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
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
> > @@ -4289,6 +4284,41 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
> >  	cstate->session =3D session;
> >  	cstate->clp =3D clp;
> > =20
> > +	/*
> > +	 * If the client ever uses the highest available slot,
> > +	 * gently try to allocate another 20%.  This allows
> > +	 * fairly quick growth without grossly over-shooting what
> > +	 * the client might use.
> > +	 */
>=20
> 20% seems like a reasonable place to start, but I do wonder if this
> might need to be tunable under some workloads. Oh well, we can cross
> that bridge if/when someone complains.

I think that if we need a tunable, then it is a failure of design.
If?when someone complains we may well need to redesign.  I hope we could
avoid a tunable in that design!

> =20
> > +	if (seq->slotid =3D=3D session->se_fchannel.maxreqs - 1 &&
> > +	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
> > +		int s =3D session->se_fchannel.maxreqs;
> > +		int cnt =3D DIV_ROUND_UP(s, 5);
> > +
> > +		do {
> > +			/*
> > +			 * GFP_NOWAIT is a low-priority non-blocking
> > +			 * allocation which can be used under
> > +			 * client_lock and only succeeds if there is
> > +			 * plenty of memory.
> > +			 * Use GFP_ATOMIC which is higher priority for
> > +			 * xa_store() so we are less likely to waste the
> > +			 * effort of the first allocation.
> > +			 */
>=20
> I don't know here. Why not just use GFP_NOWAIT for the xa_store too? If
> we're so memory constrained that that fails, we're probably better off
> releasing the slot.

Maybe.  I'm open simple using GFP_NOWAIT both places.
Most often xa_store won't need to allocate anything - it adds slots to
the array in batches (at least I assume it does - anything else would be
inefficient).  So it mostly won't matter.
So if seems at all inelegant - let's drop it.

Thanks,
NeilBrown


>=20
> > +			slot =3D kzalloc(slot_bytes(&session->se_fchannel),
> > +				       GFP_NOWAIT);
> > +			if (slot &&
> > +			    !xa_is_err(xa_store(&session->se_slots, s, slot,
> > +						GFP_ATOMIC | __GFP_NOWARN))) {
> > +				s +=3D 1;
> > +				session->se_fchannel.maxreqs =3D s;
> > +			} else {
> > +				kfree(slot);
> > +			}
> > +		} while (slot && --cnt > 0);
> > +	}
> > +	seq->maxslots =3D session->se_fchannel.maxreqs;
> > +
> >  out:
> >  	switch (clp->cl_cb_state) {
> >  	case NFSD4_CB_DOWN:
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20


