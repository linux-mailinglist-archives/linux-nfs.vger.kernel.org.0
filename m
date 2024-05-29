Return-Path: <linux-nfs+bounces-3480-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 892F18D3FB4
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 22:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E641F231FB
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 20:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EADC1B960;
	Wed, 29 May 2024 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mmzj8xH9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qyTNrUFZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mmzj8xH9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qyTNrUFZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0D1157E9D
	for <linux-nfs@vger.kernel.org>; Wed, 29 May 2024 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014990; cv=none; b=WVQoebbhO4eQFNKwV0qDpIBOwzW2WphEZvsP5QHmXOhm5yNPOl926WUE4bMoodX62RsWyj4qwPSBM8wP1vGi9Oiqco6/KQ4LmxaCZmUXwqDhKIQq5Sbc0QM5YufV4DIeTPPsP7iJtS3Dw1c6i6su5n4q3QXPP4EQIyCAENr5wsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014990; c=relaxed/simple;
	bh=uDdGxoNEZXeRyEGqrkDyCIg0gVeTWAfUyoG2yoDCuvk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=rmGlGc81dB3zgQ/J1z0PqG4FtdDLqiNzOQpa+RrsVfwMhYpjZ50OEUt5l2OV409rqaOv7MyV4phQMVX/TCLXeIBp1ZiN1lsqIAuNBG0n6xv9jhABd34oko6etufaSOuRx3jY2r1teYqCAMmgTFjUf4D/F4tgMG2RdQT1Vp7l7GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mmzj8xH9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qyTNrUFZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mmzj8xH9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qyTNrUFZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3FFA633735;
	Wed, 29 May 2024 20:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717014985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GvehF6mkUsp479pOZolrxj1EBqSAe+r68gpLfP4qvE=;
	b=mmzj8xH9+Qn5jmfEgqf+2pLWieGJKxuHj+F54kNkXC0eVXLpPsMOdMZozNvrpKKmYXIUrL
	NAO8qxJnKvoTHdIjU/J+i0EHuhFjyN7vOLB8hO6C0WMVh6gzSsAZSNOLn7iul8tL0/DCam
	PThL+p2Nl/ElIk4+4YYcN9gzCbTP75A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717014985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GvehF6mkUsp479pOZolrxj1EBqSAe+r68gpLfP4qvE=;
	b=qyTNrUFZSLIc5Oe1JTl27ImQTYtrMgtKf4LjEtQH8sde5XO/OBzT5A1/CmBKfdDv0WxA3V
	srksDaGcuZ/KT3Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717014985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GvehF6mkUsp479pOZolrxj1EBqSAe+r68gpLfP4qvE=;
	b=mmzj8xH9+Qn5jmfEgqf+2pLWieGJKxuHj+F54kNkXC0eVXLpPsMOdMZozNvrpKKmYXIUrL
	NAO8qxJnKvoTHdIjU/J+i0EHuhFjyN7vOLB8hO6C0WMVh6gzSsAZSNOLn7iul8tL0/DCam
	PThL+p2Nl/ElIk4+4YYcN9gzCbTP75A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717014985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GvehF6mkUsp479pOZolrxj1EBqSAe+r68gpLfP4qvE=;
	b=qyTNrUFZSLIc5Oe1JTl27ImQTYtrMgtKf4LjEtQH8sde5XO/OBzT5A1/CmBKfdDv0WxA3V
	srksDaGcuZ/KT3Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 057FB1372E;
	Wed, 29 May 2024 20:36:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xPTzJsaRV2aGTAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 29 May 2024 20:36:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Trond Myklebust" <trondmy@hammerspace.com>
Cc: "anna@kernel.org" <anna@kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "richard+debian+bugreport@kojedz.in" <richard+debian+bugreport@kojedz.in>,
 "1071501@bugs.debian.org" <1071501@bugs.debian.org>
Subject: Re: [PATCH] NFS: add barriers when testing for NFS_FSDATA_BLOCKED
In-reply-to: <808846871c4d5dc3410f610a704a7915d7cf5930.camel@hammerspace.com>
References:
 <>, <808846871c4d5dc3410f610a704a7915d7cf5930.camel@hammerspace.com>
Date: Wed, 29 May 2024 13:47:35 +1000
Message-id: <171695445579.27191.9734748642826473078@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[debian,bugreport];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

