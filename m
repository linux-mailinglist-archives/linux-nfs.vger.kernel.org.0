Return-Path: <linux-nfs+bounces-6892-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7331991AC6
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 23:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AEE62839B3
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 21:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9481586F6;
	Sat,  5 Oct 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AoPCuUn3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eA+zZPEW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AoPCuUn3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eA+zZPEW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D3A10A18;
	Sat,  5 Oct 2024 21:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728162592; cv=none; b=UbW96TKg3+6G1vE6e+uN/VaHK71wnmoqFGznhrs4HJXDW4IVYBUn47pJzMTz8l2mPCC2OgNZE9WmoAgkLdDpjxbIiMC3pJzkE+5iHW/F3Ll01RnP2TzitCnqvArJCtCxIWfJl/43tkxIZDiiTtqYdfMwuzyAC5T1wR50GHGi/Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728162592; c=relaxed/simple;
	bh=FSB4C8Y6MPSQCUaj4S5DIkBSdR9H2E3CtghmXAzeESg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=msSN3t9HzNpC3XeRNqWoXdKtYk4jGTkAIcW9ST5zMBs1Vprpo5DcP/UnXxYx372BCgfrN+qQ3wVNaTwKIUpVGD17hj9P6LybXu29tsiKdWFT75DD6AS4FZ7LgUU8iEV8rilfXkoiXJF6pc5stcn2GmAM3shFzpM1q439u++QWOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AoPCuUn3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eA+zZPEW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AoPCuUn3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eA+zZPEW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64A3621E35;
	Sat,  5 Oct 2024 21:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728162582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HosTUNR3Kh7UgJgk68lEQFA/0u8hP1Tbs/4Lg6STr4k=;
	b=AoPCuUn3RJo+sJT4DCleGTPfC1L5nVRvx8nie4gYVknpHzsAf+wFLAM9zF5dK1489rUeiK
	4AgWnb3psb9eSDVpMNISwhMmXCTUTH2DkhN3enubehLoXkXMa9ZTYZo3KWho/5jptsEEal
	VFg4e/5DuydaDBtsWbS1rWCDmeceoaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728162582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HosTUNR3Kh7UgJgk68lEQFA/0u8hP1Tbs/4Lg6STr4k=;
	b=eA+zZPEWydx/ZGk67ivIsH905FlmjATyxINWFpl/kJQ1lI4NTUclxUrmkq94QFYwfvUD1X
	nypTkCaJR6Cj/ECw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AoPCuUn3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eA+zZPEW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728162582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HosTUNR3Kh7UgJgk68lEQFA/0u8hP1Tbs/4Lg6STr4k=;
	b=AoPCuUn3RJo+sJT4DCleGTPfC1L5nVRvx8nie4gYVknpHzsAf+wFLAM9zF5dK1489rUeiK
	4AgWnb3psb9eSDVpMNISwhMmXCTUTH2DkhN3enubehLoXkXMa9ZTYZo3KWho/5jptsEEal
	VFg4e/5DuydaDBtsWbS1rWCDmeceoaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728162582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HosTUNR3Kh7UgJgk68lEQFA/0u8hP1Tbs/4Lg6STr4k=;
	b=eA+zZPEWydx/ZGk67ivIsH905FlmjATyxINWFpl/kJQ1lI4NTUclxUrmkq94QFYwfvUD1X
	nypTkCaJR6Cj/ECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9790F13736;
	Sat,  5 Oct 2024 21:09:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ds1hExSrAWeoXgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sat, 05 Oct 2024 21:09:40 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] nfsd: fix possible badness in FREE_STATEID
