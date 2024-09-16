Return-Path: <linux-nfs+bounces-6500-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F8F9799C3
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 03:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7552834D2
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2024 01:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFA328FD;
	Mon, 16 Sep 2024 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KPui8rk4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e11vtiSU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KPui8rk4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e11vtiSU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B736236B
	for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2024 01:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726449482; cv=none; b=cEU0FYnXthp2f6QzuDb4/zgsno5hs6wTjZc4Chjwf/bZnLSVg8zlL9nuxuMeuE2+FSv47e2ICR0XFeZwsmhKpYJNFZS7h1ofkOa9+hYh35jKHUoTHNyNnSADfRu/0qP54THiu+b0H3haBs/YgqaeI86Sa9wp8XRnmpDbM9YdyDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726449482; c=relaxed/simple;
	bh=ymFSd2zVff6PZOUbELWhsh+YoQ3kUz8ZH9c+50D8ODM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Ieh5ECW7a1sc4Z5W3nzyqfHQIqsMGGz9g/rFKSJXNKBoO9W5OxuNGrr0zxd5fQuQge5JZGgWcCWZ07Ui4nS2EkIYTf80m/fjzx4biiYYusCh1z6nvccfa6IASzpE26rSWStP0lHWpARss3Xh8a1IJyT5v9+6cibpdsPRBS67+pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KPui8rk4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e11vtiSU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KPui8rk4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e11vtiSU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B215821B9B;
	Mon, 16 Sep 2024 01:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726449478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dx8puowh7Y+wieaaD2k1PqT+jDn/me3fnBSB8OQhYjM=;
	b=KPui8rk4xF8DFbQDxLva4FEXdUDGoJhxknE1fsa0WwnRox3Ny5XOt4SfUtqhpBOXxIw1I1
	ZaIPyCr/YRfv6dGEiGRZhs6bT9/0kDSweg/6WNK6SQd+QZYzrRvRc8WAzMRnWQHCB0ejfx
	x9LtEeZ8zlqImY7uwpfijF1VCkH9X90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726449478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dx8puowh7Y+wieaaD2k1PqT+jDn/me3fnBSB8OQhYjM=;
	b=e11vtiSUV2CR2BaOHh6XDJ/2MUxWoicOyekzXN7KH8Cz9bk8gsZ7FwK0jbapEZYzQI1F3z
	b3Mbe4Eh/xG2bdAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726449478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dx8puowh7Y+wieaaD2k1PqT+jDn/me3fnBSB8OQhYjM=;
	b=KPui8rk4xF8DFbQDxLva4FEXdUDGoJhxknE1fsa0WwnRox3Ny5XOt4SfUtqhpBOXxIw1I1
	ZaIPyCr/YRfv6dGEiGRZhs6bT9/0kDSweg/6WNK6SQd+QZYzrRvRc8WAzMRnWQHCB0ejfx
	x9LtEeZ8zlqImY7uwpfijF1VCkH9X90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726449478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dx8puowh7Y+wieaaD2k1PqT+jDn/me3fnBSB8OQhYjM=;
	b=e11vtiSUV2CR2BaOHh6XDJ/2MUxWoicOyekzXN7KH8Cz9bk8gsZ7FwK0jbapEZYzQI1F3z
	b3Mbe4Eh/xG2bdAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98FE013A57;
	Mon, 16 Sep 2024 01:17:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EB5uE0SH52YESwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 16 Sep 2024 01:17:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Olga Kornievskaia" <okorniev@redhat.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix delegation_blocked() to block correctly for at
 least 30 seconds
In-reply-to:
 <CACSpFtDNpOMfRt1Msbo4XNaja5_Nuhxd5Vs51UvjCap5Z9-wLg@mail.gmail.com>
References:
 <CACSpFtDNpOMfRt1Msbo4XNaja5_Nuhxd5Vs51UvjCap5Z9-wLg@mail.gmail.com>
