Return-Path: <linux-nfs+bounces-8189-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E81E19D54FE
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 22:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F82C285DC3
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 21:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B872E84D2B;
	Thu, 21 Nov 2024 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OQh8Elaq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pA65VuDA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OQh8Elaq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pA65VuDA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E7383CDA
	for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2024 21:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225668; cv=none; b=VuPlDhlemDTTrL5/MdFe/QTm0R1AEbLEzRBYE29U9WNKIEdSNoZ2Wwg7aGAgPnsZKZ03vsuQLWGp2uKWjfmjJEDToFOIojE3mHilUHcO+DBJB7FOxZbnI+g++4TAgYVv7llU0rMrCpRfWLaLkRzI6DGTjY7sLOxNYLImn/YdiGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225668; c=relaxed/simple;
	bh=tVeFmRx9e70N//hUgvUtEWmSCAhsNdGuWZ/ntrMkwS8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=OzjmWz1Bsbaz0UFwOO1IOKs1rqJGDCV26oS2CD1gGG22rcXolhSwqXgSK72LSN1vYKJTBa9P3qbTYKYdyr8EebHBqf46KxiaTvoXm1Xg9xKlyn/21HzHL4ysdgT583ckIlpaDcqfT9SlKY1Sh3xbeBaoX7HCbj35xg32TkzgQmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OQh8Elaq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pA65VuDA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OQh8Elaq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pA65VuDA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B2BF82188C;
	Thu, 21 Nov 2024 21:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732225664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guOJ99yleC6XjLjKBn6/wMw2grYJpm/xi7L+fVifnnw=;
	b=OQh8ElaqSXoMuaQ1N5S/BcNH1u8en1EvTpFbuxiT7Em8b/Do698hGhvG948EfqCgrIvZPn
	6jQWGwhEHn4RdYzxK1q5jYKkOpbs/5suMYQqRCKVlI63yoK8XbHVPiI8Svj1e53gTRQTAo
	AUNpCD5lq4KqUuOMDqeXaWYy220uX40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732225664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guOJ99yleC6XjLjKBn6/wMw2grYJpm/xi7L+fVifnnw=;
	b=pA65VuDA8pjGFnoHADRTikIUqa5JrdFyib/lk+Y15lgJELitNPFNfEO/kwdC8Cic886M3I
	JBr27ajbfd8IbLBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732225664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guOJ99yleC6XjLjKBn6/wMw2grYJpm/xi7L+fVifnnw=;
	b=OQh8ElaqSXoMuaQ1N5S/BcNH1u8en1EvTpFbuxiT7Em8b/Do698hGhvG948EfqCgrIvZPn
	6jQWGwhEHn4RdYzxK1q5jYKkOpbs/5suMYQqRCKVlI63yoK8XbHVPiI8Svj1e53gTRQTAo
	AUNpCD5lq4KqUuOMDqeXaWYy220uX40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732225664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guOJ99yleC6XjLjKBn6/wMw2grYJpm/xi7L+fVifnnw=;
	b=pA65VuDA8pjGFnoHADRTikIUqa5JrdFyib/lk+Y15lgJELitNPFNfEO/kwdC8Cic886M3I
	JBr27ajbfd8IbLBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C71A1137CF;
	Thu, 21 Nov 2024 21:47:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rwqOGn2qP2c1NwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 21 Nov 2024 21:47:41 +0000
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
Subject:
 Re: [PATCH 5/6] nfsd: add support for freeing unused session-DRC slots
In-reply-to: <Zz069lQT2WOgR4EC@tissot.1015granger.net>
References: <>, <Zz069lQT2WOgR4EC@tissot.1015granger.net>
Date: Fri, 22 Nov 2024 08:47:33 +1100
Message-id: <173222565373.1734440.11186656662331269538@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 20 Nov 2024, Chuck Lever wrote:
> On Wed, Nov 20, 2024 at 09:35:00AM +1100, NeilBrown wrote:
> > On Wed, 20 Nov 2024, Chuck Lever wrote:
> > > On Tue, Nov 19, 2024 at 11:41:32AM +1100, NeilBrown wrote:
> > > > Reducing the number of slots in the session slot table requires
> > > > confirmation from the client.  This patch adds reduce_session_slots()
> > > > which starts the process of getting confirmation, but never calls it.
> > > > That will come in a later patch.
> > > >=20
> > > > Before we can free a slot we need to confirm that the client won't try
> > > > to use it again.  This involves returning a lower cr_maxrequests in a
> > > > SEQUENCE reply and then seeing a ca_maxrequests on the same slot which
> > > > is not larger than we limit we are trying to impose.  So for each slot
> > > > we need to remember that we have sent a reduced cr_maxrequests.
> > > >=20
> > > > To achieve this we introduce a concept of request "generations".  Each
> > > > time we decide to reduce cr_maxrequests we increment the generation
> > > > number, and record this when we return the lower cr_maxrequests to the
> > > > client.  When a slot with the current generation reports a low
> > > > ca_maxrequests, we commit to that level and free extra slots.
> > > >=20
> > > > We use an 8 bit generation number (64 seems wasteful) and if it cycles
> > > > we iterate all slots and reset the generation number to avoid false m=
atches.
> > > >=20
> > > > When we free a slot we store the seqid in the slot pointer so that it=
 can
