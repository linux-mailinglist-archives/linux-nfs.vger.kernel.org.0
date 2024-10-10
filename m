Return-Path: <linux-nfs+bounces-7037-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2AC9993E6
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 22:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398711F22FCC
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Oct 2024 20:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F5E1CF5F1;
	Thu, 10 Oct 2024 20:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1U47rMnY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="snAXz/cP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1U47rMnY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="snAXz/cP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0A01991B8;
	Thu, 10 Oct 2024 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728593363; cv=none; b=dnLaVLj2ycXxCXiSP2OX4AcdjIvSYiIbJbE+W6wocXkEQBc/nGT/0F+ePr4uCs/iwhV137LuxsUH8fY5WBHLseBpVa72aB5yzr+NuiT7SfZjDUfuhwn66TZGP3+xlxO9f2lKdPH60gVtw1mSE4vfm0EfOAlMvRa1Kv+k9OGGN0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728593363; c=relaxed/simple;
	bh=4WwtzshnrUnW4OWWNGPeLR+yfu/8AIRhKqf10LmJaBc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=p9GSKOHDvVQlMx03mhKUBlPUeWmWnjpyAHBeWMdQQLyPDaNX8FYLIG7DxUmNh2qfLCNOeW91WnCwvZAV+u7zvYvmxc3ZsKa02PpEj179l8tYRqlaP7H2ZSzF8XY+gXfBHDJ6XG/qnf2Yoqu31MKf+KZalL1UxivDrQZOYt1WRVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1U47rMnY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=snAXz/cP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1U47rMnY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=snAXz/cP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0DE221DAD;
	Thu, 10 Oct 2024 20:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728593359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRDEvICaEzdwrIe0rqzexW7NqQ5hp8fC4bwRuxky4Bo=;
	b=1U47rMnYDDdowt/gTJVQrbf1xE4lPaYP5ofP6yc9uanrNHgMrYNqd5K6s8K1+AV6XBh5ym
	fohGli5wLRAofGn4JUoG4unwS5VbcxVSms7x9D45OVETFKQ67U7Xm1Et6ZRB0v74Gkb/Nu
	7av4gRsZkjOPsVwcccsy6h4O5uhHI88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728593359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRDEvICaEzdwrIe0rqzexW7NqQ5hp8fC4bwRuxky4Bo=;
	b=snAXz/cPeY0u3NTwDyJJQJOr+AmjIR29yWiZvi0SPzFrIAqljPMGvNQsbeVUiJvqrHsJkF
	D9/CVjeynuwxOtDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728593359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRDEvICaEzdwrIe0rqzexW7NqQ5hp8fC4bwRuxky4Bo=;
	b=1U47rMnYDDdowt/gTJVQrbf1xE4lPaYP5ofP6yc9uanrNHgMrYNqd5K6s8K1+AV6XBh5ym
	fohGli5wLRAofGn4JUoG4unwS5VbcxVSms7x9D45OVETFKQ67U7Xm1Et6ZRB0v74Gkb/Nu
	7av4gRsZkjOPsVwcccsy6h4O5uhHI88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728593359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRDEvICaEzdwrIe0rqzexW7NqQ5hp8fC4bwRuxky4Bo=;
	b=snAXz/cPeY0u3NTwDyJJQJOr+AmjIR29yWiZvi0SPzFrIAqljPMGvNQsbeVUiJvqrHsJkF
	D9/CVjeynuwxOtDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22E3D1370C;
	Thu, 10 Oct 2024 20:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H9XDMsw9CGepWAAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 10 Oct 2024 20:49:16 +0000
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
Cc: Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH] nfsd: Fix NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT
In-reply-to: <ZwcSC4ZWihv/PyV2@tissot.1015granger.net>
References: <>, <ZwcSC4ZWihv/PyV2@tissot.1015granger.net>
Date: Fri, 11 Oct 2024 07:49:13 +1100
Message-id: <172859335340.444407.11709415196743389823@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 10 Oct 2024, Chuck Lever wrote:
> On Thu, Oct 10, 2024 at 07:14:07AM +1100, NeilBrown wrote:
> > On Thu, 10 Oct 2024, Chuck Lever wrote:
> > > On Tue, Oct 08, 2024 at 05:47:55PM -0400, NeilBrown wrote:
> > > > And NFSD_MAY_LOCK should be discarded, and nlm_fopen() should set
> > > > NFSD_MAY_BYPASS_SEC.
> > >=20
> > > 366         /*                                                         =
            =20
> > > 367          * pseudoflavor restrictions are not enforced on NLM,      =
            =20
> > >=20
> > > Wrt the mention of "NLM", nfsd4_lock() also sets NFSD_MAY_LOCK.
> >=20
> > True, but it shouldn't.  NFSD_MAY_LOCK is only used to bypass the GSS
> > requirement.  It must have been copied into nfsd4_lock() without a full
> > understanding of its purpose.
>=20
> nfsd4_lock()'s use of MAY_LOCK goes back before the git era, so it's
> difficult to say with certainty.
>=20
> I would like to keep such subtle changes bisectable. To me, it seems
> like it would be a basic first step to change the fh_verify() call
> in nfsd4_lock() to use (NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE)
> instead of NFSD_MAY_LOCK, as a separate patch.

Yes, that is sensible ...  though lockd used NFSD_MAY_WRITE for write
locks.
So if a process doesn't have read access to a file but does have write
access, and isn't the owner, then NLM would grant a write lock, but
NFSv4 would not.  check_fmode_for_setlk() makes the same choice, so a
local user could also get the lock.  Only NFSv4 would reject it.

>=20
>=20
> > > 368          * which clients virtually always use auth_sys for,        =
            =20
> > > 369          * even while using RPCSEC_GSS for NFS.                    =
            =20
> > > 370          */                                                        =
            =20
