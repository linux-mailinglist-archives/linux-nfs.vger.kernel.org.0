Return-Path: <linux-nfs+bounces-10951-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B40A7523B
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 22:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F37377A646D
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 21:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553EE1EF37C;
	Fri, 28 Mar 2025 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cv7g+v/U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N5xf2yeh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cv7g+v/U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N5xf2yeh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B701E1E11
	for <linux-nfs@vger.kernel.org>; Fri, 28 Mar 2025 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743198819; cv=none; b=X51YpYEk/JFsaNjFmkwAkdO4Ozio+ZciOwj8+S/cluumV25xZL3Jpah5bm5ZQrBLqsjNdtEdfz6mTBjYKpsVzcO37b9YUDOfuhcjQTaym+ZxVVsMH8hKApX1bzOoF6T0c52sHZaFfy9HnOzJsz3TWH4cra/WF9TH3BOuoMxmkio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743198819; c=relaxed/simple;
	bh=PglGDpWtYiusxP/TdTWbR1vewyulIdgQ/HnXLXW+T2I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=uY3UZJGjBfLmywHZeJj0v+7VZrPk//eLFWGSh/sh9kzbI+l8RBK1E8zmOCY18mv2NKb1EseS7ylojY+CmalhopNgROO24EwmMylXwe1/BYfpERh7EbQsJdTa6PjquTtbhJuxPEhmImx24y1tnjh9LxGOAUNrrbXv9Str8N/VcPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Cv7g+v/U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N5xf2yeh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Cv7g+v/U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N5xf2yeh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 114121F388;
	Fri, 28 Mar 2025 21:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743198815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wC+kpM0AwvG5R74jy3Nu3jORAMG7YKFiUxFQTtZ8v4A=;
	b=Cv7g+v/UC9i01uASkki0X0aL+3gmQx0gWTmrDJ+tCq77Vcwspn89o4ItnjhYe5HBjxDZZ/
	84yJCgH7uWgWlgeAMn+i/Af+yAztDotv/UDs3n0JrGVujrgGD4khSJexvPe0iDCYko5U7m
	ngjRE7fBSoYZtrb4zMtTgTOXrB/RHZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743198815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wC+kpM0AwvG5R74jy3Nu3jORAMG7YKFiUxFQTtZ8v4A=;
	b=N5xf2yehc+n2pUUHbmiP0RxXXY80PaNhrbd1HBttBWqxSHby/yDs2wYPf+dSuSPCbUbz03
	geyCySIYqdFfmvDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743198815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wC+kpM0AwvG5R74jy3Nu3jORAMG7YKFiUxFQTtZ8v4A=;
	b=Cv7g+v/UC9i01uASkki0X0aL+3gmQx0gWTmrDJ+tCq77Vcwspn89o4ItnjhYe5HBjxDZZ/
	84yJCgH7uWgWlgeAMn+i/Af+yAztDotv/UDs3n0JrGVujrgGD4khSJexvPe0iDCYko5U7m
	ngjRE7fBSoYZtrb4zMtTgTOXrB/RHZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743198815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wC+kpM0AwvG5R74jy3Nu3jORAMG7YKFiUxFQTtZ8v4A=;
	b=N5xf2yehc+n2pUUHbmiP0RxXXY80PaNhrbd1HBttBWqxSHby/yDs2wYPf+dSuSPCbUbz03
	geyCySIYqdFfmvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A93A613998;
	Fri, 28 Mar 2025 21:53:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X5VgF1wa52cMcAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 28 Mar 2025 21:53:32 +0000
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
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, chuck.lever@oracle.com,
 jlayton@kernel.org, linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com,
 tom@talpey.com
Subject:
 Re: [PATCH 3/3] nfsd: reset access mask for NLM calls in nfsd_permission
In-reply-to:
 <CAN-5tyHKrbL9DuFxvH6hnL4uwHDZ-d49X8DFBVReCvdh+Qh0XQ@mail.gmail.com>
References:
 <>, <CAN-5tyHKrbL9DuFxvH6hnL4uwHDZ-d49X8DFBVReCvdh+Qh0XQ@mail.gmail.com>
Date: Sat, 29 Mar 2025 08:53:28 +1100
Message-id: <174319880848.9342.18353626790561074601@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
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

