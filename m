Return-Path: <linux-nfs+bounces-8382-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C950E9E672C
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 07:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0FA18856A3
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 06:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F911D6DB1;
	Fri,  6 Dec 2024 06:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ww59zb1E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zJtbFfQ/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ww59zb1E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zJtbFfQ/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB37D1B78E7
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733465417; cv=none; b=oj1Hkd+CdLhOGP4rvYX/9fdCVIv1g+/buFmu4+/Z/hGPuYeNZ8whTC6vlTrnnEIeNrMzKbLtay7WcuV8MrdPUsv3MS/wixjbWNXzqJTcedj9IYN3BCqdC8+1lMx7Mpr1xybxbsJXBkNH39YveSboQ4PplFl8aswZFfafRugIfjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733465417; c=relaxed/simple;
	bh=c7eU3j6BvxMi62Fsqo0sayn0qkztDsIG2gzx0989k3w=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=SmREN0zhPM/RfVmkwFa4a0nIlSGhKL/p5nJSJkydtQt3+1suK0XC4KibddGGu6QHpxUl9ztIwjN8hCyjg0q8hiIemeZQ/Oyh2QsQgMRHoWbIZfiI/gW1/f6aNGhOyh+w57dsJJX44JdL8T9kao9LrtxTEWDEWtVVxvNcbRkTfAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ww59zb1E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zJtbFfQ/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ww59zb1E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zJtbFfQ/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2ADA2118D;
	Fri,  6 Dec 2024 06:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733465413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JkspA59C8IDalYtlnQrkHJbIWmSHjhCY7pR/wHrc1gI=;
	b=Ww59zb1ErUv/d2FmOM9GTlCJQuL5gw3jKLEezktGzqQDSm15ScVD2ajqnc0raTuJXqMIiv
	0GttbsZMAGLpW+B+ki8fRY8e16fW5gfiT9/d/uFuZTbyhUu7G45CYLuUObPbkWdrZMV9ay
	OEKd44asaa1cgMd2br9pG5gc+71PcXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733465413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JkspA59C8IDalYtlnQrkHJbIWmSHjhCY7pR/wHrc1gI=;
	b=zJtbFfQ/ZUtK+G9/PZL0gJhj4ox/lZSIYn91dpXc9LQr1hE0xMvIqeZbYTLH/JRnvlmiz0
	FIS+VvZE1WEm+FDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ww59zb1E;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="zJtbFfQ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733465413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JkspA59C8IDalYtlnQrkHJbIWmSHjhCY7pR/wHrc1gI=;
	b=Ww59zb1ErUv/d2FmOM9GTlCJQuL5gw3jKLEezktGzqQDSm15ScVD2ajqnc0raTuJXqMIiv
	0GttbsZMAGLpW+B+ki8fRY8e16fW5gfiT9/d/uFuZTbyhUu7G45CYLuUObPbkWdrZMV9ay
	OEKd44asaa1cgMd2br9pG5gc+71PcXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733465413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JkspA59C8IDalYtlnQrkHJbIWmSHjhCY7pR/wHrc1gI=;
	b=zJtbFfQ/ZUtK+G9/PZL0gJhj4ox/lZSIYn91dpXc9LQr1hE0xMvIqeZbYTLH/JRnvlmiz0
	FIS+VvZE1WEm+FDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81066138A7;
	Fri,  6 Dec 2024 06:10:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /jolDUOVUmf5VgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 06:10:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 1/2] nfsd: use new wake_up_var interfaces.
