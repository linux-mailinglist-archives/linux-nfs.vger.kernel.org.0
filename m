Return-Path: <linux-nfs+bounces-7888-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43979C4B27
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 01:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFF7284734
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 00:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8D8200125;
	Tue, 12 Nov 2024 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IT4D9ZIW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EIKX7AdI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IT4D9ZIW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EIKX7AdI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816E320011E
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731372579; cv=none; b=rv8BPsIPW4flnGS8XcN+qBTlzCwOzS4mDdNW/5LPZdDaJZcpOOhRz4/vPPW4la8/El6FbunPlJV+0vkVU/ouVbOGNgyoJ5UMTYiGmbZVus8UWGkm7w3PowNt9d07eIW5sT8fy2WADPAagTfc552ii/MHRRN3zYFvbJAlgI1vQfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731372579; c=relaxed/simple;
	bh=v+xHuZj+JdzQ+UrTv15un3yFcO0eZAdYxQ+F7+uenpM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=GSL/7nApXPiWiOyt/XVoP8TiVD826ZDMVZkRiCJu07e0d2/l6n1AnHKmQKLY0vJXcOx3jsGPMvPRCifNg9v+CoCtGabQhI5zIVTQQsYhNXjkJ+M/jc9KQ2hDHanuAPEKO33yqSIAyvJK1sDU69gKVR9uT0wMWQpDtSn7/8+UMu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IT4D9ZIW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EIKX7AdI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IT4D9ZIW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EIKX7AdI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B23A31F38E;
	Tue, 12 Nov 2024 00:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731372575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5E8viNLonCXFqKqAV08wmal0m0L3Rewty6X5LyRJvE=;
	b=IT4D9ZIWDPJZOEEdGmlHjjU3Gd6I1WU/QZYSd3ECzENn1/aHxcku7QvU7J8tOzvH72hly1
	olnEljAiPAO5gn04VunfvdDZ/nvPnc9iSb6FyXk5hgmxBN9fuM2Nu9+9QPcRF5lVUXUWtN
	dAMXPHo/cTcO3aO6ldzJ5+JItPOJgqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731372575;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5E8viNLonCXFqKqAV08wmal0m0L3Rewty6X5LyRJvE=;
	b=EIKX7AdI8WS3+12ZFcEnw18JurbIbYYxg5iuY4KelNsY3fE3Kecvu4uLl7jL6nNdez7dNW
	CkyRpfw70jWeC9Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731372575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5E8viNLonCXFqKqAV08wmal0m0L3Rewty6X5LyRJvE=;
	b=IT4D9ZIWDPJZOEEdGmlHjjU3Gd6I1WU/QZYSd3ECzENn1/aHxcku7QvU7J8tOzvH72hly1
	olnEljAiPAO5gn04VunfvdDZ/nvPnc9iSb6FyXk5hgmxBN9fuM2Nu9+9QPcRF5lVUXUWtN
	dAMXPHo/cTcO3aO6ldzJ5+JItPOJgqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731372575;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5E8viNLonCXFqKqAV08wmal0m0L3Rewty6X5LyRJvE=;
	b=EIKX7AdI8WS3+12ZFcEnw18JurbIbYYxg5iuY4KelNsY3fE3Kecvu4uLl7jL6nNdez7dNW
	CkyRpfw70jWeC9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AB8A13301;
	Tue, 12 Nov 2024 00:49:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pWUlFB2mMmfGEAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 12 Nov 2024 00:49:33 +0000
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
Cc: linux-nfs@vger.kernel.org, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [for-6.13 PATCH 10/19] nfs_common: move localio_lock to new lock
 member of nfs_uuid_t