Date: Mon, 16 Sep 2024 11:17:48 +1000
Message-id: <172644946897.17050.6911884875937617912@noble.neil.brown.name>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 12 Sep 2024, Olga Kornievskaia wrote:
> On Tue, Sep 10, 2024 at 8:00=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
> >
> > On Mon, 09 Sep 2024, Jeff Layton wrote:
> > > On Mon, 2024-09-09 at 15:06 +1000, NeilBrown wrote:
> > > > The pair of bloom filtered used by delegation_blocked() was intended =
to
> > > > block delegations on given filehandles for between 30 and 60 seconds.=
  A
> > > > new filehandle would be recorded in the "new" bit set.  That would th=
en
> > > > be switch to the "old" bit set between 0 and 30 seconds later, and it
> > > > would remain as the "old" bit set for 30 seconds.
> > > >
> > >
> > > Since we're on the subject...
> > >
> > > 60s seems like an awfully long time to block delegations on an inode.
> > > Recalls generally don't take more than a few seconds when things are
> > > functioning properly.
> > >
> > > Should we swap the bloom filters more often?
> >
> > Or should we take a completely different approach?  Or both?
> > I'm bothered by the fact that this bug in a heuristic caused rename to
> > misbehave this way.  So I did some exploration.
> >
> > try_break_deleg / break_deleg_wait are called:
> >
> >  - notify_change() - chmod_common, chown_common, and vfs_utimes  waits
> >  - vfs_unlink() - do_unlinkat waits for the delegation to be broken
> >  - vfs_link() - do_linkat waits
> >  - vfs_rename() - do_renameat2 waits
> >  - vfs_set_acl() - waits itself
> >  - vfs_remove_acl() - ditto
> >  - __vfs_setxattr_locked() - vfs_setxattr waits
> >  - __vfs_removexattr_locked() - vfs_removexattr waits
> >
> > I would argue that *none* of these justify delaying further delegations
> > once the operation itself has completed.  They aren't the sort of things
> > that suggest on-going cross-client "sharing" which delegations interfere
> > with.
>=20
> I wouldn't discount these operations (at least not rename) from being
> an operation that can't represent "sharing" of files. An example
> workload is where a file gets generated, created, written/read over
> the NFS, but then locally then transferred to another filesystem. I
> can imagine a pipeline, where then file gets filled up and the
> generated data moved to be worked on elsewhere and the same file gets
> filled up again. I think this bug was discovered because of an setup
> where there was a heavy use of these operations (on various files) and
> some got blocked causing problems. For such workload, if we are not
> going to block giving out a delegation do we cause too many
> cb_recalls?

A pipeline as you describe seem to be a case of serial sharing.
Different applications use the same file, but only at different times.
This sort of sharing isn't hurt by delegations.

The sort of sharing the might trigger excessive cb_recalls if
delegations weren't blocked would almost certainly involve file locking
and an expectation that two separate applications would sometimes access
the file concurrently.  When this is happening, neither should get a
delegation.

The problem you saw was really caused by a delegation being given out
while the rename was still happening.
i.e.:
  - the rename starts
  - the delegation is detected and broken
  - the cb_recall is sent.
  - the client opens the file prior to returning the delegation
  - the client gets a new delegation as part of this open
  - the client returns the original delegation
  - the rename loops around and finds a new delegation which it needs
    to break.

The should only loop once unless the recall takes more than 30 seconds.=20
So I'm a bit perplexed that it blocked lock enough to be noticed.  So
maybe there is more going on here than I can see.  Or maybe the recall
is really slow.

In either case I think we want to firmly block delegations while a rename
(unlink etc) is happening, but do not need to continue to block them
after the rename etc completes.

>=20
> > I imagine try_break_lease would increment some counter in ->i_flctx
> > which prevents further leases being taken, and some new call near where
> > break_deleg_wait() is called will decrement that counter.  If waiting
> > for a lease to break, call break_deleg_wait() and retry, else
> > break_deleg_done().
> >
> > Delegations are also broken by calls break_lease() which comes from
> > nfsd_open_break_lease() for conflicting nfsd opens.  I think there *are*
> > indicitive of shares and *should* result in the filehandle being recorded
> > in the bloom filter.
> > Maybe if break_lease() in nfsd_open_break_lease() returns -EWOULDBLOCK,
> > then the filehandle could be added to the bloom filter at that point.
>=20
> What about vfs_truncate() which also calls break_lease?

