Return-Path: <linux-nfs+bounces-8318-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2509E1269
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 05:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 372C5B21DF3
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 04:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF67C2BD1D;
	Tue,  3 Dec 2024 04:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ys6/S+sa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+GbJob+a";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ys6/S+sa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+GbJob+a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B036A2AE68
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 04:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733200139; cv=none; b=gFXPEbkslHEB12wZ8BQ0di2rvlKdh2kxcxfQfu+RGaPecetSGUj83Zq6dnDdgZdabHQ89NSImah8OmHP5d6fP6irB7FCSfdH+sbbM2enWU6LkfFldDkI+rRJSmpmnEi72ljx8dr09zzWrXg8HAvgEKYCheNpr9NxmvhkS3AZ4IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733200139; c=relaxed/simple;
	bh=cdLjDDN6XjOrRcRsr7WfSB5Uv6UG4HAmCeKtbrLsNcE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TZ1XzKGdRfniq+v5+7ZGHSUlvtBG1f9i0vawlBJwDEx9mV39h14wGXSebdC0wyDm4I3beoY5QL5n/Jzq0B4mYBgPgDxw3Vdm/ZwhckCfBC//310CncIOqIdWMsOn8DCr3UJGPtFH6v0UAlo/x2zaQj4LFthspvw1d51ZrpWYGmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ys6/S+sa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+GbJob+a; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ys6/S+sa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+GbJob+a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03ACD21163;
	Tue,  3 Dec 2024 04:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733200130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txEkzQ2A/kvxGr5F8Qt40b+CfTRscDZP4p5f+kCq03I=;
	b=ys6/S+sap5O4FaMfg8QV28Aw8eX8rKUKxLkzlOC/es70o3ZQwnD9dgOsUceggiwZyHz/dp
	hKVuIUsn9H4vKBa5kJQhNDlM9fIovDyXaoInyXKjuDRBp//w1HBhlLOU6dsJqflK17W1he
	2G2TUQJg8ZaaHUgmLZ8B/6BnHzYgyMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733200130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txEkzQ2A/kvxGr5F8Qt40b+CfTRscDZP4p5f+kCq03I=;
	b=+GbJob+aHiMSSdnSF8QlMsDwUDC1TiGoiOi9N//3oegADU5FSygde20Q++NdudfIDFKGZL
	nB5YntUjIV+vBBCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ys6/S+sa";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+GbJob+a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733200130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txEkzQ2A/kvxGr5F8Qt40b+CfTRscDZP4p5f+kCq03I=;
	b=ys6/S+sap5O4FaMfg8QV28Aw8eX8rKUKxLkzlOC/es70o3ZQwnD9dgOsUceggiwZyHz/dp
	hKVuIUsn9H4vKBa5kJQhNDlM9fIovDyXaoInyXKjuDRBp//w1HBhlLOU6dsJqflK17W1he
	2G2TUQJg8ZaaHUgmLZ8B/6BnHzYgyMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733200130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txEkzQ2A/kvxGr5F8Qt40b+CfTRscDZP4p5f+kCq03I=;
	b=+GbJob+aHiMSSdnSF8QlMsDwUDC1TiGoiOi9N//3oegADU5FSygde20Q++NdudfIDFKGZL
	nB5YntUjIV+vBBCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56004139C2;
	Tue,  3 Dec 2024 04:28:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F+TBOf2ITmcbfgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 03 Dec 2024 04:28:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever III" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject:
 Re: [PATCH 5/6] nfsd: add support for freeing unused session-DRC slots
