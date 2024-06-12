Return-Path: <linux-nfs+bounces-3688-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63633904BA0
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 08:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5389E1C22471
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 06:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6BE823CC;
	Wed, 12 Jun 2024 06:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0ikvNRQn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LGNZ8Pus";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0ikvNRQn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LGNZ8Pus"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FAA54FB5
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718173828; cv=none; b=AhrqKzmXTNj42wf8qGud6cZTsNGlQVIUBI2PQtXydbcBeLd7mrVPHx7oo4mFVqbYzfn7iG1b+58Ke/+ZykxlphifGDFJD5u9pdo+5xEPuacG6j8ThopOleRTwONGuUB5O0vO23CMwfsF5Rnni6j+zOr1hfGhzSToffAsZZTDFUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718173828; c=relaxed/simple;
	bh=1pCij8AgrByhuYEifGCV1GzZ7omGmQ4wO8rYysLtZ2I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Rt3EYlbejYU/L0pEVCRF7cfQUXnQc+w3TRb/Fuywp4pVKnZdQWGs9/CIqqmJnOrt6KoFg/zhEeKIC/POHYLpo4k8zEx2mFGKYO4SUijIDpygQt0hqFyU+Uw8CWqE3371tyTeFsN5qS3SiI48VBA4MTZYcKJ559FupgDc9Rv/N20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0ikvNRQn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LGNZ8Pus; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0ikvNRQn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LGNZ8Pus; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F38A210A7;
	Wed, 12 Jun 2024 06:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718173825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhDgqhbooZFNaECTQwTe4zkIw5T62tsvvKt69Nl5y1Q=;
	b=0ikvNRQneKLHRcX2QQRS9eTbEy2ssoBGf7aDt1vtAWXIxecbGgK5i6dE8IPwFFhms4dzaw
	bswLCx5p+visxbbtuXp8lSCD0Z1gZ93+PCei8QmfCWoCRx/CLOUE75sfNYucZ4tUR/ctGo
	lJvlLvSiKyawXGh/UE66GXac0k9ZHms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718173825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhDgqhbooZFNaECTQwTe4zkIw5T62tsvvKt69Nl5y1Q=;
	b=LGNZ8PusedKUXrEUjQnlduZhrE4LOXkah4qEHs6ORiKLLUuPbqcEN+HaJ/NFdso4/uFOe4
	P8SVnHZQscb8ZcCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718173825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhDgqhbooZFNaECTQwTe4zkIw5T62tsvvKt69Nl5y1Q=;
	b=0ikvNRQneKLHRcX2QQRS9eTbEy2ssoBGf7aDt1vtAWXIxecbGgK5i6dE8IPwFFhms4dzaw
	bswLCx5p+visxbbtuXp8lSCD0Z1gZ93+PCei8QmfCWoCRx/CLOUE75sfNYucZ4tUR/ctGo
	lJvlLvSiKyawXGh/UE66GXac0k9ZHms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718173825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhDgqhbooZFNaECTQwTe4zkIw5T62tsvvKt69Nl5y1Q=;
	b=LGNZ8PusedKUXrEUjQnlduZhrE4LOXkah4qEHs6ORiKLLUuPbqcEN+HaJ/NFdso4/uFOe4
	P8SVnHZQscb8ZcCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C85F1372E;
	Wed, 12 Jun 2024 06:30:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NKAlEH5AaWaKOgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Jun 2024 06:30:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [for-6.11 PATCH 10/29] nfs/nfsd: add "local io" support
In-reply-to: <ZmkomfPEA2ETa8kt@kernel.org>
References: <>, <ZmkomfPEA2ETa8kt@kernel.org>
Date: Wed, 12 Jun 2024 16:30:13 +1000
Message-id: <171817381362.14261.7848995757015032660@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Wed, 12 Jun 2024, Mike Snitzer wrote:
> On Wed, Jun 12, 2024 at 02:09:21PM +1000, NeilBrown wrote:
> > On Wed, 12 Jun 2024, Mike Snitzer wrote:
> > > On Wed, Jun 12, 2024 at 01:17:05PM +1000, NeilBrown wrote:
> > > > On Wed, 12 Jun 2024, Mike Snitzer wrote:
> > > > >=20
> > > > > SO I looked, and I'm saddened to see Neil's 6.8 commit 1e3577a4521e
> > > > > ("SUNRPC: discard sv_refcnt, and svc_get/svc_put").
> > > > >=20
> > > > > [the lack of useful refcounting with the current code kind of blew =
me
> > > > > away.. but nice to see it existed not too long ago.]
> > > > >=20
> > > > > Rather than immediately invest the effort to revert commit
> > > > > 1e3577a4521e for my apparent needs... I'll send out v2 to allow for
> > > > > further review and discussion.
> > > > >=20
> > > > > But it really does feel like I _need_ svc_{get,put} and nfsd_{get,p=
ut}
> > > >=20
> > > > You are taking a reference, and at the right time.  But it is to the
> > > > wrong thing.
> > >=20
> > > Well, that reference is to ensure nfsd (and nfsd_open_local_fh) is
> > > available for the duration of a local client connected to it.
> > >=20
> > > Really wasn't trying to keep nn->nfsd_serv around with this ;)
> > >=20
> > > > You call symbol_request(nfsd_open_local_fh) and so get a reference to
> > > > the nfsd module.  But you really want a reference to the nfsd service.
> > > >=20
> > > > I would suggest that you use symbol_request() to get a function which
> > > > you then call and immediately symbol_put().... unless you need to use=
 it
