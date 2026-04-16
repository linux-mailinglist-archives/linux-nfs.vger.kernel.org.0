Return-Path: <linux-nfs+bounces-20861-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKTUFCzf4GkEnAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20861-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 15:07:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE75040E7E7
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 15:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D10030B412D
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CDA3B6C13;
	Thu, 16 Apr 2026 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Ofuf1/2e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E4D3B5825;
	Thu, 16 Apr 2026 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344759; cv=none; b=KCa1MrmHjNRjVEUazN0XzHjtrHlxHL46aYlmQhJEUL/GRjGt6ae63kM7d3RE2CibU2mTKvgZCkUfukIuDoztwV3GZeyM0virznnrA7xcfk65qimnefhadK1k+0pL8Y3dgXa4bW0Jc7cVvLuu3s7xm3uTF2t+Jp9YM9cUy1bT+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344759; c=relaxed/simple;
	bh=LKqiYtCSdYGhCyBf/mMMNOBQugaqjT2Dib6bCbcxP/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRQZQvJyKpXsPtWpB2teltOKlZ2WHlCYKRfwptornbjn8TwLIMPFWqP5XR72onSP4yOchbi82SkCRATBmcySk+6RiLo2G+9qeZcgOC7r2QHwBNbYu7XIyuOkg/iJDdmCxC0N1CtUTcadVUttxowF01x7IqL/noXITak0ejvoBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Ofuf1/2e; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fxJD11Fnvz9trN;
	Thu, 16 Apr 2026 15:05:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1776344753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3SVhaxoe6KpS7BWIdNtnzlL4xk1+jeKHvu5tT02YlI=;
	b=Ofuf1/2e7ix58a6QMnjoZqNi0IkQDsa4ZwzLticveCI0rqjUCCCttZsEArNllde0VXuvNC
	06uqhm88AO/DtfQqy7VsqR5v0Bkuy4Jp3LHh8K6W5shnGlaHY4q/0VImNPonJF1+hdUkYW
	7Y4SK+8qK0OPTqi70cxSoyKfSrWGlZzHD4gpd21bm6Iw6jhUDEbIvLXe8/cUg/urCs3bxJ
	AxwpmKv53w1vvfF6M6yzU+RNtAqAhygVMWhK1JjjxPhWIJFtMaCCEvG5paRmyd2BVvsyee
	Qmzo80CrRuAb8PsaduekY0cMCxq1B3EIA0DadMN5CChtpgNH/bQxuOpBX0aQ/Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Thu, 16 Apr 2026 23:05:08 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, 
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org, 
	anna@kernel.org, sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, shuah@kernel.org, 
	miklos@szeredi.hu, hansg@kernel.org
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
Message-ID: <2026-04-16-raunchy-random-curfew-guide-GmtLJR@cyphar.com>
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com>
 <2026-04-16-selfless-milky-wasps-shin-p6liRL@cyphar.com>
 <CAFfO_h5kWCYszymaY=tPAbpU=PjLFxsND+CWSYtypN4iuW+qPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iix77o3fx2yurggd"
