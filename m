Return-Path: <linux-nfs+bounces-1284-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB46837AE8
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 01:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A3D2927CD
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jan 2024 00:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C640B133424;
	Tue, 23 Jan 2024 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2FRPJoNO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OSZQ6xWJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i4zC3SyP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MXVd4xdE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034A13340F
	for <linux-nfs@vger.kernel.org>; Tue, 23 Jan 2024 00:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969130; cv=none; b=evPY//DA4SSTm/GJnuWdcpKFwtAumEaJLOHX/3aCaS7IEZwdOsRMp6duTCa6f9kcWavZ/d9kmZnWBp+UIVFx6+ZZbOqNj2vwN9kdIQ9Fcn+YHS3VFJZ+A9W3rq6cLVK//KYFsdD8X2nhygWfy+E3Dyc3QvpelUxYaxBAO1lIwCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969130; c=relaxed/simple;
	bh=UwMk3rcv/3JHzeGV3WErQkpx+1wuwZHrl7Hkscompvk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=R31dqxao5sQT0Ktq4UWbRVr7vOJfDAWjKN7Dqw9ufd5D08nP+wOeNQ8bDgOwAO3M+ZHBcNKrNBhN9Nuae/jpD4FdVgw2w2HqmMWiGbYyDae6sByzEzUkZMjEZZgg+/5FTeF6I4m/FuZxzro6ed0lUw+Pv+t/tQ3gYFN3oQuCbiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2FRPJoNO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OSZQ6xWJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i4zC3SyP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MXVd4xdE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E12E21F393;
	Tue, 23 Jan 2024 00:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705969127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3E9tNqOjt4gUSUB+S3aJ3k3drtQolgc/BOfzrCPki4=;
	b=2FRPJoNOjmzmeYNL3TiX6nCqjh8v+qKGZ/AbX4uktqoFdKBQZlLXME9sZekQg7FSzqyneV
	zPI80M3yK6R2IfvQy3XxxlE3UTCIezsqkMrDXJsUoLv/m93VJxeK8s9x7KGQ8AK9cjPACf
	mLS3iJkHMjJrPLI64/IQm/tgV52hVeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705969127;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3E9tNqOjt4gUSUB+S3aJ3k3drtQolgc/BOfzrCPki4=;
	b=OSZQ6xWJI75yuaLuK81sSk/6aACa7BoC8IS7EYT9/yZGFlxvFKNYIc4qZ6+my6H7KcWRMj
	XTsQMz40mZGX/ZBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705969126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3E9tNqOjt4gUSUB+S3aJ3k3drtQolgc/BOfzrCPki4=;
	b=i4zC3SyPQvwwzAChgI3R7AweGdOi79oph0aXRX95XdIbiQf7JZ3Cc4eZSt+IMPfcEL8MWD
	Ddxgkz0kWpHvhasZzjck/47tZaTXh5OUhe4oEsAvtwOXwsar7StMj0hzmZ/MsJwPaMV7kT
	Acd3sMoG7+sqPtSFo4moJ193/hxDvGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705969126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3E9tNqOjt4gUSUB+S3aJ3k3drtQolgc/BOfzrCPki4=;
	b=MXVd4xdE70VkkNpAJ2y5xjtQbZEgWdRAlW2JNS0PdyQhCbM5yn1/hF4uQQ7z1+s/bO4yeE
	KRuUIcfsIWeYT/Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA5DF1395B;
	Tue, 23 Jan 2024 00:18:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jbROJOQFr2UyewAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 23 Jan 2024 00:18:44 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Tom Talpey" <tom@talpey.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix RELEASE_LOCKOWNER
In-reply-to: <D841692A-1D9D-49F9-B497-AA40B975C5E9@oracle.com>
References: <170589589641.23031.16356786177193106749@noble.neil.brown.name>,
 <Za57adpDbKJavMRO@tissot.1015granger.net>,
 <170596063560.23031.1725209290511630080@noble.neil.brown.name>,
 <3162C5BC-8E7C-4A9A-815C-09297B56FA17@oracle.com>,
 <170596630337.23031.332959396445243083@noble.neil.brown.name>,
 <D841692A-1D9D-49F9-B497-AA40B975C5E9@oracle.com>