> > > > to discard the reference to the service later.
> > >=20
> > > Getting the nfsd_open_local_fh symbol once when client handshakes with
> > > server is meant to avoid needing to do so for every IO the client
> > > issues to the local server.
> > >=20
> > > > The function would take nfsd_mutex, check there is an nfsd_serv, sets=
 a
> > > > flag or whatever to indicate the serv is being used for local_io, and
> > > > maybe returns the nfsd_serv.  As long as that flag is set the serv
> > > > cannot be destroy.
> > > >
> > > > Do you need there to be available threads for LOCAL_IO to work?  If so
> > > > the flag would cause setting the num threads to zero to fail.
> > > > If not ....  that is weird.  It would mean that setting the number of
> > > > threads to zero would not destroy the service and I don't think we wa=
nt
> > > > to do that.
> > > >=20
> > > > So I think that when LOCAL_IO is in use, setting number of threads to
> > > > zero must return EBUSY or similar, even if you don't need the threads.
> > >=20
> > > Yes, but I really dislike needing to play games with a tangential
> > > characteristic of nfsd_serv (that threads are what hold reference),
> > > rather than have the ability to keep the nfsd_serv around in a cleaner
> > > way.
> > >=20
> > > This localio code doesn't run in nfsd context so it isn't using nfsd's
> > > threads. Forcing threads to be held in reserve because localio doesn't
> > > want nfsd_serv to go away isn't ideal.
> >=20
> > I started reading the rest of the patches and it seems that localio is
> > only used for READ, WRTE, COMMIT.  Is that correct?  Is there
> > documentation so that I don't have to ask?
>=20
> The header for v2's patch 7 (nfs/nfsd: add "localio" support) starts with:
> Add client support for bypassing NFS for localhost reads, writes, and
> commits.
>=20
> But I should've made it clearer by saying the same in the 0th header.

Or maybe even a something to Documentation/ which describes your new
side-protocol including how the UUIDs are used and what happens when a
match is found..

>=20
> > Obviously there are lots of other NFS requests so you wouldn't be able
> > to use localio without nfsd threads running....
>=20
> That's very true.
>=20
> > But a normal remote client doesn't pin the nfsd threads or the
> > nfsd_serv.  If the threads go away, the client blocks until the service
> > comes back.  Would that be appropriate semantics for localio??  i.e.  on
> > each nfsd_open_local_fh() call you mutex_trylock and hold that long
> > enough to get the 'struct file *'.  If it fails because there is no
> > serv, you simply fall-back to the same path you use for other requests.
> >=20
> > Could that work?
>=20
> I can try it, but feels like it'd elevate nfsd_mutex to "contended",
> as such it feels heavy.
>=20
> > > Does it maybe make sense to introduce a more narrow svc_get/svc_put
> > > for this auxillary usecase?
> >=20
> > I don't think so.  nfsd is a self-contained transactional service.  It
> > doesn't promise to persist beyond each transaction.
> > Current transactions return status and/or data.  Adding a new transaction
> > that returns a 'struct file *' fits that model reasonable well.
>=20
> Sure. But to be clear, I am adding global state to nfs_common that
> tracks nfsd_uuids. Those change every time a new nfsd_net is created
> for a given server (client will then lookup the uuid to see if local).
>=20

I missed the full importance of this on my read-through.  It would
certainly make sense for the NFS client to get a counted-reference to
something managed by nfs_common and created/destroyed by nfsd.
It could then easily check if the handle is still valid and repeat the
lookup only if the handle has been marked as invalid.

We still need a way for the filehande-to-struct-file lookup to proceed
without taking nfsd_mutex.  Possibly we could use srcu and put a
synchronise_srcu() call at the top of nfsd_destroy_serv()...

>=20
> But even if we went to the extreme where nfsd instances are bouncing
> like crazy, the 'nfsd_uuids' list in nfs_common should work fine.
>=20
> Just not seeing what is gained by nfsd being so ephemeral.  Maybe your
> point is, it should work in that model too?.. I think it would, just
> less efficiently due to make-work to re-get resources it needs.

Exactly.  localio shouldn't prevent the nfsd server from being stopped
and restarted, but it needn't work efficiently when that is happening.

Thanks,
NeilBrown

