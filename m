Return-Path: <linux-nfs+bounces-8422-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE909E8395
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 05:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC33281622
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Dec 2024 04:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7310D9461;
	Sun,  8 Dec 2024 04:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="joqkHPaE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="asYn0XYU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="joqkHPaE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="asYn0XYU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3F8381AF
	for <linux-nfs@vger.kernel.org>; Sun,  8 Dec 2024 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733633587; cv=none; b=GzfZac7JiV8/sjckFkLYZuhDKvzyPfP3ukmDcTI0avnSShAUWtwLPeH0B3KhcVZZ99xbb/amWwjpchJdrcyyp2vEQSNX1AZliCtBXiaEQUvpH7C+sIYESUl/L2q4OD0UNdIqHbBWRVdHjabX5S5JRtePTNkFjNuLsPca110a2G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733633587; c=relaxed/simple;
	bh=hDtm27ibsCWThmdY5h8f1viuRyS0prZYEeQwvbuIs1g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=fW5TU0nBKFtJkhtbb5ZQjV7OPlxFpHBjcXCkSAUUD6irM3D0oEIgQz0QrrowXxAzN+sOgzqXeBkl6aHSKIZMdknuWjpOmJmQI9xG1ExZ/+YKub68cb6DH3LL6U06zUOXhWiRDiXrPsmuf5SRGMkFYNUhBR1PIknOJzyXIOh2XC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=joqkHPaE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=asYn0XYU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=joqkHPaE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=asYn0XYU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A790C21109;
	Sun,  8 Dec 2024 04:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733633582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RN1l0TCiGmKPENK6oZzrhD4W4n30yDGZn8Blcb5FEFI=;
	b=joqkHPaEH9CRXV0/9JxOXxXCuY0I+heSsouBeEZhZsduMFRF+bzfuL5rC+FcLvLlgJPnIG
	ymGXOM/IubaILntnAAOA+O2lk8S9AM4He+oYjUVzLrTqvaPQ7jV+uvpFMOIYE2LViZ4VQN
	QQEFmKzQddM/si/yFIHGpLeqvkk5qT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733633582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RN1l0TCiGmKPENK6oZzrhD4W4n30yDGZn8Blcb5FEFI=;
	b=asYn0XYUYePCbbzcDdc4iJbjNVM9NNOprB/TpM2u9f/4hROacHvbFRgJ22kdz6shHAsiT0
	QdFM/s77eVBc2JBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733633582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RN1l0TCiGmKPENK6oZzrhD4W4n30yDGZn8Blcb5FEFI=;
	b=joqkHPaEH9CRXV0/9JxOXxXCuY0I+heSsouBeEZhZsduMFRF+bzfuL5rC+FcLvLlgJPnIG
	ymGXOM/IubaILntnAAOA+O2lk8S9AM4He+oYjUVzLrTqvaPQ7jV+uvpFMOIYE2LViZ4VQN
	QQEFmKzQddM/si/yFIHGpLeqvkk5qT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733633582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RN1l0TCiGmKPENK6oZzrhD4W4n30yDGZn8Blcb5FEFI=;
	b=asYn0XYUYePCbbzcDdc4iJbjNVM9NNOprB/TpM2u9f/4hROacHvbFRgJ22kdz6shHAsiT0
	QdFM/s77eVBc2JBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 845E7133D1;
	Sun,  8 Dec 2024 04:53:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I4ITDiwmVWd1DQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 08 Dec 2024 04:53:00 +0000
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
Cc: linux-nfs@vger.kernel.org, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH 4/6] nfsd: allocate new session-based DRC slots on demand.
In-reply-to: <6428e0ec-c743-48b3-85a8-810c8727c059@oracle.com>
References: <>, <6428e0ec-c743-48b3-85a8-810c8727c059@oracle.com>
Date: Sun, 08 Dec 2024 15:52:52 +1100
Message-id: <173363357280.1734440.10760814496701823772@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.de:email,noble.neil.brown.name:mid];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 07 Dec 2024, Chuck Lever wrote:
> On 12/5/24 7:43 PM, NeilBrown wrote:
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
> >   fs/nfsd/nfs4state.c | 40 +++++++++++++++++++++++++++++++++++-----
> >   1 file changed, 35 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 67dfc699e411..ec4468ebbd40 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -4235,11 +4235,6 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
> >   	slot =3D xa_load(&session->se_slots, seq->slotid);
> >   	dprintk("%s: slotid %d\n", __func__, seq->slotid);
> >  =20
> > -	/* We do not negotiate the number of slots yet, so set the
> > -	 * maxslots to the session maxreqs which is used to encode
> > -	 * sr_highest_slotid and the sr_target_slot id to maxslots */
> > -	seq->maxslots =3D session->se_fchannel.maxreqs;
> > -
> >   	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
> >   	status =3D check_slot_seqid(seq->seqid, slot->sl_seqid,
> >   					slot->sl_flags & NFSD4_SLOT_INUSE);
> > @@ -4289,6 +4284,41 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
> >   	cstate->session =3D session;
> >   	cstate->clp =3D clp;
> >  =20
> > +	/*
> > +	 * If the client ever uses the highest available slot,
> > +	 * gently try to allocate another 20%.  This allows
> > +	 * fairly quick growth without grossly over-shooting what
> > +	 * the client might use.
> > +	 */
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
> > +			slot =3D kzalloc(slot_bytes(&session->se_fchannel),
> > +				       GFP_NOWAIT);
> > +			if (slot &&
> > +			    !xa_is_err(xa_store(&session->se_slots, s, slot,
> > +						GFP_ATOMIC | __GFP_NOWARN))) {
> > +				s +=3D 1;
> > +				session->se_fchannel.maxreqs =3D s;
> > +			} else {
> > +				kfree(slot);
>=20
> Don't you want to break out of this loop if slot allocation or the
> xa_store() fails? Does the session logic work if there is a gap
> of unallocated slots in the slot table? Seems like we want to wait
> a bit anyway after an allocation failure before asking again.

Indeed!  The "slot =3D NULL" which the next patch adds should be in this
patch.  That makes the loop abort.

>=20
> Otherwise, LGTM. I assume a v4 is forthcoming to address review
> comments.

I'll send that out Monday morning.

Thanks,
NeilBrown

>=20
>=20
> > +			}
> > +		} while (slot && --cnt > 0);
> > +	}
> > +	seq->maxslots =3D session->se_fchannel.maxreqs;
> > +
> >   out:
> >   	switch (clp->cl_cb_state) {
> >   	case NFSD4_CB_DOWN:
>=20
>=20
> --=20
> Chuck Lever
>=20