On Sat, 29 Mar 2025, Olga Kornievskaia wrote:
> On Thu, Mar 27, 2025 at 9:43=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
> >
> > On Fri, 28 Mar 2025, Olga Kornievskaia wrote:
> > > On Thu, Mar 27, 2025 at 7:54=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
> > > >
> > > > On Sat, 22 Mar 2025, Olga Kornievskaia wrote:
> > > > > NLM locking calls need to pass thru file permission checking
> > > > > and for that prior to calling inode_permission() we need
> > > > > to set appropriate access mask.
> > > > >
> > > > > Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
> > > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > > ---
> > > > >  fs/nfsd/vfs.c | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >
> > > > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > > > index 4021b047eb18..7928ae21509f 100644
> > > > > --- a/fs/nfsd/vfs.c
> > > > > +++ b/fs/nfsd/vfs.c
> > > > > @@ -2582,6 +2582,13 @@ nfsd_permission(struct svc_cred *cred, struc=
t svc_export *exp,
> > > > >       if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
> > > > >               return nfserr_perm;
> > > > >
> > > > > +     /*
> > > > > +      * For the purpose of permission checking of NLM requests,
> > > > > +      * the locker must have READ access or own the file
> > > > > +      */
> > > > > +     if (acc & NFSD_MAY_NLM)
> > > > > +             acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
> > > > > +
> > > >
> > > > I don't agree with this change.
> > > > The only time that NFSD_MAY_NLM is set, NFSD_MAY_OWNER_OVERRIDE is al=
so
> > > > set.  So that part of the change adds no value.
> > > >
> > > > This change only affects the case where a write lock is being request=
ed.
> > > > In that case acc will contains NFSD_MAY_WRITE but not NFSD_MAY_READ.
> > > > This change will set NFSD_MAY_READ.  Is that really needed?
> > > >
> > > > Can you please describe the particular problem you saw that is fixed =
by
> > > > this patch?  If there is a problem and we do need to add NFSD_MAY_REA=
D,
> > > > then I would rather it were done in nlm_fopen().
> > >
> > > set export policy with (sec=3Dkrb5:...) then mount with sec=3Dkrb5,vers=
=3D3,
> > > then ask for an exclusive flock(), it would fail.
> > >
> > > The reason it fails is because nlm_fopen() translates lock to open
> > > with WRITE. Prior to patch 4cc9b9f2bf4d, the access would be set to
> > > acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE; before calling into
> > > inode_permission(). The patch changed it and lead to lock no longer
> > > being given out with sec=3Dkrb5 policy.
> >
> > And do you have WRITE access to the file?
> >
> > check_fmode_for_setlk() in fs/locks.c suggests that for F_WRLCK to be
> > granted the file must be open for FMODE_WRITE.
> > So when an exclusive lock request arrives via NLM, nlm_lookup_file()
> > calls nlm_do_fopen() with a mode of O_WRONLY and that causes
> > nfsd_permission() to check that the caller has write access to the file.
> >
> > So if you are trying to get an exclusive lock to a file that you don't
> > have write access to, then it should fail.
> > If, however, you do have write access to the file - I cannot see why
> > asking for NFSD_MAY_READ instead of NFSD_MAY_WRITE would help.
>=20
> That's correct, the user doing flock() does NOT have write access to
> the file. Yet prior to the 4cc9b9f2bf4d, that access was allowed. If
> that was a bug then my bad. I assumed it was regression.
>=20
> It's interesting to me that on an XFS file system, I can create a file
> owned by root (on a local filesystem) and then request an exclusive
> lock on it (as a user -- no write permissions).

"flock" is the missing piece.  I always thought it was a little odd
implementing flock locks over NFS using byte-range locking.  Not
necessarily wrong, but definitely odd.

The man page for fcntl says=20

   In order to place a read lock, fd must be open for reading.  In order
   to place a write lock, fd must be open for writing.  To place both
   types of lock, open a file read-write.

So byte-range locks require a consistent open mode.

The man page for flock says

    A shared or exclusive lock can be placed on a file regardless of the
    mode in which the file was opened.

Since the NFS client started using NLM (or v4 LOCK) for flock requests,
we cannot know if a request is flock or fcntl so we cannot check the
"correct" permissions.  We have to rely on the client doing the
permission checking.

So it isn't really correct to check for either READ or WRITE.

This is awkward because nfsd doesn't just check permissions.  It has to
open the file and say what mode it is opening for.  This is apparently
important when re-exporting NFS according to

Commit: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")

So if you try an exclusive flock on a re-exported NFS file (reexported
over v3) that you have open for READ but do not have write permission
for, then the client will allow it, but the intermediate server will try
a O_WRITE open which the final server will reject.
(does re-export work over v3??)

There is no way to make this "work".  As I said: sending flock requests
over NFS was an interesting choice.
For v4 re-export it isn't a problem because the intermediate server
knows what mode the file was opened for on the client.

So what do we do?  Whatever we do needs a comment explaining that flock
vs fcntl is the problem.
Possibly we should not require read or write access - and just trust the
client.  Alternately we could stick with the current practice of
requiring READ but not WRITE - it would be rare to lock a file which you
don't have read access to.

So yes: we do need a patch here.  I would suggest something like:

 /* An NLM request may be from fcntl() which requires the open mode to
  * match to lock mode or may be from flock() which allows any lock mode
  * with any open mode.  "acc" here indicates the lock mode but we must
  * do permission check reflecting the open mode which we cannot know.
  * For simplicity and historical continuity, always only check for
  * READ access
  */
 if (acc & NFSD_MAY_NLM)
	acc =3D (acc & ~NFSD_MAY_WRITE) | NFSD_MAY_READ;

I'd prefer to leave the MAY_OWNER_OVERRIDE setting in nlm_fopen().

Thanks,
NeilBrown

