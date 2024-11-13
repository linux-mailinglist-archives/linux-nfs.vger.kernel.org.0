Return-Path: <linux-nfs+bounces-7930-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E319C7603
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 16:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D885628BD95
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 15:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AEC70823;
	Wed, 13 Nov 2024 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5xlsYOK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4A22612;
	Wed, 13 Nov 2024 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510951; cv=none; b=DXp25CE32hvU5U+edyYyF1CkjQnXCpZyPgqPkNtpJMn25MiGUcHLbprK0UBCVSYJHTC4pqp7WeQq5iB5J/cKDY3kNY5pGSkLF/dpzGv6XOsH100NxQ8jzMdJUD8eXTa3Qx6OYE+zQmqxJ/aqM9yQWi/lRR1PmeRxXt3GCNjmObc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510951; c=relaxed/simple;
	bh=Ww3dsg15SARZD9rgznxPTxMUQ2/7NxusnUi4KwK2Ig4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lcIqOls831sXQjtOctkZZrwNpVSVUo6Jfa1lr6sIdo4tbytscXaQoFv4b9UgGVA47RUnOmreoEh/gqGEFkQzxw4db9T1GkHd2NlQ5Y3lJ0Z58S1Bo4So/DogZ7OSrf77DmF0JTNBqasnDRRXyD45EHxtv81nRSsqEo0J78iWtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5xlsYOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20519C4CEC3;
	Wed, 13 Nov 2024 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731510950;
	bh=Ww3dsg15SARZD9rgznxPTxMUQ2/7NxusnUi4KwK2Ig4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=q5xlsYOKHpg200ZsqYuE+o23I/j6JfZodEfU6UKkminlLPvD99TDg4tE7yvO7mYiV
	 K9V4L2lU+smIJ/8Tl7rvvsk44JR+WlOcsz26AiaWj0o8fQaY+dOFkBX9jFXMi3gwtT
	 nyiOVWbc7pXrUYpBJ4uA98nd7dFHy9FaS1T0PvXHSCp9oPkTbcHakCF/Ak4rmVl8nn
	 O15R2+Jjkl8Qzfq9ZHEhKqJgaJ8ltnW51S56UnWHWKQME/7Rzyuvu91eZgzjcNPYbd
	 568e/BFIWh2cApGHhqZmaTKJLlZtfsMLf/gY6qNYsGraZsdjVGNdp9aKjAkjjzwA+F
	 9f1NzoilmaNUA==
Message-ID: <acf8d86338c881b6837d85399bfca406f1e1c0a3.camel@kernel.org>
Subject: Re: [PATCH v4] nfsd: allow for up to 32 callback session slots
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, Olga Kornievskaia <okorniev@redhat.com>,
 linux-nfs@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Wed, 13 Nov 2024 10:15:49 -0500
In-Reply-To: <173146150119.1734440.9442770423620311274@noble.neil.brown.name>
References: <>, <a572abe16d1e186dbb2b6ea66a1de8bafb967dcd.camel@kernel.org>
	 <173146150119.1734440.9442770423620311274@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-13 at 12:31 +1100, NeilBrown wrote:
