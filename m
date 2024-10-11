Return-Path: <linux-nfs+bounces-7108-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBCA99ADF3
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 23:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27484B22338
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 21:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50EA1CFEDB;
	Fri, 11 Oct 2024 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aNG9xj1C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rTXI2yqc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aNG9xj1C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rTXI2yqc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF719CC10
	for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728681054; cv=none; b=qXCbdVOJfNFNjJeKrjMsHXDty1d46qLskJSwdKdoRMd5gmIJ2UFNYXBXTLDF1rbz7GhG26JaeWax7oMYqZVQ0sOLS4dAJdSYMP366kVWl0s8+Zebd6UvhiPhId8OuZvfAKvMGuOoSVi63Ndm6E1uzlRU0KE0iiH6pPVbF+s4g5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728681054; c=relaxed/simple;
	bh=2eJHbw3CFrGgD9yIfhxbmRHMxgM1AUSLrtQtN4eWFzw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZzpzGypOm6cI5mfLhDTEyzl7jF8Dgq5Bxl1Ky5P95+XZoogmgME279JNHYVhXmuRLUU786Ht67Ua9L6I4I6KdrpmHtlF8xWZ0wgPXQkSVbY7iLGgFnPvGnjdR+pPjD+lAjJc3kqQsnnHZigbdyFlmd1vhbfcbIymVII5+yDd2L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aNG9xj1C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rTXI2yqc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aNG9xj1C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rTXI2yqc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 332FF1FBDE;
	Fri, 11 Oct 2024 21:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728681051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4XJoFDNmRBaaJwQ/yUAI3BoSq6jOmpV+V54sc1z6Cxc=;
	b=aNG9xj1Cq5biYv9DZ3NzCn5itfoeXdK7UlyYSholmGRFked8+a/uBJLHZ7WPqPW6l8bsAP
	2BS6OxgF6wAXrALQQP9EyLiOKMAHZp0H6EGycVNeXV5roTixVXFoap20oJqiHtdqpe4H16
	44ogoAEzTdcZHDQC5HEWEioRV4enIaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728681051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4XJoFDNmRBaaJwQ/yUAI3BoSq6jOmpV+V54sc1z6Cxc=;
	b=rTXI2yqcrK4vSiS2gXVJ1uN/QK9oxVWCtpUpD8MNOwYrmGioo7ol70bF53wEGTWuzOPNhU
	7V9tcDJQHOOpoKBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728681051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4XJoFDNmRBaaJwQ/yUAI3BoSq6jOmpV+V54sc1z6Cxc=;
	b=aNG9xj1Cq5biYv9DZ3NzCn5itfoeXdK7UlyYSholmGRFked8+a/uBJLHZ7WPqPW6l8bsAP
	2BS6OxgF6wAXrALQQP9EyLiOKMAHZp0H6EGycVNeXV5roTixVXFoap20oJqiHtdqpe4H16
	44ogoAEzTdcZHDQC5HEWEioRV4enIaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728681051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4XJoFDNmRBaaJwQ/yUAI3BoSq6jOmpV+V54sc1z6Cxc=;
	b=rTXI2yqcrK4vSiS2gXVJ1uN/QK9oxVWCtpUpD8MNOwYrmGioo7ol70bF53wEGTWuzOPNhU
	7V9tcDJQHOOpoKBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5669136E0;
	Fri, 11 Oct 2024 21:10:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yuz3IliUCWckCQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 11 Oct 2024 21:10:48 +0000
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
Cc: cel@kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH] NFSD: Replace use of NFSD_MAY_LOCK in nfsd4_lock()
In-reply-to: <ZwmRWAmRukgOrFpt@tissot.1015granger.net>
References: <>, <ZwmRWAmRukgOrFpt@tissot.1015granger.net>
Date: Sat, 12 Oct 2024 08:10:45 +1100
Message-id: <172868104593.34603.16127759664914392343@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Sat, 12 Oct 2024, Chuck Lever wrote:
> On Sat, Oct 12, 2024 at 07:53:34AM +1100, NeilBrown wrote:
> > On Sat, 12 Oct 2024, Chuck Lever wrote:
> > > On Fri, Oct 11, 2024 at 07:54:12AM +1100, NeilBrown wrote:
> > > > On Fri, 11 Oct 2024, cel@kernel.org wrote:
> > > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > >=20
> > > > > NFSv4 LOCK operations should not avoid the set of authorization
> > > > > checks that apply to all other NFSv4 operations. Also, the
> > > > > "no_auth_nlm" export option should apply only to NLM LOCK requests.
> > > > > It's not necessary or sensible to apply it to NFSv4 LOCK operations.
> > > > >=20
> > > > > The replacement MAY bit mask,
> > > > > "NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE", comes from the access
> > > > > bits that are set in nfsd_permission() when the caller has set
> > > > > NFSD_MAY_LOCK.
> > > > >=20
> > > > > Reported-by: NeilBrown <neilb@suse.de>
> > > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > > ---
> > > > >  fs/nfsd/nfs4state.c | 7 +++----
> > > > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > index 9c2b1d251ab3..3f2c11414390 100644
> > > > > --- a/fs/nfsd/nfs4state.c
> > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > @@ -7967,11 +7967,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
> > > > >  	if (check_lock_length(lock->lk_offset, lock->lk_length))
> > > > >  		 return nfserr_inval;
> > > > > =20
> > > > > -	if ((status =3D fh_verify(rqstp, &cstate->current_fh,
> > > > > -				S_IFREG, NFSD_MAY_LOCK))) {
> > > > > -		dprintk("NFSD: nfsd4_lock: permission denied!\n");
> > > > > +	status =3D fh_verify(rqstp, &cstate->current_fh, S_IFREG,
> > > > > +			   NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE);
> > > > > +	if (status !=3D nfs_ok)
> > > > >  		return status;
> > > > > -	}
> > > >=20
> > > > Reviewed-by: NeilBrown <neilb@suse.de>
> > > >=20
> > > > though I think we want a follow-on patch which uses NFSD_MAY_WRITE for
> > > > write locks for consistency with check_fmode_for_setlk().
> > >=20
> > > I think this patch might introduce a behavior regression, then.
> > > Instead of a follow-on, I need a v2 of this patch.
> >=20
> > This is not a regression - it has always been this way (since 2.3.42).
> > And both NLM and v4 suffer - I was wrong about NLM.
> >=20
> > If MAY_LOCK is set, then any MAY_READ or MAY_WRITE flag is ignored, and
> > the 'acc' passed to inode_permission() is only MAY_READ |
> > MAY_OWNER_OVERRIDE
>=20
> That's what I thought when I looked at nfsd_permission() again.
>=20
>=20
> > So any locking over nfsd currently requires ownership or READ access to
> > the inode.  This is slightly different behaviour to local filesystems
> > and it might be nice to fix but I don't think it is an important
> > difference.  Importantly your patch doesn't change this behaviour at all.
>=20
> nfsd4_lock(), IIUC, thoroughly examines the stateid just after it
> does the fh_verify(). Maybe this would be OK:
>=20
> 	status =3D fh_verify( ... , 0);
>=20
> This is what the other NFSv4 lock-related operations do.

I like that!  I haven't looked at the code yet to comment on
correctness, but it does seem like the right sort of approach.

Thanks,
NeilBrown