> > > > be restored when we reactivate the slot.  The RFC can be read as
> > > > suggesting that the slot number could restart from one after a slot is
> > > > retired and reactivated, but also suggests that retiring slots is not
> > > > required.  So when we reactive a slot we accept with the next seqid in
> > > > sequence, or 1.
> > > >=20
> > > > When decoding sa_highest_slotid into maxslots we need to add 1 - this
> > > > matches how it is encoded for the reply.
> > > >=20
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > ---
> > > >  fs/nfsd/nfs4state.c | 81 ++++++++++++++++++++++++++++++++++++++-----=
--
> > > >  fs/nfsd/nfs4xdr.c   |  5 +--
> > > >  fs/nfsd/state.h     |  4 +++
> > > >  fs/nfsd/xdr4.h      |  2 --
> > > >  4 files changed, 76 insertions(+), 16 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index fb522165b376..0625b0aec6b8 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -1910,17 +1910,55 @@ gen_sessionid(struct nfsd4_session *ses)
> > > >  #define NFSD_MIN_HDR_SEQ_SZ  (24 + 12 + 44)
> > > > =20
> > > >  static void
> > > > -free_session_slots(struct nfsd4_session *ses)
> > > > +free_session_slots(struct nfsd4_session *ses, int from)
> > > >  {
> > > >  	int i;
> > > > =20
> > > > -	for (i =3D 0; i < ses->se_fchannel.maxreqs; i++) {
> > > > +	if (from >=3D ses->se_fchannel.maxreqs)
> > > > +		return;
> > > > +
> > > > +	for (i =3D from; i < ses->se_fchannel.maxreqs; i++) {
> > > >  		struct nfsd4_slot *slot =3D xa_load(&ses->se_slots, i);
> > > > =20
> > > > -		xa_erase(&ses->se_slots, i);
> > > > +		/*
> > > > +		 * Save the seqid in case we reactivate this slot.
> > > > +		 * This will never require a memory allocation so GFP
> > > > +		 * flag is irrelevant
> > > > +		 */
> > > > +		xa_store(&ses->se_slots, i, xa_mk_value(slot->sl_seqid),
> > > > +			 GFP_ATOMIC);
> > >=20
> > > Again... ATOMIC is probably not what we want here, even if it is
> > > only documentary.
> >=20
> > Why not?  It might be called under a spinlock so GFP_KERNEL might trigger
> > a warning.
>=20
> I find using GFP_ATOMIC here to be confusing -- it requests
> allocation from special memory reserves and is to be used in
> situations where allocation might result in system failure. That is
> clearly not the case here, and the resulting memory allocation might
> be long-lived.

Would you be comfortable with GFP_NOWAIT which leaves out __GFP_HIGH ??

My understanding of how GFP_ATOMIC is used is it is what people choose
when they have to allocate in a no-sleep context.  It can fail and there
must always be a fall-back option.  In many cases GFP_NOWAIT could
possibly be used when it isn't a high priority, but there are 430 uses
for GFP_NOWAIT compared with over 5000 of GFP_ATOMIC.


>=20
> I see the comment that says memory won't actually be allocated. I'm
> not sure that's the way xa_store() works, however.

xarray.rst says:

  The xa_store(), xa_cmpxchg(), xa_alloc(),
  xa_reserve() and xa_insert() functions take a gfp_t
  parameter in case the XArray needs to allocate memory to store this entry.
  If the entry is being deleted, no memory allocation needs to be performed,
  and the GFP flags specified will be ignored.`

The particular context is that a normal pointer is currently stored a
the given index, and we are replacing that with a number.  The above
doesn't explicitly say that won't require a memory allocation, but I
think it is reasonable to say it won't need "to allocate memory to store
this entry" - as an entry is already stored - so allocation should not
be needed.

>=20
> I don't immediately see another good choice, however. I can reach
> out to Matthew and Liam and see if they have a better idea.
>=20
>=20
> > > And, I thought we determined that an unretired slot had a sequence
> > > number that is reset. Why save the slot's seqid? If I'm missing
> > > something, the comment here should be bolstered to explain it.
> >=20
> > It isn't clear to me that we determined that - only the some people
> > asserted it.
>=20
> From what I've read, everyone else who responded has said "use one".
> And they have provided enough spec quotations that 1 seems like the
> right initial slot sequence number value, always.
>=20
> You should trust Tom Talpey's opinion on this. He was directly
> involved 25 years ago when sessions were invented in DAFS and then
> transferred into the NFSv4.1 protocol.

Dave Noveck (also deeply involved) say:

   It does.=C2=A0 The problem is that it undercuts the core goal of the
   slot-based approach=C2=A0
   In that it makes it possible to have multiple requests with the same
   session id/ slot ID / sequence triple.

i.e.  resetting to 1 undercuts the core goal....  That is not a
resounding endorsement.

While I respect the people, I prefer to trust reasoned arguments.

What exactly is the sequence number protecting against?  It must be
protecting against a request being sent, not reply received, connection
closed, request sent on another connection, reply received.  Original
request getting to the server before the "close" message.  Server must
be sure not to handle this request.  sequence number provides that.

But what if the above all happens for request with seqno of 1, then the
server and client negotiate a "retiring" of slot 1 and then it's reuse
before the original request arrives.  How does the server know to ignore
it?

And Tom said that the handling of maxreq etc is "optional" for both
server and client.  So how can the server know if the client has retired
the slot when doing so is optional???

I really don't think we have clarity on this at all.

>=20
>=20
> > Until the spec is clarified I think it is safest to be cautious.
>=20
> The usual line we draw for adding code/features/complexity is the
> proposer must demonstrate a use case for it. So far I have not seen
> a client implementation that needs a server to remember the sequence
> number in a slot that has been shrunken and then re-activated.

And I cannot in good faith submit code that I think violates the spec.

>=20
> Will this dead slot be subject to being freed by the session
> shrinker?

No, but it uses much much less space than a slot.

>=20
> But the proposed implementation accepts 1 in this case, and it
> doesn't seem tremendously difficult to remove the "remember the
> seqid" mechanism once it has been codified to everyone's
> satisfaction. So I won't belabor the point.

Thank you!

NeilBrown

