Return-Path: <linux-nfs+bounces-7915-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91D29C651F
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 00:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FBC1F227BF
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 23:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EAD21EBAC;
	Tue, 12 Nov 2024 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jmEu1u4g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+QVs0orI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jmEu1u4g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+QVs0orI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B8221F4C2;
	Tue, 12 Nov 2024 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453814; cv=none; b=G7cKmoV1N9nYRM7lNFim8KeOEMdUuLCrUzvSAZl6rvhBBrm8fGeKig7gKEO2rSo3sDaDMySpgLILFTRG4iYoHDWnZrs/Gss5tTXkE9ZCd4r9zhp5PGrlWJPan0I3hUs29dJW0HahmG0u4loqJ7gj6yTb2wswFmETdI/iEjt5X/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453814; c=relaxed/simple;
	bh=fIH7YKNRdnDwHXQJQ+eGO2ojw1OjUb3MgO/Fg4KGOYg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=iJGUkSOYxNE5pH8g9IM+vCagNZkTICLgdthYgz77Yw0vmZw9NkDMYlw4nHr9M0uL5yF0N8mvoPnWJRc5ZDQh2AWA6eBn/h0osYJj0wvGAi2OGGEFLnBEG5tlmkbZCk56xvYSfl8zLpInmmOJKRAezjKIrWqGXrevOXRH9uzd84s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jmEu1u4g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+QVs0orI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jmEu1u4g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+QVs0orI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 152C121237;
	Tue, 12 Nov 2024 23:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731453809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzaWT5C7u+Ov4TZ3S5mDntEpKItEmq6x9TMLIPhviXE=;
	b=jmEu1u4gZFCIPtOmP4w0XWxxFC8SXBgvFMfPb634a1UasilqiplyjT7/QOBCLeFK3MoJPf
	V5v+N8tJ96rrSqoCo+bhdiZ0TC6dPkddOgteZ6TY8WKbU7MEngdPovT4a7/fevDh+m8swr
	4W2HCb+qbjMkeks6/lhLWY2wZmOOej8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731453809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzaWT5C7u+Ov4TZ3S5mDntEpKItEmq6x9TMLIPhviXE=;
	b=+QVs0orIMziYHu8ETvOUZIJWPuuoCOIKSS5SnnN46vkgTBsGndFbXRI1VznsoEykuIUrb2
	l4RkRJDCRouT0mAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731453809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzaWT5C7u+Ov4TZ3S5mDntEpKItEmq6x9TMLIPhviXE=;
	b=jmEu1u4gZFCIPtOmP4w0XWxxFC8SXBgvFMfPb634a1UasilqiplyjT7/QOBCLeFK3MoJPf
	V5v+N8tJ96rrSqoCo+bhdiZ0TC6dPkddOgteZ6TY8WKbU7MEngdPovT4a7/fevDh+m8swr
	4W2HCb+qbjMkeks6/lhLWY2wZmOOej8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731453809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzaWT5C7u+Ov4TZ3S5mDntEpKItEmq6x9TMLIPhviXE=;
	b=+QVs0orIMziYHu8ETvOUZIJWPuuoCOIKSS5SnnN46vkgTBsGndFbXRI1VznsoEykuIUrb2
	l4RkRJDCRouT0mAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29A7B13301;
	Tue, 12 Nov 2024 23:23:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id veJqNG3jM2dqFAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 12 Nov 2024 23:23:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Olga Kornievskaia" <aglo@umich.edu>
Cc: "Jeff Layton" <jlayton@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nfsd: allow for up to 32 callback session slots
In-reply-to:
 <CAN-5tyEh6MrTBQQt99+VO4FcnX3x1DX7XOpRwmkXFryqzr95Jw@mail.gmail.com>
References:
 <>, <CAN-5tyEh6MrTBQQt99+VO4FcnX3x1DX7XOpRwmkXFryqzr95Jw@mail.gmail.com>
