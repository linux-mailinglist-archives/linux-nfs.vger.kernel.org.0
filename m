Return-Path: <linux-nfs+bounces-8186-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A409D5471
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 22:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48FDDB2374A
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 21:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7737F1C07D3;
	Thu, 21 Nov 2024 21:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LJW8nkaV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KbfdJqrX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LJW8nkaV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KbfdJqrX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477B41AB512
	for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2024 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732223013; cv=none; b=s4MsP1iCsSyQcDauRVjwDZqjC9cldyjE6a4DlAQZ9HIIve46cpbqW2HlQheIwjPQ3R2pumoH+c4zeKRQ08R8CS4wmS//9JbCSMKowLxLM3LZCAPbnoapMhk1UnGdhm5lYQBz53Py3tOsFkOivX1jSm/HY3ZNRPHEmrv5yNpfTKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732223013; c=relaxed/simple;
	bh=xxpfWWw8+1QpIRa8gzjdyr0IBO2d0lSsSnAEsurWxRM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qPTL6S8nHZPrioEI/YaGd0xN1wkBcEpFYUaCByX33eNUfa2PxNRhOpJQRxWuYv6LAGqjwwaW4bw+t7vuEkoZl89jwJju6yk4s+Ou1WGuCLbFnknG83uTQcnIU6822mF664WNT0UfIMDJb7paP3r5gXXlKrPa4MuqPAmoBvXfW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LJW8nkaV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KbfdJqrX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LJW8nkaV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KbfdJqrX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E49A1F7FE;
	Thu, 21 Nov 2024 21:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732223009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ylJRb2VCOqRJfpoqjfPAhoFalvS5/UlduLsUK5hJ+E=;
	b=LJW8nkaVNg2B7gcUcDrBzJA0osVbBltpsoORLzXZ5Of8A3YYmS9pYvkjW3U7l9Cjtap6yF
	zJkPN0ACnbuLZQ2eJFc/S0e5YUSfVkeFXgznGwekBC9sc85a9D7XP5IApQmiDZ2mncWads
	PtphGgJBVEVxEycb3JmRqHfy9ZR7sBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732223009;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ylJRb2VCOqRJfpoqjfPAhoFalvS5/UlduLsUK5hJ+E=;
	b=KbfdJqrXR64SyPpIagVmMSbDwLWtvybtrGhSgQiHKLjatyMe31sCMaSVkdpxotxBomV5nM
	LWzwAnNbO/K+USBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732223009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ylJRb2VCOqRJfpoqjfPAhoFalvS5/UlduLsUK5hJ+E=;
	b=LJW8nkaVNg2B7gcUcDrBzJA0osVbBltpsoORLzXZ5Of8A3YYmS9pYvkjW3U7l9Cjtap6yF
	zJkPN0ACnbuLZQ2eJFc/S0e5YUSfVkeFXgznGwekBC9sc85a9D7XP5IApQmiDZ2mncWads
	PtphGgJBVEVxEycb3JmRqHfy9ZR7sBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732223009;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ylJRb2VCOqRJfpoqjfPAhoFalvS5/UlduLsUK5hJ+E=;
	b=KbfdJqrXR64SyPpIagVmMSbDwLWtvybtrGhSgQiHKLjatyMe31sCMaSVkdpxotxBomV5nM
	LWzwAnNbO/K+USBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0F3F137CF;
	Thu, 21 Nov 2024 21:03:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wo8oGR6gP2c6LAAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 21 Nov 2024 21:03:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject:
 Re: [PATCH 3/6] nfsd: add session slot count to /proc/fs/nfsd/clients/*/info
In-reply-to: <Zz0sbK49PELT7HpN@tissot.1015granger.net>
References: <>, <Zz0sbK49PELT7HpN@tissot.1015granger.net>
Date: Fri, 22 Nov 2024 08:03:22 +1100
Message-id: <173222300252.1734440.30767813440263840@noble.neil.brown.name>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 20 Nov 2024, Chuck Lever wrote:
> On Wed, Nov 20, 2024 at 09:24:52AM +1100, NeilBrown wrote:
> > On Wed, 20 Nov 2024, Chuck Lever wrote:
> > > On Tue, Nov 19, 2024 at 11:41:30AM +1100, NeilBrown wrote:
> > > > Each client now reports the number of slots allocated in each session.
> > > >=20
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > ---
> > > >  fs/nfsd/nfs4state.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >=20
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index 3889ba1c653f..31ff9f92a895 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -2642,6 +2642,7 @@ static const char *cb_state2str(int state)
> > > >  static int client_info_show(struct seq_file *m, void *v)
> > > >  {
> > > >  	struct inode *inode =3D file_inode(m->file);
> > > > +	struct nfsd4_session *ses;
> > > >  	struct nfs4_client *clp;
> > > >  	u64 clid;
> > > > =20
> > > > @@ -2678,6 +2679,13 @@ static int client_info_show(struct seq_file *m=
, void *v)
> > > >  	seq_printf(m, "callback address: \"%pISpc\"\n", &clp->cl_cb_conn.cb=
_addr);
> > > >  	seq_printf(m, "admin-revoked states: %d\n",
> > > >  		   atomic_read(&clp->cl_admin_revoked));
> > > > +	seq_printf(m, "session slots:");
> > > > +	spin_lock(&clp->cl_lock);
> > > > +	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
> > > > +		seq_printf(m, " %u", ses->se_fchannel.maxreqs);
> > > > +	spin_unlock(&clp->cl_lock);
> > > > +	seq_puts(m, "\n");
> > > > +
> > >=20
> > > Also, I wonder if information about the backchannel session can be
> > > surfaced in this way?
> > >=20
> >=20
> > Probably make sense.  Maybe we should invent a syntax for reporting
> > arbitrary info about each session.
> >=20
> >    session %d slots: %d
> >    session %d cb-slots: %d
> >    ...
> >=20
> > ???
>=20
> If each client has a directory, then it should have a subdirectory
> called "sessions". Each subdirectory of "sessions" should be one
> session, named by its hex session ID (as it is presented by
> Wireshark). Each session directory could have a file for the forward
> channel, one for the backchannel, and maybe one for generic
> information like when the session was created and how many
> connections it has.
>=20
> We don't need all of that in this patch set, but whatever is
> introduced here should be extensible to allow us to add more over
> time.

I cannot say I'm excited about the proliferation of tiny files.  Your
suggestion isn't quite as bad as sysfs which claims to want one file per
value, but I think the sysfs approach provided more pain than gain and
you seem to be heading that way.  As evidence I present the rise of
netlink.  Netlink's main advantage is that it allows you to access a
collection of data in a single syscall (or maybe pair of syscalls).  If
we had a standard format for doing that with open/read/close, the
filesystem would be a much nicer interface.  But the sysfs rules prevent
that, so people who care avoid it.

We don't need to impose those same rules on nfsd-fs.

Having separate dirs for the clients makes some sense as the clients are
quite independent.  Sessions aren't - they are just part of the client.=20
The *only* way session information is different from other client
information is that there is more structure - an array of sessions each
with detail.  I don't think that justifies a new directory.  I does
justify a carefully designed (or chosen) format for representing
structured data.

Thanks,
NeilBrown