Date: Tue, 23 Jan 2024 11:18:41 +1100
Message-id: <170596912197.23031.1418374526012433512@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i4zC3SyP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MXVd4xdE
X-Spamd-Result: default: False [-3.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 TO_DN_ALL(0.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E12E21F393
X-Spam-Level: 
X-Spam-Score: -3.31
X-Spam-Flag: NO

On Tue, 23 Jan 2024, Chuck Lever III wrote:
>=20
>=20
> > On Jan 22, 2024, at 6:31=E2=80=AFPM, NeilBrown <neilb@suse.de> wrote:
> >=20
> > On Tue, 23 Jan 2024, Chuck Lever III wrote:
> >>=20
> >>=20
> >>> On Jan 22, 2024, at 4:57=E2=80=AFPM, NeilBrown <neilb@suse.de> wrote:
> >>>=20
> >>> On Tue, 23 Jan 2024, Chuck Lever wrote:
> >>>> On Mon, Jan 22, 2024 at 02:58:16PM +1100, NeilBrown wrote:
> >>>>>=20
> >>>>> The test on so_count in nfsd4_release_lockowner() is nonsense and
> >>>>> harmful.  Revert to using check_for_locks(), changing that to not sle=
ep.
> >>>>>=20
> >>>>> First: harmful.
> >>>>> As is documented in the kdoc comment for nfsd4_release_lockowner(), t=
he
> >>>>> test on so_count can transiently return a false positive resulting in=
 a
> >>>>> return of NFS4ERR_LOCKS_HELD when in fact no locks are held.  This is
> >>>>> clearly a protocol violation and with the Linux NFS client it can cau=
se
> >>>>> incorrect behaviour.
> >>>>>=20
> >>>>> If NFS4_RELEASE_LOCKOWNER is sent while some other thread is still
> >>>>> processing a LOCK request which failed because, at the time that requ=
est
> >>>>> was received, the given owner held a conflicting lock, then the nfsd
> >>>>> thread processing that LOCK request can hold a reference (conflock) to
> >>>>> the lock owner that causes nfsd4_release_lockowner() to return an
> >>>>> incorrect error.
> >>>>>=20
> >>>>> The Linux NFS client ignores that NFS4ERR_LOCKS_HELD error because it
> >>>>> never sends NFS4_RELEASE_LOCKOWNER without first releasing any locks,=
 so
> >>>>> it knows that the error is impossible.  It assumes the lock owner was=
 in
> >>>>> fact released so it feels free to use the same lock owner identifier =
in
> >>>>> some later locking request.
> >>>>>=20
> >>>>> When it does reuse a lock owner identifier for which a previous RELEA=
SE
> >>>>> failed, it will naturally use a lock_seqid of zero.  However the serv=
er,
> >>>>> which didn't release the lock owner, will expect a larger lock_seqid =
and
> >>>>> so will respond with NFS4ERR_BAD_SEQID.
> >>>>>=20
> >>>>> So clearly it is harmful to allow a false positive, which testing
> >>>>> so_count allows.
> >>>>>=20
> >>>>> The test is nonsense because ... well... it doesn't mean anything.
> >>>>>=20
> >>>>> so_count is the sum of three different counts.
> >>>>> 1/ the set of states listed on so_stateids
> >>>>> 2/ the set of active vfs locks owned by any of those states
> >>>>> 3/ various transient counts such as for conflicting locks.
> >>>>>=20
> >>>>> When it is tested against '2' it is clear that one of these is the
> >>>>> transient reference obtained by find_lockowner_str_locked().  It is n=
ot
> >>>>> clear what the other one is expected to be.
> >>>>>=20
> >>>>> In practice, the count is often 2 because there is precisely one state
> >>>>> on so_stateids.  If there were more, this would fail.
> >>>>>=20
> >>>>> It my testing I see two circumstances when RELEASE_LOCKOWNER is calle=
d.
> >>>>> In one case, CLOSE is called before RELEASE_LOCKOWNER.  That results =
in
> >>>>> all the lock states being removed, and so the lockowner being discard=
ed
> >>>>> (it is removed when there are no more references which usually happens
> >>>>> when the lock state is discarded).  When nfsd4_release_lockowner() fi=
nds
> >>>>> that the lock owner doesn't exist, it returns success.
> >>>>>=20
> >>>>> The other case shows an so_count of '2' and precisely one state listed
> >>>>> in so_stateid.  It appears that the Linux client uses a separate lock
> >>>>> owner for each file resulting in one lock state per lock owner, so th=
is
> >>>>> test on '2' is safe.  For another client it might not be safe.
> >>>>>=20
> >>>>> So this patch changes check_for_locks() to use the (newish)
> >>>>> find_any_file_locked() so that it doesn't take a reference on the
> >>>>> nfs4_file and so never calls nfsd_file_put(), and so never sleeps.
> >>>>=20
> >>>> More to the point, find_any_file_locked() was added by commit
> >>>> e0aa651068bf ("nfsd: don't call nfsd_file_put from client states
> >>>> seqfile display"), which was merged several months /after/ commit
> >>>> ce3c4ad7f4ce ("NFSD: Fix possible sleep during
> >>>> nfsd4_release_lockowner()").
> >>>=20
> >>> Yes.  To flesh out the history:
> >>> nfsd_file_put() was added in v5.4.  In earlier kernels check_for_locks()
> >>> would never sleep.  However the problem patch was backported 4.9, 4.14,
> >>> and 4.19 and should be reverted.
> >>=20
> >> I don't see "NFSD: Fix possible sleep during nfsd4_release_lockowner()"
> >> in any of those kernels. All but 4.19 are now EOL.
> >=20
> > I hadn't checked which were EOL.  Thanks for finding the 4.19 patch and
> > requesting a revert.
> >=20
> >>=20
> >>=20
> >>> find_any_file_locked() was added in v6.2 so when this patch is
> >>> backported to 5.4, 5.10, 5.15, 5.17 - 6.1 it needs to include
> >>> find_and_file_locked()
> >>=20
> >> I think I'd rather leave those unperturbed until someone hits a real
> >> problem. Unless you have a distribution kernel that needs to see
> >> this fix in one of the LTS kernels? The supported stable/LTS kernels
> >> are 5.4, 5.10, 5.15, and 6.1.
> >=20
> > Why not fix the bug?  It's a real bug that a real customer really hit.
>=20
> That's what I'm asking. Was there a real customer issue? Because
> ce3c4ad7f4ce was the result of a might_sleep splat, not an issue
> in the field.
>=20
> Since this hit a real user, is there a BugLink: or Closes: tag
> I can add?

Unfortunately not.  Our bugs for paying customers are private - so they
can feel comfortable providing all the details we need.
The link is https://bugzilla.suse.com/show_bug.cgi?id=3D1218968
that won't help anyone outside SUSE.

But definitely a real bug.

>=20
>=20
> > I've fixed it in all SLE kernels - we don't depend on LTS though we do
> > make use of the stable trees in various ways.
> >=20
> > But it's your call.
>=20
> Well, it's not my call whether it's backported. Anyone can ask.
> It /is/ my call if I do the work.

That's fair.  I'm happy to create the manual backport patch.  I'm not
going to test those kernels.  I generally assume that someone is testing
stable kernels - so obvious problems will be found by someone else, and
non-obvious problems I wouldn't find even if I did some testing :-(

Thanks,
NeilBrown


>=20
> Mostly the issue is having the time to manage 5-6 stable
> kernels as well as upstream development. I'd like to ensure
> that any patches for which we manually request a backport have
> been applied and tested by someone with a real NFS rig, and
> there is a real problem getting addressed.
>=20
> It's getting better with kdevops... I can cherry pick any
> recent kernel and run it through a number of tests without
> needing to hand-hold. Haven't tried that with the older stable
> kernels, though; those require older compilers and what-not.
>=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20