Date: Wed, 13 Nov 2024 10:23:23 +1100
Message-id: <173145380308.1734440.15862582751276033840@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 12 Nov 2024, Olga Kornievskaia wrote:
> On Mon, Nov 11, 2024 at 12:40=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> >
> > On Mon, 2024-11-11 at 12:17 -0500, Olga Kornievskaia wrote:
> > > On Mon, Nov 11, 2024 at 9:56=E2=80=AFAM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> > > >
> > > > On Mon, Nov 11, 2024 at 08:22:07AM -0500, Jeff Layton wrote:
> > > > > On Sun, 2024-11-10 at 21:19 -0500, Olga Kornievskaia wrote:
> > > > > > On Sat, Nov 9, 2024 at 2:26=E2=80=AFPM Jeff Layton <jlayton@kerne=
l.org> wrote:
> > > > > > >
> > > > > > > On Sat, 2024-11-09 at 13:50 -0500, Olga Kornievskaia wrote:
> > > > > > > > On Tue, Nov 5, 2024 at 7:31=E2=80=AFPM Jeff Layton <jlayton@k=
ernel.org> wrote:
> > > > > > > > >
> > > > > > > > > nfsd currently only uses a single slot in the callback chan=
nel, which is
> > > > > > > > > proving to be a bottleneck in some cases. Widen the callbac=
k channel to
> > > > > > > > > a max of 32 slots (subject to the client's target_maxreqs v=
alue).
> > > > > > > > >
> > > > > > > > > Change the cb_holds_slot boolean to an integer that tracks =
the current
> > > > > > > > > slot number (with -1 meaning "unassigned").  Move the callb=
ack slot
> > > > > > > > > tracking info into the session. Add a new u32 that acts as =
a bitmap to
> > > > > > > > > track which slots are in use, and a u32 to track the latest=
 callback
