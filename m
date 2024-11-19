Return-Path: <linux-nfs+bounces-8138-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3399D308F
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 23:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34431F2387E
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 22:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAFC1D4604;
	Tue, 19 Nov 2024 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gk+o+Ujp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hadg+h7Y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gk+o+Ujp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hadg+h7Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578FF1C6886
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732055709; cv=none; b=FKM8wl6zM7reYre1892ZCGuf1mgwDALuL48R//N/Ch84vnHVCEqNCDYKrrJBXB0WQ6UtkAe1zdWJhDzjL1F9MkHL48m34+W81KqFO3W3nleUrnNNduSQIcK3Bj1KDtxYZQMCZdoptBS3FUdbaX/gUfM1HhpaQEOUVZd+DVbEb9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732055709; c=relaxed/simple;
	bh=gGEyuUefX9Eeb+9wyquUDIP/jpUGJwPuPaD/NlACtTc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=dJk+4o0CrE4Csbc4o1qa5wtfk8KCZNINAlANEbsMsQ9Lbu7OAouelqoQi+mUVCRwV+5J9S5UaYE/tVA2aTYHsj0kPuJDyx0JtPQznMYTFITWOEYCOv1y3fcjXnb054IaBagGhh6LHR5IUTMRCY3CchBNZPdCIMnzGiLSa+D3rsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gk+o+Ujp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hadg+h7Y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gk+o+Ujp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hadg+h7Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78B39219F9;
	Tue, 19 Nov 2024 22:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732055705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zwot0Zy5v+I+MW6dy6LM4b6R3iU+ER8YPYtZqoszLGU=;
	b=Gk+o+UjpWnR9IkTkp3dnuHWwuWU9lHvyCAX8aB0gLS6UrYsS1ycJa1qb15azQn2NDImqXn
	wDtrB5LB5fJB/3IkydgoRKi76xnhXLoNJ27PBxUb6DuwfxUhI7ArE8jwZXDC/lBrTgs36q
	KeqzAv3GL8N4uWCDYHAoo6g/ZE327tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732055705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zwot0Zy5v+I+MW6dy6LM4b6R3iU+ER8YPYtZqoszLGU=;
	b=hadg+h7YtP8uAtmdyAMyFDwAttvYqykPukRAOVrCsWEgavBmHR8rfOcafeVZyIInLYsO5l
	LXliEZ8bJ1MEthAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732055705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zwot0Zy5v+I+MW6dy6LM4b6R3iU+ER8YPYtZqoszLGU=;
	b=Gk+o+UjpWnR9IkTkp3dnuHWwuWU9lHvyCAX8aB0gLS6UrYsS1ycJa1qb15azQn2NDImqXn
	wDtrB5LB5fJB/3IkydgoRKi76xnhXLoNJ27PBxUb6DuwfxUhI7ArE8jwZXDC/lBrTgs36q
	KeqzAv3GL8N4uWCDYHAoo6g/ZE327tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732055705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zwot0Zy5v+I+MW6dy6LM4b6R3iU+ER8YPYtZqoszLGU=;
	b=hadg+h7YtP8uAtmdyAMyFDwAttvYqykPukRAOVrCsWEgavBmHR8rfOcafeVZyIInLYsO5l
	LXliEZ8bJ1MEthAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76E721376E;
	Tue, 19 Nov 2024 22:35:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b18bDJcSPWdKHwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 19 Nov 2024 22:35:03 +0000
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
In-reply-to: <ZzzmN2ZTPkvf+Vl8@tissot.1015granger.net>
References: <>, <ZzzmN2ZTPkvf+Vl8@tissot.1015granger.net>
Date: Wed, 20 Nov 2024 09:35:00 +1100
Message-id: <173205570058.1734440.4487071386768199899@noble.neil.brown.name>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, 20 Nov 2024, Chuck Lever wrote:
> On Tue, Nov 19, 2024 at 11:41:32AM +1100, NeilBrown wrote:
> > Reducing the number of slots in the session slot table requires
> > confirmation from the client.  This patch adds reduce_session_slots()
> > which starts the process of getting confirmation, but never calls it.
> > That will come in a later patch.
> >=20
> > Before we can free a slot we need to confirm that the client won't try
> > to use it again.  This involves returning a lower cr_maxrequests in a
> > SEQUENCE reply and then seeing a ca_maxrequests on the same slot which
> > is not larger than we limit we are trying to impose.  So for each slot
> > we need to remember that we have sent a reduced cr_maxrequests.
> >=20
> > To achieve this we introduce a concept of request "generations".  Each
> > time we decide to reduce cr_maxrequests we increment the generation
> > number, and record this when we return the lower cr_maxrequests to the
> > client.  When a slot with the current generation reports a low
> > ca_maxrequests, we commit to that level and free extra slots.
> >=20
> > We use an 8 bit generation number (64 seems wasteful) and if it cycles
> > we iterate all slots and reset the generation number to avoid false match=
es.
> >=20
> > When we free a slot we store the seqid in the slot pointer so that it can
> > be restored when we reactivate the slot.  The RFC can be read as
> > suggesting that the slot number could restart from one after a slot is
> > retired and reactivated, but also suggests that retiring slots is not
> > required.  So when we reactive a slot we accept with the next seqid in
> > sequence, or 1.
> >=20
> > When decoding sa_highest_slotid into maxslots we need to add 1 - this
> > matches how it is encoded for the reply.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 81 ++++++++++++++++++++++++++++++++++++++-------
> >  fs/nfsd/nfs4xdr.c   |  5 +--
> >  fs/nfsd/state.h     |  4 +++
> >  fs/nfsd/xdr4.h      |  2 --
> >  4 files changed, 76 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index fb522165b376..0625b0aec6b8 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1910,17 +1910,55 @@ gen_sessionid(struct nfsd4_session *ses)
> >  #define NFSD_MIN_HDR_SEQ_SZ  (24 + 12 + 44)
> > =20
> >  static void
> > -free_session_slots(struct nfsd4_session *ses)
> > +free_session_slots(struct nfsd4_session *ses, int from)
> >  {
> >  	int i;
> > =20
> > -	for (i =3D 0; i < ses->se_fchannel.maxreqs; i++) {
> > +	if (from >=3D ses->se_fchannel.maxreqs)
> > +		return;
> > +
> > +	for (i =3D from; i < ses->se_fchannel.maxreqs; i++) {
> >  		struct nfsd4_slot *slot =3D xa_load(&ses->se_slots, i);
> > =20
> > -		xa_erase(&ses->se_slots, i);
> > +		/*
> > +		 * Save the seqid in case we reactivate this slot.
> > +		 * This will never require a memory allocation so GFP
> > +		 * flag is irrelevant
> > +		 */
> > +		xa_store(&ses->se_slots, i, xa_mk_value(slot->sl_seqid),
> > +			 GFP_ATOMIC);
>=20
> Again... ATOMIC is probably not what we want here, even if it is
> only documentary.

Why not?  It might be called under a spinlock so GFP_KERNEL might trigger
a warning.

>=20
> And, I thought we determined that an unretired slot had a sequence
> number that is reset. Why save the slot's seqid? If I'm missing
> something, the comment here should be bolstered to explain it.

It isn't clear to me that we determined that - only the some people
asserted it.  Until the spec is clarified I think it is safest to be
cautious.

Thanks,
NeilBrown