> > > 371         if (access & NFSD_MAY_LOCK)                                =
            =20
> > > 372                 goto skip_pseudoflavor_check;                      =
            =20
> > > 373         if (access & NFSD_MAY_BYPASS_GSS)                          =
            =20
> > > 374                 may_bypass_gss =3D true;
> > > 375         /*                                                         =
            =20
> > > 376          * Clients may expect to be able to use auth_sys during mou=
nt,         =20
> > > 377          * even if they use gss for everything else; see section 2.=
3.2         =20
> > > 378          * of rfc 2623.                                            =
            =20
> > > 379          */                                                        =
            =20
> > > 380         if (access & NFSD_MAY_BYPASS_GSS_ON_ROOT                   =
            =20
> > > 381                         && exp->ex_path.dentry =3D=3D dentry)      =
                =20
> > > 382                 may_bypass_gss =3D true;                           =
              =20
> > > 383                                                                    =
            =20
> > > 384         error =3D check_nfsd_access(exp, rqstp, may_bypass_gss);   =
              =20
> > > 385         if (error)                                                 =
            =20
> > > 386                 goto out;                                          =
            =20
> > > 387                                                                    =
            =20
> > > 388 skip_pseudoflavor_check:                                           =
            =20
> > > 389         /* Finally, check access permissions. */                   =
            =20
> > > 390         error =3D nfsd_permission(cred, exp, dentry, access);    =20
> > >=20
> > > MAY_LOCK is checked in nfsd_permission() and __fh_verify().
> > >=20
> > > But MAY_BYPASS_GSS is set in loads of places that use those two
> > > functions. How can we be certain that the two flags are equivalent?=20
> >=20
> > We can be certain by looking at the effect.  Before a recent patch they
> > both did "goto skip_pseudoflavor_check" and nothing else.
>=20
> I'm still not convinced MAY_LOCK and MAY_BYPASS_GSS are 100%
> equivalent.  nfsd_permission() checks for MAY_LOCK, but does not
> check for MAY_BYPASS_GSS:
>=20
>         if (acc & NFSD_MAY_LOCK) {
>                 /* If we cannot rely on authentication in NLM requests,
>                  * just allow locks, otherwise require read permission, or
>                  * ownership
>                  */
>                 if (exp->ex_flags & NFSEXP_NOAUTHNLM)
>                         return 0;
>                 else=20
>                         acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
>         }=20
>=20
> The only consumer of MAY_BYPASS_GSS seems to be OP_PUTFH, now that
> I'm looking closely for it. But I don't think we want the
> no_auth_nlm export option to modify the way PUTFH behaves.

Thanks for fact-checking my claim!  I had forgotten about noauthnlm.

I'll suggest a patch which might make it all a bit clearer.

Thanks,
NeilBrown


>=20
>=20
> --=20
> Chuck Lever
>=20


