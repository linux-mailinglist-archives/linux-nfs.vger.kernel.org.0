Return-Path: <linux-nfs+bounces-7920-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3AC9C66BA
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 02:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162B72858C1
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 01:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6848127456;
	Wed, 13 Nov 2024 01:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="159h9DEl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q2yWtqaM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="159h9DEl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q2yWtqaM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E029A5;
	Wed, 13 Nov 2024 01:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731461511; cv=none; b=nyBayIo8/iaY9BnPxSsGJ5bip2taFrAFzXaQ/9WfJ98pQoXPC5dqB/pGaZzUtrY1Gw8cuJxeu7u5QSOSMxxdUBV4cQ72x2lFrYaYOw8OGhO0dsiqiaHxLM1Q7mgENIA+WzjgwliTfjuILo/9vcFf27goOTIEJztEuCPsAkLfcic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731461511; c=relaxed/simple;
	bh=JY8Irx/ppknLfkcqIhto3DpdKqX770VAHCPNYmZ9Bdw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Aq+n6aS7+QBvGbXNe2r4cSGGhXBXH9I9zt5ihx8VWWvqp/JUdl1HbRF5L/NdurGmwFN0MrgxFir8icE1atCg8I8ePRiqoSbZWRaqJbFZ0D6iUQhdoKVz9BvyPyXpI5tGoSxuOW4NLs++Q6z0r7B9yD6SoKAMEucyfGvX6AC2UZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=159h9DEl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q2yWtqaM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=159h9DEl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q2yWtqaM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34B541F365;
	Wed, 13 Nov 2024 01:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731461507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVyi9OVpeAtCICYw+GSgwLDNKYI4E7uJu2SL2OtnAUs=;
	b=159h9DEl282Ejd2vDEs1+mVk1mmMXKY1HUPnejeJCu62Uq1fxRWk3XtlHitxKYUPXgj1mD
	TLYLC7wfIw1BnyFqFqSRyAiwG1M5T7CGPZ8uRQ9IjUwSkK4RisxyV6luTgtt7AVgVbR/TR
	lo7G/LC3hSpI+UX2JZzAc0SC4KMtbtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731461507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVyi9OVpeAtCICYw+GSgwLDNKYI4E7uJu2SL2OtnAUs=;
	b=Q2yWtqaMUZc3/vkM73eYXc3QlLyQ/1r8qw2ApyCLiDnM227klv3+t1qNVI41E9GLHb3ZiF
	EygvFXv91scr15Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=159h9DEl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Q2yWtqaM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731461507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVyi9OVpeAtCICYw+GSgwLDNKYI4E7uJu2SL2OtnAUs=;
	b=159h9DEl282Ejd2vDEs1+mVk1mmMXKY1HUPnejeJCu62Uq1fxRWk3XtlHitxKYUPXgj1mD
	TLYLC7wfIw1BnyFqFqSRyAiwG1M5T7CGPZ8uRQ9IjUwSkK4RisxyV6luTgtt7AVgVbR/TR
	lo7G/LC3hSpI+UX2JZzAc0SC4KMtbtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731461507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVyi9OVpeAtCICYw+GSgwLDNKYI4E7uJu2SL2OtnAUs=;
	b=Q2yWtqaMUZc3/vkM73eYXc3QlLyQ/1r8qw2ApyCLiDnM227klv3+t1qNVI41E9GLHb3ZiF
	EygvFXv91scr15Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1EB813794;
	Wed, 13 Nov 2024 01:31:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6xyDHYABNGcLNwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 13 Nov 2024 01:31:44 +0000
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
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Olga Kornievskaia" <okorniev@redhat.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nfsd: allow for up to 32 callback session slots
In-reply-to: <a572abe16d1e186dbb2b6ea66a1de8bafb967dcd.camel@kernel.org>
References: <>, <a572abe16d1e186dbb2b6ea66a1de8bafb967dcd.camel@kernel.org>
Date: Wed, 13 Nov 2024 12:31:41 +1100
Message-id: <173146150119.1734440.9442770423620311274@noble.neil.brown.name>
X-Rspamd-Queue-Id: 34B541F365
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Wed, 13 Nov 2024, Jeff Layton wrote:
> On Wed, 2024-11-13 at 11:07 +1100, NeilBrown wrote:
> > On Wed, 06 Nov 2024, Jeff Layton wrote:
> > > +	spin_lock(&ses->se_lock);
> > > +	if (target > ses->se_cb_highest_slot) {
> > > +		int i;
> > > +
> > > +		target =3D min(target, NFSD_BC_SLOT_TABLE_MAX);
> > > +
> > > +		/* Growing the slot table. Reset any new sequences to 1 */
> > > +		for (i =3D ses->se_cb_highest_slot + 1; i <=3D target; ++i)
> > > +			ses->se_cb_seq_nr[i] =3D 1;
> >=20
> > Where is the justification in the RFC for resetting the sequence
> > numbers?
> >=20
>=20
> RFC 8881, 18.36:
>=20
>=20
>=20
> [...]
>=20
> Once the session is created, the first SEQUENCE or CB_SEQUENCE received
> on a slot MUST have a sequence ID equal to 1; if not, the replier MUST
> return NFS4ERR_SEQ_MISORDERED.

So initialising them all to 1 when the session is created, as you do in
init_session(), is clearly correct.  Reinitialising them after
target_highest_slot_id has been reduced and then increased is not
justified by the above.

>=20
> There is also some verbiage in 20.10.6.1.

2.10.6.1 ??

I cannot find anything in there that justifies discarding seq ids from
slots that have been used.  Discarding cached data and allocated memory
to cache future data is certainly justified, but there is no clear
protocol by which the client and server can agree that it is time to
reset the seqid for a particular slot (or range of slots).

Can you point me to what you can find?

>=20
> > The csr_target_highest_slotid from the client - which is the value passed=
 as
> > 'target' is defined as:
> >=20
> >    the highest slot ID the client would prefer the server use on a
> >    future CB_SEQUENCE operation.=20
> >=20
> > This is not "the highest slot ID for which the client is remembering
> > sequence numbers".
> >=20
> > If we can get rid of this, then I think the need for se_lock evaporates.
> > Allocating a new slow would be
> >=20
> > do {
> >  idx =3D ffs(ses->se_cb_slot_avail) - 1;
> > } while (is_valid(idx) && test_and_set_bit(idx, &ses->se_sb_slot_avail));
> > =20
> > where is_valid(idX) is idx >=3D 0 && idx <=3D ses->se_sb_highest_slot
> >=20
>=20
> That certainly would be better.
>=20
> Maybe it's not required to start the seqid for a new slot at 1? If a
> new slot can start its sequence counter at an arbitrary value then we
> should be able to do this.

A new slot MUST start with a seqid of 1 when the session is created.  So
the first time a slot is used in a session the seqid must be 1.  The
second time it must be 2.  etc.  But I don't see how that relates to the
code for managing se_sb_slot_avail ....

> > >  	case -NFS4ERR_SEQ_MISORDERED:
> > > -		if (session->se_cb_seq_nr !=3D 1) {
> > > -			session->se_cb_seq_nr =3D 1;
> > > +		if (session->se_cb_seq_nr[cb->cb_held_slot] !=3D 1) {
> > > +			session->se_cb_seq_nr[cb->cb_held_slot] =3D 1;
> >=20
> > This is weird ...  why do we reset the seq_nr to 1 when we get
> > SEQ_MISORDERED??  Git logs don't shed any light :-(
> >=20
>=20
>=20
> The above verbiage from 18.36 might hint that this is the right thing
> to do, but it's a little vague.

Maybe this code is useful for buggy clients that choose to reset the
seqid for slots that have been unused for a while...  It looks like the
Linux NFS client will reset seqids.  nfs41_set_client_slotid_locked()
records a new target bumping ->generation and
nfs41_set_server_slotid_locked() may then call nfs4_shrink_slot_table()
which discards seqid information.

I still cannot see how it is justified.=20

> > > @@ -2132,11 +2135,14 @@ static void init_session(struct svc_rqst *rqstp=
, struct nfsd4_session *new, stru
> > > =20
> > >  	INIT_LIST_HEAD(&new->se_conns);
> > > =20
> > > -	new->se_cb_seq_nr =3D 1;
> > > +	atomic_set(&new->se_ref, 0);
> > >  	new->se_dead =3D false;
> > >  	new->se_cb_prog =3D cses->callback_prog;
> > >  	new->se_cb_sec =3D cses->cb_sec;
> > > -	atomic_set(&new->se_ref, 0);
> > > +
> > > +	for (idx =3D 0; idx < NFSD_BC_SLOT_TABLE_MAX; ++idx)
> > > +		new->se_cb_seq_nr[idx] =3D 1;
> >=20
> > That should be "<=3D NFSD_BC_SLOT_TABLE_MAX"
>=20
> MAX in this case is the maximum slot index, so this is correct for the
> code as it stands today. I'm fine with redefining the constant to track
> the size of the slot table instead. We could also make the existing
> code more clear by just renaming the existing constant to
> NFSD_BC_SLOT_INDEX_MAX.

What do you mean by "this" in "this is correct for.."??  The code as it
stands today is incorrect as it initialises the se_cb_seq_nr for slots
0..30 but not for slot 31.

>=20
> >=20
> > I don't think *_MAX is a good choice of name.  It is the maximum number
> > of slots (no) or the maximum slot number (yes).
> > I think *_SIZE would be a better name - the size of the table that we
> > allocate. 32.
> > Looking at where the const is used in current nfsd-next:
> >=20
> > 		target =3D min(target, NFSD_BC_SLOT_TABLE_SIZE - 1
> >=20
> > 	new->se_cb_highest_slot =3D min(battrs->maxreqs,
> > 				      NFSD_BC_SLOT_TABLE_SIZE) - 1;
> >=20
> > 	for (idx =3D 0; idx < NFSD_BC_SLOT_TABLE_SIZE; ++idx)
> >=20
> > #define NFSD_BC_SLOT_TABLE_SIZE	(sizeof(u32) * 8)
> >=20
> > 	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_SIZE];
> >=20
> > which is a slight reduction in the number of "+/-1" adjustments.
> >=20
> >=20

Thanks,
NeilBrown