In-reply-to: <ZwF96Z8i3XcxDe/z@tissot.1015granger.net>
References: <>, <ZwF96Z8i3XcxDe/z@tissot.1015granger.net>
Date: Sun, 06 Oct 2024 08:04:14 +1100
Message-id: <172816225422.1692160.16192443029175940103@noble.neil.brown.name>
X-Rspamd-Queue-Id: 64A3621E35
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sun, 06 Oct 2024, Chuck Lever wrote:
> On Sat, Oct 05, 2024 at 12:20:48PM -0400, Jeff Layton wrote:
> > On Sat, 2024-10-05 at 10:53 -0400, Chuck Lever wrote:
> > > On Fri, Oct 04, 2024 at 06:04:03PM -0400, Olga Kornievskaia wrote:
> > > > When multiple FREE_STATEIDs are sent for the same delegation stateid,
> > > > it can lead to a possible either use-after-tree or counter refcount
> > > > underflow errors.
> > > >=20
> > > > In nfsd4_free_stateid() under the client lock we find a delegation
> > > > stateid, however the code drops the lock before calling nfs4_put_stid=
(),
> > > > that allows another FREE_STATE to find the stateid again. The first o=
ne
> > > > will proceed to then free the stateid which leads to either
> > > > use-after-free or decrementing already zerod counter.
> > > >=20
> > > > CC: stable@vger.kernel.org
> > >=20
> > > I assume that the broken commit is pretty old, but this fix does not
> > > apply before v6.9 (where sc_status is introduced). I can add
> > > "# v6.9+" to the Cc: stable tag.
> > >=20
> >=20
> > I don't know. It looks like nfsd4_free_stateid always returned
> > NFS4ERR_LOCKS_HELD on a delegation stateid until 3f29cc82a84c.
> >=20
> > > But what do folks think about a Fixes: tag?
> > >=20
> > > Could be e1ca12dfb1be ("NFSD: added FREE_STATEID operation"), but
> > > that doesn't have the switch statement, which was added by
> > > 2da1cec713bc ("nfsd4: simplify free_stateid").
> > >=20
> > >=20
> >=20
> > Maybe this one?
> >=20
> >     3f29cc82a84c nfsd: split sc_status out of sc_type
> >=20
> > That particular bit of the code (and the SC_STATUS_CLOSED flag) was
> > added in that patch, and I don't think you'd want to apply this patch
> > to anything that didn't have it.
>=20
> OK, if we believe that 3f29cc82 is where the misbehavior started,
> then I can replace the "Cc: stable@" with "Fixes: 3f29cc82a84c".

I believe the misbehaviour started with
Commit: b0fc29d6fcd0 ("nfsd: Ensure stateids remain unique until they are fre=
ed")
in v3.18.

The bug in the current code is that it assumes that

	list_del_init(&dp->dl_recall_lru);

actually removes from the the dl_recall_lru, and so a reference must be
dropped.  But if it wasn't on the list, then that is wrong.
So a "if (!list_empty(&dp->dl_recall_lru))" guard might also fix the
bug (though adding SC_STATUS_CLOSED is a better fix I think).

Prior to the above 3.17 commit, the relevant code was

 static void destroy_revoked_delegation(struct nfs4_delegation *dp)
 {
        list_del_init(&dp->dl_recall_lru);
        remove_stid(&dp->dl_stid);
        nfs4_put_delegation(dp);
 }

so the revoked delegation would be removed (remove_stid) from the idr
and a subsequent FREE_STATEID request would not find it.
The commit removed the remove_stid() call but didn't do anything to
prevent the free_stateid being repeated.
In that kernel it might have been appropriate to set
  dp->dl_stid.sc_type =3D NFS4_CLOSED_DELEG_STID;
was done to unhash_delegation() in that patch.

So I think we should declare
Fixes: b0fc29d6fcd0 ("nfsd: Ensure stateids remain unique until they are free=
d")

and be prepared to provide alternate patches for older kernels.

NeilBrown

>=20
>=20
> > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > > ---
> > > >  fs/nfsd/nfs4state.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index ac1859c7cc9d..56b261608af4 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -7154,6 +7154,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, stru=
ct nfsd4_compound_state *cstate,
> > > >  	switch (s->sc_type) {
> > > >  	case SC_TYPE_DELEG:
> > > >  		if (s->sc_status & SC_STATUS_REVOKED) {
> > > > +			s->sc_status |=3D SC_STATUS_CLOSED;
> > > >  			spin_unlock(&s->sc_lock);
> > > >  			dp =3D delegstateid(s);
> > > >  			list_del_init(&dp->dl_recall_lru);
> > > > --=20
> > > > 2.43.5
> > > >=20
> > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
>=20
> --=20
> Chuck Lever
>=20