Content-Disposition: inline
In-Reply-To: <CAFfO_h5kWCYszymaY=tPAbpU=PjLFxsND+CWSYtypN4iuW+qPw@mail.gmail.com>
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20861-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux-foundation.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyphar@cyphar.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[cyphar.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uapi-group.org:url,amutable.com:email,cyphar.com:mid,cyphar.com:email,cyphar.com:dkim,cyphar.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE75040E7E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--iix77o3fx2yurggd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
MIME-Version: 1.0

On 2026-04-16, Dorjoy Chowdhury <dorjoychy111@gmail.com> wrote:
> On Thu, Apr 16, 2026 at 5:41=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> =
wrote:
> >
> > On 2026-03-28, Dorjoy Chowdhury <dorjoychy111@gmail.com> wrote:
> > > This flag indicates the path should be opened if it's a regular file.
> > > This is useful to write secure programs that want to avoid being
> > > tricked into opening device nodes with special semantics while thinki=
ng
> > > they operate on regular files. This is a requested feature from the
> > > uapi-group[1].
> > >
> > > A corresponding error code EFTYPE has been introduced. For example, if
> > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > > like FreeBSD, macOS.
> > >
> > > When used in combination with O_CREAT, either the regular file is
> > > created, or if the path already exists, it is opened if it's a regular
> > > file. Otherwise, -EFTYPE is returned.
> > >
> > > When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is returned
> > > as it doesn't make sense to open a path that is both a directory and a
> > > regular file.
> > >
> > > [1]: https://uapi-group.org/kernel-features/#ability-to-only-open-reg=
ular-files
> > >
> > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > ---
> >
> > Aside from the nit below, feel free to take a
> >
> > Reviewed-by: Aleksa Sarai <aleksa@amutable.com>
> >
>=20
> Thanks for reviewing!
>=20
> > > diff --git a/fs/open.c b/fs/open.c
> > > index 681d405bc61e..a6f445f72181 100644
> > > --- a/fs/open.c
> > > +++ b/fs/open.c
> > > @@ -960,7 +960,7 @@ static int do_dentry_open(struct file *f,
> > >       if (f->f_mapping->a_ops && f->f_mapping->a_ops->direct_IO)
> > >               f->f_mode |=3D FMODE_CAN_ODIRECT;
> > >
> > > -     f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
> > > +     f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | OPENA=
T2_REGULAR);
> >
> > It's not clear to me why you dropped this, I didn't see a review
> > mentioning it either. (General note: Ideally the cover letter changelog
> > would mention who suggested a change in brackets after the changelog
> > line so it's easier to track where a change might've come from.)
> >
>=20
> Thanks for the general note. I will keep that in mind.
>=20
> The review was from Jeff Layton in v5
> https://lore.kernel.org/linux-fsdevel/5fcc2a6e6d92dae0601c6b3b8faa8b2f839=
81afb.camel@kernel.org/
> " 1. OPENAT2_REGULAR leaks into f_flags - do_dentry_open() strips
> open-time-only flags (O_CREAT|O_EXCL|O_NOCTTY|O_TRUNC)
>   but does not strip OPENAT2_REGULAR. When a regular file is
> successfully opened via openat2() with this flag, the bit
>   persists in file->f_flags and will be returned by fcntl(fd, F_GETFL)."
>=20
> I think it makes sense to strip off as OPENAT2_REGULAR is an open time
> only flag (like O_CREAT and the others already), right?

Well, O_DIRECTORY isn't stripped so if we want to mirror that behaviour
then it shouldn't be stripped either IMHO.

O_NOCTTY and O_TRUNC make sense to strip (they are not relevant to the
file after it was opened -- truncation only happens at open time and you
can always set your controlling TTY later).

The story with O_CREAT and O_EXCL is a bit more complicated. They are
stripped but the history there is unclear -- the line was added in Linux
0.98.4(!) with no mention in the release note at the time. (Linus: I
wonder if you remember why this was changed at the time? Sorry for the
trip down memory lane...)

However, the existence of F_CREATED_QUERY kind of shows that these kinds
of checks are stuff that userspace can find handy (though FMODE_CREATED
is more useful than O_CREAT|O_EXCL anyway). O_EXCL is used internally
for stuff so it can be re-exposed, I'm just not sure it's a good
precedent to make a decision based on.

Then again, userspace can check with fstat(2) so it's not the end of the
world, but I don't really see a strong reason to hide information from
userspace. Since the mail was from Claude (and it tends to give silly
nits like that) I'm not sure whether Jeff would agree with my view or
not.

--=20
Aleksa Sarai
https://www.cyphar.com/

--iix77o3fx2yurggd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaeDegxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG/oDAD+OTut8n70aNHtOfSq9HfZ
Nqs1285ca/4efdXyrzF6TdsA/Rq1PeAKk1gWARrfSWVj0XaRIK8fqL+aRFpJp6Xk
SgwB
=KY3X
-----END PGP SIGNATURE-----

--iix77o3fx2yurggd--

