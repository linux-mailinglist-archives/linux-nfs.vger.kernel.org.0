Return-Path: <linux-nfs+bounces-11214-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 690ADA979C4
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Apr 2025 23:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E711898D01
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Apr 2025 21:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B7A1EFFB2;
	Tue, 22 Apr 2025 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HU7KEiXH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WWj18ofh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W1IqpXcI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ALShbAFs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D098F223DD2
	for <linux-nfs@vger.kernel.org>; Tue, 22 Apr 2025 21:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358893; cv=none; b=c5S79YN4toYDEpa7/mVHw8t+U5l15kJiJ6FklFFvvmF0MrzOxUv+LpNrkSmYJ32ITBfZZHZND25WHl4LqoQJ5iZq20ZPdp9+4VZ1sWCru1VlHGgQCN7Zmqr8f8tYDWjMd5dPtY2ASkSZrmJcZ+/HBnQrGsB0AFmi5XTDWCN1fQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358893; c=relaxed/simple;
	bh=xqFr39ct5DB36yeIjyas7y+4/kpp5bcc+8sD6ArkPWI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=XKDjIkbRYy5Vv3dfs2EMphs7DR/XUAsVKlxc98PZ3IN8VvCFbKTENKMSc8gJLX0ZcGpVcwOnpUfxS7PyQV1TqNvK/jW5sRHcM4gnO49Lq0iif1HbWbmFE6hrDoEy5Y/y8DEgRFnLs0ozrvfxTMqxE5u18xRbFBry1CVX8i7VzM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HU7KEiXH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WWj18ofh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W1IqpXcI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ALShbAFs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C61D5211B0;
	Tue, 22 Apr 2025 21:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745358888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5huE9KoE62AJBuc2dV7lkRQb+M9LMwLQlo2WbfpyJMk=;
	b=HU7KEiXHvyGjm7G1xPnFLEnNV+Mp2aCSHUmnQ+C9HSNuVKXec3up2zsW0V4oy1zxp+uwsq
	LXULLPrleKt6ERTVVbFL5Uwjv9zhQQBcTth5rAeXgnZ4H98vsH/6autAiaKgA+DowXxKXi
	pIha9LZjADiGUfaxtecdYjGilpnOc/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745358888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5huE9KoE62AJBuc2dV7lkRQb+M9LMwLQlo2WbfpyJMk=;
	b=WWj18ofhxYZT7hURpcV+3FVmtIGaS7Vw60jDKVSX75KTWhhrB4BrrZcYjL8HsIv6bvgxVf
	kf45T1HXdsK7QuBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745358887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5huE9KoE62AJBuc2dV7lkRQb+M9LMwLQlo2WbfpyJMk=;
	b=W1IqpXcIxOb/7Fqlg4rQsqT1/ID3B/2fKMxA/8GCzFcYtl0bXHIfhcJO7jHHs+hxzkjTgF
	CrF6jAKg3iG4samGtON61L/mUXjBJI93jkZCkoypXUKvuanK8GrlozGS6qbua7Z5xjRRQ1
	3u7N4TrYNOSWavnTQoz1FtkrmtnK0nQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745358887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5huE9KoE62AJBuc2dV7lkRQb+M9LMwLQlo2WbfpyJMk=;
	b=ALShbAFsLRzk1AtoZrlTko2Tao3dBmqJ8mkpeIZdGrWj88N/mM4EoEtym5xoL73hfoj7na
	Ebmp3HnnhQkKeLCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60060139D5;
	Tue, 22 Apr 2025 21:54:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CpwHBiMQCGjOSQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 22 Apr 2025 21:54:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Cc: "Mike Snitzer" <snitzer@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Anna Schumaker" <anna.schumaker@oracle.com>, linux-nfs@vger.kernel.org,
 "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>