In-reply-to: <36a543b848e59ddf26c85d0c79b7e377d865a0af.camel@kernel.org>
References: <>, <36a543b848e59ddf26c85d0c79b7e377d865a0af.camel@kernel.org>
Date: Fri, 06 Dec 2024 17:10:08 +1100
Message-id: <173346540850.1734440.373396718120959851@noble.neil.brown.name>
X-Rspamd-Queue-Id: A2ADA2118D
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
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 06 Dec 2024, Jeff Layton wrote:
> On Fri, 2024-12-06 at 13:55 +1100, NeilBrown wrote:
> > The wake_up_var interface is fragile as barriers are sometimes needed.
> > There are now new interfaces so that most wake-ups can use an interface
> > that is guaranteed to have all barriers needed.
> >=20
> > This patch changes the wake up on cl_cb_inflight to use
> > atomic_dec_and_wake_up().
> >=20
> > It also changes the wake up on rp_locked to use store_release_wake_up().
> > This involves changing rp_locked from atomic_t to int.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4callback.c |  3 +--
> >  fs/nfsd/nfs4state.c    | 16 ++++++----------
> >  fs/nfsd/state.h        |  2 +-
> >  3 files changed, 8 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> > index 3877b53e429f..a8dc9de2f7fb 100644
> > --- a/fs/nfsd/nfs4callback.c
> > +++ b/fs/nfsd/nfs4callback.c
> > @@ -1036,8 +1036,7 @@ static void nfsd41_cb_inflight_begin(struct nfs4_cl=
ient *clp)
> >  static void nfsd41_cb_inflight_end(struct nfs4_client *clp)
> >  {
> > =20
> > -	if (atomic_dec_and_test(&clp->cl_cb_inflight))
> > -		wake_up_var(&clp->cl_cb_inflight);
> > +	atomic_dec_and_wake_up(&clp->cl_cb_inflight);
> >  }
> > =20
> >  static void nfsd41_cb_inflight_wait_complete(struct nfs4_client *clp)
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 741b9449f727..9fbf7c8f0a3e 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -4739,7 +4739,7 @@ static void init_nfs4_replay(struct nfs4_replay *rp)
> >  	rp->rp_status =3D nfserr_serverfault;
> >  	rp->rp_buflen =3D 0;
> >  	rp->rp_buf =3D rp->rp_ibuf;
> > -	atomic_set(&rp->rp_locked, RP_UNLOCKED);
> > +	rp->rp_locked =3D RP_UNLOCKED;
> >  }
> > =20
> >  static int nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstat=
e,
> > @@ -4747,9 +4747,9 @@ static int nfsd4_cstate_assign_replay(struct nfsd4_=
compound_state *cstate,
> >  {
> >  	if (!nfsd4_has_session(cstate)) {
> >  		wait_var_event(&so->so_replay.rp_locked,
> > -			       atomic_cmpxchg(&so->so_replay.rp_locked,
> > -					      RP_UNLOCKED, RP_LOCKED) !=3D RP_LOCKED);
> > -		if (atomic_read(&so->so_replay.rp_locked) =3D=3D RP_UNHASHED)
> > +			       cmpxchg(&so->so_replay.rp_locked,
> > +				       RP_UNLOCKED, RP_LOCKED) !=3D RP_LOCKED);
>=20
> nit: try_cmpxchg() generates more efficient assembly. Can we switch to
> that here too?

Does it?  try_cmpxchg() makes loops smaller (as described in
atomic_t.txt).  I think it wins when the "old" value has to be updated
each time around the loop.  In this case the "old" value is always the
same.


NeilBrown


>=20
> > +		if (so->so_replay.rp_locked =3D=3D RP_UNHASHED)
> >  			return -EAGAIN;
> >  		cstate->replay_owner =3D nfs4_get_stateowner(so);
> >  	}
> > @@ -4762,9 +4762,7 @@ void nfsd4_cstate_clear_replay(struct nfsd4_compoun=
d_state *cstate)
> > =20
> >  	if (so !=3D NULL) {
> >  		cstate->replay_owner =3D NULL;
> > -		atomic_set(&so->so_replay.rp_locked, RP_UNLOCKED);
> > -		smp_mb__after_atomic();
> > -		wake_up_var(&so->so_replay.rp_locked);
> > +		store_release_wake_up(&so->so_replay.rp_locked, RP_UNLOCKED);
> >  		nfs4_put_stateowner(so);
> >  	}
> >  }
> > @@ -5069,9 +5067,7 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct=
 net *net)
> >  	 * Some threads with a reference might be waiting for rp_locked,
> >  	 * so tell them to stop waiting.
> >  	 */
> > -	atomic_set(&oo->oo_owner.so_replay.rp_locked, RP_UNHASHED);
> > -	smp_mb__after_atomic();
> > -	wake_up_var(&oo->oo_owner.so_replay.rp_locked);
> > +	store_release_wake_up(&oo->oo_owner.so_replay.rp_locked, RP_UNHASHED);
> >  	wait_event(close_wq, refcount_read(&s->st_stid.sc_count) =3D=3D 2);
> > =20
> >  	release_all_access(s);
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index e16bb3717fb9..ba30b2335b66 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -505,7 +505,7 @@ struct nfs4_replay {
> >  	unsigned int		rp_buflen;
> >  	char			*rp_buf;
> >  	struct knfsd_fh		rp_openfh;
> > -	atomic_t		rp_locked;
> > +	int			rp_locked;
> >  	char			rp_ibuf[NFSD4_REPLAY_ISIZE];
> >  };
> > =20
>=20
> Looks good otherwise.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20