> On Wed, 13 Nov 2024, Jeff Layton wrote:
> > On Wed, 2024-11-13 at 11:07 +1100, NeilBrown wrote:
> > > On Wed, 06 Nov 2024, Jeff Layton wrote:
> > > > +	spin_lock(&ses->se_lock);
> > > > +	if (target > ses->se_cb_highest_slot) {
> > > > +		int i;
> > > > +
> > > > +		target =3D min(target, NFSD_BC_SLOT_TABLE_MAX);
> > > > +
> > > > +		/* Growing the slot table. Reset any new sequences to 1 */
> > > > +		for (i =3D ses->se_cb_highest_slot + 1; i <=3D target; ++i)
> > > > +			ses->se_cb_seq_nr[i] =3D 1;
> > >=20
> > > Where is the justification in the RFC for resetting the sequence
> > > numbers?
> > >=20
> >=20
> > RFC 8881, 18.36:
> >=20
> >=20
> >=20
> > [...]
> >=20
> > Once the session is created, the first SEQUENCE or CB_SEQUENCE received
> > on a slot MUST have a sequence ID equal to 1; if not, the replier MUST
> > return NFS4ERR_SEQ_MISORDERED.
>=20
> So initialising them all to 1 when the session is created, as you do in
> init_session(), is clearly correct.  Reinitialising them after
> target_highest_slot_id has been reduced and then increased is not
> justified by the above.
>=20

But, once the client and server have forgotten about those slots after
shrinking the slot table, aren't they effectively new? IOW, once you've
shrunk the slot table, the slots are effectively "freed". Growing it
means that you have to allocate new ones. The fact that this patch just
keeps them around is an implementation detail.

=20
> >=20
> > There is also some verbiage in 20.10.6.1.
>=20
> 2.10.6.1 ??
>=20
> I cannot find anything in there that justifies discarding seq ids from
> slots that have been used.  Discarding cached data and allocated memory
> to cache future data is certainly justified, but there is no clear
> protocol by which the client and server can agree that it is time to
> reset the seqid for a particular slot (or range of slots).
>=20
> Can you point me to what you can find?
>

I guess I'm stuck on this idea that shrinking the slot table
effectively frees those slots, so if you grow it again later, you have
to consider those slots to be new.

> >=20
> > > The csr_target_highest_slotid from the client - which is the value pa=
ssed as
> > > 'target' is defined as:
> > >=20
> > >    the highest slot ID the client would prefer the server use on a
> > >    future CB_SEQUENCE operation.=20
> > >=20
> > > This is not "the highest slot ID for which the client is remembering
> > > sequence numbers".
> > >=20
> > > If we can get rid of this, then I think the need for se_lock evaporat=
es.
> > > Allocating a new slow would be
> > >=20
> > > do {
> > >  idx =3D ffs(ses->se_cb_slot_avail) - 1;
> > > } while (is_valid(idx) && test_and_set_bit(idx, &ses->se_sb_slot_avai=
l));
> > > =20
> > > where is_valid(idX) is idx >=3D 0 && idx <=3D ses->se_sb_highest_slot
> > >=20
> >=20
> > That certainly would be better.
> >=20
> > Maybe it's not required to start the seqid for a new slot at 1? If a
> > new slot can start its sequence counter at an arbitrary value then we
> > should be able to do this.
>=20
> A new slot MUST start with a seqid of 1 when the session is created.  So
> the first time a slot is used in a session the seqid must be 1.  The
> second time it must be 2.  etc.  But I don't see how that relates to the
> code for managing se_sb_slot_avail ....
>=20

It doesn't. The se_lock was just a simple way to deal with the table
resizing.

> > > >  	case -NFS4ERR_SEQ_MISORDERED:
> > > > -		if (session->se_cb_seq_nr !=3D 1) {
> > > > -			session->se_cb_seq_nr =3D 1;
> > > > +		if (session->se_cb_seq_nr[cb->cb_held_slot] !=3D 1) {
> > > > +			session->se_cb_seq_nr[cb->cb_held_slot] =3D 1;
> > >=20
> > > This is weird ...  why do we reset the seq_nr to 1 when we get
> > > SEQ_MISORDERED??  Git logs don't shed any light :-(
> > >=20
> >=20
> >=20
> > The above verbiage from 18.36 might hint that this is the right thing
> > to do, but it's a little vague.
>=20
> Maybe this code is useful for buggy clients that choose to reset the
> seqid for slots that have been unused for a while...  It looks like the
> Linux NFS client will reset seqids.  nfs41_set_client_slotid_locked()
> records a new target bumping ->generation and
> nfs41_set_server_slotid_locked() may then call nfs4_shrink_slot_table()
> which discards seqid information.
>=20
> I still cannot see how it is justified.=20
>=20

Fair enough. I'm fine with doing this locklessly if the starting seqid
values truly don't matter. I fear they do though.


> > > > @@ -2132,11 +2135,14 @@ static void init_session(struct svc_rqst *r=
qstp, struct nfsd4_session *new, stru
> > > > =20
> > > >  	INIT_LIST_HEAD(&new->se_conns);
> > > > =20
> > > > -	new->se_cb_seq_nr =3D 1;
> > > > +	atomic_set(&new->se_ref, 0);
> > > >  	new->se_dead =3D false;
> > > >  	new->se_cb_prog =3D cses->callback_prog;
> > > >  	new->se_cb_sec =3D cses->cb_sec;
> > > > -	atomic_set(&new->se_ref, 0);
> > > > +
> > > > +	for (idx =3D 0; idx < NFSD_BC_SLOT_TABLE_MAX; ++idx)
> > > > +		new->se_cb_seq_nr[idx] =3D 1;
> > >=20
> > > That should be "<=3D NFSD_BC_SLOT_TABLE_MAX"
> >=20
> > MAX in this case is the maximum slot index, so this is correct for the
> > code as it stands today. I'm fine with redefining the constant to track
> > the size of the slot table instead. We could also make the existing
> > code more clear by just renaming the existing constant to
> > NFSD_BC_SLOT_INDEX_MAX.
>=20
> What do you mean by "this" in "this is correct for.."??  The code as it
> stands today is incorrect as it initialises the se_cb_seq_nr for slots
> 0..30 but not for slot 31.
>=20

My bad, you're correct. I'll plan to fix that up once I'm a little
clearer on what the next iteration needs to look like.

> >=20
> > >=20
> > > I don't think *_MAX is a good choice of name.  It is the maximum numb=
er
> > > of slots (no) or the maximum slot number (yes).
> > > I think *_SIZE would be a better name - the size of the table that we
> > > allocate. 32.
> > > Looking at where the const is used in current nfsd-next:
> > >=20
> > > 		target =3D min(target, NFSD_BC_SLOT_TABLE_SIZE - 1
> > >=20
> > > 	new->se_cb_highest_slot =3D min(battrs->maxreqs,
> > > 				      NFSD_BC_SLOT_TABLE_SIZE) - 1;
> > >=20
> > > 	for (idx =3D 0; idx < NFSD_BC_SLOT_TABLE_SIZE; ++idx)
> > >=20
> > > #define NFSD_BC_SLOT_TABLE_SIZE	(sizeof(u32) * 8)
> > >=20
> > > 	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_SIZE];
> > >=20
> > > which is a slight reduction in the number of "+/-1" adjustments.
> > >=20
> > >=20
>=20
> Thanks,
> NeilBrown

--=20
Jeff Layton <jlayton@kernel.org>