Subject: Re: [PATCH v2] nfs: add dummy definition for nfsd_file
In-reply-to: <20250422201609.gkcgjgdljd2u4rx7@pali>
References: <>, <20250422201609.gkcgjgdljd2u4rx7@pali>
Date: Wed, 23 Apr 2025 07:54:40 +1000
Message-id: <174535888011.500591.1496684320777038856@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,hammerspace.com,wanadoo.fr,vger.kernel.org,oss.qualcomm.com,redhat.com,talpey.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, 23 Apr 2025, Pali Roh=C3=A1r wrote:
> On Sunday 20 April 2025 12:12:22 Mike Snitzer wrote:
> > On Sat, Apr 19, 2025 at 01:52:31PM -0400, Chuck Lever wrote:
> > > On 4/18/25 5:34 PM, Mike Snitzer wrote:
> > > > On Wed, Apr 16, 2025 at 09:31:55AM -0400, Chuck Lever wrote:
> > > >> On 4/15/25 10:41 PM, Vincent Mailhol wrote:
> > > >>> +CC: Neil Brown
> > > >>> +CC: Olga Kornievskaia
> > > >>> +CC: Dai Ngo
> > > >>> +CC: Tom Talpey
> > > >>> +CC: Trond Myklebust
> > > >>> +CC: Anna Schumaker
> > > >>>
> > > >>> (just to make sure that anyone listed in
> > > >>>
> > > >>>   ./scripts/get_maintainer.pl fs/nfs_common/nfslocalio.c
> > > >>>
> > > >>> get copied).
> > > >>>
> > > >>> Here is the link to the full thread:
> > > >>>
> > > >>>   https://lore.kernel.org/all/Z_coQbSdvMWD92IA@kernel.org/
> > > >>>
> > > >>>
> > > >>> On 10/04/2025 at 11:09, Mike Snitzer:
> > > >>>> Add dummy definition for nfsd_file in both nfslocalio.c and locali=
o.c
> > > >>>> so various compilers (e.g. gcc 8.5.0 and 9.5.0) can be used. Other=
wise
> > > >>>> RCU code (rcu_dereference and rcu_access_pointer) will dereference
> > > >>>> what should just be an opaque pointer (by using typeof(*ptr)).
> > > >>>>
> > > >>>> Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in =
client")
> > > >>>> Cc: stable@vger.kernel.org
> > > >>>> Tested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> > > >>>> Tested-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > >>>> Tested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > > >>>> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > >>>
> > > >>> Hi everyone,
> > > >>>
> > > >>> The build has been broken for several weeks already. Does anyone ha=
ve
> > > >>> intention to pick-up this patch?
> > > >>>
> > > >>> (please ignore if someone already picked it up and if it is already=
 on
> > > >>> its way to Linus's tree).
> > > >>
> > > >> I assumed that, like all LOCALIO-related changes, this fix would go
> > > >> in through the NFS client tree. Let me know if it needs to go via NF=
SD.
> > > >=20
> > > > Since we haven't heard from Trond or Anna about it, I think you'd be
> > > > perfectly fine to pick it up.  It is a compiler fixup associated with
> > > > nfd_file being kept opaque to the client -- but given it is "struct
> > > > nfsd_file" that gives you full license to grab it (IMO).
> > > >=20
> > > > I'm also unaware of any conflicting changes in the NFS client tree.
> > >=20
> > > Hi Mike -
> > >=20
> > > I just looked at this one again. The patch's diffstat is:
> > >=20
> > >  fs/nfs/localio.c           | 8 ++++++++
> > >  fs/nfs_common/nfslocalio.c | 8 ++++++++
> > >=20
> > > Although fs/nfs_common/ is part of both trees, fs/nfs/localio.c is
> > > definitely a client file. I'm still happy to pick it up, but technically
> > > I would need an Acked-by: from one of the NFS client maintainers.
> > >=20
> > > My impression is that Trond is managing the NFS client pulls for v6.15.
> >=20
> > Sure, that's my understanding too.  Feel free to offer your Acked-by
> > (for fs/nfs_common/) and hopefully it'll get picked up.  I can
> > followup with Trond later this coming week if/as needed.
> >=20
> > Thanks,
> > Mike
>=20
> Can we move forward here? The compilation of kernel is broken for at
> least 2 months. Also I have tried to contact Trond for more months but
> has not responded to my emails.
>=20
> Could be this change picked with a slightly higher priority than just
> waiting another two months? Note that nobody objected this particular
> fix and there are 3+ Tested-by lines. And it is not a good image if some
> kernel component does not compile...
>=20

Actually I do object to this fix (though I've been busy and hadn't had
much change to look at it properly).
The fix is ugly.  At the very least it should be wrapping in an=20
   #if  GCC_VERSION  < whatever

to make the purpose more clear.  But I'd rather a deeper fix.

GCC is complaining that rcu_dereference is being called on a point to a
structure that it doesn't know the content of.
So the code is says "I'm going to dereference this pointer even that
that is actually impossible as I don't know what any of the fields are".

I'd rather it didn't do that.  I've been playing with the code and I
think it can be made quite a bit cleaner by moving the rcu_dereference()
call into the nfsd side of the code.  Hopefully I'll have a patch in a
day or so to demonstrate what I mean.

I understand your desire for some action - but the reality is that you
have the full source code of the kernel and you can do whatever you want
to the kernel that you are working on.  You don't need us.
Getting code upstream is certainly good and we should continue to work
on doing that, but if you *need* something to be upstream then you might
want to consider whether your processes are really serving you.

Trond does often seem slow to take patches, and often they simply appear
in git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git without any
reply to the emails, but he or Anna does usually get to stuff
eventually.

NeilBrown

