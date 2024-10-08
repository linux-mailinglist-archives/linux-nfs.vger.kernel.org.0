Return-Path: <linux-nfs+bounces-6918-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660EA993C86
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 03:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A111C2165C
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Oct 2024 01:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E641863E;
	Tue,  8 Oct 2024 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V/XW6T0n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Lm4Ej3zR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V/XW6T0n";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Lm4Ej3zR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C182117BD9;
	Tue,  8 Oct 2024 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728352349; cv=none; b=mtwQ73zuizsOr4baYtOkoUmAUTb/fZ+9puZGh0xpabWBX+FnjheV2UfD2OMZV3ZlAwVm0ero+eWnqykk9XYFbhoVsh71o2JZwwmfKl+3wobnnoR1JadPv8kpKb+9W8smukQIyy+LwkGxQingJx1WKDPRiEd0aj/Za25EfTTUlgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728352349; c=relaxed/simple;
	bh=gDDjxlViTUGObdV7i8J2Bjcr6KVDo8g1FCI3rwsPBK4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Lh0iMe0FXIIs6hU9xF0buv/E6uOCMSQcsbiB/w9/WDt3E15FX0ACk/37b7LQl7o2VOUL/3TO1RVwbSnniXSc3M5nfPmKmK0xJbkzZ3AO0aRFrg4JHQ6mZNHnFArTJoxkA5UipJ6FxyYDROELoxgmDVhOK4LORMU51hjnTBNCdag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V/XW6T0n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Lm4Ej3zR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V/XW6T0n; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Lm4Ej3zR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C99CE1F891;
	Tue,  8 Oct 2024 01:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728352345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wb0RvxEXP61me5Urhg3Sm0XRzCYDlL5A4Q4WY1FIwLU=;
	b=V/XW6T0nyuBj5hxvb4HMSvDByXICb3yyhXc4aIAxgJlsTUQ60hNYmuslAp5PYS51mbGy/t
	pGIvb9BpR7ySsHZk8Z2dRMoMFLQsiWyDPnTXEMAkLtVSHYJyTpB8Vf9j0Nuv2jUGeVGVLt
	xKV3pwCEh3pPgz2PpjK6sBxMo18UMmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728352345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wb0RvxEXP61me5Urhg3Sm0XRzCYDlL5A4Q4WY1FIwLU=;
	b=Lm4Ej3zRx2fh2tmFHvic4ZjilBTEHnEKpu2WLS2MDNbfO5YuDarwtxkWSQELTJ6CubVftd
	iIq68gGSTGZSoRBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728352345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wb0RvxEXP61me5Urhg3Sm0XRzCYDlL5A4Q4WY1FIwLU=;
	b=V/XW6T0nyuBj5hxvb4HMSvDByXICb3yyhXc4aIAxgJlsTUQ60hNYmuslAp5PYS51mbGy/t
	pGIvb9BpR7ySsHZk8Z2dRMoMFLQsiWyDPnTXEMAkLtVSHYJyTpB8Vf9j0Nuv2jUGeVGVLt
	xKV3pwCEh3pPgz2PpjK6sBxMo18UMmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728352345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wb0RvxEXP61me5Urhg3Sm0XRzCYDlL5A4Q4WY1FIwLU=;
	b=Lm4Ej3zRx2fh2tmFHvic4ZjilBTEHnEKpu2WLS2MDNbfO5YuDarwtxkWSQELTJ6CubVftd
	iIq68gGSTGZSoRBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCAEE13A66;
	Tue,  8 Oct 2024 01:52:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TJPRHFeQBGcEOQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 08 Oct 2024 01:52:23 +0000
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
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfsd: fix possible badness in FREE_STATEID
In-reply-to:
 <CAN-5tyE=XkZ9hfGOortUapxCc43_YkgSeN9+7oFf=M8xRFFxTw@mail.gmail.com>
References:
 <>, <CAN-5tyE=XkZ9hfGOortUapxCc43_YkgSeN9+7oFf=M8xRFFxTw@mail.gmail.com>