vfs_truncate() is quite different, though that isn't a good excuse for
me to leave it out.  It uses break_lease() like open does - not
try_break_deleg() like rename.
It can do this because it has called get_write_access() in the inode
which has incremented i_writecount which will prevent leases from being
granted.  But that DOESN'T prevent delegations from being granted.  I
think it should.

>=20
> > do_dentry_open also calls break_lease() but we still want the filehandle
> > to go in the bloom-filter in that case ....  maybe the lm_break callback
> > could check i_writecount and i_readcount and use those to determine if
> > delaying delegations is appropriate.
> >
> > wrt the time to block delegation for, I'm not sure that it matters much.
> > Once we focus the delay on files that are concurrently opened from
> > multiple clients (not both read-only) I think there are some files
> > (most) that are never shared, and some files that are often shared.  We
> > probably don't want delegations for often shared files at all.  So I'd
> > be comfortable blocking delegations on often-shared files for quite a
> > while.
>=20
> So perhaps rename might be an exception among the operations that are
> triggering delegation recalls. Though I think unlink might be similar
> and truncate. Otherwise, perhaps optimizing other operation would be
> useful. However, I would like to ask does the added complexity justify
> the benefits? What kind of workload would be greatly penalized? If we
> imagine the other operations are low occurrence (ie not representing a
> sharing example) then the penalty is just an infrequent 60s block.
>=20

My concern is that the current design is conceptually wrong.
We need to block delegation while rename etc is happening.  We currently
block for 30-60 seconds.  As rename never takes that long, this works.
But I don't like it.

Some day someone might find a workload for which the current delay is
too long.  If we just reduced the size of the delay, we might make it
take less time than a rename, and something unexpected would break.

So I want to fix the design so that it make sense.  Then I won't really
care how long the delay is for.


> > I wouldn't advocate for *longer* than 30 seconds because I don't want
> > the bloom filters to fill up - that significantly reduced their
> > usefulness.  So maybe we could also swap filters when the 'new' one
> > becomes 50% full....
>=20
> I was suggesting changing that value to 15 because it would mean that
> at most the wait would be 30s which is same as what it was before the
> fix but we are imposing at least 15s block and it keeps the filter 'at
> the same capacity as before'.  But of course in the case of heavy
> conflicting operations there will be less blockage and more recalls.
> This is where I was hoping a configurable value might be handy. Or, I
> would instead argue that we implement a heuristic of detecting that
> the server is in a state of frequent delegation recall phase and then
> automatically adjust the value for how long the delegations are
> blocked. Perhaps  we keep a counter in the bloom_filter when a block
> is set and when a threshold is reached we increase the value before we
> swap the filters (yes at the risk of having a full bloom filter but
> because it's better to be cautious in giving out delegations when
> there are frequent recalls?). Then, with perhaps another timer we
> adjust the block time down.... Wouldn't that cover either having
> different NFS clients having conflicting opens or having some workload
> that has NFS/local file system conflicts.
>=20

I agree that as we have been use "0-30 seconds" for 10 year with no
complaints, changing to "15-30 seconds" is safer than change to "30-60
seconds".

I think that if we want to fine-tune further, there are other steps we
could take which might more clearly be helpful.
Currently we only block delegation when a recall happens.  This means
the 30-60 second count is started when a client opens a file and sharing
is detected.  I think we should also start that timer when a client
CLOSES a file which some other client has open.  So if it is ever the
case that to clients have the file open at the same time, we block
delegations until 30-60 seconds after the file has been closed by all
clients.=20

i.e I don't really want to detect "frequent delegation recall".  I want
to detect "ongoing sharing".  In that case I don't want any delegations
or any recall.

Thanks,
NeilBrown