On Wed, 29 May 2024, Trond Myklebust wrote:
> On Tue, 2024-05-28 at 11:19 +1000, NeilBrown wrote:
> > On Tue, 28 May 2024, Trond Myklebust wrote:
> > > On Mon, 2024-05-27 at 13:04 +1000, NeilBrown wrote:
> > > >=20
> > > > dentry->d_fsdata is set to NFS_FSDATA_BLOCKED while unlinking or
> > > > renaming-over a file to ensure that no open succeeds while the
> > > > NFS
> > > > operation progressed on the server.
> > > >=20
> > > > Setting dentry->d_fsdata to NFS_FSDATA_BLOCKED is done under -
> > > > >d_lock
> > > > after checking the refcount is not elevated.=C2=A0 Any attempt to open
> > > > the
> > > > file (through that name) will go through lookp_open() which will
> > > > take
> > > > ->d_lock while incrementing the refcount, we can be sure that
> > > > once
> > > > the
> > > > new value is set, __nfs_lookup_revalidate() *will* see the new
> > > > value
> > > > and
> > > > will block.
> > > >=20
> > > > We don't have any locking guarantee that when we set ->d_fsdata
> > > > to
> > > > NULL,
> > > > the wait_var_event() in __nfs_lookup_revalidate() will notice.
> > > > wait/wake primitives do NOT provide barriers to guarantee order.=C2=A0
> > > > We
> > > > must use smp_load_acquire() in wait_var_event() to ensure we look
> > > > at
> > > > an
> > > > up-to-date value, and must use smp_store_release() before
> > > > wake_up_var().
> > > >=20
> > > > This patch adds those barrier functions and factors out
> > > > block_revalidate() and unblock_revalidate() far clarity.
> > > >=20
> > > > There is also a hypothetical bug in that if memory allocation
> > > > fails
> > > > (which never happens in practice) we might leave ->d_fsdata
> > > > locked.
> > > > This patch adds the missing call to unblock_revalidate().
> > > >=20
> > > > Reported-and-tested-by: Richard Kojedzinszky
> > > > <richard+debian+bugreport@kojedz.in>
> > > > Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1071501
> > > > Fixes: 3c59366c207e ("NFS: don't unhash dentry during
> > > > unlink/rename")
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > ---
> > > > =C2=A0fs/nfs/dir.c | 44 +++++++++++++++++++++++++++++---------------
> > > > =C2=A01 file changed, 29 insertions(+), 15 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > > > index ac505671efbd..c91dc36d41cc 100644
> > > > --- a/fs/nfs/dir.c
> > > > +++ b/fs/nfs/dir.c
> > > > @@ -1802,9 +1802,10 @@ __nfs_lookup_revalidate(struct dentry
> > > > *dentry,
> > > > unsigned int flags,
> > > > =C2=A0		if (parent !=3D READ_ONCE(dentry->d_parent))
> > > > =C2=A0			return -ECHILD;
> > > > =C2=A0	} else {
> > > > -		/* Wait for unlink to complete */
> > > > +		/* Wait for unlink to complete - see
> > > > unblock_revalidate() */
> > > > =C2=A0		wait_var_event(&dentry->d_fsdata,
> > > > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dentry->d_fsdata !=3D
> > > > NFS_FSDATA_BLOCKED);
> > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smp_load_acquire(&dentry-
> > > > >d_fsdata)
> > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !=3D NFS_FSDATA_BLOCKED);
> > >=20
> > > Doesn't this end up being a reversed ACQUIRE+RELEASE as described
> > > in
> > > the "LOCK ACQUISITION FUNCTIONS" section of Documentation/memory-
> > > barriers.txt?
> >=20
> > I don't think so.=C2=A0 That section is talking about STORE operations
> > which
> > can move backwards through ACQUIRE and forwards through RELEASE.
> >=20
> > Above we have a LOAD operation which mustn't move backwards through
> > ACQUIRE.=C2=A0 Below there is a STORE operation which mustn't move
> > forwards
> > through a RELEASE.=C2=A0 Both of those are guaranteed.
>=20
> It isn't necessary for the LOAD to move backwards through the ACQUIRE.
> As I understand it, the point is that the ACQUIRE can move through the
> RELEASE as per the following paragraph in that document:
>=20
>             Similarly, the reverse case of a RELEASE followed by an ACQUIRE=
 does
>             not imply a full memory barrier.  Therefore, the CPU's executio=
n of the
>             critical sections corresponding to the RELEASE and the ACQUIRE =
can cross,
>             so that:
>            =20
>                     *A =3D a;
>                     RELEASE M
>                     ACQUIRE N
>                     *B =3D b;
>            =20
>             could occur as:
>            =20
>                     ACQUIRE N, STORE *B, STORE *A, RELEASE M

On the wakeup side we have:

  STORE ->d_fsdata
  RELEASE
  spin_lock
  LOAD: check is waitq is empty

and on the wait side we have

  STORE: add to waitq
  spin_unlock
  ACQUIRE
  LOAD ->d_fsdata

I believe that spin_lock is an ACQUIRE operation and spin_unlock is a
RELEASE operation.  So both of these have "ACQUIRE ; RELEASE" which
creates a full barrier.

>=20
> This would presumably be why the function clear_and_wake_up_bit() needs
> a full memory barrier on most architectures, instead of being just an
> smp_wmb(). Is my understanding of this wrong?

clear_and_wake_up_bit() calls __wake_up_bit() which calls
waitqueue_active() without taking a lock.  So there is no ACQUIRE after
the RELEASE in clear_bit_unlock() and before testing for list-empty.  So
we need to explicitly add a barrier.

At least that is my understanding just now.  I hadn't worked through all
the details before, but I'm glad you prompted me to - thanks.

NeilBrown