In-reply-to: <14EF5A9B-0511-42FE-8E3C-32CDC8133A99@oracle.com>
References: <>, <14EF5A9B-0511-42FE-8E3C-32CDC8133A99@oracle.com>
Date: Tue, 03 Dec 2024 15:28:33 +1100
Message-id: <173320011366.1734440.11867983668802898163@noble.neil.brown.name>
X-Rspamd-Queue-Id: 03ACD21163
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 03 Dec 2024, Chuck Lever III wrote:
>=20
>=20
> > On Nov 21, 2024, at 5:29=E2=80=AFPM, Chuck Lever III <chuck.lever@oracle.=
com> wrote:
> >=20
> >=20
> >=20
> >> On Nov 21, 2024, at 4:47=E2=80=AFPM, NeilBrown <neilb@suse.de> wrote:
> >>=20
> >> On Wed, 20 Nov 2024, Chuck Lever wrote:
> >>> On Wed, Nov 20, 2024 at 09:35:00AM +1100, NeilBrown wrote:
> >>>> On Wed, 20 Nov 2024, Chuck Lever wrote:
> >>>>> On Tue, Nov 19, 2024 at 11:41:32AM +1100, NeilBrown wrote:
> >>>>>> Reducing the number of slots in the session slot table requires
> >>>>>> confirmation from the client.  This patch adds reduce_session_slots()
> >>>>>> which starts the process of getting confirmation, but never calls it.
> >>>>>> That will come in a later patch.
> >>>>>>=20
> >>>>>> Before we can free a slot we need to confirm that the client won't t=
ry
> >>>>>> to use it again.  This involves returning a lower cr_maxrequests in a
> >>>>>> SEQUENCE reply and then seeing a ca_maxrequests on the same slot whi=
ch
> >>>>>> is not larger than we limit we are trying to impose.  So for each sl=
ot
> >>>>>> we need to remember that we have sent a reduced cr_maxrequests.
> >>>>>>=20
> >>>>>> To achieve this we introduce a concept of request "generations".  Ea=
ch
> >>>>>> time we decide to reduce cr_maxrequests we increment the generation
> >>>>>> number, and record this when we return the lower cr_maxrequests to t=
he
> >>>>>> client.  When a slot with the current generation reports a low
> >>>>>> ca_maxrequests, we commit to that level and free extra slots.
> >>>>>>=20
> >>>>>> We use an 8 bit generation number (64 seems wasteful) and if it cycl=
es
> >>>>>> we iterate all slots and reset the generation number to avoid false =
matches.
> >>>>>>=20
> >>>>>> When we free a slot we store the seqid in the slot pointer so that i=
t can
> >>>>>> be restored when we reactivate the slot.  The RFC can be read as
> >>>>>> suggesting that the slot number could restart from one after a slot =
is
> >>>>>> retired and reactivated, but also suggests that retiring slots is not
> >>>>>> required.  So when we reactive a slot we accept with the next seqid =
in
> >>>>>> sequence, or 1.
> >>>>>>=20
> >>>>>> When decoding sa_highest_slotid into maxslots we need to add 1 - this
> >>>>>> matches how it is encoded for the reply.
> >>>>>>=20
> >>>>>> Signed-off-by: NeilBrown <neilb@suse.de>
> >>>>>> ---
> >>>>>> fs/nfsd/nfs4state.c | 81 ++++++++++++++++++++++++++++++++++++++-----=
--
> >>>>>> fs/nfsd/nfs4xdr.c   |  5 +--
> >>>>>> fs/nfsd/state.h     |  4 +++
> >>>>>> fs/nfsd/xdr4.h      |  2 --
> >>>>>> 4 files changed, 76 insertions(+), 16 deletions(-)
> >>>>>>=20
> >>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >>>>>> index fb522165b376..0625b0aec6b8 100644
> >>>>>> --- a/fs/nfsd/nfs4state.c
> >>>>>> +++ b/fs/nfsd/nfs4state.c
> >>>>>> @@ -1910,17 +1910,55 @@ gen_sessionid(struct nfsd4_session *ses)
> >>>>>> #define NFSD_MIN_HDR_SEQ_SZ  (24 + 12 + 44)
> >>>>>>=20
> >>>>>> static void
> >>>>>> -free_session_slots(struct nfsd4_session *ses)
> >>>>>> +free_session_slots(struct nfsd4_session *ses, int from)
> >>>>>> {
> >>>>>> int i;
> >>>>>>=20
> >>>>>> - for (i =3D 0; i < ses->se_fchannel.maxreqs; i++) {
> >>>>>> + if (from >=3D ses->se_fchannel.maxreqs)
> >>>>>> + return;
> >>>>>> +
> >>>>>> + for (i =3D from; i < ses->se_fchannel.maxreqs; i++) {
> >>>>>> struct nfsd4_slot *slot =3D xa_load(&ses->se_slots, i);
> >>>>>>=20
> >>>>>> - xa_erase(&ses->se_slots, i);
> >>>>>> + /*
> >>>>>> +  * Save the seqid in case we reactivate this slot.
> >>>>>> +  * This will never require a memory allocation so GFP
> >>>>>> +  * flag is irrelevant
> >>>>>> +  */
> >>>>>> + xa_store(&ses->se_slots, i, xa_mk_value(slot->sl_seqid),
> >>>>>> +  GFP_ATOMIC);
> >>>>>=20
> >>>>> Again... ATOMIC is probably not what we want here, even if it is
> >>>>> only documentary.
> >>>>=20
> >>>> Why not?  It might be called under a spinlock so GFP_KERNEL might trig=
ger
> >>>> a warning.
> >>>=20
> >>> I find using GFP_ATOMIC here to be confusing -- it requests
> >>> allocation from special memory reserves and is to be used in
> >>> situations where allocation might result in system failure. That is
> >>> clearly not the case here, and the resulting memory allocation might
> >>> be long-lived.
> >>=20
> >> Would you be comfortable with GFP_NOWAIT which leaves out __GFP_HIGH ??
> >=20
> > I will be comfortable when I hear back from Matthew and Liam.
> >=20
> > :-)
> >=20
> >=20
> >>> I see the comment that says memory won't actually be allocated. I'm
> >>> not sure that's the way xa_store() works, however.
> >>=20
> >> xarray.rst says:
> >>=20
> >> The xa_store(), xa_cmpxchg(), xa_alloc(),
> >> xa_reserve() and xa_insert() functions take a gfp_t
> >> parameter in case the XArray needs to allocate memory to store this entr=
y.
> >> If the entry is being deleted, no memory allocation needs to be performe=
d,
> >> and the GFP flags specified will be ignored.`
> >>=20
> >> The particular context is that a normal pointer is currently stored a
> >> the given index, and we are replacing that with a number.  The above
> >> doesn't explicitly say that won't require a memory allocation, but I
> >> think it is reasonable to say it won't need "to allocate memory to store
> >> this entry" - as an entry is already stored - so allocation should not
> >> be needed.
> >=20
> > xa_mk_value() converts a number to a pointer, and xa_store
> > stores that pointer.
> >=20
> > I suspect that xa_store() is allowed to rebalance the
> > xarray's internal data structures, and that could result
> > in memory release or allocation. That's why a GFP flag is
> > one of the arguments.
>=20
> Matthew says the xa_store() is guaranteed not to do a memory
> allocation in this case. However, they prefer an annotation
> of the call site with a "0" GFP argument to show that the
> allocation flags are not relevant.
>=20
> Does this:
>=20
> 	xa_store(&ses->se_slots, i, xa_mk_value(slot->sl_seqid), 0);
>=20
> work for you?

Sure.
And it looks like sparse will be happy even though "0" isn't explicitly
"gfp_t" because 0 is "special".

I might prefer GFP_NULL or similar, but 0 certainly works for me.  I'll
include that when I resend.

Thanks
NeilBrown