In-reply-to: <ZzKeciwU6n4R9VgX@kernel.org>
References: <>, <ZzKeciwU6n4R9VgX@kernel.org>
Date: Tue, 12 Nov 2024 11:49:30 +1100
Message-id: <173137257042.1734440.8400976538590009783@noble.neil.brown.name>
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, 12 Nov 2024, Mike Snitzer wrote:
> On Tue, Nov 12, 2024 at 10:23:19AM +1100, NeilBrown wrote:
> > On Tue, 12 Nov 2024, Mike Snitzer wrote:
> > > On Tue, Nov 12, 2024 at 07:35:04AM +1100, NeilBrown wrote:
> > > >=20
> > > > I don't like NFS_CS_LOCAL_IO_CAPABLE.
> > > > A use case that I imagine (and a customer does something like this) i=
s an
> > > > HA cluster where the NFS server can move from one node to another.  A=
ll
> > > > the node access the filesystem, most over NFS.  If a server-migration
> > > > happens (e.g.  the current server node failed) then the new server no=
de
> > > > would suddenly become LOCALIO-capable even though it wasn't at
> > > > mount-time.  I would like it to be able to detect this and start doing
> > > > localio.
> > >=20
> > > Server migration while retaining the client being local to the new
> > > server?  So client migrates too?
> >=20
> > No.  Client doesn't migrate.  Server migrates and appears on the same
> > host as the client.  The client can suddenly get better performance.  It
> > should benefit from that.
> >=20
> > >=20
> > > If the client migrates then it will negotiate with server using
> > > LOCALIO protocol.
> > >=20
> > > Anyway, this HA hypothetical feels contrived.  It is fine that you
> > > dislike NFS_CS_LOCAL_IO_CAPABLE but I don't understand what you'd like
> > > as an alternative.  Or why the simplicity in my approach lacking.
> >=20
> > We have customers with exactly this HA config.  This is why I put work
> > into make sure loop-back NFS (client and server on same node) works
> > cleanly without memory allocation deadlocks.
> >   https://lwn.net/Articles/595652/
> > Getting localio in that config would be even better.
> >=20
> > Your approach assumes that if LOCALIO isn't detected at mount time, it
> > will never been available.  I think that is a flawed assumption.
>=20
> That's fair, I agree your HA scenario is valid.  It was terse as
> initially presented but I understand now, thanks.
>=20
> > > > So I don't want NFS_CS_LOCAL_IO_CAPABLE.  I think tracking when the
> > > > network connection is re-established is sufficient.
> > >=20
> > > Eh, that type of tracking doesn't really buy me anything if I've lost
> > > context (that LOCALIO was previously established and should be
> > > re-established).
> > >=20
> > > NFS v3 is stateless, hence my hooking off read and write paths to
> > > trigger nfs_local_probe_async().  Unlike NFS v4, with its grace, more
> > > care is needed to avoid needless calls to nfs_local_probe_async().
> >=20
> > I think it makes perfect sense to trigger the probe on a successful
> > read/write with some rate limiting to avoid sending a LOCALIO probe on
> > EVERY read/write.  Your rate-limiting for NFSv3 is:
> >    - never probe if the mount-time probe was not successful
> >    - otherwise probe once every 256 IO requests.
> >=20
> > I think the first is too restrictive, and the second is unnecessarily
> > frequent.
> > I propose:
> >    - probe once each time the client reconnects with the server
> >=20
> > This will result in many fewer probes in practice, but any successful
> > probe will happen at nearly the earliest possible moment.
>=20
> I'm all for what you're proposing (its what I wanted from the start).
> In practice I just don't quite grok the client reconnect awareness
> implementation you're saying is at our finger tips.
>=20
> > > Your previous email about just tracking network connection change was
> > > an optimization for avoiding repeat (pointless) probes.  We still
> > > need to know to do the probe to begin with.  Are you saying you want
> > > to backfill the equivalent of grace (or pseudo-grace) to NFSv3?
> >=20
> > You don't "know to do the probe" at mount time.  You simply always do
> > it.  Similarly whenever localio isn't active it is always appropriate to
> > probe - with rate limiting.
> >=20
> > And NFSv3 already has a grace period - in the NLM/STAT protocols.  We
> > could use STAT to detect when the server has restarted and so it is worth
> > probing again.  But STAT is not as reliable as we might like and it
> > would be more complexity with no real gain.
>=20
> If you have a specific idea for the mechanism we need to create to
> detect the v3 client reconnects to the server please let me know.
> Reusing or augmenting an existing thing is fine by me.

nfs3_local_probe(struct nfs_server *server)
{
  struct nfs_client *clp =3D server->nfs_client;
  nfs_uuid_t *nfs_uuid =3D &clp->cl_uuid;

  if (nfs_uuid->connect_cookie !=3D clp->cl_rpcclient->cl_xprt->connect_cooki=
e)
       nfs_local_probe_async()
}

static void nfs_local_probe_async_work(struct work_struct *work)
{
  struct nfs_client *clp =3D container_of(work, struct nfs_client,
                              cl_local_probe_work);
  clp->cl_uuid.connect_cookie =3D
     clp->cl_rpcclient->cl_xprt->connect_cookie;
  nfs_local_probe(clp);
}

Or maybe assign connect_cookie (which we have to add to uuid) inside
nfs_local_probe().=20

Though you need rcu_dereference_pointer() to access cl_xprt and
rcu_read_lock() protection around that.
(cl_xprt can change when the NFS client follows a "location" reported by
 the server to handle migration or mirroring.  Conceivably we should
 check for either cl_xprt changing or cl_xprt->connect_cookie changing,
 but if that were an issue it would be easier to initialise
 ->connect_cookie to a random number)
=20
Note that you don't need local_probe_mutex.  A given work_struct
(cl_local_probe_work) can only be running once.  If you try to
queue_work() it while it is running, queue_work() will do nothing.

You'll want to only INIT_WORK() once - not on every
nfs_local_probe_async() call.

NeilBrown

