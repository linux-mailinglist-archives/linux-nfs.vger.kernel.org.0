Return-Path: <linux-nfs+bounces-20868-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE+HOU794GlloAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20868-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:16:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA744106D9
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98D8B301BA4C
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 15:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730063E276D;
	Thu, 16 Apr 2026 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Virv/0El"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1C13DE45C;
	Thu, 16 Apr 2026 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776352585; cv=none; b=jlHrNVCvQ8noJhLYVrAiRNI/lnMDYK+CX5kP3YyDyVxBsYMEndk6QZGIeOq10sqSb6MRTNzKAJ9NOCZJjPowG4zdl4SqYwOhzpHzcSTJKX87Ms/YslB28lG27eF2GfGrGJu+1Dj1VTjEmMyxGuJfSc2sTV+3qUcaFu+kSg9eLl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776352585; c=relaxed/simple;
	bh=XyF+E6gO478wOiq/pgMuvIN81fx+9yXqn/Vvu2aT0L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOofYZVZ2XdsaRVag0klVLF7jG2XIZtwpKMf0FrUtULvCvTL512zt27kuRCnfM3SXfv5O0rbH4Lxn3bb+1vOOy58JSIzw6kFv2oZGTVOkGZhKLqtMvlEeJjXvI7UVl2sXUHqeb6Xm+4oo5V/5a36a6A0z+XfvAFYP60uTXQFOl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Virv/0El; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fxM6P2PZ5z9tSb;
	Thu, 16 Apr 2026 17:16:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1776352573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nhdCoiv/I0uxkoUrCPPG8rmJC6ZboD1OxA5S+uwKny8=;
	b=Virv/0ElZ0qFnnPY/GhS5IhJ+h+GwbEprg/h6Z9gV2OljviLjkdVEwRZ+7X854ZIKSFeH0
	hC4Niqhi7j9PLi4+x63KFfnDPt4RuFBqYxloFK25bI25vzvnHeqoJVXrIUJggjY/wyR6sU
	RAg+Gmv9Q8pOXrv4JpVr7Wx/FZ1ibiwpX3fq5zPDnVBU8spo4050i3foBmWYOnB3d8Hz0d
	zJQBpIWvwsnJqNPDc7mRLjs7ut2beQ15RsBmg4fBV07bQjFt69J5XLy6EZvGe9QHajdQDq
	FFTKxD9BCwP255KkJ0kJ8owP3FVsOz/lVDwfI2wM+7QFoaGvhF8LuoZY6ew7SQ==
Date: Fri, 17 Apr 2026 01:15:42 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, 
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org, 
	anna@kernel.org, sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, shuah@kernel.org, 
	miklos@szeredi.hu, hansg@kernel.org
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
Message-ID: <2026-04-16-upstate-capable-deacon-petals-0l25lH@cyphar.com>
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com>
 <aeDpIgfDaIKEaBcL@lt-jori.localdomain>
 <CAFfO_h6pkyX=uN5uoXda6toTtT6KsahfBNBLom9i21HdZ7JOmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ms7kw7kvw4rfqdw6"
Content-Disposition: inline
In-Reply-To: <CAFfO_h6pkyX=uN5uoXda6toTtT6KsahfBNBLom9i21HdZ7JOmQ@mail.gmail.com>
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cyphar.com,reject];
	R_DKIM_ALLOW(-0.20)[cyphar.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20868-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[xs4all.nl,vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyphar@cyphar.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[cyphar.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cyphar.com:mid,cyphar.com:dkim,cyphar.com:url,xs4all.nl:email]
X-Rspamd-Queue-Id: 8BA744106D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ms7kw7kvw4rfqdw6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
MIME-Version: 1.0

On 2026-04-16, Dorjoy Chowdhury <dorjoychy111@gmail.com> wrote:
> On Thu, Apr 16, 2026 at 7:52=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.n=
l> wrote:
> >
> > On Sat, Mar 28, 2026 at 11:22:22PM +0600, Dorjoy Chowdhury wrote:
> > > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include=
/uapi/asm/fcntl.h
> > > index 50bdc8e8a271..fe488bf7c18e 100644
> > > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > > @@ -34,6 +34,7 @@
> > >
> > >  #define O_PATH               040000000
> > >  #define __O_TMPFILE  0100000000
> > > +#define OPENAT2_REGULAR      0200000000
> > >
> >
> > I don't quite understand why we are adding OPENAT2_REGULAR inside the
> > O_* flag range. Wasn't this supposed to be only supported for openat2()?
> > If so, I don't see the need to waste an O_* flag bit. But maybe I am
> > missing something.
> >
>=20
> Yes, OPENAT2_REGULAR is only supported for openat2. I am not sure if I
> got a specific review to not add OPENAT2_REGULAR in the O_* flag 32
> bit range. But as far as I understand, for the old open system calls
> we can't easily add new O_* flags as the older codepaths don't strip
> off unknown bits which openat2 does. It's not easy to add new O_*
> flags for the old open system calls since that could break userspace
> programs. So I guess it's okay to add OPENAT2_REGULAR in the 32 bits
> range anyway? (Also lots of code paths take 32bit flags param right
> now and those would need changing to take uint64_t instead but this is
> of course not a reason to not add the new flag outside of the 32
> bits).

Oh, I didn't notice that this wasn't mentioned here, we had a separate
discussion about it in a thread with Jori and I must've assumed we
discussed it in both. (My brain is also really not wired up to read
large octal values easily.)

While it is hard to add new O_* flags (hence OPENAT2_REGULAR), it's not
/impossible/ (Jori has a patch for OPENAT2_EMPTY_PATH that is safe to
add to O_* flags because of some fun historical coincidences).

I would have a slight preference towards segregating the bits, ideally
at the top end but even 1<<31 would've been nice. Then again, I'm not
too fussed either way to be honest...

--=20
Aleksa Sarai
https://www.cyphar.com/

--ms7kw7kvw4rfqdw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaeD9HhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG9xNAD/S5O3wWRTFXlfMtlEHV4H
tBLno64cQT7NoYqdsUavC30BAL3p0Ba/trcO4rvoUwChjEeB5/aNYaoe0DC5i/3Y
W2AO
=6Jzu
-----END PGP SIGNATURE-----

--ms7kw7kvw4rfqdw6--

