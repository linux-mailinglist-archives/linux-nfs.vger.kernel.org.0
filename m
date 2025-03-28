Return-Path: <linux-nfs+bounces-10939-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4C2A7421A
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 02:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22F93AF211
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Mar 2025 01:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45217224CC;
	Fri, 28 Mar 2025 01:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N61OM+Ie";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aLjG7JX9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N61OM+Ie";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aLjG7JX9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214DCDDAD
	for <linux-nfs@vger.kernel.org>; Fri, 28 Mar 2025 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743126201; cv=none; b=GiMKgtUV2iw/jXDEr6Ill7UE4JrQpGGG2A/61WqCRCgn1HLzzXTL2Zh6sOV0NlT6E+iE3zISYEmY8SWKqqdar1jyErME1uB0knNsVsMhKiP8KYO3JhS0W0osyZWHDyGnAJpSG5DXlKsA74h0hztetNijdOFwxd7LP+COO4v2OvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743126201; c=relaxed/simple;
	bh=pY893Q6oWAbSKuxP7YHq+Vjdp/EIuSMEi7yeY8YULSs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=UbhaVizMozu6esfq3lj12Oh6j1Xfok6i7r8cF66QiczcTV4lABxzDaun0OKUZn5qAiPGCXmR3HHvwkXLS3n54/S9N4WMOjw2fs3y7gu3SV2Iscg3i4wNzDXz+IBgenKTijYFd6tgDkLVgIylef+EhxGNBDwDnW69uQiTwwy2HtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N61OM+Ie; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aLjG7JX9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N61OM+Ie; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aLjG7JX9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BBA91F388;
	Fri, 28 Mar 2025 01:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743126196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GYTf7Y59/M4gGnp3QhKHvubRUEqTh9r4VMqjyukjBPo=;
	b=N61OM+IemKJ6Pg6MMHpFoCazRZFBJIE8N8IwJ5CpTj/xbi5M5LbLIUKHYnxnb2/VjXOgLh
	wXgGJmwof7Zt6edYZsCrGFstSxwvB2MiIX/aiZrV9D0UjZl8Vj5GFs97uqM5mM90t3HeR2
	osnxjn+kViWDwDwSZTd9l5HycOKzaO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743126196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GYTf7Y59/M4gGnp3QhKHvubRUEqTh9r4VMqjyukjBPo=;
	b=aLjG7JX9pIGgWdweZw4iUVtyqKAa5VC3w9lZDBEzAiD9dmSdNoQgz1lNxsJE/O3m+vg52t
	kWWz6fVHEJttCgCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=N61OM+Ie;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aLjG7JX9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743126196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GYTf7Y59/M4gGnp3QhKHvubRUEqTh9r4VMqjyukjBPo=;
	b=N61OM+IemKJ6Pg6MMHpFoCazRZFBJIE8N8IwJ5CpTj/xbi5M5LbLIUKHYnxnb2/VjXOgLh
	wXgGJmwof7Zt6edYZsCrGFstSxwvB2MiIX/aiZrV9D0UjZl8Vj5GFs97uqM5mM90t3HeR2
	osnxjn+kViWDwDwSZTd9l5HycOKzaO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743126196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GYTf7Y59/M4gGnp3QhKHvubRUEqTh9r4VMqjyukjBPo=;
	b=aLjG7JX9pIGgWdweZw4iUVtyqKAa5VC3w9lZDBEzAiD9dmSdNoQgz1lNxsJE/O3m+vg52t
	kWWz6fVHEJttCgCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A8FA13691;
	Fri, 28 Mar 2025 01:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sF2kDLL+5WfTGQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 28 Mar 2025 01:43:14 +0000
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
Cc: chuck.lever@oracle.com, jlayton@kernel.org, linux-nfs@vger.kernel.org,
 Dai.Ngo@oracle.com, tom@talpey.com
Subject:
 Re: [PATCH 3/3] nfsd: reset access mask for NLM calls in nfsd_permission
In-reply-to:
 <CACSpFtAj1TxzsMfxuSttA0_tqAZ2FZR69DuL5i-xK6bvMbtc_w@mail.gmail.com>
References:
 <>, <CACSpFtAj1TxzsMfxuSttA0_tqAZ2FZR69DuL5i-xK6bvMbtc_w@mail.gmail.com>
Date: Fri, 28 Mar 2025 12:43:11 +1100
Message-id: <174312619109.9342.16173648063480052169@noble.neil.brown.name>
X-Rspamd-Queue-Id: 8BBA91F388
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 28 Mar 2025, Olga Kornievskaia wrote:
> On Thu, Mar 27, 2025 at 7:54=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
> >
> > On Sat, 22 Mar 2025, Olga Kornievskaia wrote:
> > > NLM locking calls need to pass thru file permission checking
> > > and for that prior to calling inode_permission() we need
> > > to set appropriate access mask.
> > >
> > > Fixes: 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")
> > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > ---
> > >  fs/nfsd/vfs.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > > index 4021b047eb18..7928ae21509f 100644
> > > --- a/fs/nfsd/vfs.c
> > > +++ b/fs/nfsd/vfs.c
> > > @@ -2582,6 +2582,13 @@ nfsd_permission(struct svc_cred *cred, struct sv=
c_export *exp,
> > >       if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
> > >               return nfserr_perm;
> > >
> > > +     /*
> > > +      * For the purpose of permission checking of NLM requests,
> > > +      * the locker must have READ access or own the file
> > > +      */
> > > +     if (acc & NFSD_MAY_NLM)
> > > +             acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
> > > +
> >
> > I don't agree with this change.
> > The only time that NFSD_MAY_NLM is set, NFSD_MAY_OWNER_OVERRIDE is also
> > set.  So that part of the change adds no value.
> >
> > This change only affects the case where a write lock is being requested.
> > In that case acc will contains NFSD_MAY_WRITE but not NFSD_MAY_READ.
> > This change will set NFSD_MAY_READ.  Is that really needed?
> >
> > Can you please describe the particular problem you saw that is fixed by
> > this patch?  If there is a problem and we do need to add NFSD_MAY_READ,
> > then I would rather it were done in nlm_fopen().
>=20
> set export policy with (sec=3Dkrb5:...) then mount with sec=3Dkrb5,vers=3D3,
> then ask for an exclusive flock(), it would fail.
>=20
> The reason it fails is because nlm_fopen() translates lock to open
> with WRITE. Prior to patch 4cc9b9f2bf4d, the access would be set to
> acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE; before calling into
> inode_permission(). The patch changed it and lead to lock no longer
> being given out with sec=3Dkrb5 policy.

And do you have WRITE access to the file?

check_fmode_for_setlk() in fs/locks.c suggests that for F_WRLCK to be
granted the file must be open for FMODE_WRITE.
So when an exclusive lock request arrives via NLM, nlm_lookup_file()
calls nlm_do_fopen() with a mode of O_WRONLY and that causes
nfsd_permission() to check that the caller has write access to the file.

So if you are trying to get an exclusive lock to a file that you don't
have write access to, then it should fail.
If, however, you do have write access to the file - I cannot see why
asking for NFSD_MAY_READ instead of NFSD_MAY_WRITE would help.

NeilBrown


>=20
>=20
> >
> > Thanks,
> > NeilBrown
> >
> >
> > >       /*
> > >        * The file owner always gets access permission for accesses that
> > >        * would normally be checked at open time. This is to make
> > > --
> > > 2.47.1
> > >
> > >
> >
>=20
>=20