> > > > > > > > > target_slotid that the client reports. To protect the new f=
ields, add
> > > > > > > > > a new per-session spinlock (the se_lock). Fix nfsd41_cb_get=
_slot to always
> > > > > > > > > search for the lowest slotid (using ffs()).
> > > > > > > > >
> > > > > > > > > Finally, convert the session->se_cb_seq_nr field into an ar=
ray of
> > > > > > > > > counters and add the necessary handling to ensure that the =
seqids get
> > > > > > > > > reset at the appropriate times.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > > > > > > ---
> > > > > > > > > v3 has a bug that Olga hit in testing. This version should =
fix the wait
> > > > > > > > > when the slot table is full. Olga, if you're able to test t=
his one, it
> > > > > > > > > would be much appreciated.
> > > > > > > > > ---
> > > > > > > > > Changes in v4:
> > > > > > > > > - Fix the wait for a slot in nfsd41_cb_get_slot()
> > > > > > > > > - Link to v3: https://lore.kernel.org/r/20241030-bcwide-v3-=
0-c2df49a26c45@kernel.org
> > > > > > > > >
> > > > > > > > > Changes in v3:
> > > > > > > > > - add patch to convert se_flags to single se_dead bool
> > > > > > > > > - fix off-by-one bug in handling of NFSD_BC_SLOT_TABLE_MAX
> > > > > > > > > - don't reject target highest slot value of 0
> > > > > > > > > - Link to v2: https://lore.kernel.org/r/20241029-bcwide-v2-=
1-e9010b6ef55d@kernel.org
> > > > > > > > >
> > > > > > > > > Changes in v2:
> > > > > > > > > - take cl_lock when fetching fields from session to be enco=
ded
> > > > > > > > > - use fls() instead of bespoke highest_unset_index()
> > > > > > > > > - rename variables in several functions with more descripti=
ve names
> > > > > > > > > - clamp limit of for loop in update_cb_slot_table()
> > > > > > > > > - re-add missing rpc_wake_up_queued_task() call
> > > > > > > > > - fix slotid check in decode_cb_sequence4resok()
> > > > > > > > > - add new per-session spinlock
> > > > > > > > > ---
> > > > > > > > >  fs/nfsd/nfs4callback.c | 113 +++++++++++++++++++++++++++++=
+++++++-------------
> > > > > > > > >  fs/nfsd/nfs4state.c    |  11 +++--
> > > > > > > > >  fs/nfsd/state.h        |  15 ++++---
> > > > > > > > >  fs/nfsd/trace.h        |   2 +-
> > > > > > > > >  4 files changed, 101 insertions(+), 40 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > > > > > > > > index e38fa834b3d91333acf1425eb14c644e5d5f2601..47a67833390=
7eaa92db305dada503704c34c15b2 100644
> > > > > > > > > --- a/fs/nfsd/nfs4callback.c
> > > > > > > > > +++ b/fs/nfsd/nfs4callback.c
> > > > > > > > > @@ -406,6 +406,19 @@ encode_cb_getattr4args(struct xdr_stre=
am *xdr, struct nfs4_cb_compound_hdr *hdr,
> > > > > > > > >         hdr->nops++;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static u32 highest_slotid(struct nfsd4_session *ses)
> > > > > > > > > +{
> > > > > > > > > +       u32 idx;
> > > > > > > > > +
> > > > > > > > > +       spin_lock(&ses->se_lock);
> > > > > > > > > +       idx =3D fls(~ses->se_cb_slot_avail);
> > > > > > > > > +       if (idx > 0)
> > > > > > > > > +               --idx;
> > > > > > > > > +       idx =3D max(idx, ses->se_cb_highest_slot);
> > > > > > > > > +       spin_unlock(&ses->se_lock);
> > > > > > > > > +       return idx;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  /*
> > > > > > > > >   * CB_SEQUENCE4args
> > > > > > > > >   *
> > > > > > > > > @@ -432,15 +445,35 @@ static void encode_cb_sequence4args(s=
truct xdr_stream *xdr,
> > > > > > > > >         encode_sessionid4(xdr, session);
> > > > > > > > >
> > > > > > > > >         p =3D xdr_reserve_space(xdr, 4 + 4 + 4 + 4 + 4);
> > > > > > > > > -       *p++ =3D cpu_to_be32(session->se_cb_seq_nr);      /=
* csa_sequenceid */
> > > > > > > > > -       *p++ =3D xdr_zero;                        /* csa_sl=
otid */
> > > > > > > > > -       *p++ =3D xdr_zero;                        /* csa_hi=
ghest_slotid */
> > > > > > > > > +       *p++ =3D cpu_to_be32(session->se_cb_seq_nr[cb->cb_h=
eld_slot]);    /* csa_sequenceid */
> > > > > > > > > +       *p++ =3D cpu_to_be32(cb->cb_held_slot);           /=
* csa_slotid */
> > > > > > > > > +       *p++ =3D cpu_to_be32(highest_slotid(session)); /* c=
sa_highest_slotid */
> > > > > > > > >         *p++ =3D xdr_zero;                        /* csa_ca=
chethis */
> > > > > > > > >         xdr_encode_empty_array(p);              /* csa_refe=
rring_call_lists */
> > > > > > > > >
> > > > > > > > >         hdr->nops++;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static void update_cb_slot_table(struct nfsd4_session *ses=
, u32 target)
> > > > > > > > > +{
> > > > > > > > > +       /* No need to do anything if nothing changed */
> > > > > > > > > +       if (likely(target =3D=3D READ_ONCE(ses->se_cb_highe=
st_slot)))
> > > > > > > > > +               return;
> > > > > > > > > +
> > > > > > > > > +       spin_lock(&ses->se_lock);
> > > > > > > > > +       if (target > ses->se_cb_highest_slot) {
> > > > > > > > > +               int i;
> > > > > > > > > +
> > > > > > > > > +               target =3D min(target, NFSD_BC_SLOT_TABLE_M=
AX);
> > > > > > > > > +
> > > > > > > > > +               /* Growing the slot table. Reset any new se=
quences to 1 */
> > > > > > > > > +               for (i =3D ses->se_cb_highest_slot + 1; i <=
=3D target; ++i)
> > > > > > > > > +                       ses->se_cb_seq_nr[i] =3D 1;
> > > > > > > > > +       }
> > > > > > > > > +       ses->se_cb_highest_slot =3D target;
> > > > > > > > > +       spin_unlock(&ses->se_lock);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  /*
> > > > > > > > >   * CB_SEQUENCE4resok
> > > > > > > > >   *
> > > > > > > > > @@ -468,7 +501,7 @@ static int decode_cb_sequence4resok(str=
uct xdr_stream *xdr,
> > > > > > > > >         struct nfsd4_session *session =3D cb->cb_clp->cl_cb=
_session;
> > > > > > > > >         int status =3D -ESERVERFAULT;
> > > > > > > > >         __be32 *p;
> > > > > > > > > -       u32 dummy;
> > > > > > > > > +       u32 seqid, slotid, target;
> > > > > > > > >
> > > > > > > > >         /*
> > > > > > > > >          * If the server returns different values for sessi=
onID, slotID or
> > > > > > > > > @@ -484,21 +517,22 @@ static int decode_cb_sequence4resok(s=
truct xdr_stream *xdr,
> > > > > > > > >         }
> > > > > > > > >         p +=3D XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
> > > > > > > > >
> > > > > > > > > -       dummy =3D be32_to_cpup(p++);
> > > > > > > > > -       if (dummy !=3D session->se_cb_seq_nr) {
> > > > > > > > > +       seqid =3D be32_to_cpup(p++);
> > > > > > > > > +       if (seqid !=3D session->se_cb_seq_nr[cb->cb_held_sl=
ot]) {
> > > > > > > > >                 dprintk("NFS: %s Invalid sequence number\n"=
, __func__);
> > > > > > > > >                 goto out;
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > -       dummy =3D be32_to_cpup(p++);
> > > > > > > > > -       if (dummy !=3D 0) {
> > > > > > > > > +       slotid =3D be32_to_cpup(p++);
> > > > > > > > > +       if (slotid !=3D cb->cb_held_slot) {
> > > > > > > > >                 dprintk("NFS: %s Invalid slotid\n", __func_=
_);
> > > > > > > > >                 goto out;
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > -       /*
> > > > > > > > > -        * FIXME: process highest slotid and target highest=
 slotid
> > > > > > > > > -        */
> > > > > > > > > +       p++; // ignore current highest slot value
> > > > > > > > > +
> > > > > > > > > +       target =3D be32_to_cpup(p++);
> > > > > > > > > +       update_cb_slot_table(session, target);
> > > > > > > > >         status =3D 0;
> > > > > > > > >  out:
> > > > > > > > >         cb->cb_seq_status =3D status;
> > > > > > > > > @@ -1203,6 +1237,22 @@ void nfsd4_change_callback(struct nf=
s4_client *clp, struct nfs4_cb_conn *conn)
> > > > > > > > >         spin_unlock(&clp->cl_lock);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static int grab_slot(struct nfsd4_session *ses)
> > > > > > > > > +{
> > > > > > > > > +       int idx;
> > > > > > > > > +
> > > > > > > > > +       spin_lock(&ses->se_lock);
> > > > > > > > > +       idx =3D ffs(ses->se_cb_slot_avail) - 1;
> > > > > > > > > +       if (idx < 0 || idx > ses->se_cb_highest_slot) {
> > > > > > > > > +               spin_unlock(&ses->se_lock);
> > > > > > > > > +               return -1;
> > > > > > > > > +       }
> > > > > > > > > +       /* clear the bit for the slot */
> > > > > > > > > +       ses->se_cb_slot_avail &=3D ~BIT(idx);
> > > > > > > > > +       spin_unlock(&ses->se_lock);
> > > > > > > > > +       return idx;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  /*
> > > > > > > > >   * There's currently a single callback channel slot.
> > > > > > > > >   * If the slot is available, then mark it busy.  Otherwise=
, set the
> > > > > > > > > @@ -1211,28 +1261,32 @@ void nfsd4_change_callback(struct n=
fs4_client *clp, struct nfs4_cb_conn *conn)
> > > > > > > > >  static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, =
struct rpc_task *task)
> > > > > > > > >  {
> > > > > > > > >         struct nfs4_client *clp =3D cb->cb_clp;
> > > > > > > > > +       struct nfsd4_session *ses =3D clp->cl_cb_session;
> > > > > > > > >
> > > > > > > > > -       if (!cb->cb_holds_slot &&
> > > > > > > > > -           test_and_set_bit(0, &clp->cl_cb_slot_busy) !=3D=
 0) {
> > > > > > > > > +       if (cb->cb_held_slot >=3D 0)
> > > > > > > > > +               return true;
> > > > > > > > > +       cb->cb_held_slot =3D grab_slot(ses);
> > > > > > > > > +       if (cb->cb_held_slot < 0) {
> > > > > > > > >                 rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
> > > > > > > > >                 /* Race breaker */
> > > > > > > > > -               if (test_and_set_bit(0, &clp->cl_cb_slot_bu=
sy) !=3D 0) {
> > > > > > > > > -                       dprintk("%s slot is busy\n", __func=
__);
> > > > > > > > > +               cb->cb_held_slot =3D grab_slot(ses);
> > > > > > > > > +               if (cb->cb_held_slot < 0)
> > > > > > > > >                         return false;
> > > > > > > > > -               }
> > > > > > > > >                 rpc_wake_up_queued_task(&clp->cl_cb_waitq, =
task);
> > > > > > > > >         }
> > > > > > > > > -       cb->cb_holds_slot =3D true;
> > > > > > > > >         return true;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  static void nfsd41_cb_release_slot(struct nfsd4_callback *=
cb)
> > > > > > > > >  {
> > > > > > > > >         struct nfs4_client *clp =3D cb->cb_clp;
> > > > > > > > > +       struct nfsd4_session *ses =3D clp->cl_cb_session;
> > > > > > > > >
> > > > > > > > > -       if (cb->cb_holds_slot) {
> > > > > > > > > -               cb->cb_holds_slot =3D false;
> > > > > > > > > -               clear_bit(0, &clp->cl_cb_slot_busy);
> > > > > > > > > +       if (cb->cb_held_slot >=3D 0) {
> > > > > > > > > +               spin_lock(&ses->se_lock);
> > > > > > > > > +               ses->se_cb_slot_avail |=3D BIT(cb->cb_held_=
slot);
> > > > > > > > > +               spin_unlock(&ses->se_lock);
> > > > > > > > > +               cb->cb_held_slot =3D -1;
> > > > > > > > >                 rpc_wake_up_next(&clp->cl_cb_waitq);
> > > > > > > > >         }
> > > > > > > > >  }
> > > > > > > > > @@ -1249,8 +1303,8 @@ static void nfsd41_destroy_cb(struct =
nfsd4_callback *cb)
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  /*
> > > > > > > > > - * TODO: cb_sequence should support referring call lists, =
cachethis, multiple
> > > > > > > > > - * slots, and mark callback channel down on communication =
errors.
> > > > > > > > > + * TODO: cb_sequence should support referring call lists, =
cachethis,
> > > > > > > > > + * and mark callback channel down on communication errors.
> > > > > > > > >   */
> > > > > > > > >  static void nfsd4_cb_prepare(struct rpc_task *task, void *=
calldata)
> > > > > > > > >  {
> > > > > > > > > @@ -1292,7 +1346,7 @@ static bool nfsd4_cb_sequence_done(st=
ruct rpc_task *task, struct nfsd4_callback
> > > > > > > > >                 return true;
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > -       if (!cb->cb_holds_slot)
> > > > > > > > > +       if (cb->cb_held_slot < 0)
> > > > > > > > >                 goto need_restart;
> > > > > > > > >
> > > > > > > > >         /* This is the operation status code for CB_SEQUENC=
E */
> > > > > > > > > @@ -1306,10 +1360,10 @@ static bool nfsd4_cb_sequence_done(=
struct rpc_task *task, struct nfsd4_callback
> > > > > > > > >                  * If CB_SEQUENCE returns an error, then th=
e state of the slot
> > > > > > > > >                  * (sequence ID, cached reply) MUST NOT cha=
nge.
> > > > > > > > >                  */
> > > > > > > > > -               ++session->se_cb_seq_nr;
> > > > > > > > > +               ++session->se_cb_seq_nr[cb->cb_held_slot];
> > > > > > > > >                 break;
> > > > > > > > >         case -ESERVERFAULT:
> > > > > > > > > -               ++session->se_cb_seq_nr;
> > > > > > > > > +               ++session->se_cb_seq_nr[cb->cb_held_slot];
> > > > > > > > >                 nfsd4_mark_cb_fault(cb->cb_clp);
> > > > > > > > >                 ret =3D false;
> > > > > > > > >                 break;
> > > > > > > > > @@ -1335,17 +1389,16 @@ static bool nfsd4_cb_sequence_done(=
struct rpc_task *task, struct nfsd4_callback
> > > > > > > > >         case -NFS4ERR_BADSLOT:
> > > > > > > > >                 goto retry_nowait;
> > > > > > > > >         case -NFS4ERR_SEQ_MISORDERED:
> > > > > > > > > -               if (session->se_cb_seq_nr !=3D 1) {
> > > > > > > > > -                       session->se_cb_seq_nr =3D 1;
> > > > > > > > > +               if (session->se_cb_seq_nr[cb->cb_held_slot]=
 !=3D 1) {
> > > > > > > > > +                       session->se_cb_seq_nr[cb->cb_held_s=
lot] =3D 1;
> > > > > > > > >                         goto retry_nowait;
> > > > > > > > >                 }
> > > > > > > > >                 break;
> > > > > > > > >         default:
> > > > > > > > >                 nfsd4_mark_cb_fault(cb->cb_clp);
> > > > > > > > >         }
> > > > > > > > > -       nfsd41_cb_release_slot(cb);
> > > > > > > > > -
> > > > > > > > >         trace_nfsd_cb_free_slot(task, cb);
> > > > > > > > > +       nfsd41_cb_release_slot(cb);
> > > > > > > > >
> > > > > > > > >         if (RPC_SIGNALLED(task))
> > > > > > > > >                 goto need_restart;
> > > > > > > > > @@ -1565,7 +1618,7 @@ void nfsd4_init_cb(struct nfsd4_callb=
ack *cb, struct nfs4_client *clp,
> > > > > > > > >         INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
> > > > > > > > >         cb->cb_status =3D 0;
> > > > > > > > >         cb->cb_need_restart =3D false;
> > > > > > > > > -       cb->cb_holds_slot =3D false;
> > > > > > > > > +       cb->cb_held_slot =3D -1;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  /**
> > > > > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > > > > index baf7994131fe1b0a4715174ba943fd2a9882aa12..75557e7cc92=
65517f51952563beaa4cfe8adcc3f 100644
> > > > > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > > > > @@ -2002,6 +2002,9 @@ static struct nfsd4_session *alloc_se=
ssion(struct nfsd4_channel_attrs *fattrs,
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > >         memcpy(&new->se_fchannel, fattrs, sizeof(struct nfs=
d4_channel_attrs));
> > > > > > > > > +       new->se_cb_slot_avail =3D ~0U;
> > > > > > > > > +       new->se_cb_highest_slot =3D battrs->maxreqs - 1;
> > > > > > > > > +       spin_lock_init(&new->se_lock);
> > > > > > > > >         return new;
> > > > > > > > >  out_free:
> > > > > > > > >         while (i--)
> > > > > > > > > @@ -2132,11 +2135,14 @@ static void init_session(struct svc=
_rqst *rqstp, struct nfsd4_session *new, stru
> > > > > > > > >
> > > > > > > > >         INIT_LIST_HEAD(&new->se_conns);
> > > > > > > > >
> > > > > > > > > -       new->se_cb_seq_nr =3D 1;
> > > > > > > > > +       atomic_set(&new->se_ref, 0);
> > > > > > > > >         new->se_dead =3D false;
> > > > > > > > >         new->se_cb_prog =3D cses->callback_prog;
> > > > > > > > >         new->se_cb_sec =3D cses->cb_sec;
> > > > > > > > > -       atomic_set(&new->se_ref, 0);
> > > > > > > > > +
> > > > > > > > > +       for (idx =3D 0; idx < NFSD_BC_SLOT_TABLE_MAX; ++idx)
> > > > > > > > > +               new->se_cb_seq_nr[idx] =3D 1;
> > > > > > > > > +
> > > > > > > > >         idx =3D hash_sessionid(&new->se_sessionid);
> > > > > > > > >         list_add(&new->se_hash, &nn->sessionid_hashtbl[idx]=
);
> > > > > > > > >         spin_lock(&clp->cl_lock);
> > > > > > > > > @@ -3159,7 +3165,6 @@ static struct nfs4_client *create_cli=
ent(struct xdr_netobj name,
> > > > > > > > >         kref_init(&clp->cl_nfsdfs.cl_ref);
> > > > > > > > >         nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4=
_CLNT_CB_NULL);
> > > > > > > > >         clp->cl_time =3D ktime_get_boottime_seconds();
> > > > > > > > > -       clear_bit(0, &clp->cl_cb_slot_busy);
> > > > > > > > >         copy_verf(clp, verf);
> > > > > > > > >         memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_st=
orage));
> > > > > > > > >         clp->cl_cb_session =3D NULL;
> > > > > > > > > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > > > > > > > > index d22e4f2c9039324a0953a9e15a3c255fb8ee1a44..848d023cb30=
8f0b69916c4ee34b09075708f0de3 100644
> > > > > > > > > --- a/fs/nfsd/state.h
> > > > > > > > > +++ b/fs/nfsd/state.h
> > > > > > > > > @@ -71,8 +71,8 @@ struct nfsd4_callback {
> > > > > > > > >         struct work_struct cb_work;
> > > > > > > > >         int cb_seq_status;
> > > > > > > > >         int cb_status;
> > > > > > > > > +       int cb_held_slot;
> > > > > > > > >         bool cb_need_restart;
> > > > > > > > > -       bool cb_holds_slot;
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > >  struct nfsd4_callback_ops {
> > > > > > > > > @@ -307,6 +307,9 @@ struct nfsd4_conn {
> > > > > > > > >         unsigned char cn_flags;
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > > +/* Highest slot index that nfsd implements in NFSv4.1+ bac=
kchannel */
> > > > > > > > > +#define NFSD_BC_SLOT_TABLE_MAX (sizeof(u32) * 8 - 1)
> > > > > > > >
> > > > > > > > Are there some values that are known not to work? I was exper=
imenting
> > > > > > > > with values and set it to 2 and 4 and the kernel oopsed. I un=
derstand
> > > > > > > > it's not a configurable value but it would still be good to k=
now the
> > > > > > > > expectations...
> > > > > > > >
> > > > > > > > [  198.625021] Unable to handle kernel paging request at virt=
ual
> > > > > > > > address dfff800020000000
> > > > > > > > [  198.625870] KASAN: probably user-memory-access in range
> > > > > > > > [0x0000000100000000-0x0000000100000007]
> > > > > > > > [  198.626444] Mem abort info:
> > > > > > > > [  198.626630]   ESR =3D 0x0000000096000005
> > > > > > > > [  198.626882]   EC =3D 0x25: DABT (current EL), IL =3D 32 bi=
ts
> > > > > > > > [  198.627234]   SET =3D 0, FnV =3D 0
> > > > > > > > [  198.627441]   EA =3D 0, S1PTW =3D 0
> > > > > > > > [  198.627627]   FSC =3D 0x05: level 1 translation fault
> > > > > > > > [  198.627859] Data abort info:
> > > > > > > > [  198.628000]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00=
000000
> > > > > > > > [  198.628272]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =
=3D 0
> > > > > > > > [  198.628619]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs=
 =3D 0
> > > > > > > > [  198.628967] [dfff800020000000] address between user and ke=
rnel address ranges
> > > > > > > > [  198.629438] Internal error: Oops: 0000000096000005 [#1] SMP
> > > > > > > > [  198.629806] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_r=
esolver
> > > > > > > > nfs netfs nfnetlink_queue nfnetlink_log nfnetlink bluetooth c=
fg80211
> > > > > > > > rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl =
lockd
> > > > > > > > grace isofs uinput snd_seq_dummy snd_hrtimer vsock_loopback
> > > > > > > > vmw_vsock_virtio_transport_common qrtr rfkill vmw_vsock_vmci_=
transport
> > > > > > > > vsock sunrpc vfat fat snd_hda_codec_generic snd_hda_intel
> > > > > > > > snd_intel_dspcfg snd_hda_codec snd_hda_core snd_hwdep snd_seq=
 uvcvideo
> > > > > > > > videobuf2_vmalloc snd_seq_device videobuf2_memops uvc videobu=
f2_v4l2
> > > > > > > > videodev snd_pcm videobuf2_common mc snd_timer snd vmw_vmci s=
oundcore
> > > > > > > > xfs libcrc32c vmwgfx drm_ttm_helper ttm nvme drm_kms_helper
> > > > > > > > crct10dif_ce nvme_core ghash_ce sha2_ce sha256_arm64 sha1_ce =
drm
> > > > > > > > nvme_auth sr_mod cdrom e1000e sg fuse
> > > > > > > > [  198.633799] CPU: 5 UID: 0 PID: 6081 Comm: nfsd Kdump: load=
ed Not
> > > > > > > > tainted 6.12.0-rc6+ #47
> > > > > > > > [  198.634345] Hardware name: VMware, Inc. VMware20,1/VBSA, B=
IOS
> > > > > > > > VMW201.00V.21805430.BA64.2305221830 05/22/2023
> > > > > > > > [  198.635014] pstate: 11400005 (nzcV daif +PAN -UAO -TCO +DI=
T -SSBS BTYPE=3D--)
> > > > > > > > [  198.635492] pc : nfsd4_sequence+0x5a0/0x1f60 [nfsd]
> > > > > > > > [  198.635798] lr : nfsd4_sequence+0x340/0x1f60 [nfsd]
> > > > > > > > [  198.636065] sp : ffff8000884977e0
> > > > > > > > [  198.636234] x29: ffff800088497910 x28: ffff0000b1b39280 x2=
7: ffff0000ab508128
> > > > > > > > [  198.636624] x26: ffff0000b1b39298 x25: ffff0000b1b39290 x2=
4: ffff0000a65e1c64
> > > > > > > > [  198.637049] x23: 1fffe000212e6804 x22: ffff000109734024 x2=
1: 1ffff00011092f16
> > > > > > > > [  198.637472] x20: ffff00010aed8000 x19: ffff000109734000 x1=
8: 1fffe0002de20c8b
> > > > > > > > [  198.637883] x17: 0100000000000000 x16: 1ffff0000fcef234 x1=
5: 1fffe000212e600f
> > > > > > > > [  198.638286] x14: ffff80007e779000 x13: ffff80007e7791a0 x1=
2: 0000000000000000
> > > > > > > > [  198.638697] x11: ffff0000a65e1c38 x10: ffff00010aedaca0 x9=
 : 1fffe000215db594
> > > > > > > > [  198.639110] x8 : 1fffe00014cbc387 x7 : ffff0000a65e1c03 x6=
 : ffff0000a65e1c00
> > > > > > > > [  198.639541] x5 : ffff0000a65e1c00 x4 : 0000000020000000 x3=
 : 0000000100000001
> > > > > > > > [  198.639962] x2 : ffff000109730060 x1 : 0000000000000003 x0=
 : dfff800000000000
> > > > > > > > [  198.640332] Call trace:
> > > > > > > > [  198.640460]  nfsd4_sequence+0x5a0/0x1f60 [nfsd]
> > > > > > > > [  198.640715]  nfsd4_proc_compound+0xb94/0x23b0 [nfsd]
> > > > > > > > [  198.640997]  nfsd_dispatch+0x22c/0x718 [nfsd]
> > > > > > > > [  198.641260]  svc_process_common+0x8e8/0x1968 [sunrpc]
> > > > > > > > [  198.641566]  svc_process+0x3d4/0x7e0 [sunrpc]
> > > > > > > > [  198.641827]  svc_handle_xprt+0x828/0xe10 [sunrpc]
> > > > > > > > [  198.642108]  svc_recv+0x2cc/0x6a8 [sunrpc]
> > > > > > > > [  198.642346]  nfsd+0x270/0x400 [nfsd]
> > > > > > > > [  198.642562]  kthread+0x288/0x310
> > > > > > > > [  198.642745]  ret_from_fork+0x10/0x20
> > > > > > > > [  198.642937] Code: f2fbffe0 f9003be4 f94007e2 52800061 (38e=
06880)
> > > > > > > > [  198.643267] SMP: stopping secondary CPUs
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Good catch. I think the problem here is that we don't currently=
 cap the
> > > > > > > initial value of se_cb_highest_slot at NFSD_BC_SLOT_TABLE_MAX. =
Does
> > > > > > > this patch prevent the panic?
> > > > > > >
> > > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > > index 3afe56ab9e0a..839be4ba765a 100644
> > > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > > @@ -2011,7 +2011,7 @@ static struct nfsd4_session *alloc_sessio=
n(struct nfsd4_channel_attrs *fattrs,
> > > > > > >
> > > > > > >         memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_c=
hannel_attrs));
> > > > > > >         new->se_cb_slot_avail =3D ~0U;
> > > > > > > -       new->se_cb_highest_slot =3D battrs->maxreqs - 1;
> > > > > > > +       new->se_cb_highest_slot =3D min(battrs->maxreqs - 1, NF=
SD_BC_SLOT_TABLE_MAX);
> > > > > > >         spin_lock_init(&new->se_lock);
> > > > > > >         return new;
> > > > > > >  out_free:
> > > > > >
> > > > > > It does help. I thought that the CREATE_SESSION reply for the
> > > > > > backchannel would be guided by the NFSD_BC_SLOT_TABLE_MAX value b=
ut
> > > > > > instead it seems like it's not. But yes I can see that the highest
> > > > > > slot used by the server is capped by the NFSD_BC_SLOT_TABLE_MAX v=
alue.
> > > > >
> > > > > Thanks for testing it, Olga.
> > > > >
> > > > > Chuck, would you be OK with folding the above delta into 9ab4c4077d=
e9,
> > > > > or would you rather I resend the patch?
> > > >
> > > > I've folded the above one-liner into the applied patch.
> > > >
> > > > I agree with Tom, I think there's probably a (surprising)
> > > > explanation lurking for not seeing the expected performance
> > > > improvement. I can delay sending the NFSD v6.13 merge window pull
> > > > request for a bit to see if you can get it teased out.
> > >
> > > I would like to raise a couple of issues:
> > > (1) I believe the server should be reporting back an accurate value
> > > for the backchannel session table size. I think if the
> > > NFSD_BC_SLOT_TABLE_MAX was way lower than the client's value then the
> > > client would be wasting resources for its bc session table?
> >
> > Yes, but those resources are 32-bit integer per wasted slot. The Linux
> > client allows for up to 16 slots, so we're wasting 64 bytes per session
> > with this scheme with the Linux client. I didn't think it was worth
> > doing a separate allocation for that.
> >
> > We could make NFSD_BC_SLOT_TABLE_MAX smaller though. Maybe we should
> > match the client's size and make it 15?
> >
> > > ->back_channel->maxreqs gets decoded in nfsd4_decode_create_session()
> > > and is never adjusted for the reply to be based on the
> > > NFSD_BC_SLOT_TABLE_MAX. The problem is currently invisible because
> > > linux client's bc slot table size is 16 and nfsd's is higher.
> > >
> >
> > I'm not sure I understand the problem here. We don't care about most of
> > the backchannel attributes. maxreqs is the only one that matters, and
> > track that in se_cb_highest_slot.
>=20
> Client sends a create_session with cba_back_chan_attrs with max_reqs
> of 16 -- stating that the client can handle 16 slots in it's slot
> table. Server currently doesn't do anything about reflecting back to
> the client its session slot table. It blindly returns what the client
> sent. Say NFSD_BC_SLOT_TABLE_MAX was 4. Server would never use more
> than 4 slots and yet the client would have to create a reply cache
> table for 16 slots. Isn't that poor sportsmanship on behalf of the
> linux server?

RFC8881 section 18.36.2 - Description for CREATE_SESSION

ca_maxrequests:

 The maximum number of concurrent COMPOUND or CB_COMPOUND requests the
 requester will send on the session.  Subsequent requests will each be
 assigned a slot identifier by the requester within the range zero to
 ca_maxrequests - 1 inclusive.  For the backchannel, the server MUST NOT
 change the value the client offers.  For the fore channel, the server
 MAY change the requested value.=20

The "MUST NOT" doesn't seem ambiguous.

NeilBrown