Date: Tue, 08 Oct 2024 12:52:20 +1100
Message-id: <172835234057.3184596.16273347722668350379@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, 08 Oct 2024, Olga Kornievskaia wrote:
> On Sat, Oct 5, 2024 at 5:09=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
> >
> > On Sun, 06 Oct 2024, Chuck Lever wrote:
> > > On Sat, Oct 05, 2024 at 12:20:48PM -0400, Jeff Layton wrote:
> > > > On Sat, 2024-10-05 at 10:53 -0400, Chuck Lever wrote:
> > > > > On Fri, Oct 04, 2024 at 06:04:03PM -0400, Olga Kornievskaia wrote:
> > > > > > When multiple FREE_STATEIDs are sent for the same delegation stat=
eid,
> > > > > > it can lead to a possible either use-after-tree or counter refcou=
nt
> > > > > > underflow errors.
> > > > > >
> > > > > > In nfsd4_free_stateid() under the client lock we find a delegation
> > > > > > stateid, however the code drops the lock before calling nfs4_put_=
stid(),
> > > > > > that allows another FREE_STATE to find the stateid again. The fir=
st one
> > > > > > will proceed to then free the stateid which leads to either
> > > > > > use-after-free or decrementing already zerod counter.
> > > > > >
> > > > > > CC: stable@vger.kernel.org
> > > > >
> > > > > I assume that the broken commit is pretty old, but this fix does not
> > > > > apply before v6.9 (where sc_status is introduced). I can add
> > > > > "# v6.9+" to the Cc: stable tag.
> > > > >
> > > >
> > > > I don't know. It looks like nfsd4_free_stateid always returned
> > > > NFS4ERR_LOCKS_HELD on a delegation stateid until 3f29cc82a84c.
> > > >
> > > > > But what do folks think about a Fixes: tag?
> > > > >
> > > > > Could be e1ca12dfb1be ("NFSD: added FREE_STATEID operation"), but
> > > > > that doesn't have the switch statement, which was added by
> > > > > 2da1cec713bc ("nfsd4: simplify free_stateid").
> > > > >
> > > > >
> > > >
> > > > Maybe this one?
> > > >
> > > >     3f29cc82a84c nfsd: split sc_status out of sc_type
> > > >
> > > > That particular bit of the code (and the SC_STATUS_CLOSED flag) was
> > > > added in that patch, and I don't think you'd want to apply this patch
> > > > to anything that didn't have it.
> > >
> > > OK, if we believe that 3f29cc82 is where the misbehavior started,
> > > then I can replace the "Cc: stable@" with "Fixes: 3f29cc82a84c".
> >
> > I believe the misbehaviour started with
> > Commit: b0fc29d6fcd0 ("nfsd: Ensure stateids remain unique until they are=
 freed")
> > in v3.18.
> >
> > The bug in the current code is that it assumes that
> >
> >         list_del_init(&dp->dl_recall_lru);
> >
> > actually removes from the the dl_recall_lru, and so a reference must be
> > dropped.  But if it wasn't on the list, then that is wrong.
>=20
> I've actually been chasing a different problem (a UAF) and Ben noticed
> a problem with doing a double free (by double free_stateid) which this
> patch addresses. But, this particular line list_del_init() in
> nfsd4_free_stateid() has been bothering me as I thought this access
> should be guarded by the "state_lock"? Though I have to admit I've
> tried that and it doesn't seem to help my UAF problem. Anyway where
> I'm going with it perhaps the guard "if
> (!list_empty(&dp->dl_recall_lru))" is still needed (not for double
> free_stateid by from other possibilities)?

dl_recall_lru is a bit confusing.

Sometimes it is on nn->del_recall_lru in which case it is protected by
state_lock.
Sometimes it is on clp->cl_revoked in which case it is protected by
clp->cl_lock.
And sometimes it is on reaplist which doesn't need protection.

So it is important to update the state of the delegation when it is
moved between lists or removed from a list.  I think we now do thanks to
your patch, but it wouldn't hurt to audit all accesses again...

NeilBrown


>=20
> I was wondering if the nfsd4_free_stateid() somehow could steal the
> entries from the list while the laundromat is going thru the
> revocation process. The problem I believe is that the laundromat
> thread marks the delegation "revoked" but somehow never ends up
> calling destroy_delegation() (destoy_delegation is the place that
> frees the lease -- but instead we are left with a lease on the file
> which causes a new open to call into break_lease() which ends up doing
> a UAF on a freed delegation stateid -- which was freed by the
> free_stateid).
>=20
>=20
> > So a "if (!list_empty(&dp->dl_recall_lru))" guard might also fix the
> > bug (though adding SC_STATUS_CLOSED is a better fix I think).
> >
> > Prior to the above 3.17 commit, the relevant code was
> >
> >  static void destroy_revoked_delegation(struct nfs4_delegation *dp)
> >  {
> >         list_del_init(&dp->dl_recall_lru);
> >         remove_stid(&dp->dl_stid);
> >         nfs4_put_delegation(dp);
> >  }
> >
> > so the revoked delegation would be removed (remove_stid) from the idr
> > and a subsequent FREE_STATEID request would not find it.
> > The commit removed the remove_stid() call but didn't do anything to
> > prevent the free_stateid being repeated.
> > In that kernel it might have been appropriate to set
> >   dp->dl_stid.sc_type =3D NFS4_CLOSED_DELEG_STID;
> > was done to unhash_delegation() in that patch.
> >
> > So I think we should declare
> > Fixes: b0fc29d6fcd0 ("nfsd: Ensure stateids remain unique until they are =
freed")
> >
> > and be prepared to provide alternate patches for older kernels.
> >
> > NeilBrown
> >
> > >
> > >
> > > > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > > > ---
> > > > > >  fs/nfsd/nfs4state.c | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > index ac1859c7cc9d..56b261608af4 100644
> > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > @@ -7154,6 +7154,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, =
struct nfsd4_compound_state *cstate,
> > > > > >         switch (s->sc_type) {
> > > > > >         case SC_TYPE_DELEG:
> > > > > >                 if (s->sc_status & SC_STATUS_REVOKED) {
> > > > > > +                       s->sc_status |=3D SC_STATUS_CLOSED;
> > > > > >                         spin_unlock(&s->sc_lock);
> > > > > >                         dp =3D delegstateid(s);
> > > > > >                         list_del_init(&dp->dl_recall_lru);
> > > > > > --
> > > > > > 2.43.5
> > > > > >
> > > > >
> > > >
> > > > --
> > > > Jeff Layton <jlayton@kernel.org>
> > >
> > > --
> > > Chuck Lever
> > >
> >
> >
>=20


